extends Node2D

@onready var item_blank: PackedScene = load("res://Scenes/item.tscn")
@onready var timer = $item_timer
@onready var timer2 = $item_timer2
@onready var spawn = $Path2D/spawn_point
@onready var ui = $UI
@onready var player:Player = load("res://Resources/Player.tres")

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSignalBus.connect("game_over",_on_game_over)
	GlobalSignalBus.connect("list_complete",_on_level_complete)
	Global.change_state("pregame")
	Items.initialize_items(Global.intensity)
	timer.wait_time = timer.wait_time/Global.intensity
	timer2.wait_time = randf()
	
	

func start_level():
	player.game_setup()
	Global.change_state("play")
	timer.start()
	timer2.start()


func spawn_item():
	var new_item = item_blank.instantiate()
	spawn.progress_ratio=randf()
	new_item.position = spawn.position
	add_child(new_item)
	new_item.setup(Items.get_random_item())


func _on_item_timer_timeout():
	if Global.state == "play":
		for i in range(Global.intensity):
			spawn_item()


func _on_basket_collected(collected_item):
	if Global.state == "play":
		player.bought(collected_item.item_name)
		collected_item.queue_free()


func _on_game_over(debt):
	Global.change_state("game over")
	print("GAME OVER\n",debt)

func _on_level_complete():
	print("LEvel Complete")
	Global.change_state("game over")
	


func _on_item_timer_2_timeout():
	if Global.state == "play":
		timer2.wait_time = randf()
		spawn_item()


func _on_ui_start():
	start_level()
