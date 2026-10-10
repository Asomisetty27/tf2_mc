scoreboard players operation $repair tf2.var < 102 tf2.const
scoreboard players operation $affordable tf2.var = $metal tf2.var
scoreboard players operation $affordable tf2.var *= 3 tf2.const
scoreboard players operation $repair tf2.var < $affordable tf2.var
scoreboard players operation $cost tf2.var = $repair tf2.var
scoreboard players add $cost tf2.var 2
scoreboard players operation $cost tf2.var /= 3 tf2.const
scoreboard players operation @s tf2.health += $repair tf2.var
scoreboard players operation $metal tf2.var -= $cost tf2.var
execute if score $repair tf2.var matches 1.. run function tf2:__private__/if_else/20