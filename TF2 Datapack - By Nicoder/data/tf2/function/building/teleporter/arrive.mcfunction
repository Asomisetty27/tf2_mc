scoreboard players operation $traveler tf2.building.tele_player = @s tf2.building.tele_player
execute as @e[type=#tf2:player_like,tag=!tf2.dead] if score @s tf2.player.id = $traveler tf2.building.tele_player run tag @s add tf2.tele_traveler
scoreboard players reset @s tf2.building.tele_player
execute if entity @e[tag=tf2.tele_match,tag=!tf2.constructing] if entity @e[tag=tf2.tele_traveler] run function tf2:__private__/if_else/18
tag @e remove tf2.tele_traveler