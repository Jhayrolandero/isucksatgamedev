extends CharacterBody3D

var mouse_sensitivity := 0.001
var twist_input := 0.0
var pitch_input := 0.0

# Node Variable
@onready var twist_pivot = $TwistPivot
@onready var pitch_pivot = $TwistPivot/PitchPivot
@onready var knight = $"."

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
@onready var animation_player = $AnimationPlayer

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	
	if Input.is_action_just_pressed("move_forward"):
		print("Forward")
	elif  Input.is_action_just_pressed("move_backward"):
		print("Backward")
	elif  Input.is_action_just_pressed("move_left"):
		print("Left")
	elif  Input.is_action_just_pressed("move_right"):
		print("Right")
		
	var direction = (twist_pivot.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if Input.is_action_just_pressed("move_backward") or Input.is_action_just_pressed("move_forward") or Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"): 
		print(twist_pivot.basis)
	
	if direction:
		animation_player.play("Walking_A")
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		animation_player.play("Idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	twist_pivot.rotate_y(twist_input)
	pitch_pivot.rotate_x(pitch_input)
	
	pitch_pivot.rotation.x = clamp(pitch_pivot.rotation.x, deg_to_rad(-30), deg_to_rad(40))
	twist_input = 0.0
	pitch_input = 0.0
	
	
		
	move_and_slide()

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			twist_input = - event.relative.x * mouse_sensitivity
			pitch_input = - event.relative.y * mouse_sensitivity


# Rotation

	
	
	
	
	
	
	
