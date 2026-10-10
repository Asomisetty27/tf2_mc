execute store result storage tf2:vars upgrade int 1 run scoreboard players get @s tf2.building.upgrade_metal
data modify storage tf2:actionbar buildings append value {text:" ⬆",color:"aqua"}
data modify storage tf2:actionbar buildings append string storage tf2:vars upgrade 0
data modify storage tf2:actionbar buildings append value {text:"/200",color:"aqua"}