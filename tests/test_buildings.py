"""
Gameplay tests for Engineer buildings, run against a live Minecraft server over RCON.

Villagers stand in for players (#tf2:player_like includes them), so no client is needed.
The server must have this datapack, Iris and player_motion loaded, with
enable-rcon=true and pause-when-empty-seconds=-1.

    python3 tests/test_buildings.py [--port 25575] [--password test]
"""
import argparse
import re
import socket
import struct
import sys
import time

ENGINEER, MEDIC, SPY = 8, 9, 1
Y = 200  # build the test platform high up, away from map content


class Rcon:
    def __init__(self, port, password):
        self.sock = socket.create_connection(("127.0.0.1", port), timeout=30)
        self.next_id = 1
        if self._send(3, password)[0] == -1:
            sys.exit("RCON auth failed")

    def _send(self, kind, body):
        self.next_id += 1
        data = struct.pack("<ii", self.next_id, kind) + body.encode() + b"\x00\x00"
        self.sock.sendall(struct.pack("<i", len(data)) + data)
        size = struct.unpack("<i", self._read(4))[0]
        payload = self._read(size)
        return struct.unpack("<i", payload[:4])[0], payload[8:-2].decode(errors="replace")

    def _read(self, n):
        buf = b""
        while len(buf) < n:
            buf += self.sock.recv(n - len(buf))
        return buf

    def __call__(self, cmd):
        return self._send(2, cmd)[1]


class Game:
    def __init__(self, rcon):
        self.r = rcon

    def score(self, selector, objective):
        out = self.r(f"execute as {selector} run scoreboard players get @s {objective}")
        m = re.search(r"has (-?\d+) \[", out)
        return int(m.group(1)) if m else None

    def count(self, selector):
        out = self.r(f"execute if entity {selector}")
        m = re.search(r"Count: (\d+)", out)
        return int(m.group(1)) if m else 0

    def _global(self):
        out = self.r("scoreboard players get $__global__ xrroou1m8_p_join")
        return int(re.search(r"has (-?\d+) \[", out).group(1))

    def ticks(self, n):
        # deterministic: the world stays frozen and we step exactly n ticks,
        # waiting until the datapack's tick counter has moved n times
        start = self._global()
        self.r(f"tick step {n}")
        deadline = time.time() + 60
        while time.time() < deadline and self._global() < start + n:
            time.sleep(0.1)

    def villager(self, tag, x, z, yaw=0, cls=ENGINEER, team=1, pid=0, health=125, metal=None):
        self.r(f"summon villager {x} {Y} {z} {{NoAI:1b,Silent:1b,Invulnerable:1b,"
               f"Tags:[\"t.e\",\"{tag}\"],Rotation:[{yaw}f,0f]}}")
        sel = f"@e[tag={tag},limit=1]"
        for obj, val in [("tf2.class", cls), ("tf2.team", team), ("tf2.player.id", pid),
                         ("tf2.health", health), ("tf2.max_health", 125), ("tf2.batch_number", 0)]:
            self.r(f"scoreboard players set {sel} {obj} {val}")
        if metal is not None:
            self.r(f"scoreboard players set {sel} tf2.metal {metal}")
        return sel

    def reset(self):
        self.r("kill @e[tag=t.e]")
        self.r("kill @e[type=item_display,predicate=tf2:is_a_building]")
        self.r("kill @e[type=item_display,tag=tf2.base]")
        self.r(f"fill -12 {Y - 1} -12 12 {Y - 1} 12 minecraft:stone")
        self.r(f"fill -12 {Y} -12 12 {Y + 4} 12 minecraft:air")

    def build(self, eng, building_type, team=1):
        self.r(f"scoreboard players set {eng} tf2.construction {building_type + 10 * team}")
        self.r(f"execute as {eng} at @s run function tf2:class/engineer/place_building")
        self.r(f"scoreboard players reset {eng} tf2.construction")

    def wrench(self, eng, building):
        # same entry point the melee raycast uses: the swinging Engineer carries iris.executing
        self.r(f"tag {eng} add iris.executing")
        self.r(f"execute as {building} at @s run function tf2:building/wrench_hit")
        self.r("tag @e remove iris.executing")


results = []


def check(name, actual, expected):
    ok = actual == expected
    results.append(ok)
    print(f"  {'PASS' if ok else 'FAIL'}  {name}: got {actual!r}" + ("" if ok else f", expected {expected!r}"))


def check_range(name, actual, lo, hi):
    ok = actual is not None and lo <= actual <= hi
    results.append(ok)
    print(f"  {'PASS' if ok else 'FAIL'}  {name}: got {actual!r}" + ("" if ok else f", expected {lo}..{hi}"))


