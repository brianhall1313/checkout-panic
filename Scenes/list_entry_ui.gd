extends Control

@onready var done_icon = $HBoxContainer/done_icon
@onready var item_title = $HBoxContainer/item
@onready var progress = $HBoxContainer/progress
@onready var complete = $HBoxContainer/complete
var initial_complete:bool = false


func initial_data(item_stats):
	self.name = item_stats["item_name"]
	item_title.text = item_stats["item_name"]
	progress.text = "0/" + str(item_stats["need"])


func update_data(item_stats):
	progress.text = str(item_stats["have"]) + "/" + str(item_stats["need"])
	if item_stats["have"] >= item_stats["need"]:
		done_icon.hide()
		complete.show()
		if initial_complete == false:
			GlobalSignalBus.play_effect.emit("complete")
			initial_complete = true
