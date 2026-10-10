scoreboard players operation $repair tf2.var = @s tf2.max_health
scoreboard players operation $repair tf2.var -= @s tf2.health
execute if score $repair tf2.var matches 1.. run function tf2:building/repair_with_metal