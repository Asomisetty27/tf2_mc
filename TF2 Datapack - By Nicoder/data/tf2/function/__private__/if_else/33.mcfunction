execute store result storage tf2:vars shells int 1 run scoreboard players get @s tf2.primary_ammo
data modify storage tf2:actionbar buildings append value {text:" ⁍",color:"gold"}
data modify storage tf2:actionbar buildings append string storage tf2:vars shells 0