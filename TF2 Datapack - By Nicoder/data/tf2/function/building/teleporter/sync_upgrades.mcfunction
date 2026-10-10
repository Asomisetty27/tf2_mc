function tf2:building/teleporter/tag_match
execute as @e[tag=tf2.tele_match,tag=!tf2.constructing,limit=1] run function tf2:__private__/anonymous/8
execute if entity @e[tag=tf2.tele_match,tag=!tf2.constructing] run function tf2:__private__/if_else/20
tag @e remove tf2.tele_match