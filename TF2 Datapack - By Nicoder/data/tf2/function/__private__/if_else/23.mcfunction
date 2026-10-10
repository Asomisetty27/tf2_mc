scoreboard players operation $shells tf2.var = @s tf2.primary_maxAmmo
scoreboard players operation $shells tf2.var -= @s tf2.primary_ammo
scoreboard players operation $shells tf2.var < 40 tf2.const
scoreboard players operation $shells tf2.var < $metal tf2.var
scoreboard players operation @s tf2.primary_ammo += $shells tf2.var
scoreboard players operation $metal tf2.var -= $shells tf2.var