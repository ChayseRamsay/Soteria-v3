/obj/effect/proc_holder/spell/targeted/forcewall/summonreviverune
	name = "Summon revival rune"
	desc = "Create a rune you can use to revive people."
	panel = "Miracles"
	invocation = "Be with us, holy one!"
	action_icon_state = "blight"
/obj/effect/proc_holder/spell/targeted/forcewall/summonreviverune/cast(list/targets,mob/user = usr)
	new /obj/effect/rune/raise_dead/chaplain(get_turf(user),user)
	if(user.dir == SOUTH || user.dir == NORTH)
		new /obj/effect/rune/raise_dead/chaplain(get_step(user, EAST),user)
		new /obj/effect/rune/raise_dead/chaplain(get_step(user, WEST),user)
	else
		new /obj/effect/rune/raise_dead/chaplain(get_step(user, NORTH),user)
		new /obj/effect/rune/raise_dead/chaplain(get_step(user, SOUTH),user)
/obj/effect/rune/raise_dead/chaplain
	name = "resurrection rune"
	desc = "A sacred rune drawn by the Chaplain."
/obj/effect/rune/raise_dead/chaplain/New()
	..()
	QDEL_IN(src, 300)
/obj/effect/rune/raise_dead/chaplain/attack_hand(mob/living/user)
	if(!ischaplain(user))
		user << "<span class='warning'>You aren't able to understand the words of [src].</span>"
		return
	else
		invoke(user)
/obj/effect/rune/raise_dead/chaplain/invoke(mob/living/invoker)
	var/turf/T = get_turf(src)
	var/mob/living/mob_to_revive
	var/list/potential_revive_mobs = list()
	var/list/sacrificeditems = list()
	var/mob/living/user = invoker
	var/totalvalue = 0
	var/costtorevive = 200
	if(rune_in_use)
		return
	for(var/mob/living/M in T.contents)
		if(M.stat == DEAD && iscarbon(M))
			potential_revive_mobs |= M
	if(!potential_revive_mobs.len)
		user << "<span class='cultitalic'>There are no dead people on the rune!</span>"
		log_game("Raise Dead rune failed - no corpses to revive")
		fail_invoke()
		return
	for(var/obj/item/I1 in T.contents)//pay
		sacrificeditems |= I1
		if(sacrificeditems.len)
			for(var/obj/item/I2 in sacrificeditems)
				totalvalue += 10 //Just do a simple cost in items for now
			if(totalvalue >= costtorevive)
				for(var/obj/item/I3 in sacrificeditems)
					qdel(I3)
			else
				user << "<span class='cultitalic'>There isn't enough of a sacrifice on the rune!</span>"
	if(potential_revive_mobs.len > 1)
		mob_to_revive = input(user, "Choose a person to revive.", "Person to Revive") as null|anything in potential_revive_mobs
	else
		mob_to_revive = potential_revive_mobs[1]
	if(!src || qdeleted(src) || rune_in_use || !validness_checks(mob_to_revive, user))
		return
	rune_in_use = 1
	if(user.name == "Herbert West")
		user.say("To life, to life, I bring them!")
	else
		user.say("Pasnar val'keriam usinar. Savrae ines amutan. Yam'toth remium il'tarat!")
	..()
	revives_used++
	mob_to_revive.revive(1, 1) //This does remove disabilities and such, but the rune might actually see some use because of it!
	mob_to_revive.grab_ghost()
	mob_to_revive << "<span class='cultlarge'>\"PASNAR SAVRAE YAM'TOTH. Arise.\"</span>"
	mob_to_revive.visible_message("<span class='warning'>[mob_to_revive] draws in a huge breath, red light shining from [mob_to_revive.p_their()] eyes.</span>", \
								  "<span class='cultlarge'>You awaken suddenly from the void. You're alive!</span>")
	rune_in_use = 0
