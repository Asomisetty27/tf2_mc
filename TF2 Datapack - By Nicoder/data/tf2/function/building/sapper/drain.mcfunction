scoreboard players operation $particle_timer tf2.var = $__global__ xrroou1m8_p_join
scoreboard players operation $particle_timer tf2.var %= 5 tf2.const
execute if score $particle_timer tf2.var matches 0 run particle minecraft:electric_spark ~ ~0.3 ~ 0.25 0.25 0.25 0.05 3
scoreboard players operation $drain_timer tf2.var = $__global__ xrroou1m8_p_join
scoreboard players operation $drain_timer tf2.var %= 4 tf2.const
execute unless score $drain_timer tf2.var matches 0 run return 0
data modify storage tf2:lookup damages append value {kill_verb:"destroyed",weapon:[{text:"Sapper",italic:true,color:"gray"}]}
execute store result storage tf2:lookup damages[-1].cause int 1 run scoreboard players get @s tf2.building.sapper_owner
execute store result storage tf2:lookup damages[-1].target int 1 run scoreboard players get @s tf2.player.id
data modify storage tf2:lookup damages[-1].amount set value 5
return 1