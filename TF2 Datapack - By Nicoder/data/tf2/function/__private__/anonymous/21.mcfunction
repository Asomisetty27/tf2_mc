scoreboard players set $total tf2.var 2100
execute if entity @s[tag=tf2.dispenser] run scoreboard players set $total tf2.var 4200
execute if entity @s[tag=tf2.teleporter] run scoreboard players set $total tf2.var 4200
scoreboard players operation $percent tf2.var = @s tf2.building.progress
scoreboard players operation $percent tf2.var *= 100 tf2.const
scoreboard players operation $percent tf2.var /= $total tf2.var
execute store result storage tf2:vars percent int 1 run scoreboard players get $percent tf2.var
data modify storage tf2:actionbar buildings append value {text:" building ",color:"yellow"}
data modify storage tf2:actionbar buildings append string storage tf2:vars percent 0
data modify storage tf2:actionbar buildings append value {text:"%",color:"yellow"}
return 1