/// Send player in not-quiet cryopod. If with_paper = TRUE, place a paper with notification under player.
/mob/proc/send_to_cryo(with_paper = FALSE)
	//effect
	playsound(loc, 'sound/effects/magic/Repulse.ogg', 100, 1)
	var/datum/effect_system/spark_spread/quantum/sparks = new
	sparks.set_up(10, 1, loc)
	sparks.attach(loc)
	sparks.start()

	//make a paper if need
	if(with_paper)
		var/obj/item/paper/cryo_paper = new /obj/item/paper(loc)
		cryo_paper.name = "Уведомление - [name]"
		cryo_paper.add_raw_text("Приносим искренние извинения, персону \"[name][job ? ", [job]," : ""]\" пришлось отправить в криогенное хранилище по причинам, которые на данный момент не могут быть уточнены.<br><br>С уважением,<br><i>Агентство Нанотрейзен по борьбе с SSD.</i>")
		cryo_paper.update_appearance()
	//find cryopod
	for(var/obj/machinery/cryopod/cryo in GLOB.valid_cryopods)
		if(cryo.occupant || !cryo.state_open || cryo.panel_open) //free, opened, and panel closed?
			return
		if(buckled)
			buckled.unbuckle_mob(src, TRUE)
		if(buckled_mobs)
			for(var/mob/buckled_mob in buckled_mobs)
				unbuckle_mob(buckled_mob)
		cryo.close_machine(src) //put player
		break
