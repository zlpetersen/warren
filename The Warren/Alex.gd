extends KinematicBody2D

const FRICTION = 0.75
const SPEED = 50

var direction = 'd'
var moving = false

var velocity = Vector2()

var idle_anims = {'u' : "IdleB", 'd' : "IdleF", 'r' : "IdleF", 'l' : "IdleF"}
var run_anims = {'u' : "RunB", 'd' : "RunF", 'r' : "RunF", 'l' : "RunF"}

onready var playeranim = get_node("PlayerAnim")
onready var sword = get_node("Sword")

func _physics_process(delta):
	if (!sword.is_attacking()):
		direction = get_direction(velocity)
	
	if (Input.is_action_pressed('mv_left')):
		velocity.x -= SPEED
	if (Input.is_action_pressed('mv_right')):
		velocity.x += SPEED
	if (Input.is_action_pressed('mv_up')):
		velocity.y -= SPEED
	if (Input.is_action_pressed('mv_down')):
		velocity.y += SPEED
	
	if (Input.is_action_just_pressed("attack")):
		sword.attack(direction)
	
	if (abs(velocity.x) < 10 and abs(velocity.y) < 10):
		moving = false
	else:
		moving = true
	
	animate_and_attack()
	
	velocity *= FRICTION
	
	velocity = move_and_slide(velocity)

func animate_and_attack():
	if (moving):
		playeranim.play(run_anims[direction])
	else:
		playeranim.play(idle_anims[direction])

func get_direction(vel):
	if (!moving):
		return direction
	if (abs(vel.y) > abs(vel.x)):
		return 'u' if vel.y < 0 else 'd'
	else:
		return 'r' if vel.x > 0 else 'l'
	return direction
