extends Node2D

var map : TileMap
var VIEWPORT: Viewport

const GROUND: int = 0
const SUNK: int = 1
const GROUND_OBJECTS: int = 2

const ROCK_SOURCE: int = 3
const ROCK_COORDS: Vector2i = Vector2i(0, 0)

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


func new_rock(pos: Vector2):
	var map_pos: Vector2i = map.local_to_map(pos)
	
	var ground_tile: TileData = map.get_cell_tile_data(GROUND, map_pos)
	if not ground_tile:
		return
	
	var terrain: int = ground_tile.get_terrain()
	if terrain == -1:
		return
	
	if map.get_cell_tile_data(GROUND_OBJECTS, map_pos):
		return
	
	print(map_pos)
	
	map.set_cell(GROUND_OBJECTS, map_pos, ROCK_SOURCE, ROCK_COORDS)
