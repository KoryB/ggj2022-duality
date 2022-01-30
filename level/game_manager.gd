class_name GameManager
extends Node

const StickerLevel := preload("res://sticker/sticker_level.tscn")

var is_fullscreen := false


func _ready():
	randomize()


func _process(delta: float):
	handle_input()
	
	
func handle_input():
	if Input.is_action_just_pressed("player_done"):
		var fsc = $"../FullScreenCamera"
		var p = $"../Player"
		var pc = p.get_node("PlayerCamera")
		
		is_fullscreen = !is_fullscreen
		
		if is_fullscreen:
			fsc.pan_from(p.position + pc.offset, pc.zoom)
		else:
			pc.pan_from(p.transform.inverse() * fsc.position - pc.offset.rotated(-p.transform.get_rotation()), fsc.zoom)
		
		fsc.current = is_fullscreen
		pc.current = !is_fullscreen
		
		p.is_active = !is_fullscreen
		p.visible = !is_fullscreen
		
	if is_fullscreen and Input.is_action_just_pressed("screenshot_time"):
		PictureManager.take_screenshot()
		get_tree().change_scene_to(StickerLevel)
