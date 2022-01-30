# Singleton PictureManager
extends Node


var game_image: Image


func _ready():
	game_image = Image.new()


func take_screenshot():
	game_image = get_viewport().get_texture().get_data()
	game_image.flip_y()
	

func get_screenshot_texture() -> ImageTexture:
	var tex := ImageTexture.new()
	tex.create_from_image(game_image)
	
	return tex
