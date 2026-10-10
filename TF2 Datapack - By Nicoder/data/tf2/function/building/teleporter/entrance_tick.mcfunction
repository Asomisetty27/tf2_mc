scoreboard players remove @s[scores={tf2.attack_delay=1..}] tf2.attack_delay 1
execute if score @s tf2.building.tele_timer matches 1.. run function tf2:__private__/if_else/16
scoreboard players set $ready tf2.var 1
execute unless entity @e[tag=tf2.tele_match,tag=!tf2.constructing] run scoreboard players set $ready tf2.var 0
execute if entity @s[tag=tf2.sapped] run scoreboard players set $ready tf2.var 0
execute if entity @e[tag=tf2.tele_match,tag=tf2.sapped] run scoreboard players set $ready tf2.var 0
execute if entity @e[tag=tf2.tele_match,scores={tf2.building.disable_ticks=1..}] run scoreboard players set $ready tf2.var 0
execute if score @s tf2.attack_delay matches 1.. run scoreboard players set $ready tf2.var 0
execute if score @s tf2.building.tele_timer matches 1.. run scoreboard players set $ready tf2.var 0
execute unless score $ready tf2.var matches 1.. run return run tag @s remove tf2.tele_ready
execute if entity @s[tag=!tf2.tele_ready] run function tf2:__private__/if_else/17
scoreboard players operation $particle_timer tf2.var = $__global__ xrroou1m8_p_join
scoreboard players operation $particle_timer tf2.var %= 10 tf2.const
execute if score $particle_timer tf2.var matches 0 run particle minecraft:portal ~ ~-0.6 ~ 0.25 0.05 0.25 0.2 4
scoreboard players operation $temp tf2.team = @s tf2.team
execute positioned ~-0.4572 ~-0.875 ~-0.4572 as @e[type=#tf2:player_like,dx=0.9144,dy=0.3,dz=0.9144,tag=!tf2.dead] unless entity @s[gamemode=spectator] run tag @s add tf2.tele_candidate
execute as @e[tag=tf2.tele_candidate] unless score @s tf2.team = $temp tf2.team unless entity @s[scores={tf2.class=1}] run tag @s remove tf2.tele_candidate
execute as @e[type=player,tag=tf2.tele_candidate] run function tf2:building/teleporter/require_standing_still
execute if entity @e[tag=tf2.tele_candidate] run function tf2:building/teleporter/send
tag @e remove tf2.tele_candidate