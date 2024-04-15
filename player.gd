extends Area2D
signal pickup
signal hurt

@export var speed = 350
# @export allows you to set val in inspector window
# inspector values will override the script values

var velocity = Vector2.ZERO
var screensize = Vector2(480, 640)

func start():
	set_process(true)
	position = screensize / 2
	$AnimatedSprite2D.animation = "idle"

func die():
	$AnimatedSprite2D.animation = "hurt"
	set_process(false)
	# game over tells Godot to stop calling the _process() function every frame.

# Called when the node enters the scene tree for the first time.
func _ready():
	start()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	position += velocity * speed * delta
	# delta = elapsed time since the previous frame = ~ 0.016 seconds
	
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
	
	if velocity.length() > 0:
		$AnimatedSprite2D.animation = "run"
	else:
		$AnimatedSprite2D.animation = "idle"
	if velocity.x != 0:
		$AnimatedSprite2D.flip_h = velocity.x < 0


func _on_area_entered(area):
# Whenever another area object overlaps with the player, this function
# will be called, and that overlapping area will be passed in with the area
# parameter. The coin object will have a pickup() function that defines
# what the coin does when picked up (playing an animation or sound, for
# example). When you create the coins and obstacles, you’ll assign them
# to the appropriate group so that they can be detected correctly.
	if area.is_in_group("powerups"):
		area.pickup()
		pickup.emit("powerup")
	if area.is_in_group("coins"):
		area.pickup()
		pickup.emit("coin")
	if area.is_in_group("obstacles"):
		hurt.emit()
		die()
