extends Node2D

var player
# Called when the node enters the scene tree for the first time.
func _ready():
	for child in self.get_children():
		if child.name == "guy":
			player = child


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.position.y >= 100:
		print("player death due to boundary")
		self.get_tree().reload_current_scene()
