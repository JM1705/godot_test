extends Node2D

var level
var reticle
var reticle_sprite
var blocks = []
var targeting_time_elapsed = 0
var best_pos = Vector2(0,0)
var best_value = 0

var level_path = "../../level"
var kill_bounds_local_x = 150
var explosion_radius = 50
var targeting_pos_refresh_time = 0.1 # seconds

func pythagoras(v1, v2):
	var dist = ((v1[0]-v2[0])**2 + (v1[1]-v2[1])**2)**0.5
	return dist
	

# Called when the node enters the scene tree for the first time.
func _ready():
	level = get_node(level_path)
	for block in level.get_children():
		blocks.append(block)
	
	reticle = get_node("../../reticle")
	reticle_sprite = get_node("../../reticle/reticle_sprite")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	targeting_time_elapsed += delta
	if targeting_time_elapsed >= targeting_pos_refresh_time:
		targeting_time_elapsed = 0
		
		best_pos = Vector2(0,0)
		best_value = 0
		
		var block_values = []
		for block in blocks:
			var value = 0
			var delta_x = block.global_position.x - self.global_position.x
			if delta_x <= kill_bounds_local_x: # if block is within bounds
				value += delta_x
			block_values.append(value)
		
		# circle stuff
		var local_xs = range(35, 150, 10)
		var local_ys = range(-160, 160, 10)
		local_xs.shuffle()
		
		for local_x in local_xs:
			local_ys.shuffle()
			for local_y in local_ys:
				var explosion_local_pos = Vector2(local_x, local_y)
				var explosion_global_pos = explosion_local_pos + self.global_position
				
				var value = 0
				for block_index in blocks.size():
					var block_value = block_values[block_index]
					var block_global_pos = blocks[block_index].global_position
					var dist = pythagoras(explosion_global_pos, block_global_pos)
					if dist <= explosion_radius:
						value += block_value
				if value >= best_value:
					best_value = value
					best_pos = explosion_global_pos
		
	if best_value > 0:
		reticle_sprite.show()
	else:
		reticle_sprite.hide()
	reticle.global_position = best_pos
	
	
		
