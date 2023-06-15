extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var planet = null
 

func _physics_process(delta):
	if planet:
		
		var direction_to_planet_center = (planet.global_transform.origin - global_transform.origin).normalized()
		look_at(direction_to_planet_center, Vector3.UP)
		pass
	# Handle Jump.
 
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


func _on_area_3d_body_entered(body):
	planet = body
	print(body)

func _on_area_3d_body_exited(body):
	planet = null
