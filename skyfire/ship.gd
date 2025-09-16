extends CharacterBody2D

const type: String = "ship"
var speed: int  = 500
var screensize: Vector2
var half_h: int
var half_w: int

func _ready() -> void:
	screensize = get_viewport_rect().size
	half_h = $Sprite2D.texture.get_height() / 2
	half_w =$Sprite2D.texture.get_width() / 2

func _physics_process(delta: float) -> void:
	if get_parent().score < 0:
		kill()
		return
	velocity.x = 0.0
	if Input.is_action_pressed("ui_right"):
		velocity.x = speed
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -speed
	if Input.is_action_just_pressed("ui_select"):
		var x = position.x 
		var y = position.y - half_h - 20
		get_parent().new_bomb(Vector2(x,y))
	var info = move_and_collide(velocity * delta)
	position.x = clamp(position.x, half_w, screensize.x - half_w)
	
func kill() -> void:
	get_parent().new_explosion(position)
	get_parent().game_over()
	queue_free()
	
	
	
	
