tag @s remove tf2.new
execute if score @s tf2.health matches ..0 run return run function tf2:building/teleporter/die
execute if entity @s[tag=tf2.constructing] run return run function tf2:building/construction_tick
execute if entity @s[tag=tf2.tele_exit] run return 0
function tf2:building/teleporter/tag_match
function tf2:building/teleporter/entrance_tick
tag @e remove tf2.tele_match