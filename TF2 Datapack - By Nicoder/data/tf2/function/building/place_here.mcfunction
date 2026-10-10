execute if entity @e[type=item_display,predicate=tf2:is_a_building,distance=..1.25] run return run function tf2:__private__/anonymous/10
scoreboard players set $placed tf2.var 1
execute if score $type tf2.var matches 0 run function tf2:__private__/if_else/21
execute if score $type tf2.var matches 1 run function tf2:__private__/if_else/22
execute if score $type tf2.var matches 2.. run function tf2:__private__/if_else/23
execute store result storage tf2:index i int 1 run scoreboard players get @s tf2.batch_number
execute as @e[type=item_display,tag=tf2.just_spawned] run function tf2:__private__/anonymous/11
playsound minecraft:block.anvil.place block @a ~ ~ ~ 0.6 1.4