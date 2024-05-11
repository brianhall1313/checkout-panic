extends Area2D

const SPEED:float = 1000.0
signal collected(collected_item)
var screen_size

func _ready():
	screen_size = get_viewport_rect().size

func _physics_process(delta):
	if Global.state == "play":
		var velocity = Vector2.ZERO
		var direction = Input.get_vector("left", "right", "up", "down")
		velocity = direction * SPEED
		
		position += velocity * delta
		position = position.clamp(Vector2.ZERO, screen_size)


func _on_body_entered(body):
	collected.emit(body)
