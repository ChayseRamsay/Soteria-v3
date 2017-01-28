/obj/effect/proc_holder/spell/targeted/touch/miracle/cure
	name = "Cure"
	desc = "This spell allows you to fill another person with your god's, erm, 'love.'"
	hand_path = "/obj/item/weapon/melee/touch_attack/cure"
	action_icon_state = "Sigil of Accession"

/obj/item/weapon/melee/touch_attack/cure
	name = "\improper healing touch"
	desc = "The ability to heal people, in the palm of your hand. Thank god for... Gods?"
	catchphrase = "Be healed, in the name of !"
	on_use_sound = "sound/magic/Staff_Healing.ogg"
	icon_state = "disintegrate"
	item_state = "disintegrate"
/obj/item/weapon/melee/touch_attack/cure/afterattack(atom/target, mob/living/carbon/user, proximity)
	var/msgfromgod = "Be healed, child."
	if(!proximity || target == user || !ismob(target) || !iscarbon(user) || user.lying || user.handcuffed) //exploding after touching yourself would be bad
		return
	if(issilicon(target))
		msgfromgod = "I cannot heal this... abomination."
		user << "<i>You hear a voice in your head... <b>[msgfromgod]</i></b>"
		return
	var/mob/living/carbon/M = target //fuck robots, they're slaves to the MACHINE anyways
	var/datum/effect_system/spark_spread/sparks = new
	sparks.set_up(4, 0, M.loc)
	sparks.start()
	M.heal_overall_damage(10,10)
	M.adjustToxLoss(-10)
	M.adjustOxyLoss(-10)
	target << "<i>You hear a voice in your head... <b>[msgfromgod]</i></b>"
	catchphrase = addtext(uppertext("Be healed in the name of "),uppertext(SSreligion.Bible_deity_name),"!")
	..()