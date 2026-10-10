scoreboard players add @s tf2.building.level 1
scoreboard players set @s tf2.building.upgrade_metal 0
function tf2:building/apply_level
scoreboard players operation @s tf2.health = @s tf2.max_health
scoreboard players operation @s[tag=tf2.sentry] tf2.primary_ammo = @s tf2.primary_maxAmmo
playsound minecraft:block.beacon.power_select block @a ~ ~ ~ 0.7 1.2
particle minecraft:totem_of_undying ~ ~0.6 ~ 0.3 0.4 0.3 0.2 20