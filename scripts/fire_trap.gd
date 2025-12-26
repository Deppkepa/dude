extends Area2D

@onready var sprite = get_node("AnimatedSprite2D")
var flag_static_plaer_in_fire = false
@onready var particles = get_node("CPUParticles2D")
var player_body

func _on_body_entered(_body: CharacterBody2D) -> void:
	player_body = _body
	flag_static_plaer_in_fire = true
	particles.visible = true
	sprite.play("start_fire")
	
func _ready() -> void:
	particles.visible = false


func _on_body_exited(_body: CharacterBody2D) -> void:
	flag_static_plaer_in_fire = false

func _process(_delta: float) -> void:
	if flag_static_plaer_in_fire == true and sprite.animation == "loop_fire":
		var direction = player_body.position.direction_to(global_position)
		print(direction)
		player_body.velocity += direction.normalized() * -50
		
 
		

func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite.animation == "start_fire":
		sprite.play("loop_fire")
	elif sprite.animation == "loop_fire" and flag_static_plaer_in_fire == true:
		sprite.play("loop_fire")
	elif sprite.animation == "loop_fire":
		sprite.play("end_fire")
	else:
		particles.visible = false
	
