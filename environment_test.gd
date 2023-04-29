extends Node2D

var VIEWPORT: Viewport
var ENVIRONMENT: Node

var left_was_pressed: bool = false
var right_was_pressed: bool = false


func _ready():
	VIEWPORT = get_viewport()
	ENVIRONMENT = get_node("Environment")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var mouse_coords: Vector2i = ENVIRONMENT.get_mouse_tile_coords()
	
	# Left Click changes the background
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if not left_was_pressed:
			left_was_pressed = true
			
			var background = ENVIRONMENT.get_background(mouse_coords)
			match background:
				ENVIRONMENT.TERRAINS.BLANK:
					ENVIRONMENT.set_background(mouse_coords, ENVIRONMENT.TERRAINS.GRASS)
				ENVIRONMENT.TERRAINS.GRASS:
					ENVIRONMENT.set_background(mouse_coords, ENVIRONMENT.TERRAINS.WATER)
				ENVIRONMENT.TERRAINS.WATER:
					ENVIRONMENT.set_background(mouse_coords, ENVIRONMENT.TERRAINS.GRASS)
				_:
					print("Error in matching current background")
	else:
		left_was_pressed = false
	
	# Right Click changes the surface object
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		if not right_was_pressed:
			right_was_pressed = true
			
			var surface = ENVIRONMENT.get_surface(mouse_coords)
			match surface:
				ENVIRONMENT.SURFACE.BLANK:
					ENVIRONMENT.set_surface(mouse_coords, ENVIRONMENT.SURFACE.ROCK)
				ENVIRONMENT.SURFACE.ROCK:
					ENVIRONMENT.set_surface(mouse_coords, ENVIRONMENT.SURFACE.BLANK)
					ENVIRONMENT.set_surface(mouse_coords, ENVIRONMENT.SURFACE.TREE)
				ENVIRONMENT.SURFACE.TREE:
					ENVIRONMENT.set_surface(mouse_coords, ENVIRONMENT.SURFACE.BLANK)
				_:
					print("Error in matching current surface")
	else:
		right_was_pressed = false
