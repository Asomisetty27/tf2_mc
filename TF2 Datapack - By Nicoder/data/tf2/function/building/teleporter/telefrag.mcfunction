data modify storage tf2:lookup damages append value {instakill:true,kill_verb:"telefragged"}
execute store result storage tf2:lookup damages[-1].cause int 1 run scoreboard players get $traveler_id tf2.player.id
execute store result storage tf2:lookup damages[-1].target int 1 run scoreboard players get @s tf2.player.id