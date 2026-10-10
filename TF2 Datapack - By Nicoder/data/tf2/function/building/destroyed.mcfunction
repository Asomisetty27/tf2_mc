particle minecraft:explosion ~ ~0.5 ~ 0.2 0.2 0.2 0 2
playsound minecraft:entity.generic.explode block @a ~ ~ ~ 0.8 1.2
function tf2:building/sentry/get_owner
execute if entity @s[tag=tf2.sentry] run tellraw @a[tag=tf2.owner] {"text":"Your Sentry Gun was destroyed!","color":"red","type":"text"}
execute if entity @s[tag=tf2.dispenser] run tellraw @a[tag=tf2.owner] {"text":"Your Dispenser was destroyed!","color":"red","type":"text"}
execute if entity @s[tag=tf2.tele_entrance] run tellraw @a[tag=tf2.owner] {"text":"Your Teleporter Entrance was destroyed!","color":"red","type":"text"}
execute if entity @s[tag=tf2.tele_exit] run tellraw @a[tag=tf2.owner] {"text":"Your Teleporter Exit was destroyed!","color":"red","type":"text"}
tag @a remove tf2.owner
execute on vehicle run kill @s
kill @s