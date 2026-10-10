#!/usr/bin/env bash
# Sets up a headless Minecraft 26.2 server for tests/test_buildings.py.
#
#   tests/setup_server.sh <server-dir>
#   cd <server-dir> && java -jar server.jar nogui     # needs Java 25
#   python3 tests/test_buildings.py --port 25598
#
# Re-run it after recompiling to copy the fresh datapack in, then /reload over RCON.
set -euo pipefail

DIR="${1:?usage: setup_server.sh <server-dir>}"
REPO="$(cd "$(dirname "$0")/.." && pwd)"
SERVER_SHA1=823e2250d24b3ddac457a60c92a6a941943fcd6a   # official 26.2 server.jar
mkdir -p "$DIR/world/datapacks" && cd "$DIR"

if [ ! -f server.jar ]; then
    curl -fsSL -o server.jar "https://piston-data.mojang.com/v1/objects/$SERVER_SHA1/server.jar"
    echo "$SERVER_SHA1  server.jar" | shasum -c -
fi
echo eula=true > eula.txt
[ -f server.properties ] || cat > server.properties <<'EOF'
online-mode=false
level-type=minecraft\:flat
server-port=25599
enable-rcon=true
rcon.port=25598
rcon.password=test
pause-when-empty-seconds=-1
EOF

relax_mcmeta() {
    # the dependency packs declare old formats; let 26.2 load them anyway
    python3 - "$1" <<'EOF'
import json, sys
d = json.load(open(sys.argv[1])); p = d["pack"]
for k in ("pack_format", "supported_formats"): p.pop(k, None)
p["min_format"], p["max_format"] = [1, 0], [999, 0]
json.dump(d, open(sys.argv[1], "w"), indent=1)
EOF
}

# Iris: the GitHub repo has no generated hitbox tables, so start from the 25w06a release build,
# layer Nico's fork on top, and fix the 1.21.9 rename of minecraft:chain to minecraft:iron_chain
if [ ! -d world/datapacks/Iris ]; then
    tmp="$(mktemp -d)"
    curl -fsSL -o "$tmp/iris.zip" https://github.com/Aeldrion/Iris/releases/download/25w06a/Iris-25w06a.zip
    mkdir world/datapacks/Iris && unzip -q "$tmp/iris.zip" -d world/datapacks/Iris
    git clone -q --depth 1 https://github.com/Nico314159/Iris.git "$tmp/fork"
    rsync -a --exclude .git --exclude build --exclude README.md --exclude LICENSE "$tmp/fork/" world/datapacks/Iris/
    for f in function/get_hitbox/block/tree/1.mcfunction function/get_hitbox/block/shape_groups/chain.mcfunction tags/block/tree/1.json; do
        sed -i.bak -E 's/minecraft:chain([^_a-z])/minecraft:iron_chain\1/g' "world/datapacks/Iris/data/iris/$f"
        rm "world/datapacks/Iris/data/iris/$f.bak"
    done
    relax_mcmeta world/datapacks/Iris/pack.mcmeta
fi

if [ ! -d world/datapacks/player_motion ]; then
    tmp="$(mktemp -d)"
    git clone -q --depth 1 https://github.com/MulverineX/player_motion.git "$tmp/pm"
    cp -R "$tmp/pm/player_motion" world/datapacks/player_motion
    relax_mcmeta world/datapacks/player_motion/pack.mcmeta
fi

rsync -a --delete --exclude .git "$REPO/TF2 Datapack - By Nicoder/" world/datapacks/tf2/
echo "Server ready in $DIR"
