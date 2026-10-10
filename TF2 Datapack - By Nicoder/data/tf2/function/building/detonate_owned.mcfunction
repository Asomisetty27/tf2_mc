function tf2:building/tag_owned
execute as @e[tag=tf2.owned] at @s run function tf2:building/destroyed
tag @e remove tf2.owned