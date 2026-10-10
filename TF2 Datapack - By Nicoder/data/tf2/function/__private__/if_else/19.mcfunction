scoreboard players operation @s tf2.building.level = $match_level tf2.building.level
scoreboard players operation @s tf2.building.upgrade_metal = $match_metal tf2.building.upgrade_metal
function tf2:building/apply_level
scoreboard players operation @s tf2.health = @s tf2.max_health