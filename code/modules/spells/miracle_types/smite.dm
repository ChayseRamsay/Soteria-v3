/obj/effect/proc_holder/spell/targeted/touch/miracle/smite
	name = "Smite"
	desc = "This spell allows you to fill another person with your god's, erm, 'love.'"
	hand_path = "/obj/item/weapon/melee/touch_attack/smite"
	action_icon_state = "sacredflame"
/obj/item/weapon/melee/touch_attack/smite
	name = "\improper holy wrath"
	desc = "Cast your pure anger at another person."
	catchphrase = "BURN FOR YOUR SINS!"
	on_use_sound = "sound/magic/WandODeath.ogg"
	icon_state = "disintegrate"
	item_state = "disintegrate"
/obj/item/weapon/melee/touch_attack/smite/afterattack(atom/target, mob/living/carbon/user, proximity)
	var/msgfromgod = "BURN FOR YOUR SINS!"
	if(!proximity || target == user || !ismob(target) || !iscarbon(user) || user.lying || user.handcuffed) //exploding after touching yourself would be bad
		return
	if(issilicon(target))
		msgfromgod = "I REFUSE TO TOUCH THIS ABOMINATION!"
		user << "<i>You hear a voice in your head... <b>[msgfromgod]</i></b>"
		return
	var/mob/living/carbon/M = target //fuck robots, they're slaves to the MACHINE anyways
	var/datum/effect_system/spark_spread/sparks = new
	sparks.set_up(4, 0, M.loc)
	sparks.start()
	M.take_overall_damage(10,10)
	M.adjust_fire_stacks(3)
	M.IgniteMob()
	target << "<i>You hear a booming voice in your head... <b>[msgfromgod]</i></b>"
	catchphrase = addtext(uppertext("FEEL THE WRATH OF "),uppertext(SSreligion.Bible_deity_name),"!")
	..()