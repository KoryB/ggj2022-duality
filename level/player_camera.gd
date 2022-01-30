class_name PlayerCamera
extends Camera2D


export var pan_time := 1.2


func pan_from(pos: Vector2, z: Vector2):	
	$Tween.interpolate_property(self, "position",
			pos, position, pan_time,
			Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
	$Tween.interpolate_property(self, "zoom",
			z, zoom, pan_time,
			Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
	$Tween.start()