def test_sentry_construction(g):
    print("Sentry: placement, metal cost, construction")
    g.reset()
    eng = g.villager("t.eng", 0.5, 0.5, yaw=0, pid=9001, metal=200)
    g.build(eng, 0)
    sentry = "@e[type=item_display,tag=tf2.sentry,limit=1]"
    check("sentry spawned", g.count("@e[type=item_display,tag=tf2.sentry]"), 1)
    check("130 metal spent", g.score(eng, "tf2.metal"), 70)
    check("owned by the engineer", g.score(sentry, "tf2.building.owner"), 9001)
    check("starts under construction", g.count("@e[tag=tf2.sentry,tag=tf2.constructing]"), 1)
    check("starts at 1 hp", g.score(sentry, "tf2.health"), 1)
    check("placed in front of the engineer (+z)", g.count(f"@e[tag=tf2.sentry,x=0,y={Y},z=1.6,dx=1,dy=2,dz=1.5]"), 1)

    g.ticks(105)
    check_range("half built at 5.25 s -> about half health", g.score(sentry, "tf2.health"), 70, 80)
    g.ticks(110)
    check("finished after 10.5 s", g.count("@e[tag=tf2.sentry,tag=tf2.constructing]"), 0)
    check("level 1 max health 150", g.score(sentry, "tf2.health"), 150)
    check("level 1 holds 150 shells", g.score(sentry, "tf2.primary_ammo"), 150)

    print("Sentry: placement rules")
    g.build(eng, 0)
    check("second sentry refused", g.count("@e[type=item_display,tag=tf2.sentry]"), 1)
    check("no metal charged for refusal", g.score(eng, "tf2.metal"), 70)
    g.build(eng, 1)
    check("dispenser refused at 70 metal", g.count("@e[type=item_display,tag=tf2.dispenser]"), 0)
    g.r(f"scoreboard players set {eng} tf2.metal 200")
    g.build(eng, 1)
    check("dispenser refused right on top of the sentry", g.count("@e[type=item_display,tag=tf2.dispenser]"), 0)
    g.r(f"setblock 0 {Y} -2 minecraft:stone")
    g.r(f"setblock 0 {Y + 1} -2 minecraft:stone")
    g.r(f"tp {eng} 0.5 {Y} 0.5 180 0")
    g.build(eng, 1)
    check("dispenser refused into a wall", g.count("@e[type=item_display,tag=tf2.dispenser]"), 0)


def test_wrench(g):
    print("Wrench: construction boost, repair, upgrade, ammo")
    g.reset()
    eng = g.villager("t.eng", 0.5, 0.5, pid=9001, metal=200)
    g.build(eng, 0)
    sentry = "@e[type=item_display,tag=tf2.sentry,limit=1]"
    g.ticks(10)
    plain = g.score(sentry, "tf2.building.progress")
    g.wrench(eng, sentry)
    g.ticks(10)
    boosted = g.score(sentry, "tf2.building.progress") - plain
    check("wrench hit makes the next 10 ticks build 2.5x faster", boosted, 250)
    check("construction hits cost no metal", g.score(eng, "tf2.metal"), 70)
    g.ticks(220)

    g.r(f"scoreboard players set {sentry} tf2.health 40")
    g.r(f"scoreboard players set {eng} tf2.metal 200")
    g.wrench(eng, sentry)
    check("repairs 102 hp per swing", g.score(sentry, "tf2.health"), 142)
    check("costs 34 metal (3 hp per metal)", g.score(eng, "tf2.metal"), 166)
    check("no upgrade progress on a repair swing", g.score(sentry, "tf2.building.upgrade_metal"), 0)
    g.wrench(eng, sentry)
    check("tops off to max health", g.score(sentry, "tf2.health"), 150)
    check("only pays for hp restored (8 hp -> 3 metal)", g.score(eng, "tf2.metal"), 163)

    g.r(f"scoreboard players set {eng} tf2.metal 200")
    for _ in range(7):
        g.wrench(eng, sentry)
    check("25 upgrade metal per swing", g.score(sentry, "tf2.building.upgrade_metal"), 175)
    check("still level 1 at 175/200", g.score(sentry, "tf2.building.level"), 1)
    g.r(f"scoreboard players set {sentry} tf2.primary_ammo 100")
    g.wrench(eng, sentry)
    check("8th swing upgrades to level 2", g.score(sentry, "tf2.building.level"), 2)
    check("level 2 max health 180, refilled", g.score(sentry, "tf2.health"), 180)
    check("level 2 shells refilled to 200", g.score(sentry, "tf2.primary_ammo"), 200)
    check("upgrade used exactly 200 metal", g.score(eng, "tf2.metal"), 0)

    g.r(f"scoreboard players set {eng} tf2.metal 200")
    g.r(f"scoreboard players set {sentry} tf2.primary_ammo 120")
    g.r(f"scoreboard players set {sentry} tf2.building.upgrade_metal 0")
    g.wrench(eng, sentry)
    check("ammo swing adds 40 shells", g.score(sentry, "tf2.primary_ammo"), 160)
    check("upgrade + ammo on one swing: 25 + 40 metal", g.score(eng, "tf2.metal"), 135)

    g.r(f"scoreboard players set {sentry} tf2.building.level 3")
    g.r(f"execute as {sentry} run function tf2:building/apply_level")
    check("level 3 max health 216", g.score(sentry, "tf2.max_health"), 216)
    check("level 3 max shells 200", g.score(sentry, "tf2.primary_maxAmmo"), 200)


