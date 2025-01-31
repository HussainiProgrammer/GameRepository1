extends Node

@onready var initialState: State = $idle
var currentState: State
var canDoubleJump: bool = true

func changeState(newState: State):
	if newState != currentState:
		currentState.Exit()
		newState.Enter()
		currentState = newState

func _ready() -> void:
	for child in get_children():
		child.animatedSprite = $"../AnimatedSprite2D"
		child.player = $".."
		child.rightHitArea = $"../RightHitArea"
		child.leftHitArea = $"../LeftHitArea"
		child.attackCooldown = $"../attackCooldown"
	
	initialState.Enter()
	currentState = initialState

func _physics_process(delta: float) -> void:
	var newState = currentState.Physics_Update(delta)
	if newState: changeState(get_node(newState))

	get_parent().move_and_slide()
