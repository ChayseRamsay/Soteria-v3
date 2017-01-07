var/datum/subsystem/religion/SSreligion

/datum/subsystem/religion
	name = "Religion"
	init_order = 19
	flags = SS_NO_FIRE|SS_NO_INIT

	var/bible_deity_name
	var/Bible_icon_state
	var/Bible_item_state
	var/Bible_name
	var/Bible_deity_name = "Space Jesus"
	var/Bible_deity_init = 0

	var/holy_weapon
	var/list/possiblereligions = list()


/datum/subsystem/religion/New()
	NEW_SS_GLOBAL(SSreligion)
	possiblereligions.Add("Light")