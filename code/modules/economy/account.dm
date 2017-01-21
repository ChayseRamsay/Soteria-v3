/datum/account
	var/credits = 0
	var/associatedid = null
	var/jobname = "Clown"
/datum/account/proc/add(var/creditstoadd)
	credits += creditstoadd
/datum/account/proc/withdraw(var/creditstobepaid)
	credits -= creditstobepaid
/datum/bankdata
	var/list/accounts = new/list()
/datum/bankdata/proc/addaccount(var/datum/account/A)
	accounts |= A
/datum/bankdata/proc/findaccountbyid(var/obj/item/weapon/card/id/I)
	for(var/datum/account/A in accounts)
		if(A.associatedid == I)
			return A
	return null