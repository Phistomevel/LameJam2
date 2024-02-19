@icon("res://grafiken/augeRot.png")

extends Node2D
var throwTarget


var retractTarget : Node
var state
var startTimeStamp

# Called when the node enters the scene tree for the first time.
func _ready():
	state = "send"
	startTimeStamp = Time.get_ticks_msec()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if state == "send":
		sendOut(delta)
	elif state == "recall":
		recalled(delta)
	elif state== "idle":
		idle(delta)
	pass


func sendOut(delta):
	if (throwTarget - global_position).length()>20:
		global_position += (throwTarget - global_position).normalized()*600 * delta
	else:
		global_position = throwTarget
		state = "idle"
		

func recalled(delta):
	global_position += (retractTarget.global_position - global_position).normalized()*800* delta
	pass

func idle(delta):
	rotation += get_angle_to(get_global_mouse_position())

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
			global_rotation = (retractTarget.global_position - global_position).angle()
			state = "recall"




func _on_eye_area_area_entered(area):
	print("area")
	pass # Replace with function body.


func _on_eye_area_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	print("area body shape")
	state= "idle"
	pass # Replace with function body.


func _on_eye_area_body_entered(body):
	print("area body")
	state= "idle"
	pass # Replace with function body.