def test_dispenser(g):
    print("Dispenser: build time, healing, metal storage, cloak, range, line of sight")
    g.reset()
    eng = g.villager("t.eng", 0.5, 0.5, pid=9001, metal=200)
    g.build(eng, 1)
    disp = "@e[type=item_display,tag=tf2.dispenser,limit=1]"
    check("100 metal spent", g.score(eng, "tf2.metal"), 100)
    g.ticks(415)
    check("still building at 20.75 s", g.count("@e[tag=tf2.dispenser,tag=tf2.constructing]"), 1)
    g.r(f"tp {eng} 30 {Y} 30")  # keep the engineer out of range while it finishes
    g.ticks(6)
    check("finished after 21 s", g.count("@e[tag=tf2.dispenser,tag=tf2.constructing]"), 0)
    check("starts with 25 stored metal", g.score(disp, "tf2.building.metal"), 25)

    ally = g.villager("t.ally", 0.5, 3.0, cls=MEDIC, pid=9002, health=20)
    g.ticks(20)
    check("heals 10 hp per second at level 1", g.score(ally, "tf2.health"), 30)

    g.r(f"scoreboard players set {disp} tf2.building.level 3")
    g.r(f"scoreboard players set {ally} tf2.health 20")
    g.ticks(20)
    check("heals 20 hp per second at level 3", g.score(ally, "tf2.health"), 40)
    g.r(f"scoreboard players set {disp} tf2.building.level 1")

    enemy = g.villager("t.enemy", 1.5, 2.5, cls=MEDIC, team=2, pid=9003, health=20)
    g.ticks(20)
    check("does not heal enemies", g.score(enemy, "tf2.health"), 20)
    g.r("kill @e[tag=t.enemy]")

    far = g.villager("t.far", 0.5, 5.5, cls=MEDIC, pid=9004, health=20)
    g.ticks(20)
    check("does not heal outside the 64 HU box", g.score(far, "tf2.health"), 20)
    g.r("kill @e[tag=t.far]")

    # an ally standing behind another ally is still healed (only world geometry blocks)
    # dispenser sits at z=2.1, its box reaches z=3.32; 'behind' is just inside it, 'ally' blocks the ray
    behind = g.villager("t.behind", 0.5, 3.55, cls=MEDIC, pid=9005, health=20)
    g.r(f"tp {ally} 0.5 {Y} 2.75")
    g.ticks(20)
    check("ally behind another ally still healed", g.score(behind, "tf2.health"), 30)
    g.r("kill @e[tag=t.behind]")

    # ally off to the side (+x) with a glass column between it and the dispenser
    g.r(f"tp {ally} 1.9 {Y} 2.1")
    g.r(f"fill 1 {Y} 1 1 {Y + 2} 3 minecraft:glass")
    g.r(f"scoreboard players set {ally} tf2.health 20")
    g.ticks(20)
    check("no healing through a wall", g.score(ally, "tf2.health"), 20)
    g.r(f"fill 1 {Y} 1 1 {Y + 2} 3 minecraft:air")
    g.ticks(20)
    check("heals again once the wall is gone", g.score(ally, "tf2.health"), 30)
    g.r(f"tp {ally} 0.5 {Y} 3.0")

    g.r(f"scoreboard players set {disp} tf2.building.metal 25")
    g.r(f"scoreboard players set {eng} tf2.metal 0")
    g.r(f"tp {eng} 1.5 {Y} 2.5")
    g.ticks(2)
    check("engineer gets metal, capped by storage (25)", g.score(eng, "tf2.metal"), 25)
    check("storage drained", g.score(disp, "tf2.building.metal"), 0)
    g.r(f"scoreboard players set {disp} tf2.building.ticks_idle 0")
    g.r(f"tp {eng} 30 {Y} 30")
    g.ticks(60)
    check("storage refills 40 at 3 s", g.score(disp, "tf2.building.metal"), 40)
    g.ticks(120)
    check("then 40 every 6 s", g.score(disp, "tf2.building.metal"), 80)
    g.r(f"scoreboard players set {disp} tf2.building.metal 390")
    g.ticks(120)
    check("storage caps at 400", g.score(disp, "tf2.building.metal"), 400)


