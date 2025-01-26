extends Area2D

@export var damage: int = 25

func _on_area_entered(area: Area2D) -> void: area.get_parent().damage(damage)

func _on_body_entered(body: Node2D) -> void: body.damage(damage)
