/obj/machinery/ai/networking
	name = "AI networking hub"
	desc = "A bluespace-enhanced networking device capable of bridging AI networks across vast distances."
	icon = 'icons/obj/machines/telecomms.dmi'
	icon_state = "broadcaster"
	density = TRUE
	use_power = ACTIVE_POWER_USE
	idle_power_usage = 500
	active_power_usage = 2000
	max_integrity = 500

	// PLACEHOLDER: Circuit board will be created in Phase 7
	//circuit = /obj/item/circuitboard/machine/ai_networking

	var/datum/ai_network/linked_network
	var/network_id = null
	var/on = TRUE

/obj/machinery/ai/networking/Initialize(mapload)
	. = ..()
	// PLACEHOLDER: Auto-linking system would connect to matching network_id
	// For now, networking machines just extend the local network

/obj/machinery/ai/networking/examine(mob/user)
	. = ..()
	. += span_notice("Network ID: [network_id ? network_id : "None"]")
	. += span_notice("Status: [on ? "Online" : "Offline"]")
	if(linked_network)
		. += span_notice("Connected to remote network.")
	else
		. += span_notice("No remote connection established.")

/obj/machinery/ai/networking/attack_hand(mob/user)
	. = ..()
	if(.)
		return

	var/new_id = stripped_input(user, "Enter network ID (leave blank to disconnect):", "Network Configuration", network_id, 20)
	if(!Adjacent(user))
		return

	if(new_id == null)
		return

	network_id = new_id
	to_chat(user, span_notice("Network ID set to: [network_id ? network_id : "None"]"))

	// PLACEHOLDER: Would attempt to link to matching network_id
	update_icon()

/obj/machinery/ai/networking/process()
	update_power()

/obj/machinery/ai/networking/proc/update_power()
	if(machine_stat & (BROKEN|NOPOWER|EMPED))
		on = FALSE
	else
		on = TRUE
	update_icon()

/obj/machinery/ai/networking/update_icon_state()
	. = ..()
	if(panel_open)
		icon_state = "[initial(icon_state)]_o"
	else
		icon_state = initial(icon_state)

/obj/machinery/ai/networking/update_overlays()
	. = ..()
	if(on && network_id)
		var/mutable_appearance/on_overlay = mutable_appearance(icon, "[initial(icon_state)]_on")
		. += on_overlay
