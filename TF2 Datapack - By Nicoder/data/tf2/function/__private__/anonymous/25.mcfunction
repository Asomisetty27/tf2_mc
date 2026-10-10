function tf2:building/teleporter/tag_match
execute as @e[tag=tf2.tele_match,tag=tf2.sapped] at @s run function tf2:building/sapper/damage_sapper
tag @e remove tf2.tele_match