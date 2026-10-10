scoreboard players set $copy tf2.var 0
execute if score $match_level tf2.building.level > @s tf2.building.level run scoreboard players set $copy tf2.var 1
execute if score $match_level tf2.building.level = @s tf2.building.level if score $match_metal tf2.building.upgrade_metal > @s tf2.building.upgrade_metal run scoreboard players set $copy tf2.var 1
execute if score $copy tf2.var matches 1.. run function tf2:__private__/if_else/19