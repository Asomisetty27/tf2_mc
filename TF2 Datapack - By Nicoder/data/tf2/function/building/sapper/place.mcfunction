execute if score @s tf2.is_invisible matches 1 run return fail
tag @s add tf2.sapping
data modify storage tf2:vars iris_target_entities set from storage iris:settings TargetEntities
data modify storage tf2:vars iris_depth set from storage iris:settings MaxRecursionDepth
scoreboard players operation $spy_team tf2.team = @s tf2.team
scoreboard players operation $spy_id tf2.var = @s tf2.player.id
data modify storage iris:settings TargetEntities set value true
execute anchored eyes positioned ^ ^ ^ run function tf2:raycast/informational
execute as @e[type=item_display,tag=iris.targeted_entity,tag=tf2.base] on passengers run tag @s add iris.targeted_entity
execute as @e[type=item_display,tag=iris.targeted_entity,predicate=tf2:is_a_building,distance=..3.05] unless score @s tf2.team = $spy_team tf2.team run tag @s add tf2.sap_target
tag @e[tag=tf2.sap_target,tag=tf2.sapped] remove tf2.sap_target
tag @e remove iris.targeted_entity
execute unless entity @e[tag=tf2.sap_target] run function tf2:__private__/if_else/35
tag @s remove tf2.sapping
data modify storage iris:settings TargetEntities set from storage tf2:vars iris_target_entities
data modify storage iris:settings MaxRecursionDepth set from storage tf2:vars iris_depth
execute unless entity @e[tag=tf2.sap_target] run return run playsound minecraft:block.dispenser.fail player @s ~ ~ ~ 0.5 1.6
execute as @e[tag=tf2.sap_target,limit=1] at @s run function tf2:building/sapper/attach
tag @e remove tf2.sap_target
return 1