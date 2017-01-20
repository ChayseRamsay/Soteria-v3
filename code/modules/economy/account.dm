/datum/account
	var/credits = 0
	var/associatedid = null
	var/jobname = "Clown"
/datum/account/proc/pay(var/creditstobepayed)
	credits += creditstobepayed
/datum/bankdata
	var/list/accounts = new/list()
/datum/bankdata/New()
	accounts = new/list()
/datum/bankdata/proc/addaccount(var/datum/account/A)
	accounts |= A