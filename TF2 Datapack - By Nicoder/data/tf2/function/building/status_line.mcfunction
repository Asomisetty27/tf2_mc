execute if entity @s[tag=tf2.constructing] run return run function tf2:__private__/anonymous/13
execute store result storage tf2:vars hp int 1 run scoreboard players get @s tf2.health
data modify storage tf2:actionbar buildings append value {text:" ❤",color:"red"}
data modify storage tf2:actionbar buildings append string storage tf2:vars hp 0
execute if entity @s[tag=tf2.sentry] run function tf2:__private__/if_else/24
execute if score @s tf2.building.level matches ..2 run function tf2:__private__/if_else/25