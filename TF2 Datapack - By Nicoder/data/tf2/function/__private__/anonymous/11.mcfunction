execute store result entity @s Rotation[0] float 0.01 run scoreboard players get $yaw tf2.var
scoreboard players operation @s tf2.building.last_yaw = $yaw tf2.var
execute on vehicle store result entity @s Rotation[0] float 0.01 run scoreboard players get $yaw tf2.var
function tf2:session/sync with storage tf2:index
function tf2:building/start_construction