scoreboard players set $total tf2.var 2100
scoreboard players set $height tf2.var 1250
execute if entity @s[tag=tf2.dispenser] run function tf2:__private__/if_else/19
scoreboard players operation $depth tf2.var = $total tf2.var
scoreboard players operation $depth tf2.var -= @s tf2.building.progress
scoreboard players operation $depth tf2.var *= $height tf2.var
scoreboard players operation $depth tf2.var /= $total tf2.var
scoreboard players operation $depth tf2.var *= -1 tf2.const
execute store result entity @s transformation.translation[1] float 0.001 run scoreboard players get $depth tf2.var
data modify entity @s start_interpolation set value 0
execute on vehicle run function tf2:__private__/anonymous/9