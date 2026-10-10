tag @s remove tf2.sapped
scoreboard players set @s tf2.building.sapper_hp 0
scoreboard players reset @s tf2.building.sapper_owner
scoreboard players set @s tf2.building.disable_ticks 10
particle minecraft:smoke ~ ~0.4 ~ 0.2 0.2 0.2 0.02 8
playsound minecraft:entity.item.break block @a ~ ~ ~ 0.7 0.8