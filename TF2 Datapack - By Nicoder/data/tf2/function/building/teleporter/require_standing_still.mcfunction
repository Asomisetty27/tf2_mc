scoreboard players operation $dx tf2.var = @s tf2.now_x
scoreboard players operation $dx tf2.var -= @s tf2.last_x
scoreboard players operation $dz tf2.var = @s tf2.now_z
scoreboard players operation $dz tf2.var -= @s tf2.last_z
scoreboard players set $still tf2.var 1
execute if score $dx tf2.var matches 6.. run scoreboard players set $still tf2.var 0
execute if score $dx tf2.var matches ..-6 run scoreboard players set $still tf2.var 0
execute if score $dz tf2.var matches 6.. run scoreboard players set $still tf2.var 0
execute if score $dz tf2.var matches ..-6 run scoreboard players set $still tf2.var 0
execute unless score $still tf2.var matches 1.. run tag @s remove tf2.tele_candidate