tag @e[type=#tf2:player_like,tag=!tf2.dispenser_candidate] add tf2.los_ignore
tag @e[type=item_display,predicate=tf2:is_a_building] add tf2.los_ignore
execute if entity @e[tag=tf2.dispenser_candidate] run function tf2:__private__/while_loop/0
tag @e[tag=tf2.los_ignore] remove tf2.los_ignore