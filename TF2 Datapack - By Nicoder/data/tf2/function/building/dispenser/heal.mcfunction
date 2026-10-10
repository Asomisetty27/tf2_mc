scoreboard players operation @s tf2.health += $health tf2.var
execute if score $health tf2.var matches 1.. run tag @s remove tf2.on_fire
function tf2:player/clamp_health
execute unless score $dispense tf2.var matches 1.. run return 0
scoreboard players operation $add_amount tf2.var = @s tf2.primary_maxAmmo
scoreboard players operation $add_amount tf2.var += @s tf2.primary_maxClip
scoreboard players operation $add_amount tf2.var *= $ammo tf2.var
scoreboard players add $add_amount tf2.var 99
scoreboard players operation $add_amount tf2.var /= 100 tf2.const
scoreboard players operation $clip_space tf2.var = @s tf2.primary_maxClip
scoreboard players operation $clip_space tf2.var -= @s tf2.primary_clip
scoreboard players operation $clip_space tf2.var < $add_amount tf2.var
scoreboard players operation @s tf2.primary_clip += $clip_space tf2.var
scoreboard players operation $add_amount tf2.var -= $clip_space tf2.var
scoreboard players operation @s tf2.primary_ammo += $add_amount tf2.var
scoreboard players operation @s tf2.primary_ammo < @s tf2.primary_maxAmmo
scoreboard players operation $add_amount tf2.var = @s tf2.secondary_maxAmmo
scoreboard players operation $add_amount tf2.var += @s tf2.secondary_maxClip
scoreboard players operation $add_amount tf2.var *= $ammo tf2.var
scoreboard players add $add_amount tf2.var 99
scoreboard players operation $add_amount tf2.var /= 100 tf2.const
scoreboard players operation $clip_space tf2.var = @s tf2.secondary_maxClip
scoreboard players operation $clip_space tf2.var -= @s tf2.secondary_clip
scoreboard players operation $clip_space tf2.var < $add_amount tf2.var
scoreboard players operation @s tf2.secondary_clip += $clip_space tf2.var
scoreboard players operation $add_amount tf2.var -= $clip_space tf2.var
scoreboard players operation @s tf2.secondary_ammo += $add_amount tf2.var
scoreboard players operation @s tf2.secondary_ammo < @s tf2.secondary_maxAmmo
execute if score @s tf2.class matches 1 run function tf2:__private__/if_else/9
execute if score @s tf2.class matches 8 run function tf2:__private__/if_else/10