var/datum/subsystem/economy/SSeconomy

/datum/subsystem/economy
	name = "Economy"
	flags = SS_KEEP_TIMING|SS_NO_TICK_CHECK //We run timers, and they need to be fairly accurate
	init_order = -99
	wait = 10
	var/datum/bankdata/bank = new /datum/bankdata
	var/budgetdry = 1
	var/timebetweenpay = 12000 //remember to reset
	var/list/wagemap = new/list()
	var/wagemapinit = 0
	var/waitingonpayday = 0

/datum/subsystem/economy/New()
	NEW_SS_GLOBAL(SSeconomy)
/datum/subsystem/economy/fire()
	if(!Master.round_started) // Sanity Check, we shouldn't fire in the lobby, but if we do we tell the master controller to go ahead
		return
	else
		if(!wagemapinit)
			populatewagemap(wagemap)
		if(budgetdry)
			if(SSshuttle.points < 4500)
				return
			else
				budgetdry = 0
		if(!waitingonpayday)
			if(SSshuttle.points < 4500)
				priority_announce("The station budget appears to have run dry. We regret to inform you that no further wage payments are possible until this situation is rectified.","Payroll Announcement")
				budgetdry = 1
				return
			queuepayday()
			return
		else
			return
/datum/subsystem/economy/proc/populatewagemap()
	var/job
	for(job in assistant_occupations)
		wagemap |= job
	for(job in command_positions)
		wagemap |= job
	for(job in security_positions)
		wagemap |= job
	for(job in engineering_positions)
		wagemap |= job
	for(job in medical_positions)
		wagemap |= job
	for(job in supply_positions)
		wagemap |= job
	for(job in science_positions)
		wagemap |= job
	for(job in civilian_positions)
		wagemap |= job
	SSeconomy.wagemap["Captain"] = 500
	SSeconomy.wagemap["Head of Security"] = 300
	SSeconomy.wagemap["Warden"] = 125
	SSeconomy.wagemap["Detective"] = 115
	SSeconomy.wagemap["Security Officer"] = 100
	SSeconomy.wagemap["Cargo Technician"] = 85
	SSeconomy.wagemap["Chief Engineer"] = 285 //Uber daycare
	SSeconomy.wagemap["Station Engineer"] = 150
	SSeconomy.wagemap["Atmospheric Technician"] = 150
	SSeconomy.wagemap["Chief Medical Officer"] = 275 //More daycare
	SSeconomy.wagemap["Medical Doctor"] = 125
	SSeconomy.wagemap["Geneticist"] = 150
	SSeconomy.wagemap["Virologist"] = 125
	SSeconomy.wagemap["Chemist"] = 85
	SSeconomy.wagemap["Research Director"] = 200 //Daycare manager
	SSeconomy.wagemap["Scientist"] = 75 // Science degrees are worthless
	SSeconomy.wagemap["Roboticist"] = 100
	SSeconomy.wagemap["Head of Personnel"] = 250
	SSeconomy.wagemap["Quartermaster"] = 175
	SSeconomy.wagemap["Shaft Miner"] = 75 //Moderately unskilled labour
	SSeconomy.wagemap["Bartender"] = 85
	SSeconomy.wagemap["Botanist"] = 125
	SSeconomy.wagemap["Cook"] = 85
	SSeconomy.wagemap["Janitor"] = 90
	SSeconomy.wagemap["Librarian"] = 75
	SSeconomy.wagemap["Lawyer"] = 125
	SSeconomy.wagemap["Chaplain"] = 55 //What are we paying you for, you kook
	SSeconomy.wagemap["Clown"] = 1
	SSeconomy.wagemap["Mime"] = 0 //Is paid imaginary money
	SSeconomy.wagemap["Assistant"] = 50
	return
/datum/subsystem/economy/proc/payWages()
	for(var/datum/account/A in SSeconomy.bank.accounts)
		A.add(SSeconomy.wagemap[A.jobname])
		SSshuttle.points -= SSeconomy.wagemap[A.jobname]
	waitingonpayday = 0
/datum/subsystem/economy/proc/queuepayday()
	addtimer(CALLBACK(SSeconomy, .proc/payWages), timebetweenpay, TIMER_UNIQUE)