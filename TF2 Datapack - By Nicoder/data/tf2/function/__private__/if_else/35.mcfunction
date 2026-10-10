execute anchored eyes positioned ^ ^ ^1.5 as @e[type=item_display,predicate=tf2:is_a_building,tag=!tf2.sapped,distance=..1.8] unless score @s tf2.team = $spy_team tf2.team run tag @s add tf2.sap_candidate
tag @e[tag=tf2.sap_candidate,distance=3.05..] remove tf2.sap_candidate
execute as @e[tag=tf2.sap_candidate,sort=nearest] run function tf2:building/sapper/try_snap
tag @e remove tf2.sap_candidate