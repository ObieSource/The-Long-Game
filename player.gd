extends CharacterBody2D

#0 = front, 1 = right, 2 = back, 3 = left
var direction = 0
var idle = ["front-idle","side-idle","back-idle","side-idle"]
var walk = ["front-walk","side-walk","back-walk","side-walk"]

const SPEED = 75.0

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionX = Input.get_axis("ui_left", "ui_right")
	var directionY = Input.get_axis("ui_up", "ui_down")
		
	if directionX:
		velocity.x = directionX * SPEED
		direction = 2 + directionX
		if (directionX < 0) :
			$Sprite2D.flip_h = true
		else:
			$Sprite2D.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if directionY:
		velocity.y = directionY * SPEED
		direction = 1 - directionY
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	if directionX || directionY:
		$Sprite2D.play(walk[direction])
	else:
		$Sprite2D.play(idle[direction])

	move_and_slide()

