#define CELL_POWERUSE_MULTIPLIER 0.025

/obj/machinery/ai/data_core
	name = "AI data core"
	desc = "A complicated computer system capable of emulating the neural functions of an organic being at near-instantanous speeds."
	icon = 'icons/obj/machines/research.dmi'
	icon_state = "server1"

	// PLACEHOLDER: Circuit board will be created in Phase 7
	//circuit = /obj/item/circuitboard/machine/ai_data_core

	active_power_usage = AI_DATA_CORE_POWER_USAGE
	idle_power_usage = 1000
	use_power = IDLE_POWER_USE

	var/disableheat = FALSE

	critical_machine = TRUE

	var/primary = FALSE

	var/valid_ticks = 0 //Limited to MAX_AI_DATA_CORE_TICKS. Decrement by 1 every time we have an invalid tick, opposite when valid

	var/warning_sent = FALSE
	//COOLDOWN_DECLARE(warning_cooldown) // PLACEHOLDER: Cooldown system not yet ported

	var/TimerID //party time
	//Heat production multiplied by this
	var/heat_modifier = 1
	//Power modifier, power modified by this. Be aware this indirectly changes heat since power => heat
	var/power_modifier = 1

	var/obj/item/stock_parts/power_store/cell/integrated_battery

	//var/obj/ai_smoke/smoke // PLACEHOLDER: Smoke effect not yet ported

	var/obj/item/dead_ai/dead_ai_blackbox


/obj/machinery/ai/data_core/Initialize(mapload)
	. = ..()
	valid_ticks = MAX_AI_DATA_CORE_TICKS
	GLOB.data_cores += src
	if(primary && !GLOB.primary_data_core)
		GLOB.primary_data_core = src
	update_appearance()
	RefreshParts()

/obj/machinery/ai/data_core/JoinPlayerHere(mob/M, buckle)
	return

/obj/machinery/ai/data_core/RefreshParts()
	. = ..()
	var/new_heat_mod = 1
	var/new_power_mod = 1
	for(var/obj/item/stock_parts/power_store/cell/C in component_parts)
		integrated_battery = C

	for(var/datum/stock_part/matter_bin/M in component_parts)
		new_heat_mod -= (M.tier - 1) / 30 //Max -20% at tier 4 parts, min -0% at tier 1

	for(var/datum/stock_part/capacitor/C in component_parts)
		new_power_mod -= (C.tier - 1) / 40 //Max -15% at tier 4 parts, min -0% at tier 1
	//63% total heat reduction in total at tier 4

	heat_modifier = new_heat_mod
	power_modifier = new_power_mod

	idle_power_usage = initial(idle_power_usage) * power_modifier

/obj/machinery/ai/data_core/proc/valid_data_core()
	if(network)
		return TRUE
	return FALSE

