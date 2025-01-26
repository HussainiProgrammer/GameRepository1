extends State

func Physics_Update(delta: float) -> String:
	var newState: String

	var direction = Input.get_axis("left", "right")
	if direction != 0:
		if Input.is_action_pressed("sprint"):
			newState = "sprint"
			player.velocity.x = direction * sprintSpeed

		else:
			player.velocity.x = direction * runSpeed
		
		newState = "run"
		animatedSprite.flip_h = direction == -1
		
	else:
		player.velocity.x = 0
		newState ="idle"

	if player.is_on_floor():
		if !get_parent().canDoubleJump: get_parent().canDoubleJump = true
		if Input.is_action_just_pressed("jump"):
			player.velocity.y = jumpVelocity
			newState = "jump"
		
	else:
		player.velocity += player.get_gravity() * delta
		newState = "double_jump"
			
	if Input.is_action_just_pressed("attack") and attackCooldown.is_stopped():
		newState = "attack"
		
	return newState
	
