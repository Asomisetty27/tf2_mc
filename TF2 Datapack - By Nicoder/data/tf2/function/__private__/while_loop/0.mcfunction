tag @n[tag=tf2.dispenser_candidate] add tf2.los_checking
tag @e[tag=tf2.dispenser_candidate,tag=!tf2.los_checking] add tf2.los_ignore
execute at @s positioned ~ ~.25 ~ facing entity @n[tag=tf2.los_checking] eyes run function tf2:raycast/informational
tag @e[tag=tf2.los_checking,tag=iris.targeted_entity] add tf2.ally_in_range
tag @e[tag=tf2.dispenser_candidate,tag=!tf2.los_checking] remove tf2.los_ignore
tag @e[tag=tf2.los_checking] add tf2.los_ignore
tag @e[tag=tf2.los_checking] remove tf2.dispenser_candidate
tag @e[tag=tf2.los_checking] remove tf2.los_checking
execute if entity @e[tag=tf2.dispenser_candidate] run function tf2:__private__/while_loop/0