tag @s add tf2.sapped
scoreboard players set @s tf2.building.sapper_hp 100
scoreboard players operation @s tf2.building.sapper_owner = $spy_id tf2.var
scoreboard players reset @s[tag=tf2.sentry] tf2.building.target
playsound minecraft:block.redstone_torch.burnout block @a ~ ~ ~ 0.8 0.7
particle minecraft:electric_spark ~ ~0.3 ~ 0.3 0.3 0.3 0.1 15
function tf2:building/sentry/get_owner
execute if entity @s[tag=tf2.sentry] run tellraw @a[tag=tf2.owner] {"text":"Your Sentry Gun is being sapped!","color":"red","type":"text"}
execute if entity @s[tag=tf2.dispenser] run tellraw @a[tag=tf2.owner] {"text":"Your Dispenser is being sapped!","color":"red","type":"text"}
execute if entity @s[tag=tf2.tele_entrance] run tellraw @a[tag=tf2.owner] {"text":"Your Teleporter Entrance is being sapped!","color":"red","type":"text"}
execute if entity @s[tag=tf2.tele_exit] run tellraw @a[tag=tf2.owner] {"text":"Your Teleporter Exit is being sapped!","color":"red","type":"text"}
tag @a remove tf2.owner