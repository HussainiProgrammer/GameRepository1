extends Node
class_name State

@export var animation: String
var animatedSprite: AnimatedSprite2D
var player: CharacterBody2D
var runSpeed = Gloable.SPEED
var sprintSpeed = Gloable.SPEED*2
var jumpVelocity = Gloable.JUMP_VELOCITY

func Enter():
	animatedSprite.play(animation)
	
func Exit():
	pass
	
func Physics_Update(_delta: float):
	pass
