tag @s remove tf2.new
execute if score @s tf2.health matches ..0 run return run function tf2:building/dispenser/die
execute if entity @s[tag=tf2.constructing] run return run function tf2:building/construction_tick
execute if entity @s[tag=tf2.sapped] run return fail
function tf2:building/dispenser/refill_storage
scoreboard players remove @s[scores={tf2.attack_delay=1..}] tf2.attack_delay 1
scoreboard players operation $temp tf2.team = @s tf2.team
execute positioned ~-1.2192 ~-1.5702 ~-1.2192 run function tf2:__private__/anonymous/4
execute unless entity @e[tag=tf2.dispenser_candidate] run return 0
function tf2:building/dispenser/check_line_of_sight
execute unless entity @e[tag=tf2.ally_in_range] run return 0
function tf2:building/dispenser/calculate_amounts
scoreboard players operation $dispenser_metal tf2.var = @s tf2.building.metal
execute as @e[tag=tf2.ally_in_range] run function tf2:building/dispenser/heal
scoreboard players operation @s tf2.building.metal = $dispenser_metal tf2.var
execute at @s as @e[tag=tf2.ally_in_range] run function tf2:building/dispenser/heal_particles
execute if score $dispense tf2.var matches 1.. run scoreboard players set @s tf2.attack_delay 20
tag @e remove tf2.ally_in_range