/obj/machinery/ai/master_subcontroller
	name = "master subcontroller"
	desc = "An ancient mainframe dedicated to tasks thought too simple for the onboard experimental AI. This mainframe takes care of duties such as polling APCs for updates, priming door servos and updating air alarms."
	icon = 'icons/obj/machines/telecomms.dmi'
	icon_state = "hub"
	density = TRUE
	use_power = ACTIVE_POWER_USE
	idle_power_usage = 100
	active_power_usage = 500
	max_integrity = 1000

	// PLACEHOLDER: Circuit board will be created in Phase 7
	//circuit = /obj/item/circuitboard/machine/subcontroller
	var/on = TRUE

	// PLACEHOLDER: Full area management system - simplified for now
	var/list/enabled_areas = list()
	var/list/disabled_areas = list()

/obj/machinery/ai/master_subcontroller/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	// PLACEHOLDER: Simple UI - full area management UI not yet implemented
	var/action = tgui_alert(user, "Configure master subcontroller", "Master Subcontroller", list("Enable Area", "Disable Area", "Cancel"))

	if(!action || action == "Cancel")
		return TRUE

	if(!Adjacent(user))
		return TRUE

	// PLACEHOLDER: Area selection simplified - full system would use proper area wire types
	if(action == "Enable Area")
		if(!disabled_areas.len)
			to_chat(user, span_warning("There are no areas to enable!"))
			return TRUE
		var/selected_area = tgui_input_list(user, "Please select an area to enable:", "Enable Area", disabled_areas)
		if(!selected_area)
			return TRUE
		if(!disabled_areas[selected_area])
			return TRUE
		enabled_areas[selected_area] = disabled_areas[selected_area]
		disabled_areas -= selected_area

	if(action == "Disable Area")
		if(!enabled_areas.len)
			to_chat(user, span_warning("There are no areas to disable!"))
			return TRUE
		var/selected_area = tgui_input_list(user, "Please select an area to disable:", "Disable Area", enabled_areas)
		if(!selected_area)
			return TRUE
		if(!enabled_areas[selected_area])
			return TRUE
		disabled_areas[selected_area] = enabled_areas[selected_area]
		enabled_areas -= selected_area
	return TRUE

/obj/machinery/ai/master_subcontroller/process()
	update_power()

/obj/machinery/ai/master_subcontroller/update_icon_state()
	. = ..()
	if(panel_open)
		icon_state = "[initial(icon_state)]_o"
	else
		icon_state = initial(icon_state)

/obj/machinery/ai/master_subcontroller/update_overlays()
	. = ..()
	cut_overlays()
	if(on)
		var/mutable_appearance/on_overlay
		on_overlay = mutable_appearance(icon, "[initial(icon_state)]_on")
		add_overlay(on_overlay)


/obj/machinery/ai/master_subcontroller/proc/update_power()
	if(machine_stat & (BROKEN|NOPOWER|EMPED)) // if powered, on. if not powered, off. if too damaged, off
		on = FALSE
	else
		on = TRUE
	update_icon()

/obj/machinery/ai/master_subcontroller/disconnect_from_ai_network()
	if(network && network.cached_subcontroller == src)
		network.cached_subcontroller = null
	return ..()
