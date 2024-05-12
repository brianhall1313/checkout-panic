class_name Item
extends CharacterBody2D

@onready var sprite = $icon
@onready var hitbox = $hitbox
var item_name:String =""
const SPEED:int=300

func _physics_process(delta):
	if (velocity == Vector2.ZERO):
		velocity.y = 250
	move_and_collide(velocity * delta)


func setup(item:String):
	var reg 
	if item in Items.hazard.keys():
		reg = Items.hazard[item]["region"]
	else:
		reg = Items.items[item]["region"]
	sprite.region_rect = reg
	self.item_name = item
	hitbox.shape.size = reg.size


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
