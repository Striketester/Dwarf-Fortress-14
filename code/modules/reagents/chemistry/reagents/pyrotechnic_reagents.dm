/datum/reagent/thermite
	name = "Термит"
	enname = "Thermite"
	description = "Thermite produces an aluminothermic reaction known as a thermite reaction. Can be used to melt walls."
	reagent_state = SOLID
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	color = "#550000"
	taste_description = "сладкий вкус металла"

/datum/reagent/thermite/expose_turf(turf/exposed_turf, reac_volume)
	. = ..()
	if(reac_volume >= 1)
		exposed_turf.AddComponent(/datum/component/thermite, reac_volume)

/datum/reagent/thermite/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	M.adjustFireLoss(1 * REM * delta_time, 0)
	..()
	return TRUE

/datum/reagent/nitroglycerin
	name = "Нитроглицерин"
	enname = "Nitroglycerin"
	description = "Nitroglycerin is a heavy, colorless, oily, explosive liquid obtained by nitrating glycerol."
	color = "#808080" // rgb: 128, 128, 128
	taste_description = "масло"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/stabilizing_agent
	name = "Стабилизирующее Вещество"
	enname = "Stabilizing Agent"
	description = "Keeps unstable chemicals stable. This does not work on everything."
	reagent_state = LIQUID
	color = "#FFFF00"
	taste_description = "металл"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/clf3
	name = "Трифторид Хлора"
	enname = "Chlorine Trifluoride"
	description = "Makes a temporary 3x3 fireball when it comes into existence, so be careful when mixing. ClF3 applied to a surface burns things that wouldn't otherwise burn, sometimes through the very floors of the station and exposing it to the vacuum of space."
	reagent_state = LIQUID
	color = "#FFC8C8"
	metabolization_rate = 10 * REAGENTS_METABOLISM
	taste_description = "горение"
	penetrates_skin = NONE
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/clf3/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	M.adjust_fire_stacks(2 * REM * delta_time)
	M.adjustFireLoss(0.3 * max(M.fire_stacks, 1) * REM * delta_time, 0)
	..()
	return TRUE

/datum/reagent/clf3/expose_turf(turf/exposed_turf, reac_volume)
	. = ..()
	if(isplatingturf(exposed_turf))
		var/turf/open/floor/plating/target_plating = exposed_turf
		if(prob(10 + target_plating.burnt + 5*target_plating.broken)) //broken or burnt plating is more susceptible to being destroyed
			target_plating.ScrapeAway(flags = CHANGETURF_INHERIT_AIR)
	if(isfloorturf(exposed_turf))
		var/turf/open/floor/target_floor = exposed_turf
		if(prob(reac_volume))
			target_floor.make_plating()
		else if(prob(reac_volume))
			target_floor.burn_tile()

/datum/reagent/clf3/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume)
	. = ..()
	exposed_mob.adjust_fire_stacks(min(reac_volume/5, 10))
	exposed_mob.IgniteMob()

/datum/reagent/sorium
	name = "Сориум"
	enname = "Sorium"
	description = "Sends everything flying from the detonation point."
	reagent_state = LIQUID
	color = "#5A64C8"
	taste_description = "воздух и горечь"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/liquid_dark_matter
	name = "Жидкая Тёмная Материя"
	enname = "Liquid Dark Matter"
	description = "Sucks everything into the detonation point."
	reagent_state = LIQUID
	color = "#210021"
	taste_description = "сжатая горечь"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/gunpowder
	name = "Оружейный Порох"
	enname = "Gunpowder"
	description = "Explodes. Violently."
	reagent_state = LIQUID
	color = "#000000"
	metabolization_rate = 0.125 * REAGENTS_METABOLISM
	taste_description = "соль"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/gunpowder/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	. = TRUE
	..()
	M.set_drugginess(15 * REM * delta_time)
	if(M.hallucination < volume)
		M.hallucination += 5 * REM * delta_time

/datum/reagent/gunpowder/on_ex_act()
	var/location = get_turf(holder.my_atom)
	var/datum/effect_system/reagents_explosion/e = new()
	e.set_up(1 + round(volume/6, 1), location, 0, 0, message = 0)
	e.start()
	holder.clear_reagents()

