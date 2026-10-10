execute if entity @s[tag=tf2.constructing] run return run function tf2:__private__/anonymous/10
scoreboard players operation $metal tf2.var = @e[type=#tf2:player_like,tag=iris.executing,limit=1] tf2.metal
scoreboard players set $did_work tf2.var 0
scoreboard players operation $repair tf2.var = @s tf2.max_health
scoreboard players operation $repair tf2.var -= @s tf2.health
execute if score $repair tf2.var matches 1.. run function tf2:__private__/if_else/21
execute unless score $did_work tf2.var matches 1.. if score @s tf2.building.level matches ..2 if score $metal tf2.var matches 1.. run function tf2:__private__/if_else/22
execute if entity @s[tag=tf2.sentry] run function tf2:__private__/if_else/23
scoreboard players operation @e[type=#tf2:player_like,tag=iris.executing,limit=1] tf2.metal = $metal tf2.var
playsound minecraft:block.smithing_table.use block @a ~ ~ ~ 0.5 1.5