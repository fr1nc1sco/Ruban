extends CharacterBody2D

# Variables
# Animation access variable
@onready var animated_sprite = $AnimatedSprite2D
# Movement variables
var SPEED = 200.0
var JUMP_VELOCITY = -600.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
# Attack Variables
var IS_ATTACKING = false
var LIGHT_ATTACK_DAMAGE = 10
var HEAVY_ATTACK_DAMAGE = 30

func _physics_process(delta):
		# Horizontal Movement
	var DIRECTION = Input.get_axis("left", "right")
	if DIRECTION and not IS_ATTACKING:
		velocity.x = DIRECTION*SPEED
		animated_sprite.play("walk")
		if (velocity.x < 0):
			animated_sprite.flip_h = true
		elif(velocity.x > 0):
			animated_sprite.flip_h = false
	else:
		animated_sprite.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	#Gravity
	if not is_on_floor():
		velocity.y += gravity * delta
		animated_sprite.animation = "fall"
	else:
		if (velocity.x == 0):
			animated_sprite.animation("idle")
	
	# Jump
	# if Ruban is on the floor and jump is being pressed
	if Input.is_action_pressed("jump") and is_on_floor():
		# charge jump animation
		animated_sprite.animation = "jump"
		if (SPEED >= 0):
			SPEED -= SPEED*delta*3.5
	elif Input.is_action_just_released("jump") and is_on_floor():
		SPEED = 200
		velocity.y = JUMP_VELOCITY
		animated_sprite.play("jump")
	else:
		SPEED = 200
		velocity.y = 0
		animated_sprite.play("idle")
	
		
	move_and_slide()


	
#		# Light Attack
#	if Input.is_action_just_pressed("light"):
#		IS_ATTACKING = true
#		animated_sprite.animation.play("jab")
#		if (SPEED >= 0):
#			SPEED -= SPEED*delta*4
#	elif Input.is_action_pressed("heavy"):
#		IS_ATTACKING = true
#		animated_sprite.animation = "heavy"
#		if (SPEED >= 0):
#			SPEED -= SPEED*delta*5
#		animated_sprite.animation.play()
#	elif Input.is_action_just_released("heavy"):
#		animated_sprite.animation.play("heavy")
#		if (SPEED >= 0):
#			SPEED -= SPEED*delta*6
#	else:
#		SPEED = 200
	

