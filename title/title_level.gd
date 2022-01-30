class_name TitleLevel
extends Node2D


const MainLevel := preload("res://level/test_level.tscn")


func _process(delta: float):
	if Input.is_action_just_pressed("screenshot_time"):
		get_tree().change_scene_to(MainLevel)
