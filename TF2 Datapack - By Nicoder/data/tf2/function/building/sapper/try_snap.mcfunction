execute if entity @e[tag=tf2.sap_target] run return 0
tag @s add tf2.sap_checking
data modify storage iris:settings TargetEntities set value false
data modify storage iris:settings MaxRecursionDepth set value 4
execute as @e[type=#tf2:player_like,tag=tf2.sapping,limit=1] at @s anchored eyes positioned ^ ^ ^ facing entity @e[tag=tf2.sap_checking,limit=1] feet run function iris:get_target
scoreboard players set $blocked tf2.var 0
execute if data storage iris:output {TargetType:"BLOCK"} run function tf2:building/sapper/compare_wall_distance with storage iris:output
execute unless score $blocked tf2.var matches 1.. run tag @s add tf2.sap_target
tag @s remove tf2.sap_checking