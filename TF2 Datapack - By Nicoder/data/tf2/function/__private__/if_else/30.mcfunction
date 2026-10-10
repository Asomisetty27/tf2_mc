scoreboard players set $add tf2.var 200
scoreboard players operation $add tf2.var -= @s tf2.building.upgrade_metal
scoreboard players operation $add tf2.var < 25 tf2.const
scoreboard players operation $add tf2.var < $metal tf2.var
scoreboard players operation $metal tf2.var -= $add tf2.var
scoreboard players operation @s tf2.building.upgrade_metal += $add tf2.var
particle minecraft:wax_off ~ ~0.6 ~ 0.3 0.3 0.3 0 4
scoreboard players operation @e[tag=tf2.tele_match] tf2.building.upgrade_metal = @s tf2.building.upgrade_metal
execute if score @s tf2.building.upgrade_metal matches 200.. run function tf2:__private__/if_else/29