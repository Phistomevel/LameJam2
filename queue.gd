extends AudioStreamPlayer

var streams: Array = [0,0]
var progress= 0

# Called when the node enters the scene tree for the first time.
func _ready():
	streams[0] = preload("res://Sounds/HidingIntro.mp3")
	streams[1] = preload("res://Sounds/HidingLoop.mp3")
	play()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_finished():
	progress+= 1
	if progress > 1:
		progress = 1
	stream = streams[progress] 
	play()
	pass # Replace with function body.
