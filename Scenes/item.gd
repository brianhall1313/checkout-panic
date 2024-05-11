class_name Item
extends RigidBody2D

@onready var sprite = $icon
@onready var hitbox = $hitbox
var item_name:String =""



func setup(item:String):
	var reg = Items.items[item]["region"]
	sprite.region_rect = reg
	self.item_name = item
	hitbox.shape.size = reg.size


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
