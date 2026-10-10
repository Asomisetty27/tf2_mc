scoreboard players operation @s tf2.building.tele_player = @n[tag=tf2.tele_candidate] tf2.player.id
scoreboard players set @s tf2.building.tele_timer 7
tag @s remove tf2.tele_ready
scoreboard players set @s tf2.attack_delay 210
scoreboard players set @s[scores={tf2.building.level=2}] tf2.attack_delay 110
scoreboard players set @s[scores={tf2.building.level=3..}] tf2.attack_delay 70
playsound minecraft:entity.enderman.teleport block @a ~ ~ ~ 0.7 1.3
particle minecraft:reverse_portal ~ ~-0.4 ~ 0.25 0.5 0.25 0.05 30
execute at @e[tag=tf2.tele_match,limit=1] run particle minecraft:portal ~ ~-0.4 ~ 0.25 0.5 0.25 0.5 30