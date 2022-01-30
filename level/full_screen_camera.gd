class_name FullScreenCamera
extends Camera2D

export var zoom_speed := 0.8
export var zoom_time := 0.25

export var pan_time := 1.5
export var move_time := 0.05

var target_position: Vector2
var target_zoom: float

var is_glow := false


func _ready():
	target_position = position


func _process(delta: float):
	handle_input()
	handle_postprocess()
	

func handle_input():
	if current:
		if Input.is_action_just_pressed("postprocess_glow"):
			is_glow = !is_glow
			
			
func handle_postprocess():
	$"../WorldEnvironment".get_environment().glow_enabled = current and is_glow

	
func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.is_mouse_button_pressed(BUTTON_LEFT):
		var delta = event.relative * zoom
		target_position -= delta
		
		$Tween.interpolate_property(self, "position",
				position, target_position, move_time,
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
		
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


func pan_from(pos: Vector2, z: Vector2):
	$Tween.interpolate_property(self, "position",
			pos, position, pan_time,
			Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
	$Tween.interpolate_property(self, "zoom",
			z, zoom, pan_time,
			Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
		
	position = pos
	zoom = z
	$Tween.start()
