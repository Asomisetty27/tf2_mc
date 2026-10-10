function tf2:building/tag_owned
scoreboard players set $already_built tf2.var 0
execute if score $type tf2.var matches 0 if entity @e[tag=tf2.owned,tag=tf2.sentry] run scoreboard players set $already_built tf2.var 1
execute if score $type tf2.var matches 1 if entity @e[tag=tf2.owned,tag=tf2.dispenser] run scoreboard players set $already_built tf2.var 1
execute if score $type tf2.var matches 2 if entity @e[tag=tf2.owned,tag=tf2.tele_entrance] run scoreboard players set $already_built tf2.var 1
execute if score $type tf2.var matches 3 if entity @e[tag=tf2.owned,tag=tf2.tele_exit] run scoreboard players set $already_built tf2.var 1
tag @e remove tf2.owned
execute if score $already_built tf2.var matches 1.. run return run tellraw @s {"text":"You already have one of those built. Use the Destruction PDA to remove it first.","color":"yellow","italic":true,"type":"text"}
scoreboard players set $cost tf2.var 130
execute if score $type tf2.var matches 1 run scoreboard players set $cost tf2.var 100
execute if score $type tf2.var matches 2.. run scoreboard players set $cost tf2.var 50
execute if score @s tf2.metal < $cost tf2.var run return run tellraw @s ["",{"text":"Not enough metal. That costs ","color":"yellow","italic":true,"type":"text"},{"score":{"name":"$cost","objective":"tf2.var"},"color":"yellow","type":"score"},{"text":", you have ","color":"yellow"},{"score":{"name":"@s","objective":"tf2.metal"},"color":"yellow","type":"score"},{"text":".","color":"yellow"}]
execute if entity @s[tag=tf2.in_spawn] run return run tellraw @s {"text":"You can't build inside a spawn room.","color":"yellow","italic":true,"type":"text"}
execute store result score $yaw tf2.var run data get entity @s Rotation[0] 100
scoreboard players set $placed tf2.var 0
execute rotated ~ 0 positioned ^ ^ ^1.6 align y run function tf2:__private__/anonymous/9
execute if score $placed tf2.var matches 2 run return run tellraw @s {"text":"Too close to another building.","color":"yellow","italic":true,"type":"text"}
execute unless score $placed tf2.var matches 1.. run return run tellraw @s {"text":"Can't build there. Face open, flat ground.","color":"yellow","italic":true,"type":"text"}
scoreboard players operation @s tf2.metal -= $cost tf2.var
return 1