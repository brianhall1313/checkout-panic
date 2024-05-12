extends AudioStreamPlayer


var effect_dict:Dictionary = {"complete":preload("res://Sound/Magic-And-Spell-Sound-Effects-magic-game-win-success.wav"),
"collect":preload("res://Sound/impactSoft_medium_000.ogg"),
}
# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSignalBus.connect('play_effect',_on_play_effect)

func _on_play_effect(effect):
	if effect == "collect":
		$"../effect_backup".stream=effect_dict[effect]
		$"../effect_backup".play()
		return
	stream=effect_dict[effect]
	play()
