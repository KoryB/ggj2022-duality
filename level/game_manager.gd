class_name GameManager
extends Node

var is_fullscreen := false


func _ready():
	randomize()


func _process(delta: float):
	handle_input()
	
	
func handle_input():
	if Input.is_action_just_pressed("player_done"):
		is_fullscreen = !is_fullscreen
		
		$"../FullScreenCamera".current = is_fullscreen
		$"../Player/PlayerCamera".current = !is_fullscreen
		
		$"../Player".is_active = !is_fullscreen
		$"../Player".visible = !is_fullscreen
