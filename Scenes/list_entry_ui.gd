extends Control

@onready var done_icon = $HBoxContainer/done_icon
@onready var item_title = $HBoxContainer/item
@onready var progress = $HBoxContainer/progress

const clear = Rect2(1239,3353,175,185)


func initialize(item_stats):
	item_title.text = item_stats["item_name"]
	progress.text = "0/" + str(item_stats["need"])


func update_data(item_stats):
	progress.text = str(item_stats["have"]) + "/" + str(item_stats["need"])
	if item_stats["have"] >= item_stats["need"]:
		done_icon.region_rect = clear


