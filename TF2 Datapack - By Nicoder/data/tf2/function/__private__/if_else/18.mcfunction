scoreboard players operation $traveler_team tf2.team = @n[tag=tf2.tele_traveler] tf2.team
scoreboard players operation $traveler_id tf2.player.id = @n[tag=tf2.tele_traveler] tf2.player.id
execute at @e[tag=tf2.tele_match,limit=1] positioned ~-0.55 ~-0.875 ~-0.55 as @e[type=#tf2:player_like,dx=1.1,dy=1.8,dz=1.1,tag=!tf2.dead,tag=!tf2.tele_traveler] unless score @s tf2.team = $traveler_team tf2.team run function tf2:building/teleporter/telefrag
execute as @e[tag=tf2.tele_traveler] at @e[tag=tf2.tele_match,limit=1] rotated as @e[tag=tf2.tele_match,limit=1] positioned ~ ~-0.627 ~ run tp @s ~ ~ ~ ~ 0
execute at @e[tag=tf2.tele_match,limit=1] run function tf2:__private__/anonymous/7