extends CharacterBody2D
@onready var player = $"."


var speed = 100
var acc = 10
var target = Vector2.ZERO
var moving = false

func _input(event):
	if event is InputEventScreenTouch and event.is_pressed():
		target = event.position #pega o toque na tela 
		moving = true 
		
		
func _process(delta):
	if moving:
		var direction = (target - global_position).normalized()
		velocity = direction * speed
		move_and_slide()

	if global_position.distance_to(target) < 10:
		moving = false
		
