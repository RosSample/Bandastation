/mob/living/silicon/ai/verb/ai_change_voice()
	set category = "AI Commands"
	set name = "Change Voice"
	change_tts_seed(new_traits = list(TTS_TRAIT_ROBOTIZE))
