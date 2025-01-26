extends State

func Physics_Update(delta: float):
	var newState: String

	var direction = Input.get_axis("left", "right")
	if direction != 0:
		if Input.is_action_pressed("sprint"):
			newState = "sprint"
			player.velocity.x = direction * sprintSpeed

		else:
			newState = "run"
			player.velocity.x = direction * runSpeed
		
		animatedSprite.flip_h = direction == -1

	if player.is_on_floor():
		if !get_parent().canDoubleJump: get_parent().canDoubleJump = true
		if Input.is_action_just_pressed("jump"):
			newState = "jump"
			player.velocity.y = jumpVelocity
		
	else:
		if Input.is_action_just_pressed("jump") and get_parent().canDoubleJump:
			get_parent().canDoubleJump = false
			newState = "double_jump"
			player.velocity.y = jumpVelocity

		else:
			newState = "fall"
			player.velocity += player.get_gravity() * delta
			
	if Input.is_action_just_pressed("attack") and attackCooldown.is_stopped():
		newState = "attack"
		
	return newState
	
