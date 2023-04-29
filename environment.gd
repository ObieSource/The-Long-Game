extends Node2D

var map: TileMap

enum MAP_LAYER {
	BACKGROUND,
	WATERLOGGED,
	SURFACE,
}

enum TERRAINS {
	BLANK = -1,
	GRASS,
	WATER,
}

enum WATERLOGGED {
	BLANK = -1,
	BARRIER,
	ROCK,
}

enum SURFACE {
	BLANK = -1,
	ROCK,
	TREE,
}

const BARRIER_SOURCE: int = 2
const BARRIER_ATLAS_COORDS: Vector2i = Vector2i(9, 14)
const WATERLOGGED_ROCK_SOURCE: int = 3
const WATERLOGGED_ROCK_ATLAS_COORDS: Vector2i = Vector2i(0,0)

const SURFACE_ROCK_SOURCE: int = 3
const SURFACE_ROCK_ATLAS_COORDS: Vector2i = Vector2i(0, 0)
const TREE_SOURCE: int = 4
const TREE_ATLAS_COORDS: Vector2i = Vector2i(0, 0)

func _ready():
	map = get_node("TileMap")


func get_tile_coords(coords: Vector2) -> Vector2i:
	return map.local_to_map(to_local(coords))


func get_mouse_tile_coords() -> Vector2i:
	return map.local_to_map(map.get_local_mouse_position())


func get_background(coords: Vector2i) -> int:
	var tile: TileData = map.get_cell_tile_data(MAP_LAYER.BACKGROUND, coords)
	if tile == null:
		return TERRAINS.BLANK
	return tile.get_terrain()


func get_waterlogged(coords: Vector2i) -> int:
#	var waterlogged: TileData =  map.get_cell_tile_data(MAP_LAYER.WATERLOGGED, coords)
	var source: int = map.get_cell_source_id(MAP_LAYER.WATERLOGGED, coords)
	var atlas_coords: Vector2i = map.get_cell_atlas_coords(MAP_LAYER.WATERLOGGED, coords)
	
	match [source, atlas_coords]:
		[-1, _]:
			return WATERLOGGED.BLANK
		[BARRIER_SOURCE, BARRIER_ATLAS_COORDS]:
			return WATERLOGGED.BARRIER
		[WATERLOGGED_ROCK_SOURCE, WATERLOGGED_ROCK_ATLAS_COORDS]:
			return WATERLOGGED.ROCK
	return -2


func get_surface(coords: Vector2i) -> int:
#	var waterlogged: TileData =  map.get_cell_tile_data(MAP_LAYER.WATERLOGGED, coords)
	var source: int = map.get_cell_source_id(MAP_LAYER.SURFACE, coords)
	var atlas_coords: Vector2i = map.get_cell_atlas_coords(MAP_LAYER.SURFACE, coords)
	
	match [source, atlas_coords]:
		[-1, _]:
			return SURFACE.BLANK
		[SURFACE_ROCK_SOURCE, SURFACE_ROCK_ATLAS_COORDS]:
			return SURFACE.ROCK
		[TREE_SOURCE, TREE_ATLAS_COORDS]:
			return SURFACE.TREE
	return -2


func set_background(coords: Vector2i, key: int, force: bool = false) -> bool:
	var background: int = get_background(coords)
	var waterlogged: int = get_waterlogged(coords)
	
	match key:
		TERRAINS.BLANK:
			# If there is water, check for waterlogged object
			if background == TERRAINS.WATER:
				if waterlogged != WATERLOGGED.BARRIER and not force:
					return false
				map.set_cell(MAP_LAYER.WATERLOGGED, coords, -1, Vector2i(-1, -1))
			# Remove Terrain, with tileset matching
			map.set_cells_terrain_connect(MAP_LAYER.BACKGROUND, [coords], 0, TERRAINS.BLANK)
		TERRAINS.GRASS:
			# If there is water, check for waterlogged object
			if background == TERRAINS.WATER:
				if waterlogged != WATERLOGGED.BARRIER and not force:
					return false
				map.set_cell(MAP_LAYER.WATERLOGGED, coords, -1, Vector2i(-1, -1))
			# Set grass, with tileset matching
			map.set_cells_terrain_connect(MAP_LAYER.BACKGROUND, [coords], 0, TERRAINS.GRASS, false)
		TERRAINS.WATER:
			if waterlogged == WATERLOGGED.BLANK:
				map.set_cell(MAP_LAYER.WATERLOGGED, coords, BARRIER_SOURCE, BARRIER_ATLAS_COORDS)
			map.set_cells_terrain_connect(MAP_LAYER.BACKGROUND, [coords], 0, TERRAINS.WATER, false)
	
	return true


func set_waterlogged(coords: Vector2i, key: int, force: bool = false) -> bool:
	var background: int = get_background(coords)
	
	match key:
		WATERLOGGED.BLANK:
			# If tile isn't water or if force is enabled,
			# set waterlogged tile to blank
			if background != TERRAINS.WATER or force:
				map.set_cell(MAP_LAYER.WATERLOGGED, coords, -1, Vector2i(-1, -1))
			else:
				return false
		WATERLOGGED.BARRIER:
			# If tile is water or if force is enabled,
			# set waterlogged tile to water
			if background == TERRAINS.WATER or force:
				map.set_cell(MAP_LAYER.WATERLOGGED, coords, BARRIER_SOURCE, BARRIER_ATLAS_COORDS)
			else:
				return false
		WATERLOGGED.ROCK:
			# If tile is water or if force is enabled,
			# set waterlogged tile to rock
			if background == TERRAINS.WATER or force:
				map.set_cell(MAP_LAYER.WATERLOGGED, coords, WATERLOGGED_ROCK_SOURCE, WATERLOGGED_ROCK_ATLAS_COORDS)
			else:
				return false
	
	return true

## May be removed if these will be implemented as sprites

func set_surface(coords: Vector2i, key: int, force: bool = false) -> bool:
	var background: int = get_background(coords)
	var surface: int = get_surface(coords)
	
	match key:
		SURFACE.BLANK:
			# Set blank
			map.set_cell(MAP_LAYER.SURFACE, coords, -1, Vector2i(-1, -1))
		SURFACE.ROCK:
			# If tile isn't water and space is empty, or if force is enabled,
			# set tile to rock
			if (background != TERRAINS.WATER and surface == SURFACE.BLANK) or force:
				map.set_cell(MAP_LAYER.SURFACE, coords, SURFACE_ROCK_SOURCE, SURFACE_ROCK_ATLAS_COORDS)
			else:
				return false
		SURFACE.TREE:
			# If tile isn't water and space is empty, or if force is enabled,
			# set tile to tree
			if (background != TERRAINS.WATER and surface == SURFACE.BLANK) or force:
				map.set_cell(MAP_LAYER.SURFACE, coords, TREE_SOURCE, TREE_ATLAS_COORDS)
			else:
				return false

	return true
