extends Node2D

const GROUND: int = 0
const SUNK: int = 1
const GROUND_OBJECTS: int = 2

const GRAS = 0
const WAER = 1

const ROCK_SOURCE: int = 3
const ROCK_COORDS: Vector2i = Vector2i(0, 0)

var map : TileMap
var VIEWPORT: Viewport
var rocks: Array = []
var was_pressed: bool = false


func _ready():
	VIEWPORT = get_viewport()
	map = get_node("Environment/TileMap")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if not was_pressed:
			was_pressed = true
			
#			new_rock(map.get_local_mouse_position())
			new_rock(VIEWPORT.get_mouse_position())
	else:
		was_pressed = false
	
	var removal = []
	for rock_index in range(len(rocks)):
		var rock = rocks[rock_index]
		var good_spots = [
			rock + Vector2i(0, -1),
			rock + Vector2i(0, +1),
			rock + Vector2i(-1, 0),
			rock + Vector2i(+1, 0),
		].filter(is_rock_spot)
		if good_spots.size() == 0:
			continue
		
		var new_spot = good_spots[randi() % good_spots.size()]
		# delete current rock
		map.set_cell(GROUND_OBJECTS, rock, -1, Vector2i(-1,-1))
		
		# make new rock
		var terrain: int = map.get_cell_tile_data(GROUND, new_spot).get_terrain()
		var sunk = map.get_cell_tile_data(SUNK, new_spot) != null
		
		if terrain == GRAS or sunk:
			map.set_cell(GROUND_OBJECTS, new_spot, ROCK_SOURCE, ROCK_COORDS)
			rocks[rock_index] = new_spot
		elif terrain == WAER:
			map.set_cell(SUNK, new_spot, ROCK_SOURCE, ROCK_COORDS)
			removal.push_front(rock_index)
	
	for removal_index in removal:
		rocks.remove_at(removal_index)


func new_rock(pos: Vector2):
	var map_pos: Vector2i = map.local_to_map(pos)
	
	if not is_rock_spot(map_pos):
		return
	
	map.set_cell(GROUND_OBJECTS, map_pos, ROCK_SOURCE, ROCK_COORDS)
	rocks.append(map_pos)

func is_rock_spot(map_pos) -> bool:
	var ground_tile: TileData = map.get_cell_tile_data(GROUND, map_pos)
	if not ground_tile:
		return false
	
	var terrain: int = ground_tile.get_terrain()
	if terrain == -1:
		return false
	
	if map.get_cell_tile_data(GROUND_OBJECTS, map_pos):
		return false
	
	return true
