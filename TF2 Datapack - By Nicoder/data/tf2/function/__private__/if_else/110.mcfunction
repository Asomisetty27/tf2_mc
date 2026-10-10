execute as @e[type=!#tf2:player_like] run function tf2:session/check_validity
execute store result score $batch_markers tf2.var if entity @e[type=marker,tag=tf2.batch]
execute unless score $batch_markers tf2.var = $Settings.max_batches tf2.var run function tf2:setup_markers