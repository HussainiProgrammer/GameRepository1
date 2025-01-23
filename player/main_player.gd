extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var double_jump: AnimatedSprite2D = $double_jump
@onready var slide: AnimatedSprite2D = $slide
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var character_body_2d: CharacterBody2D = %CharacterBody2D



var SPEED = Gloable.SPEED
var JUMP_VELOCITY = Gloable.JUMP_VELOCITY
var can_doublejump = false

func _physics_process(delta: float) -> void:
	Gloable.bloom_mode = false
	animated_sprite_2d.visible = true
	double_jump.visible = false
	slide.visible = false
	if abs(velocity.x) > 1:
		animated_sprite_2d.animation = "running"
	else:
		animated_sprite_2d.animation = "default"
	if not is_on_floor():
		velocity += get_gravity() * delta
		if velocity.y > 0:
			animated_sprite_2d.animation = "fall"
		if velocity.y < 0 and  can_doublejump:
			animated_sprite_2d.animation = "jump"
		if abs(velocity.y)>0 and not can_doublejump:
			animated_sprite_2d.animation = "double_jump"
			animated_sprite_2d.visible = false
			double_jump.visible = false
			double_jump.visible = true 
			
			
	if Input.is_action_just_pressed("mouse") and is_on_floor() and not Gloable.stunned:
		velocity.y = JUMP_VELOCITY
		can_doublejump = true
	if Input.is_action_just_pressed("mouse") and can_doublejump and not Gloable.stunned and not is_on_floor():
		velocity.y = JUMP_VELOCITY
		can_doublejump = false
	if Input.is_action_just_pressed("sprint"):
		SPEED = 800
	if Input.is_action_just_pressed("dead"):
		get_tree().change_scene_to_file.bind("res://Scenes/startscene.tscn").call_deferred()
		#for i in range(200):
		#	SPEED += 5
			#await get_tree().create_timer(0.1).timeout

		print(SPEED)
		"""	if Input.is_action_pressed("s"):
				collision_shape_2d.shape.set_size(Vector2i(66,44.25))
				collision_shape_2d.position.y = 155
				slide.visible = true
				animated_sprite_2d.visible = false"""
	elif Input.is_action_just_released("sprint"):
		SPEED = 300
		
	var direction := Input.get_axis("a", "d")
	if direction and not Gloable.stunned:
		velocity.x = direction * SPEED
		#print(Global.stunned)
		#animated_sprite_2d.animation = "running"
		
		
		
	else:
		velocity.x = move_toward(velocity.x, 0, Gloable.SPEED)
		

	move_and_slide()

	var is_left = velocity.x < 0
	animated_sprite_2d.flip_h = is_left
