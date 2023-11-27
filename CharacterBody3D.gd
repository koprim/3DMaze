extends CharacterBody3D

const SPEED = 50.0

@export_range(0.1, 3.0, 0.1, "or_greater") var camera_sens: float = 3
var look_dir: Vector2 # Input direction for look/aim

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(_delta):
	# Add the gravity.
	#if not is_on_floor():
	#	velocity.y -= gravity * delta

	# Handle Jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
func _input(event):         
	if event is InputEventMouseMotion:
		look_dir = event.relative * 0.001
		rotation.y -= look_dir.x * camera_sens
		$Camera3D.rotation.x = clamp($Camera3D.rotation.x - look_dir.y * camera_sens, -1.5, 1.5)
