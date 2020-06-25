extends RigidBody2D

var disable_keyboard = false;
var disable_mouse = false;

const impulse_value_y = 75
const impulse_value_x = 25
const mouse_impulse = 1.4
const mouse_max = 65

var force = Vector2(0, 0)
var arrow_key_direction = Vector2(0, 0)
var mouse_position;
var mouse_pressed;


func _physics_process(delta):
	print(arrow_key_direction);
	force += Vector2(arrow_key_direction.x*impulse_value_x, arrow_key_direction.y*impulse_value_y)
	
	if mouse_pressed && mouse_position:
		var mouse_position_new =  get_global_mouse_position()
		
		var difference = mouse_position_new - mouse_position;
		var force_to_be_added = (Vector2(difference.x, difference.y*3)) * mouse_impulse
		if(force_to_be_added.length()>=mouse_max):
			force_to_be_added = mouse_max*force_to_be_added.normalized()
		force += force_to_be_added
		mouse_position += difference.normalized()*difference.length()*0.9
		#print(difference)
		
		
	elif mouse_pressed:
		mouse_position = get_global_mouse_position()
	else:
		mouse_position = null
	apply_impulse(Vector2(0, 0), force*delta*50)
	force = Vector2(0, 0)
	
	

func _unhandled_input(event):
	if event is InputEventKey && not disable_keyboard:
		var direction = Vector2(0, 0)
		if Input.is_action_pressed("ui_up"):
			direction += Vector2(0, -1)
		if Input.is_action_pressed("ui_down"):
			direction += Vector2(0, 1)
		if Input.is_action_pressed("ui_left"):
			direction += Vector2(-1, 0)
		if Input.is_action_pressed("ui_right"):
			direction += Vector2(1, 0)
		arrow_key_direction = direction;
	if event is InputEventMouseButton && not disable_mouse:
		if event.button_index == 1 :
			if event.pressed:
				mouse_pressed = true
			else:
				mouse_pressed = false
				
	
