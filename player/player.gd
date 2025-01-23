extends CharacterBody2D
@onready var idle: AnimatedSprite2D = $idle
@onready var running: AnimatedSprite2D = $running
@onready var jump: AnimatedSprite2D = $jump
@onready var double_jump: AnimatedSprite2D = $double_jump
@onready var fall: AnimatedSprite2D = $fall


var SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	print(int(velocity.y))
	if abs(velocity.x) > 1:set_animation(running)
	else:set_animation(idle)
	if not is_on_floor():
		velocity += get_gravity() * delta
		if velocity.y > 0 :
			set_animation(fall)
		if velocity.y < 0 and Gloable.can_double_jump:
			set_animation(jump)
		if abs(velocity.y) > 0 and not Gloable.can_double_jump:
			set_animation(double_jump)
			
			
			
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		Gloable.can_double_jump = true
		Gloable.jump_count+=1
		
	if Input.is_action_just_pressed("jump") and not is_on_floor() and Gloable.can_double_jump:
		velocity.y = JUMP_VELOCITY
		Gloable.can_double_jump = false
		Gloable.jump_count=0

	
	if Input.is_action_pressed("sprint"):SPEED = 600.0
	else: SPEED = 300.0
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 10)
	
	var is_left = velocity.x < 0 
	var animations = [idle,running,jump,double_jump,fall]
	
	for animation_index in animations:
		animation_index.flip_h = is_left
	
	move_and_slide()
	
func set_animation(animation:AnimatedSprite2D):
	var animations = [idle,running,jump,double_jump,fall]
	for animation_index in animations:
		if animation_index != null:
			if animation_index == animation:
				animation_index.visible = true
			else:
				animation_index.visible = false
