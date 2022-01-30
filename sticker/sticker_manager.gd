class_name StickerManager
extends Node


var screenshot: Image

var is_selected := false
var selected_path: String


func _process(delta: float):
	if Input.is_action_just_pressed("screenshot_time"):
		take_screenshot()
		
		# Just in case.........
		for i in range(10):
			yield(get_tree(), "idle_frame")
		
		$FileDialog.popup_centered()


func _on_FileDialog_file_selected(path):
	save_screenshot(path)
	$FileDialog.hide()
		
		
func take_screenshot():
	screenshot = get_viewport().get_texture().get_data()
	screenshot.flip_y()
	

func save_screenshot(path):
	screenshot.save_png(path)
