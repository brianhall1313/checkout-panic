extends Node2D

@onready var item_blank: PackedScene = load("res://Scenes/item.tscn")
@onready var timer = $item_timer
@onready var timer2 = $item_timer2
@onready var hazard_timer=$hazard_timer
@onready var spawn = $Path2D/spawn_point
@onready var ui = $UI
@onready var player:Player = load("res://Resources/Player.tres")

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSignalBus.connect("game_over",_on_game_over)
	GlobalSignalBus.connect("list_complete",_on_level_complete)
	Items.initialize_items(Global.intensity)
	timer.wait_time = timer.wait_time/Global.intensity
	timer2.wait_time = randf()
	hazard_timer.wait_time = hazard_timer.wait_time/Global.intensity
	if Global.state == "new":
		print("play a new game")
		player.game_setup()
	else:
		print("play a previous state")
		player.game_setup(true)
	GlobalSignalBus.update_balance.emit(player.get_budget())
	Global.change_state("pregame")
	

func start_level():
	Global.change_state("play")
	timer.start()
	timer2.start()
	hazard_timer.start()


func spawn_item():
	var new_item = item_blank.instantiate()
	spawn.progress_ratio=randf()
	new_item.position = spawn.position
	add_child(new_item)
	new_item.setup(Items.get_random_item())


func spawn_hazard():
	var new_item = item_blank.instantiate()
	spawn.progress_ratio=randf()
	new_item.position = spawn.position
	add_child(new_item)
	new_item.setup(Items.get_random_hazard())


func _on_item_timer_timeout():
	if Global.state == "play":
		spawn_item()


func _on_basket_collected(collected_item):
	if Global.state == "play":
		player.bought(collected_item.item_name)
		collected_item.queue_free()
		GlobalSignalBus.update_balance.emit(player.get_budget())
		GlobalSignalBus.play_effect.emit("collect")


func _on_game_over(debt):
	Global.change_state("game over")
	print("GAME OVER\n",debt)

func _on_level_complete():
	print("LEvel Complete")
	Global.save(player.get_budget())
	Global.change_state("game over")
	


func _on_item_timer_2_timeout():
	if Global.state == "play":
		timer2.wait_time = randf()
		spawn_item()


func _on_ui_start():
	start_level()


func _on_hazard_timer_timeout():
	if Global.state == "play":
		var intensity_modifier=clamp(Global.intensity,1,6)
		if 1 == randi_range(1,8-intensity_modifier):
			spawn_hazard()
