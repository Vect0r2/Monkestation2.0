/obj/item/ai_ram
	name = "AI RAM module"
	desc = "A memory module designed for artificial intelligence systems."
	icon = 'icons/obj/module.dmi'
	icon_state = "datadisk0"
	inhand_icon_state = "electronic"
	w_class = WEIGHT_CLASS_TINY

	var/capacity = 1 // TB

/obj/item/ai_ram/examine(mob/user)
	. = ..()
	. += span_notice("Capacity: [capacity] TB")
	. += span_notice("Power Usage: [AI_RAM_POWER_USAGE]W")

// 1TB RAM
/obj/item/ai_ram/one_tb
	name = "1TB AI RAM module"
	desc = "A 1 terabyte memory module for AI systems."
	icon_state = "ram_1tb"
	capacity = 1

// 2TB RAM
/obj/item/ai_ram/two_tb
	name = "2TB AI RAM module"
	desc = "A 2 terabyte memory module for AI systems."
	icon_state = "ram_2tb"
	capacity = 2

// 4TB RAM
/obj/item/ai_ram/four_tb
	name = "4TB AI RAM module"
	desc = "A 4 terabyte memory module for AI systems."
	icon_state = "ram_4tb"
	capacity = 4

// 8TB RAM
/obj/item/ai_ram/eight_tb
	name = "8TB AI RAM module"
	desc = "An 8 terabyte memory module for AI systems. Cutting-edge technology."
	icon_state = "ram_8tb"
	capacity = 8
