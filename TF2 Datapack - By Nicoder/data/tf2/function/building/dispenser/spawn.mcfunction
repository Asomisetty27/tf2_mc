summon item_display ~ ~0.875 ~ {Rotation:[0.0f,0.0f],Tags:["tf2.dispenser","tf2.can_be_shot","tf2.new","tf2.just_spawned"],CustomName:"Dispenser",CustomNameVisible:false,item:{id:"minecraft:white_dye",components:{"minecraft:item_model":"tf2:building/dispenser","minecraft:custom_model_data":{floats:[1,1]},}},transformation:{right_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[1.75f,1.75f,1.75f],left_rotation:[0.0f,0.0f,0.0f,1.0f],translation:[0.0f,0.0f,0.0f]},}
scoreboard players operation $id tf2.var = @s tf2.player.id
execute store result score @s tf2.batch_number run scoreboard players operation $batch tf2.var = @s tf2.batch_number
execute as @n[tag=tf2.new] store result entity @s item.components.minecraft:custom_model_data.floats[0] int 1 run execute store result score @s tf2.team run data get storage tf2:summon dispenser.team
execute as @n[tag=tf2.new] store result entity @s item.components.minecraft:custom_model_data.floats[1] int 1 run execute store result score @s tf2.building.level run data get storage tf2:summon dispenser.level
execute as @n[tag=tf2.new] run scoreboard players set @s tf2.attack_delay 0
execute as @n[tag=tf2.new] run scoreboard players set @s tf2.building.ticks_idle 0
execute as @n[tag=tf2.new] run scoreboard players set @s tf2.building.metal 25
execute as @n[tag=tf2.new] run scoreboard players set @s tf2.building.upgrade_metal 0
execute as @n[tag=tf2.new] run scoreboard players add $global tf2.player.id 1
execute as @n[tag=tf2.new] run scoreboard players operation @s tf2.player.id = $global tf2.player.id
execute as @n[tag=tf2.new] run scoreboard players operation @s tf2.building.owner = $id tf2.var
execute as @n[tag=tf2.new] run scoreboard players operation @s tf2.batch_number = $batch tf2.var
execute as @n[tag=tf2.new] run scoreboard players set @s tf2.hitbox 1500
execute as @n[tag=tf2.new] run function tf2:building/apply_level
execute as @n[tag=tf2.new] run scoreboard players operation @s tf2.health = @s tf2.max_health
execute as @n[tag=tf2.new] run tag @s remove tf2.new