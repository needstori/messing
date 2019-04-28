extends Node

# Board properties
var board_height = 8
var board_width = 8

# Square properties
var square_height = 64
var square_width = 64

var board_occupants = []

func _init():
	for i in range(board_width):
		board_occupants.append([])
		for j in range(board_height):
			board_occupants[i].append(null)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Assigns the given creature to the given location in square
func _occupy_square(creature, square):
	board_occupants[square[0]][square[1]] = creature
	print(board_occupants[square[0]][square[1]].name)

# Determines what square a creature is currently occupying by comparing its location
#	to the board properties
func _determine_square(creature):
	# Calculate the square that the creature occupies
	var x_square = (creature.position.x - square_width / 2) / square_width
	var y_square = (creature.position.y - square_height / 2) / square_height
	
	#Return that square
	var square = [x_square, y_square]
	return square

# Returns the occupant of the given square
func _get_occupant(square):
	var x_sqaure = square[0]
	var y_sqaure = square[1]
	
	# If the x or y location is ousite of the board limits then return null
	if(x_sqaure >= board_width):
		return null
	if(y_sqaure >= board_height):
		return null

	return board_occupants[square[0]][square[1]]
