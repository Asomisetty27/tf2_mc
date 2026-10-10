scoreboard players operation $tick_timer tf2.var = $__global__ xrroou1m8_p_join
scoreboard players operation $tick_timer tf2.var %= 4 tf2.const
execute store success score $health tf2.var if score $tick_timer tf2.var <= @s tf2.building.level
execute store result score $ammo tf2.var store result score $cloak tf2.var run scoreboard players set $metal_to_give tf2.var 0
scoreboard players set $dispense tf2.var 0
execute if score @s tf2.attack_delay matches 1.. run return 1
scoreboard players set $dispense tf2.var 1
scoreboard players operation $ammo tf2.var = @s tf2.building.level
scoreboard players add $ammo tf2.var 1
scoreboard players operation $ammo tf2.var *= 10 tf2.const
scoreboard players operation $metal_to_give tf2.var = @s tf2.building.level
scoreboard players remove $metal_to_give tf2.var 1
scoreboard players operation $metal_to_give tf2.var *= 10 tf2.const
scoreboard players add $metal_to_give tf2.var 40
scoreboard players operation $cloak tf2.var = @s tf2.building.level
scoreboard players add $cloak tf2.var 1
scoreboard players operation $cloak tf2.var *= 5 tf2.const
return 1