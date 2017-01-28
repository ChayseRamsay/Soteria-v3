/obj/effect/proc_holder/spell/miracle
	name = "Miracle"
	desc = "A Chaplain's Miracle"
	panel = "Miracles"
	clothes_req = 0//We're not a wizard, just basing off because lazy
	human_req = 1 //Liggers go home
	nonabstract_req = 1 //Must be solid
	invocation_type = "shout"
	invocation = "IN THE NAME OF"
/obj/effect/proc_holder/spell/targeted/touch/miracle
	name = "Touch Miracle"
	desc = "An on-touch Miracle."
	panel = "Miracles"
	hand_path = "/obj/item/weapon/melee/touch_attack"
	attached_hand = null
	invocation_type = "none"
	include_user = 1
	range = -1
	charge_max = 200
	clothes_req = 0
	cooldown_min = 200 //100 deciseconds reduction per rank