/datum/reagent/rdx
	name = "Гексоген"
	enname = "RDX"
	description = "Military grade explosive"
	reagent_state = SOLID
	color = "#FFFFFF"
	taste_description = "соль"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/tatp
	name = "TaTP"
	enname = "TaTP"
	description = "Suicide grade explosive"
	reagent_state = SOLID
	color = "#FFFFFF"
	taste_description = "смерть"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/flash_powder
	name = "Светошумовой Порох"
	enname = "Flash Powder"
	description = "Makes a very bright flash."
	reagent_state = LIQUID
	color = "#C8C8C8"
	taste_description = "соль"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/smoke_powder
	name = "Дымный Порох"
	enname = "Smoke Powder"
	description = "Makes a large cloud of smoke that can carry reagents."
	reagent_state = LIQUID
	color = "#C8C8C8"
	taste_description = "дым"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/sonic_powder
	name = "Звуковой Порох"
	enname = "Sonic Powder"
	description = "Makes a deafening noise."
	reagent_state = LIQUID
	color = "#C8C8C8"
	taste_description = "громкие звуки"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/phlogiston
	name = "Флогистон"
	enname = "Phlogiston"
	description = "Catches you on fire and makes you ignite."
	reagent_state = LIQUID
	color = "#FA00AF"
	taste_description = "горение"
	self_consuming = TRUE
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/phlogiston/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume)
	. = ..()
	exposed_mob.adjust_fire_stacks(1)
	var/burndmg = max(0.3*exposed_mob.fire_stacks, 0.3)
	exposed_mob.adjustFireLoss(burndmg, 0)
	exposed_mob.IgniteMob()

/datum/reagent/phlogiston/on_mob_life(mob/living/carbon/metabolizer, delta_time, times_fired)
	metabolizer.adjust_fire_stacks(1 * REM * delta_time)
	metabolizer.adjustFireLoss(0.3 * max(metabolizer.fire_stacks, 0.15) * REM * delta_time, 0)
	..()
	return TRUE

/datum/reagent/napalm
	name = "Напалм"
	enname = "Napalm"
	description = "Very flammable."
	reagent_state = LIQUID
	color = "#FA00AF"
	taste_description = "горение"
	self_consuming = TRUE
	penetrates_skin = NONE
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/napalm/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	M.adjust_fire_stacks(1 * REM * delta_time)
	..()

/datum/reagent/napalm/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(istype(exposed_mob) && (methods & (TOUCH|VAPOR|PATCH)))
		exposed_mob.adjust_fire_stacks(min(reac_volume/4, 20))

#define CRYO_SPEED_PREFACTOR 0.4
#define CRYO_SPEED_CONSTANT 0.1

/datum/reagent/cryostylane
	name = "Криостилан"
	enname = "Cryostylane"
	description = "Induces a cryostasis like state in a patient's organs, preventing them from decaying while dead. Slows down surgery while in a patient however. When reacted with oxygen, it will slowly consume it and reduce a container's temperature to 0K. Also damages slime simplemobs when 5u is sprayed."
	color = "#0000DC"
	metabolization_rate = 0.05 * REAGENTS_METABOLISM
	taste_description = "ледяная горечь"
	purity = REAGENT_STANDARD_PURITY
	self_consuming = TRUE
	impure_chem = /datum/reagent/consumable/ice
	inverse_chem_val = 0.5
	inverse_chem = /datum/reagent/inverse/cryostylane
	failed_chem = null
	burning_volume = 0.05
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED | REAGENT_DEAD_PROCESS

/datum/reagent/cryostylane/burn(datum/reagents/holder)
	if(holder.has_reagent(/datum/reagent/oxygen))
		burning_temperature = 0//king chilly
		return
	burning_temperature = null

/datum/reagent/cryostylane/on_mob_add(mob/living/consumer, amount)
	. = ..()
	consumer.mob_surgery_speed_mod = 1-((CRYO_SPEED_PREFACTOR * (1 - creation_purity))+CRYO_SPEED_CONSTANT) //10% - 30% slower
	consumer.color = COLOR_CYAN

/datum/reagent/cryostylane/on_mob_delete(mob/living/consumer)
	. = ..()
	consumer.mob_surgery_speed_mod = 1
	consumer.color = COLOR_WHITE