/obj/machinery/ai/data_core/process()
	valid_ticks = clamp(valid_ticks, 0, MAX_AI_DATA_CORE_TICKS)

	// PLACEHOLDER: Warning system simplified - full cooldown system not yet ported
	if(network && network.ai_list.len && valid_ticks <= 10 && !warning_sent)
		warning_sent = TRUE
		for(var/mob/living/silicon/ai/AI in network.ai_list)
			if(!AI.mind && !AI.deployed_shell?.mind)
				continue
			to_chat(AI, span_userdanger("Data core in [get_area(src)] is on the verge of failing! Immediate action required to prevent failure."))
			AI.playsound_local(AI, 'sound/machines/engine_alert2.ogg', 30)

	if(valid_holder())
		valid_ticks++
		if(valid_ticks == 1)
			update_appearance(UPDATE_ICON)
		if(icon_state == "core-offline")
			update_appearance(UPDATE_ICON)
		// PLACEHOLDER: Smoke effect commented out
		//if(smoke)
		//	vis_contents -= smoke
		//	QDEL_NULL(smoke)
		use_power = ACTIVE_POWER_USE
		if((machine_stat & NOPOWER) && integrated_battery)
			integrated_battery.use(active_power_usage * CELL_POWERUSE_MULTIPLIER)
		warning_sent = FALSE
	else
		valid_ticks--
		// PLACEHOLDER: Smoke effect commented out
		//if(!smoke)
		//	if(get_holder_status() == AI_MACHINE_TOO_HOT)
		//		smoke = new()
		//		vis_contents += smoke
		if(valid_ticks <= 0)
			use_power = IDLE_POWER_USE
			update_appearance(UPDATE_ICON)
			// PLACEHOLDER: AI relocate will be implemented in Phase 6
			//for(var/mob/living/silicon/ai/AI in contents)
			//	if(!AI.is_dying)
			//		AI.relocate()
		if(network && network.resources)
			network.resources.set_cpu(src, 0)

	if(!(machine_stat & (BROKEN|EMPED)) && has_power() && !disableheat)
		var/temp_active_usage = machine_stat & NOPOWER ? active_power_usage * CELL_POWERUSE_MULTIPLIER : active_power_usage
		var/temperature_increase = (temp_active_usage / AI_HEATSINK_CAPACITY)* heat_modifier
		core_temp += temperature_increase * AI_TEMPERATURE_MULTIPLIER

/obj/machinery/ai/data_core/Destroy()
	GLOB.data_cores -= src
	if(GLOB.primary_data_core == src)
		GLOB.primary_data_core = null

	if(network && network.resources)
		var/list/all_ais = network.resources.get_all_ais()

		// PLACEHOLDER: AI relocate will be implemented in Phase 6
		//for(var/mob/living/silicon/ai/AI in contents)
		//	all_ais -= AI
		//	if(!AI.is_dying)
		//		AI.relocate()

		for(var/mob/living/silicon/ai/AI in all_ais)
			// PLACEHOLDER: is_dying will be implemented in Phase 6
			//if(AI.is_dying)
			//	continue
			if(!AI.mind && AI.deployed_shell && AI.deployed_shell.mind)
				to_chat(AI.deployed_shell, span_userdanger("Warning! Data Core brought offline in [get_area(src)]! Please verify that no malicious actions were taken."))
			else
				to_chat(AI, span_userdanger("Warning! Data Core brought offline in [get_area(src)]! Please verify that no malicious actions were taken."))

	disconnect_from_ai_network()
	// PLACEHOLDER: Smoke effect commented out
	//vis_contents -= smoke
	//QDEL_NULL(smoke)
	return ..()

/obj/machinery/ai/data_core/attackby(obj/item/O, mob/living/user, params)
	// PLACEHOLDER: Dead AI blackbox system will be implemented in Phase 6
	//if(istype(O, /obj/item/dead_ai))
	//	if(dead_ai_blackbox)
	//		to_chat(user, span_warning("There's already a neural core inserted!"))
	//		return
	//	if(!can_transfer_ai())
	//		to_chat(user, span_warning("This core is currently unable to host an AI due to being offline."))
	//		return
	//	dead_ai_blackbox = O
	//	dead_ai_blackbox.forceMove(src)
	//	network.reviving_ais |= src
	//	return TRUE
	if(O.tool_behaviour == TOOL_SCREWDRIVER)
		if(!do_after(user, 5 SECONDS, src))
			to_chat(user, span_warning("You need to stand still to open the panel!"))
			return
		if(default_deconstruction_screwdriver(user, "core-open", "core", O))
			return TRUE

	if(O.tool_behaviour == TOOL_CROWBAR)
		if(!do_after(user, 5 SECONDS, src))
			to_chat(user, span_warning("You need to stand still to deconstruct the core!"))
			return
		if(default_deconstruction_crowbar(O))
			return TRUE
	if(panel_open)
		if(!Adjacent(user))
			return // Must be adjacent
		if(HAS_TRAIT(O, TRAIT_NODROP))
			to_chat(user, span_warning("[O] is stuck to your hand!"))
			return
		else
			var/add = FALSE
			// PLACEHOLDER: Component insertion simplified - full upgradepanel system not yet ported
			if(istype(O, /obj/item/stock_parts/power_store/cell))
				if(integrated_battery)
					to_chat(user, span_warning("There's already a battery installed!"))
				else
					add = TRUE
					integrated_battery = O
			else if(component_parts)
				add = TRUE

			if(add)
				to_chat(user, span_notice("You insert [O]."))
				user.transferItemToLoc(O, src, TRUE)
				component_parts += O
				RefreshParts()
			return TRUE

	return ..()

