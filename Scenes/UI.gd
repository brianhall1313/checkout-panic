extends Control

@onready var start_button =$start_button
@onready var list_element = $list_background/shopping_list/shopping_list
@onready var game_over_screen=$game_over_screen
@onready var restart=$game_over_screen/VBoxContainer/restart
@onready var results=$game_over_screen/VBoxContainer/results
@onready var next=$game_over_screen/VBoxContainer/next
# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSignalBus.connect("update_list",update_list)
	GlobalSignalBus.connect("update_balance",update_balance)
	GlobalSignalBus.connect("game_over",_on_game_over)
	GlobalSignalBus.connect("list_complete",_on_level_complete)


func update_list(list):
	list_element.text = ""
	for item in list:
		list_element.text+=item["item_name"] + ": " + str(item["have"]) + "/" + str(item["need"]) + "\n"


func update_balance(balance):
	pass


func _on_game_over(debt):
	game_over_screen.show()
	restart.show()
	next.hide()
	results.text = "You are bankrupt!\nYou are now $" + str(debt)+" in debt!" 

func _on_level_complete():
	game_over_screen.show()
	restart.hide()
	next.show()
	results.text = "You completed your shopping trip without going destitute!"
