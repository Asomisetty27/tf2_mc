scoreboard players set $rate tf2.var 10
execute if score @s tf2.building.boost matches 1.. run function tf2:__private__/if_else/24
scoreboard players operation @s tf2.building.progress += $rate tf2.var
scoreboard players set $total tf2.var 2100
execute if entity @s[tag=tf2.dispenser] run scoreboard players set $total tf2.var 4200
execute if entity @s[tag=tf2.teleporter] run scoreboard players set $total tf2.var 4200
scoreboard players operation @s tf2.building.progress < $total tf2.var
scoreboard players operation $granted tf2.var = @s tf2.max_health
scoreboard players operation $granted tf2.var *= @s tf2.building.progress
scoreboard players operation $granted tf2.var /= $total tf2.var
scoreboard players operation $gain tf2.var = $granted tf2.var
scoreboard players operation $gain tf2.var -= @s tf2.building.granted_hp
scoreboard players operation @s tf2.health += $gain tf2.var
scoreboard players operation @s tf2.building.granted_hp = $granted tf2.var
scoreboard players operation @s tf2.health < @s tf2.max_health
scoreboard players operation $visual_tick tf2.var = $__global__ xrroou1m8_p_join
scoreboard players operation $visual_tick tf2.var %= 2 tf2.const
execute if score $visual_tick tf2.var matches 0 run function tf2:building/construction_visual
scoreboard players operation $particle_tick tf2.var = $__global__ xrroou1m8_p_join
scoreboard players operation $particle_tick tf2.var %= 10 tf2.const
execute if score $particle_tick tf2.var matches 0 run particle minecraft:crit ~ ~0.4 ~ 0.3 0.2 0.3 0 3
execute if score @s tf2.building.progress >= $total tf2.var run function tf2:building/finish_construction