data modify storage tf2:actionbar buildings set value [""]
function tf2:building/tag_owned
execute as @e[tag=tf2.owned,tag=tf2.sentry,limit=1] run function tf2:__private__/anonymous/17
execute as @e[tag=tf2.owned,tag=tf2.dispenser,limit=1] run function tf2:__private__/anonymous/18
execute as @e[tag=tf2.owned,tag=tf2.tele_entrance,limit=1] run function tf2:__private__/anonymous/19
execute as @e[tag=tf2.owned,tag=tf2.tele_exit,limit=1] run function tf2:__private__/anonymous/20
tag @e remove tf2.owned