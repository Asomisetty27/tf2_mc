scoreboard players operation $repair tf2.var < 102 tf2.const
scoreboard players operation $affordable tf2.var = $metal tf2.var
scoreboard players operation $affordable tf2.var *= $ratio tf2.var
scoreboard players operation $repair tf2.var < $affordable tf2.var
scoreboard players operation $cost tf2.var = $repair tf2.var
scoreboard players operation $cost tf2.var += $ratio tf2.var
scoreboard players remove $cost tf2.var 1
scoreboard players operation $cost tf2.var /= $ratio tf2.var
scoreboard players operation $repair tf2.var = $cost tf2.var
scoreboard players operation $repair tf2.var *= $ratio tf2.var
scoreboard players operation @s tf2.health += $repair tf2.var
scoreboard players operation @s tf2.health < @s tf2.max_health
scoreboard players operation $metal tf2.var -= $cost tf2.var
execute if score $repair tf2.var matches 1.. run function tf2:__private__/if_else/32