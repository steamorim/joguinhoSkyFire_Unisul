extends Node2D

const Enemy = preload("res://enemy.tscn")
const Bomb = preload("res://bomb.tscn")
const Explosion = preload("res://explosion.tscn")

var gameover: bool = false
var score: int = 0

func set_point(up: bool) -> void:
	if up:
		score += 1
	else: 
		score -= 1
	$Score.text = str(score)

func game_over() -> void:
	$Music.stop()
	gameover = true
	$ImageGameOver.visible = true
	
func new_bomb(pos: Vector2) -> void:
	var bomb = Bomb.instantiate()
	bomb.position = pos
	add_child(bomb)

func new_explosion(pos: Vector2) -> void:
	var explosion = Explosion.instantiate()
	explosion.position = pos
	add_child(explosion)

func _on_timer_timeout() -> void:
	if gameover:
		return
	var enemy = Enemy.instantiate()
	add_child(enemy)
	$Timer.wait_time = (randi() % 2) + 1
	$Timer.start()
	
