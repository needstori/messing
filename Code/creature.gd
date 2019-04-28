extends Node2D

var board
var board_position

# The creature that is currently the target of this creature
var target

# Called when the node enters the scene tree for the first time.
func _ready():
	# Find the board node and occupy current square
	board = get_parent()
	board_position = board._determine_square(self)
	board._occupy_square(self, board_position)
	
	# Create a timer that triggers the actions of this creature
	var action_timer = Timer.new()
	action_timer.connect("timeout", self, "_action")
	#Add the timer to this node as a child
	self.add_child(action_timer)
	action_timer.start()
	
	#Assign the target to null
	target = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _action():
	print_debug("Action")
	_search()
	print(target.name)

# Searches for a new opponent to target or move towards
func _search():
	# TODO: Adjust for boards that are not square
	for i in range(1, board.board_width):
		# Create a new board position object that starts in the top left of the search
		var to_check = [board_position[0] - i, board_position[1] - i]
		
		# Start the search along the top of the search area
		for j in range(i * 2):
			to_check[0] += 1
			target = board._get_occupant(to_check)
			if(target != null):
				return
				
		# Continue the search down the right side of the search area
		for j in range(i * 2):
			to_check[1] += 1
			target = board._get_occupant(to_check)
			if(target != null):
				return
				
		# Continue the search along the bottom of the search area
		for j in range(i * 2):
			to_check[0] -= 1
			target = board._get_occupant(to_check)
			if(target != null):
				return
				
		# Continue the search up the left side of the search area
		for j in range(i * 2):
			to_check[1] -= 1
			target = board._get_occupant(to_check)
			if(target != null):
				return
				
		#If nothing has been found the loop continues again in a wider loop

# Attacks the target of this creature
func _attack():
	if(target != null):
		print("Attacked: " + target.name)