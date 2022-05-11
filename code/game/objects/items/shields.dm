/obj/item/shield
	name = "щит"
	icon = 'icons/obj/shields.dmi'
	block_chance = 50
	var/transparent = FALSE	// makes beam projectiles pass through the shield
	block_sounds = list('white/valtos/sounds/shieldhit1.wav', 'white/valtos/sounds/shieldhit2.wav')

/obj/item/shield/proc/on_shield_block(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "attack", damage = 0, attack_type = MELEE_ATTACK)
	return TRUE
