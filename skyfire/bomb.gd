extends CharacterBody2D

const type: String = "bomb"
var speed: int = 200

func _ready() -> void:
	$Sound.play()
	
func _physics_process(delta: float) -> void:
	velocity.y = -speed
	var info = move_and_collide(velocity * delta)
	if info:
		var entity = info.get_collider()
		if 'enemy' in entity.type:
			entity.kill()
			kill()
			get_parent().set_point(true)
	if position.y < 0:
		queue_free()
		
func kill() -> void:
		queue_free()
	
