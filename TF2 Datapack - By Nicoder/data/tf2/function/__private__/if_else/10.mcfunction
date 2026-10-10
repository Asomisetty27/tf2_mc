scoreboard players set $give tf2.var 200
scoreboard players operation $give tf2.var -= @s tf2.metal
scoreboard players operation $give tf2.var < $metal_to_give tf2.var
scoreboard players operation $give tf2.var < $dispenser_metal tf2.var
scoreboard players operation @s tf2.metal += $give tf2.var
scoreboard players operation $dispenser_metal tf2.var -= $give tf2.var