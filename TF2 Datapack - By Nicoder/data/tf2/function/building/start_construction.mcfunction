tag @s remove tf2.just_spawned
tag @s add tf2.constructing
scoreboard players set @s tf2.building.progress 0
scoreboard players set @s tf2.building.boost 0
scoreboard players set @s tf2.building.granted_hp 0
scoreboard players set @s tf2.building.upgrade_metal 0
scoreboard players set @s tf2.health 1
scoreboard players set @s tf2.primary_ammo 0
data modify entity @s interpolation_duration set value 2
execute on vehicle run data modify entity @s interpolation_duration set value 2
function tf2:building/construction_visual