def test_destruction(g):
    print("Destruction PDA and death")
    g.reset()
    eng = g.villager("t.eng", 0.5, 0.5, pid=9001, metal=200)
    g.build(eng, 0)
    g.r(f"scoreboard players set {eng} tf2.destruction 11")
    g.r(f"execute as {eng} at @s run function tf2:class/engineer/remove_building")
    check("dispenser slot empty: sentry untouched", g.count("@e[type=item_display,tag=tf2.sentry]"), 1)
    g.r(f"scoreboard players set {eng} tf2.destruction 10")
    g.r(f"execute as {eng} at @s run function tf2:class/engineer/remove_building")
    check("sentry removed", g.count("@e[type=item_display,tag=tf2.sentry]"), 0)
    check("sentry base removed too", g.count("@e[type=item_display,tag=tf2.base]"), 0)
    check("no metal refund (TF2 rules)", g.score(eng, "tf2.metal"), 70)

    g.r(f"scoreboard players set {eng} tf2.metal 200")
    g.build(eng, 1)
    disp = "@e[type=item_display,tag=tf2.dispenser,limit=1]"
    g.r(f"scoreboard players set {disp} tf2.health 0")
    g.ticks(1)
    check("building at 0 hp is destroyed", g.count("@e[type=item_display,tag=tf2.dispenser]"), 0)
    g.build(eng, 1)
    check("can rebuild after destruction", g.count("@e[type=item_display,tag=tf2.dispenser]"), 1)


def test_integration(g):
    print("Integration with existing sentry targeting, Spy cloak, class change")
    g.reset()
    eng = g.villager("t.eng", 0.5, 0.5, pid=9001, metal=200)
    enemy = g.villager("t.enemy", 0.5, 8.5, cls=MEDIC, team=2, pid=9010)
    g.build(eng, 0)
    sentry = "@e[type=item_display,tag=tf2.sentry,limit=1]"
    g.ticks(40)
    check("sentry under construction picks no target", g.score(sentry, "tf2.building.target"), None)
    g.ticks(180)
    check("finished sentry locks onto the enemy", g.score(sentry, "tf2.building.target"), 9010)
    g.r("kill @e[tag=t.enemy]")

    g.r(f"scoreboard players set {eng} tf2.metal 200")
    g.r(f"tp {eng} 4.5 {Y} 0.5")
    g.build(eng, 1)
    disp = "@e[type=item_display,tag=tf2.dispenser,limit=1]"
    g.r(f"scoreboard players set {disp} tf2.building.progress 99999")
    g.r(f"tp {eng} 30 {Y} 30")
    g.ticks(2)
    spy = g.villager("t.spy", 4.5, 3.0, cls=SPY, pid=9011)
    g.r(f"item replace entity {spy} weapon.offhand with minecraft:white_dye"
        "[minecraft:custom_data={attributes:{cloak_recharge:30.0}}]")
    g.r(f"scoreboard players set {spy} tf2.cloak 0")
    g.ticks(10)
    check("first cloak dispense is immediate: 10% of 600", g.score(spy, "tf2.cloak"), 60)
    g.ticks(20)
    check("then another 10% one second later", g.score(spy, "tf2.cloak"), 120)

    g.r(f"scoreboard players set {eng} tf2.class {MEDIC}")
    g.r(f"execute as {eng} run function tf2:class_select")
    check("switching off Engineer destroys the sentry", g.count("@e[type=item_display,tag=tf2.sentry]"), 0)
    check("and the dispenser", g.count("@e[type=item_display,tag=tf2.dispenser]"), 0)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--port", type=int, default=25575)
    ap.add_argument("--password", default="test")
    args = ap.parse_args()
    g = Game(Rcon(args.port, args.password))
    g.r("forceload add -16 -16 16 16")
    g.r("tick freeze")
    try:
        for test in (test_sentry_construction, test_wrench, test_dispenser, test_destruction, test_integration):
            test(g)
    finally:
        g.reset()
        g.r("tick unfreeze")
    print(f"\n{sum(results)}/{len(results)} checks passed")
    sys.exit(0 if all(results) else 1)


main()
