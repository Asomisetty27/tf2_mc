# Building tests

`test_buildings.py` checks the Engineer buildings against a real Minecraft 26.2 server over RCON. Villagers stand in for players (they're in `#tf2:player_like`), so no game client is needed. The world stays frozen and the script steps exact tick counts, so results are repeatable.

```
tests/setup_server.sh ../tf2-test-server
cd ../tf2-test-server && java -jar server.jar nogui      # Java 25
python3 tests/test_buildings.py --port 25598             # from the repo root, in another terminal
```

After recompiling, run `setup_server.sh` again to copy the new datapack in, then `/reload`.

What it covers (93 checks): placement and metal cost, the one-of-each rule, walls and overlapping buildings, build time and health ramp, wrench construction boost, repair, upgrade and sentry ammo, per-level health and shells, dispenser healing rate, range, line of sight, metal storage and refill timing, Spy cloak, the Destruction PDA, destruction at 0 HP, sentries acquiring targets once built, buildings blowing up when the Engineer switches class, and teleporters (send timing, arrival position and facing, recharge per level, enemy Spies allowed and other enemies not, telefrags, shared repair and upgrades, a rebuilt end inheriting the pair's level).

Not covered: anything that needs a real player (PDA dialogs, HUD, kill feed, ammo pack pickups, void deaths).

## Compiler

The pack needs JMC from source (`WingedSeal/jmc` main). Current main rejects macro arguments after `matches` (`unless score @s tf2.team matches $(opp_team)` in `main.jmc`), so apply `jmc-matches-macro.patch` first:

```
git clone https://github.com/WingedSeal/jmc && cd jmc
git apply ../tf2_mc/tests/jmc-matches-macro.patch
pip install ./src
```

With that patch, compiling the unmodified pack reproduces the committed `data/` output byte for byte.
