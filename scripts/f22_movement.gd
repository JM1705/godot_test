extends Node2D

var player_root
var f22_root
var speed = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	player_root = get_node("../../guy")
	f22_root = get_node("../")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var player_ypos = player_root.position.y
	f22_root.position.y = player_ypos
	
func _physics_process(delta):
	f22_root.position.x += speed

