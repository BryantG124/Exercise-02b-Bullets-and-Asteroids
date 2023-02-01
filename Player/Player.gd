extends KinematicBody2D

var velocity = Vector2.ZERO

var rotation_speed = 5.0
var speed = 5.0
var max_speed = 400.0


onready var Bullet = load('res://Player/Bullet.tscn')
var nose = Vector2(0,-60)

func _ready():
	pass

func _physics_process(_delta):
	velocity = velocity + get_input()*speed
	velocity = velocity.normalized() * clamp(velocity.length(), 0, max_speed)
	position = position + velocity
	position.x = wrapf(position.x, 0, 1024)
	position.y = wrapf(position.y, 0, 600)
	
	if Input.is_action_just_pressed("shoot"):
		var Effects =  get_node_or_null("/root/Game/Effects")
		if Effects != null:
			var bullet = Bullet.instance()
			bullet.global_position = global_position
			bullet.rotation = rotation
			add_child(bullet)
	
func get_input():
	var to_return = Vector2.ZERO
	$Exhaust.hide()
	if Input.is_action_pressed("forward"):
		to_return.y -= 1
		$Exhaust.show()

	if Input.is_action_pressed("left"):
		to_return.x -= 1
	if Input.is_action_pressed("right"):
		to_return.x += 1
	
	
	return to_return.rotated(rotation)
	
	
	
	
