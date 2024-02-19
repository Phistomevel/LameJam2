extends Camera2D
@onready var targetNode = $"../Player"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if get_node_or_null("../Eye"):
		global_position = $"../Eye".global_position
	else:
		global_position = targetNode.global_position
	pass
