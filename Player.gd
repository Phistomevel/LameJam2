@icon("res://grafiken/playableCharacterConcept2mithanden.png")
extends CharacterBody2D
@export var speed : int = 4
@export var hasEye = true


@onready var EyeScene = load("res://eye.tscn")
@onready var AnimSprite = $"AnimatedSprite2D"
var eyeNode : Node2D
var eyeInCollider : bool = false
var reverseDir 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	## the movement controls
	reverseDir = position
	if hasEye:
		if Input.is_key_pressed(KEY_W):
			move_and_collide(Vector2(0,-1)*speed)
		if Input.is_key_pressed(KEY_S):
			move_and_collide(Vector2(0, 1)*speed)
		if Input.is_key_pressed(KEY_A):
			move_and_collide(Vector2(-1, 0)*speed)
		if Input.is_key_pressed(KEY_D):
			move_and_collide(Vector2(1,0)*speed)
		rotation = (global_position-get_global_mouse_position()).angle()+PI
	

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
			if hasEye:
				AnimSprite.play()
			else:
				if eyeInCollider :
					eyeNode.free()
					hasEye = true
					AnimSprite.frame = 0


#throw an eye on to the position of a Vector 2D
func throwEye(target : Vector2): 
	
	hasEye = false
	var newEye = EyeScene.instantiate()
	add_sibling(newEye)
	newEye.global_position = self.global_position + Vector2(100,0).rotated(self.rotation)
	newEye.throwTarget = target
	newEye.retractTarget = self
	newEye.rotation = self.rotation
	eyeNode = newEye
	eyeInCollider = true






func _on_area_2d_area_entered(area):
	if area.get_parent().get_name() == "Eye":
		if area.get_parent().state !="send":
			area.get_parent().free()
			hasEye = true
			AnimSprite.frame = 0
	
	pass # Replace with function body.


func _on_area_2d_area_exited(area):
	if area.get_parent().get_name() == "Eye":
		if area.get_parent().state =="send":
			eyeInCollider = false
	pass # Replace with function body.


func _on_animated_sprite_2d_frame_changed():
	if AnimSprite.frame ==10:
		throwEye(get_global_mouse_position())
	pass # Replace with function body.


func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	print("2afefa")
	pass # Replace with function body.
