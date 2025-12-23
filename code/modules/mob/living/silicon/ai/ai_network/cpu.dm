/obj/item/ai_cpu
	name = "AI CPU"
	desc = "A central processing unit designed for artificial intelligence systems."
	icon = 'icons/obj/module.dmi'
	icon_state = "std_mod"
	inhand_icon_state = "electronic"
	w_class = WEIGHT_CLASS_SMALL

	var/speed = 1 // THz
	var/base_power_usage = AI_CPU_BASE_POWER_USAGE
	var/efficiency = 1 // 1.0 = 100% efficient

/obj/item/ai_cpu/examine(mob/user)
	. = ..()
	. += span_notice("Speed: [speed] THz")
	. += span_notice("Power Usage: [get_power_usage()]W")
	. += span_notice("Efficiency: [round(efficiency * 100, 0.1)]%")

/obj/item/ai_cpu/proc/get_power_usage()
	return base_power_usage * speed

/obj/item/ai_cpu/proc/get_efficiency()
	return efficiency

// Basic CPU - 1 THz, 100% efficient
/obj/item/ai_cpu/basic
	name = "basic AI CPU"
	desc = "A standard central processing unit for AI systems. Runs at 1 THz."
	icon_state = "cpu_basic"
	speed = 1
	efficiency = 1.0

// Advanced CPU - 2 THz, 95% efficient
/obj/item/ai_cpu/advanced
	name = "advanced AI CPU"
	desc = "An advanced central processing unit for AI systems. Runs at 2 THz with slightly reduced efficiency."
	icon_state = "cpu_advanced"
	speed = 2
	efficiency = 0.95

// Bluespace CPU - 4 THz, 90% efficient
/obj/item/ai_cpu/bluespace
	name = "bluespace AI CPU"
	desc = "A cutting-edge bluespace-enhanced central processing unit. Runs at 4 THz but with reduced efficiency due to quantum fluctuations."
	icon_state = "cpu_bluespace"
	speed = 4
	efficiency = 0.90
