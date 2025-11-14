extends Node

var codes: Dictionary[String, Callable] = {
	"spedicey": func(): if not Achievements.data.has("Jacksepticeye"):Achievements.data["Jacksepticeye"] = true;Achievements.data["SecretMusic"] = true,
	"DAYUMM": func(): if not Achievements.data.has("DayumDrops"):Achievements.data["DayumDrops"] = true;Achievements.data["SecretMusic"] = true,
	"Motherlode": func(): if not Achievements.data.has("Cheater"):Achievements.data["Cheater"] = true,
}

func submit_code(code: String) -> bool:
	if codes.has(code):
		codes[code].call()
		Achievements.save_data()
		return true
	else:
		print("Invalid code:", code)
		return false
