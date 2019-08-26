extends Node2D

onready var attackanim = get_node("AttackAnim")
onready var attackarea = get_node("AttackAnim/AttackArea")

var attack_anims = {'u' : "AttackB", 'd' : "AttackF", 'r' : "AttackR", 'l' : "AttackL"}

var attacking = false
var direction = 'd'

func _ready():
	attackanim.visible = false

func attack(direction):
	self.direction = direction
	attackanim.visible = true
	if (direction == 'u'):
		attackanim.z_index = -1
		attackarea.set_position(Vector2(0, -9))
	elif (direction == 'd'):
		attackanim.z_index = 1
		attackarea.set_position(Vector2(0, 9))
	else:
		attackanim.z_index = 1
		if (direction == 'l'):
			attackarea.set_position(Vector2(-9, 0))
		elif (direction == 'r'):
			attackarea.set_position(Vector2(9, 0))
	attackanim.play(attack_anims[direction])
	attacking = true

func is_attacking():
	return attacking

func _on_AttackAnim_animation_finished():
	attacking = false
	attackanim.stop()
	attackanim.visible = false

func _process(delta):
	if (attacking):
		if (direction == 'r' or direction == 'l'):
			if (attackanim.get_frame() == 4):
				attackanim.z_index = -1
