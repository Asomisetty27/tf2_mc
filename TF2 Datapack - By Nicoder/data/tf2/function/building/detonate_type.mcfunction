function tf2:building/tag_owned
scoreboard players set $found tf2.var 0
execute if score $type tf2.var matches 0 store result score $found tf2.var if entity @e[tag=tf2.owned,tag=tf2.sentry]
execute if score $type tf2.var matches 1 store result score $found tf2.var if entity @e[tag=tf2.owned,tag=tf2.dispenser]
execute if score $type tf2.var matches 0 as @e[tag=tf2.owned,tag=tf2.sentry] at @s run function tf2:building/destroyed
execute if score $type tf2.var matches 1 as @e[tag=tf2.owned,tag=tf2.dispenser] at @s run function tf2:building/destroyed
tag @e remove tf2.owned
execute if score $type tf2.var matches 2.. run return run tellraw @s {"text":"Teleporters aren't in yet.","color":"yellow","italic":true,"type":"text"}
execute unless score $found tf2.var matches 1.. run tellraw @s {"text":"You don't have one of those built.","color":"yellow","italic":true,"type":"text"}