tool
extends Button

signal set_channel

func can_drop_data(position, data):
	return true

func drop_data(position, data):
	var texture: Texture
	match data.type:
		"files":
			var file: = load(data["files"][0])
			if file is Texture:
				texture = file
		"resource":
			var res: Resource = data["resource"]
			if res is Texture:
				texture = res
	
	if texture:
		pressed = true
		emit_signal("set_channel", name, texture)

func _on_pressed() -> void:
	reset()

func reset():
	pressed = false
	emit_signal("set_channel", name, null)
