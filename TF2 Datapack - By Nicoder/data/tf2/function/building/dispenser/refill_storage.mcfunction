scoreboard players add @s tf2.building.ticks_idle 1
scoreboard players operation $refill_timer tf2.var = @s tf2.building.ticks_idle
scoreboard players add $refill_timer tf2.var 60
scoreboard players operation $refill_timer tf2.var %= 120 tf2.const
execute unless score $refill_timer tf2.var matches 0 run return 0
scoreboard players operation $refill tf2.var = @s tf2.building.level
scoreboard players remove $refill tf2.var 1
scoreboard players operation $refill tf2.var *= 10 tf2.const
scoreboard players add $refill tf2.var 40
scoreboard players operation @s tf2.building.metal += $refill tf2.var
scoreboard players operation @s tf2.building.metal < 400 tf2.const
return 1