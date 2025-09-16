extends CharacterBody2D

const type: String = "enemy"
const LEFT: int = 0
const RIGHT: int = 1
var screensize: Vector2
var half_w: int
var direction: int 
var speed_y: int = 200
var speed_x: int = 300

func _ready() -> void:
	screensize = get_viewport_rect().size
	half_w = $Sprite2D.texture.get_width() /2
	randomize()
	position.x = randi() % int (screensize.x)
	position.y = -100
	direction = randi()  % 2
	
func _physics_process(delta: float) -> void:
	velocity.x = 0
	velocity.y = speed_y
	if direction == RIGHT:
		velocity.x = speed_x
	if position.x + half_w > screensize.x:
		direction = LEFT
	elif direction == LEFT:
		velocity.x = -speed_x
	if position.x - half_w < 0:
		direction = RIGHT
	var info = move_and_collide(velocity * delta)
	if info:
		var entity = info.get_collider()
		if 'ship' in entity.type:
			kill()
			entity.kill()
			
			
	if position.y > screensize.y + 100:
		queue_free()
		get_parent().set_point(false)
	
func kill() -> void:
	get_parent().new_explosion(position)
	queue_free()
