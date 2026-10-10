scoreboard players set @s tf2.max_health 150
scoreboard players set @s[scores={tf2.building.level=2}] tf2.max_health 180
scoreboard players set @s[scores={tf2.building.level=3}] tf2.max_health 216
scoreboard players set @s[tag=tf2.sentry] tf2.primary_maxAmmo 150
scoreboard players set @s[tag=tf2.sentry,scores={tf2.building.level=2..}] tf2.primary_maxAmmo 200
execute store result entity @s item.components.minecraft:custom_model_data.floats[1] int 1 run scoreboard players get @s tf2.building.level
execute if entity @s[tag=tf2.sentry] run function tf2:__private__/anonymous/8