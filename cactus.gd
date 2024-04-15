extends Area2D
var screensize = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area):
	if area.is_in_group("player") or area.is_in_group("obstacles"):
			position = Vector2(randi_range(0, screensize.x),randi_range(0, screensize.y))