//Pauses decay! Does do something, I promise.
/datum/reagent/cryostylane/on_mob_dead(mob/living/carbon/consumer)
	. = ..()
	metabolization_rate = 0.05 * REM //slower consumption when dead

/datum/reagent/cryostylane/on_mob_life(mob/living/carbon/consumer, delta_time, times_fired)
	metabolization_rate = 0.25 * REM//faster consumption when alive
	if(consumer.reagents.has_reagent(/datum/reagent/oxygen))
		consumer.reagents.remove_reagent(/datum/reagent/oxygen, 0.5 * REM * delta_time)
		consumer.adjust_bodytemperature(-15 * REM * delta_time)
		if(ishuman(consumer))
			var/mob/living/carbon/human/humi = consumer
			humi.adjust_coretemperature(-15 * REM * delta_time)
	..()

/datum/reagent/cryostylane/expose_turf(turf/exposed_turf, reac_volume)
	. = ..()
	if(reac_volume < 5)
		return

#undef CRYO_SPEED_PREFACTOR
#undef CRYO_SPEED_CONSTANT

/datum/reagent/pyrosium
	name = "Пирозий"
	enname = "Pyrosium"
	description = "Comes into existence at 20K. As long as there is sufficient oxygen for it to react with, Pyrosium slowly heats all other reagents in the container."
	color = "#64FAC8"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	taste_description = "горечь"
	self_consuming = TRUE
	burning_temperature = null
	burning_volume = 0.05
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/pyrosium/burn(datum/reagents/holder)
	if(holder.has_reagent(/datum/reagent/oxygen))
		burning_temperature = 3500
		return
	burning_temperature = null

/datum/reagent/pyrosium/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	if(holder.has_reagent(/datum/reagent/oxygen))
		holder.remove_reagent(/datum/reagent/oxygen, 0.5 * REM * delta_time)
		M.adjust_bodytemperature(15 * REM * delta_time)
		if(ishuman(M))
			var/mob/living/carbon/human/humi = M
			humi.adjust_coretemperature(15 * REM * delta_time)
	..()

/datum/reagent/teslium //Teslium. Causes periodic shocks, and makes shocks against the target much more effective.
	name = "Теслий"
	enname = "Teslium"
	description = "An unstable, electrically-charged metallic slurry. Periodically electrocutes its victim, and makes electrocutions against them more deadly. Excessively heating teslium results in dangerous destabilization. Do not allow to come into contact with water."
	reagent_state = LIQUID
	color = "#20324D" //RGB: 32, 50, 77
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	taste_description = "заряженный металл"
	self_consuming = TRUE
	var/shock_timer = 0
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/teslium/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	shock_timer++
	if(shock_timer >= rand(5, 30)) //Random shocks are wildly unpredictable
		shock_timer = 0
		M.electrocute_act(rand(5, 20), "Teslium in their body", 1, SHOCK_NOGLOVES) //SHOCK_NOGLOVES because it's caused from INSIDE of you
		playsound(M, "sparks", 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	..()

/datum/reagent/teslium/energized_jelly
	name = "Заряженный Желатин"
	enname = "Energized Jelly"
	description = "Electrically-charged jelly. Boosts jellypeople's nervous system, but only shocks other lifeforms."
	reagent_state = LIQUID
	color = "#CAFF43"
	taste_description = "желе"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/firefighting_foam
	name = "Пена для Пожаротушения"
	enname = "Firefighting Foam"
	description = "A historical fire suppressant. Originally believed to simply displace oxygen to starve fires, it actually interferes with the combustion reaction itself. Vastly superior to the cheap water-based extinguishers found on NT vessels."
	reagent_state = LIQUID
	color = "#A6FAFF55"
	taste_description = "внутренняя часть огнетушителя"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/firefighting_foam/expose_turf(turf/open/exposed_turf, reac_volume)
	. = ..()
	if (!istype(exposed_turf))
		return


/datum/reagent/firefighting_foam/expose_obj(obj/exposed_obj, reac_volume)
	. = ..()
	exposed_obj.extinguish()

/datum/reagent/firefighting_foam/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(methods & (TOUCH|VAPOR))
		exposed_mob.extinguish_mob() //All stacks are removed
