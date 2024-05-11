extends Node2D

@onready var item_blank: PackedScene = load("res://Scenes/item.tscn")
@onready var timer = $item_timer
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
	

func start_level():
	player.game_setup()
	Global.change_state("play")
	timer.start()


func spawn_item():
	var new_item = item_blank.instantiate()
	spawn.progress_ratio=.5#randf()
	new_item.position = spawn.position
	add_child(new_item)
	new_item.setup(Items.get_random_item())


func _on_item_timer_timeout():
	if Global.state == "play":
		spawn_item()


func _on_button_button_up():
	$UI/start_button.hide()
	start_level()


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
	
