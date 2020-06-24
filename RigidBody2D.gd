extends RigidBody2D

var force = Vector2(0, 0)
const impulse_value_y = 75
const impulse_value_x = 25
var mouse_position;

func _physics_process(_delta):
	gravity_scale = 9.8
	bounce = 0.5
	force = Vector2(0, 0)
	if Input.is_action_pressed("ui_up"):
		force += Vector2(0, -impulse_value_y)
	if Input.is_action_pressed("ui_down"):
		force += Vector2(0, impulse_value_y)
	if Input.is_action_pressed("ui_left"):
		force += Vector2(-impulse_value_x, 0)
	if Input.is_action_pressed("ui_right"):
		force += Vector2(impulse_value_x, 0)
	if Input.is_mouse_button_pressed(1) && mouse_position:
		var mouse_position_new =  get_global_mouse_position()
		
		var difference = mouse_position_new - mouse_position;
		force += (Vector2(difference.x, difference.y*3)) * 0.05
		print(difference)
		
		
	elif Input.is_mouse_button_pressed(1):
		mouse_position = get_global_mouse_position()
	else:
		mouse_position = null
	apply_impulse(Vector2(0, 0), force)
	
