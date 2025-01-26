extends State

func Enter() -> void:
	super.Enter()
	
	leftHitArea.monitoring = animatedSprite.flip_h
	rightHitArea.monitoring = !animatedSprite.flip_h
	
func Physics_Update(delta: float) -> String:
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
		
	else:
		player.velocity.x = 0
		newState = "idle"

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
		
		
	if animatedSprite.is_playing(): return "attack"	
	return newState
	
func Exit() -> void:
	super.Exit()
	
	leftHitArea.monitoring = false
	rightHitArea.monitoring = false
	attackCooldown.start()
