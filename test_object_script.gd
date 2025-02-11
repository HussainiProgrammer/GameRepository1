extends Node

@export var health: float = 100
@onready var healthBar: TextureProgressBar = $TextureProgressBar

func damage(amountOfDamage: int) -> void:
	print("OUCH! Stop it!")
	health -= amountOfDamage
	
	if health < 0: health = 0
	
	healthBar.value = health
	
	if health == 0: queue_free()
