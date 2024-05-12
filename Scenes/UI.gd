extends Control

@onready var start_button =$start_button
@onready var game_over_screen=$game_over_screen
@onready var restart=$game_over_screen/VBoxContainer/restart
@onready var results=$game_over_screen/VBoxContainer/results
@onready var next=$game_over_screen/VBoxContainer/next
@onready var shopping_list=$list_background/shopping_list
@onready var spent=$balance/GridContainer/spent
@onready var card_display=$balance/GridContainer/card_display
@onready var total=$balance/GridContainer/total

@onready var list_entry:PackedScene = load("res://Scenes/list_entry_ui.tscn")
@onready var card_sprite:PackedScene = load("res://Scenes/credit_card.tscn")


signal start


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSignalBus.connect("initial_list",initial_list)
	GlobalSignalBus.connect("update_balance",update_balance)
	GlobalSignalBus.connect("update_list",update_list)
	GlobalSignalBus.connect("game_over",_on_game_over)
	GlobalSignalBus.connect("list_complete",_on_level_complete)


func update_list(list):
	var children = shopping_list.get_children()
	for child in children:
		for item in list:
			if item["item_name"] == child.name:
				child.update_data(item)
	


func initial_list(list):
	for item in list:
		var new = list_entry.instantiate()
		shopping_list.add_child(new)
		new.initial_data(item)


func update_cards(cards):
	for card in card_display.get_children():
		card.queue_free()
	for i in range(cards):
		card_display.add_child(card_sprite.instantiate())


func update_balance(balance):
	spent.text = "$"+str(balance.spent)+"/$"+str(balance.budget)
	update_cards(balance.cards)
	total.text = "$"+str(balance.credit_current)+"/$"+str(balance.credit_limit)


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


func _on_start_button_button_up():
	start.emit()
	start_button.hide()


func _on_quit_button_up():
	get_tree().change_scene_to_file("res://Scenes/start_screen.tscn")

func _on_next_button_up():
	Global.intensity+=1
	Global.change_state("continue")
	get_tree().reload_current_scene()


func _on_restart_button_up():
	Global.intensity=1
	Global.change_state("new")
	get_tree().reload_current_scene()
