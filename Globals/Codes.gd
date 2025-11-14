extends Node

var codes: Dictionary[String, Callable] = {
	"spedicey": func(): if not Achievements.data.has("Jacksepticeye"):Achievements.data["Jacksepticeye"] = true;Achievements.data["SecretMusic"] = true,
	"dayumm": func(): if not Achievements.data.has("DayumDrops"):Achievements.data["DayumDrops"] = true;Achievements.data["SecretMusic"] = true,
	"brofist": func(): if not Achievements.data.has("PewDiePie"):Achievements.data["PewDiePie"] = true;Achievements.data["SecretMusic"] = true,	
	"motherlode": func(): if not Achievements.data.has("Cheater"):Achievements.data["Cheater"] = true,
}

func submit_code(code: String) -> bool:
	code = code.to_lower()
	if codes.has(code):
		codes[code].call()
		Achievements.save_data()
		return true
	else:
		print("Invalid code:", code)
		return false
