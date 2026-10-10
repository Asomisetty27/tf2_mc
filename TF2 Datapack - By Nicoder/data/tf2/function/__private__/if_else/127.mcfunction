scoreboard players operation $add_amount tf2.var = $percent tf2.var
scoreboard players operation $add_amount tf2.var *= 200 tf2.const
scoreboard players operation $add_amount tf2.var /= 100 tf2.const
scoreboard players operation @s tf2.metal += $add_amount tf2.var
scoreboard players operation @s tf2.metal < 200 tf2.const