scoreboard players operation $particle_timer tf2.var = $__global__ xrroou1m8_p_join
scoreboard players operation $particle_timer tf2.var %= 5 tf2.const
execute unless score $particle_timer tf2.var matches 0 run return 0
execute if score @s tf2.team matches 1 at @s anchored eyes positioned ^ ^-0.4 ^0.3 run particle minecraft:dust{color:[0.85,0.25,0.25],scale:0.8} ~ ~ ~ 0.15 0.15 0.15 0 3
execute if score @s tf2.team matches 2 at @s anchored eyes positioned ^ ^-0.4 ^0.3 run particle minecraft:dust{color:[0.3,0.45,0.9],scale:0.8} ~ ~ ~ 0.15 0.15 0.15 0 3