/obj/machinery/ai/data_core/process_atmos()
	..()
	if(!(machine_stat & (BROKEN|EMPED)) && has_power())
		var/turf/T = get_turf(src)
		var/datum/gas_mixture/env = T.return_air()
		if(!disableheat)
			if(env && env.heat_capacity())
				var/temp_active_usage = machine_stat & NOPOWER ? active_power_usage * CELL_POWERUSE_MULTIPLIER : active_power_usage
				var/temperature_increase = (temp_active_usage / env.heat_capacity()) * heat_modifier
				var/new_temp = env.return_temperature() + temperature_increase * AI_TEMPERATURE_MULTIPLIER
				env.temperature = new_temp
				T.air_update_turf()

/obj/machinery/ai/data_core/proc/can_transfer_ai()
	if(machine_stat & (BROKEN|EMPED) || !has_power())
		return FALSE
	if(!valid_data_core())
		return FALSE
	return TRUE

/obj/machinery/ai/data_core/proc/transfer_AI(mob/living/silicon/ai/AI)
	AI.forceMove(src)
	if(AI.eyeobj)
		AI.eyeobj.forceMove(get_turf(src))

	if(network != AI.ai_network)
		if(AI.ai_network)
			AI.ai_network.ai_list -= AI
		var/datum/ai_network/old_net = AI.ai_network
		AI.ai_network = network
		if(network)
			network.ai_list |= AI
		AI.switch_ainet(old_net, network)

	to_chat(AI, span_notice("Consciousness transfer complete. You are now housed in [src] at [get_area(src)]."))
	update_appearance(UPDATE_ICON)

/obj/machinery/ai/data_core/update_icon_state()
	. = ..()

	if(!(machine_stat & (BROKEN|EMPED)) && has_power())
		if(!valid_data_core())
			return
		icon_state = "server1"
	else
		icon_state = "server0"

/obj/machinery/ai/data_core/connect_to_ai_network() //If we ever get connected to a network (or a new one gets created) we get the AIs to the correct one too
	. = ..()
	for(var/mob/living/silicon/ai/AI in contents)
		if(!AI.ai_network)
			if(network)
				network.ai_list |= AI
				var/datum/ai_network/old_net = AI.ai_network
				AI.ai_network = network
				AI.switch_ainet(old_net, network)

		if(AI.ai_network != network)
			if(AI.ai_network)
				AI.ai_network.ai_list -= AI
			var/datum/ai_network/old_net = AI.ai_network
			AI.ai_network = network
			if(network)
				network.ai_list |= AI
			AI.switch_ainet(old_net, network)

// PLACEHOLDER: Party time procs commented out - visual effect not critical
/*
/obj/machinery/ai/data_core/proc/partytime()
	var/current_color = random_color()
	set_light(7, 3, current_color)
	TimerID = addtimer(CALLBACK(src, PROC_REF(partytime)), 0.5 SECONDS, TIMER_STOPPABLE)

/obj/machinery/ai/data_core/proc/stoptheparty()
	set_light(0)
	if(TimerID)
		deltimer(TimerID)
		TimerID = null
*/

/obj/machinery/ai/data_core/primary
	name = "primary AI Data Core"
	desc = "A complicated computer system capable of emulating the neural functions of a human at near-instantanous speeds. This one has a scrawny and faded note saying: 'Primary AI Data Core'"
	primary = TRUE

#undef CELL_POWERUSE_MULTIPLIER
