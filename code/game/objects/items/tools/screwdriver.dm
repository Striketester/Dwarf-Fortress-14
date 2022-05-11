/obj/item/screwdriver
	name = "отвёртка"
	desc = "Ею можно откручивать и закручивать различные штуки."
	gender = FEMALE
	icon = 'white/valtos/icons/items.dmi'
	lefthand_file = 'white/valtos/icons/lefthand.dmi'
	righthand_file = 'white/valtos/icons/righthand.dmi'
	icon_state = "screwdriver_map"
	inhand_icon_state = "screwdriver"
	worn_icon_state = "screwdriver"
	belt_icon_state = "screwdriver"
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT
	force = 5
	w_class = WEIGHT_CLASS_TINY
	throwforce = 5
	throw_speed = 3
	throw_range = 5
	custom_materials = list(/datum/material/iron=75)
	attack_verb_continuous = list("втыкает")
	attack_verb_simple = list("втыкает")
	hitsound = 'sound/weapons/bladeslice.ogg'
	usesound = list('sound/items/screwdriver.ogg', 'sound/items/screwdriver2.ogg')
	tool_behaviour = TOOL_SCREWDRIVER
	toolspeed = 1
	drop_sound = 'sound/items/handling/screwdriver_drop.ogg'
	pickup_sound =  'sound/items/handling/screwdriver_pickup.ogg'
	atck_type = PIERCE
	var/random_color = TRUE //if the screwdriver uses random coloring
	var/static/list/screwdriver_colors = list(
		"blue" = rgb(24, 97, 213),
		"red" = rgb(255, 0, 0),
		"pink" = rgb(213, 24, 141),
		"brown" = rgb(160, 82, 18),
		"green" = rgb(14, 127, 27),
		"cyan" = rgb(24, 162, 213),
		"yellow" = rgb(255, 165, 0)
	)

/obj/item/screwdriver/suicide_act(mob/user)
	user.visible_message(span_suicide("[user] is stabbing [src] into [user.ru_ego()] [pick("temple", "heart")]! It looks like [user.p_theyre()] trying to commit suicide!"))
	return(BRUTELOSS)

/obj/item/screwdriver/Initialize()
	. = ..()
	AddElement(/datum/element/eyestab)
	if(random_color) //random colors!
		icon_state = "screwdriver"
		var/our_color = pick(screwdriver_colors)
		add_atom_colour(screwdriver_colors[our_color], FIXED_COLOUR_PRIORITY)
		update_icon()
	if(prob(75))
		pixel_y = rand(0, 16)

/obj/item/screwdriver/update_overlays()
	. = ..()
	if(!random_color) //icon override
		return
	var/mutable_appearance/base_overlay = mutable_appearance(icon, "screwdriver_screwybits")
	base_overlay.appearance_flags = RESET_COLOR
	. += base_overlay

/obj/item/screwdriver/worn_overlays(isinhands = FALSE, icon_file)
	. = list()
	if(isinhands && random_color)
		var/mutable_appearance/M = mutable_appearance(icon_file, "screwdriver_head")
		M.appearance_flags = RESET_COLOR
		. += M

/obj/item/screwdriver/get_belt_overlay()
	if(random_color)
		var/mutable_appearance/body = mutable_appearance('white/valtos/icons/belt_overlays.dmi', "screwdriver")
		var/mutable_appearance/head = mutable_appearance('white/valtos/icons/belt_overlays.dmi', "screwdriver_head")
		body.color = color
		head.add_overlay(body)
		return head
	else
		return mutable_appearance('white/valtos/icons/belt_overlays.dmi', icon_state)

/obj/item/screwdriver/abductor
	name = "инопланетная отвёртка"
	desc = "Похожа на экспериментальную сверхзвуковую отвертку."
	icon = 'icons/obj/abductor.dmi'
	icon_state = "screwdriver_a"
	inhand_icon_state = "screwdriver_nuke"
	usesound = 'sound/items/pshoom.ogg'
	toolspeed = 0.1
	random_color = FALSE

/obj/item/screwdriver/abductor/get_belt_overlay()
	return mutable_appearance('white/valtos/icons/belt_overlays.dmi', "screwdriver_nuke")

/obj/item/screwdriver/cyborg
	name = "автоматическая отвертка"
	desc = "Мощная автоматическая отвертка, разработанная для быстрой и точной работы."
	icon = 'white/Feline/icons/cyber_arm_tools.dmi'
	icon_state = "screwdriver_cyborg"
	hitsound = 'sound/items/drill_hit.ogg'
	usesound = 'sound/items/drill_use.ogg'
	toolspeed = 0.5
	random_color = FALSE
