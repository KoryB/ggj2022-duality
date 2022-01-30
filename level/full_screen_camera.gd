class_name FullScreenCamera
extends Camera2D

export var zoom_speed := 0.8
export var zoom_time := 0.25

var target_zoom: float


func _process(delta: float):
	pass
	
	
func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.is_mouse_button_pressed(BUTTON_LEFT):
		position -= event.relative * zoom
		
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_WHEEL_UP:
			$Tween.interpolate_property(self, "zoom",
				zoom, zoom * zoom_speed, zoom_time,
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()

			
		elif event.button_index == BUTTON_WHEEL_DOWN:
			$Tween.interpolate_property(self, "zoom",
				zoom, zoom / zoom_speed, zoom_time,
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()