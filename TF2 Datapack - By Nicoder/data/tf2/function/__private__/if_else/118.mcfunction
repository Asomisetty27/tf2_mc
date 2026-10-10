kill @e[type=arrow,tag=!tf2.projectile]
scoreboard players set __if_else__ tf2.var 0
execute if predicate tf2:ammo_in_clip run function tf2:__private__/if_else/117
execute if score __if_else__ tf2.var matches 0 if items entity @s weapon.mainhand *[custom_data~{attributes:{sapper:true}}] run function tf2:weapons/main_fire
scoreboard players set __if_else__ tf2.var 1