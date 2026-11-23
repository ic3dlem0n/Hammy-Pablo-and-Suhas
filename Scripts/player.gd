extends CharacterBody2D
class_name Player

@export var speed: float = 120.0
@export var acceleration: float = 0.15
@export var deceleration: float = 0.2

@onready var character: AnimatedSprite2D = $player

func _physics_process(_delta: float) -> void:
	get_input()
	update_animations()

#Moves the character with the respective WASD KEYBAORD format
func get_input() -> void:
	if Input.is_action_pressed("d"):
		velocity.x = lerp(velocity.x, speed, acceleration)
	elif Input.is_action_pressed("a"):
		velocity.x = lerp(velocity.x, -speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, deceleration)

	if Input.is_action_pressed("s"):
		velocity.y = lerp(velocity.y, speed, acceleration)
	elif Input.is_action_pressed("w"):
		velocity.y = lerp(velocity.y, -speed, acceleration)
	else:
		velocity.y = lerp(velocity.y, 0.0, deceleration)

	move_and_slide()

#Changes the animation based on what the character is doing.
func update_animations() -> void:
	#Plays Idle Animation
	if velocity.length() < 5.0:
		character.stop()
		character.frame = 0
		return

	# plays the remaining animation which is the side by side and the top and bottom animation.
	if abs(velocity.x) > abs(velocity.y):
		character.flip_h = velocity.x < 0
		character.play("walk_cycle")
	else:
		character.flip_h = false
		if velocity.y < 0:
			character.play("top_cycle")
		else:
			character.play("bottom_cycle")
