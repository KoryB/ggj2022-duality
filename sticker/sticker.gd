class_name Sticker
extends Sprite


export var rotation_speed: float = 90
export var scale_speed: float = 2 

var target_position: Vector2
var target_rotation_degrees: float
var target_scale: float

var has_focus: bool


# Called when the node enters the scene tree for the first time.
func _ready():
	target_position = global_position
	target_rotation_degrees = rotation_degrees
	target_scale = scale.x


func _process(delta):
	handle_input(delta)
	$Polygon2D.visible = has_focus
	
	$Tween.interpolate_property(self, "rotation_degrees",
		rotation_degrees, target_rotation_degrees, 0.1,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property(self, "global_position",
		global_position, target_position, 0.1,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property(self, "scale",
		scale, Vector2(target_scale, target_scale), 0.1,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		
	$Tween.start()


func _on_ClickRegion_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and \
	   event.pressed and \
	   event.button_index == BUTTON_LEFT:
		get_tree().set_input_as_handled()
		has_focus = true
		

func handle_input(delta: float):
	if has_focus:
		if Input.is_mouse_button_pressed(BUTTON_LEFT):
			target_position = get_global_mouse_position()
		
		if Input.is_action_pressed("rotate_sprite_right"):
			target_rotation_degrees += rotation_speed * delta
		if Input.is_action_pressed("rotate_sprite_left"):
			target_rotation_degrees -= rotation_speed * delta

		if Input.is_action_pressed("scale_sprite_up"):
			target_scale += scale_speed * delta
		if Input.is_action_pressed("scale_sprite_down"):
			target_scale -= scale_speed * delta

func _on_ClickRegion_mouse_exited():
	if not Input.is_mouse_button_pressed(BUTTON_LEFT):
		has_focus = false
