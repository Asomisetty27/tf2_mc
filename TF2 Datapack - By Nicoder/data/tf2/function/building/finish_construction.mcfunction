tag @s remove tf2.constructing
scoreboard players operation @s tf2.health < @s tf2.max_health
data modify entity @s transformation.translation[1] set value 0.0f
execute on vehicle run data modify entity @s transformation.translation[1] set value 0.0f
scoreboard players operation @s[tag=tf2.sentry] tf2.primary_ammo = @s tf2.primary_maxAmmo
scoreboard players set @s[tag=tf2.dispenser] tf2.building.metal 25
scoreboard players set @s tf2.building.ticks_idle 0
scoreboard players set @s[tag=tf2.teleporter] tf2.attack_delay 0
execute if entity @s[tag=tf2.teleporter] run function tf2:building/teleporter/sync_upgrades
playsound minecraft:block.beacon.activate block @a ~ ~ ~ 0.5 1.6