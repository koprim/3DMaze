extends Node

var size_x = 10
var size_y = 10
var visited = 0
var cell
var maze
var steps = 10000
var shape3d = preload("res://wall.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	initMaze(size_x,size_y)
	
	while ((visited < size_x * size_y) && (steps > 0)): 
		nextStep()
		steps-=1
	
	var exit = Vector2i(maze.size()-1, maze[0].size())
	for row in range(-1, maze.size()+1):
		for col in range(-1, maze[0].size()+1):
			if (not exit==Vector2i(row, col)) and((row==-1) or (col==-1) or (row ==  maze.size())\
			or (col ==  maze.size()) or (maze[row][col])):
				var wall = shape3d.instantiate()
				wall.set_position(Vector3(row*10,0,col*10))
				self.add_child(wall)
				
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

# initialize the generation of the maze.
func initMaze(maze_x,maze_y):
	maze = []
	for x in range(maze_x * 2 - 1):
		maze.append([])
		for y in range(maze_y * 2 - 1):
			maze[x].append(0)
			
	var i=0
	while i < (maze_y * 2 - 1):
		var j = 0
		while j < (maze_x * 2 - 1):
			maze[i][j] = 1
			j+=1
		i+=1
	
	#cell to start the generation
	cell = {
		"row": 0, 
		"col": 0}
	maze[cell.row][cell.col] = 0
	visited+=1

# while there are unvisited cells, pick random neighbour
func nextStep():
	# go through the array to pick every cells
	var nl = []
	if (cell.row + 2 < maze[0].size()):
		nl.append({"row": cell.row + 2, "col": cell.col})
	if (cell.col + 2 <  maze[0].size()):
		nl.append({"row": cell.row, "col": cell.col + 2})
	if (cell.row > 0):
		nl.append({"row": cell.row - 2, "col": cell.col})
	if (cell.col > 0):
		nl.append({"row": cell.row, "col": cell.col - 2})
	var n = nl[randi() % len(nl)]
	if (maze[n.row][n.col] == 1):  # unvisited
		# set to visited 
		maze[n.row][n.col] = 0
		# remove wall
		maze[(n.row+cell.row)/2][(n.col+cell.col)/2] = 0
		# termination condition
		visited+=1
	# set new current
	cell = n
