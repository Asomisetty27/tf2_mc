execute store result storage tf2:vars level int 1 run scoreboard players get @s tf2.building.level
data modify storage tf2:actionbar buildings append value {text:"  Sentry ",color:"gray"}
data modify storage tf2:actionbar buildings append value {text:"L",color:"white"}
data modify storage tf2:actionbar buildings append string storage tf2:vars level 0
function tf2:building/status_line