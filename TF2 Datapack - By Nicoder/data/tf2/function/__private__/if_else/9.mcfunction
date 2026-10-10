execute store result score $full_cloak tf2.var run data get entity @s equipment.offhand.components.minecraft:custom_data.attributes.cloak_recharge 20
scoreboard players operation $add_amount tf2.var = $cloak tf2.var
scoreboard players operation $add_amount tf2.var *= $full_cloak tf2.var
scoreboard players add $add_amount tf2.var 99
scoreboard players operation $add_amount tf2.var /= 100 tf2.const
scoreboard players operation @s tf2.cloak += $add_amount tf2.var
scoreboard players operation @s tf2.cloak < $full_cloak tf2.var