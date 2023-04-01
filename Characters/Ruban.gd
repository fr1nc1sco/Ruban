extends CharacterBody2D

# Get animation node for modifying
@onready var ANIMATION_NODE = $AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Movement variables
var SPEED = 200.0
var JUMP_VELOCITY = -600.0
# Attack variables
var is_attacking = false;

#Handles physics
func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var DIRECTION = Input.get_axis("left", "right")
	if DIRECTION:
		velocity.x = DIRECTION * SPEED
		if (velocity.x < 0):
			ANIMATION_NODE.flip_h = true
		elif (velocity.x > 0):
			ANIMATION_NODE.flip_h = false
		ANIMATION_NODE.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		ANIMATION_NODE.play("idle")
		
		
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		ANIMATION_NODE.play("fall")

	# Handle Jump.
	if Input.is_action_pressed("jump") and is_on_floor():
		ANIMATION_NODE.animation = "jump"
		if (SPEED > 0):
			SPEED -= SPEED*delta*3.5
	elif Input.is_action_just_released("jump") and is_on_floor():
		SPEED = 200
		velocity.y = JUMP_VELOCITY
		
		
	
	move_and_slide()


