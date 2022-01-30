class_name Picture
extends Sprite


func _ready():
	texture = PictureManager.get_screenshot_texture()
