tool
extends Control

signal texture_generated

onready var viewport_container: = $VB/CC/VC
onready var viewport: Viewport = $VB/CC/VC/Viewport
onready var sprite: Sprite = $VB/CC/VC/Viewport/Sprite

onready var filename_prompt: = $VB/VB/filename_prompt
onready var width_prompt: = $VB/VB/CC/HFlowContainer/GC/w
onready var height_prompt: = $VB/VB/CC/HFlowContainer/GC/h
onready var smart_toggle: = $VB/VB/CC/HFlowContainer/smart_toggle

onready var channel_buttons: = $VB/VB/VB.get_children()

func _generate():
	var tex: = viewport.get_texture()
	var img: = tex.get_data()
	img.flip_y()
#
	var dir: = Directory.new()
	var path: = "res://"
	if dir.open(path) == OK:
		dir.list_dir_begin(true)
		var _file_name: String = filename_prompt.text \
								if filename_prompt.text != "*.png" \
								else str(OS.get_ticks_msec())
		if !_file_name.ends_with(".png"):
			_file_name += ".png"
		img.save_png(path.plus_file(_file_name))
		emit_signal("texture_generated")
		

func set_width(x: int):
	viewport_container.rect_size.x = x
	viewport.size.x = x
	sprite.texture.width = x
	sprite.position.x = x/2.0

func set_height(y: int):
	viewport_container.rect_size.y = y
	viewport.size.y = y
	sprite.texture.height = y
	sprite.position.y = y/2.0

func set_channel(channel: String, texture: Texture):
	if smart_toggle.pressed:
		if texture:
			if texture.get_size() > viewport.size:
				var w: = texture.get_width()
				var h: = texture.get_height()
				set_width(w)
				set_height(h)
				width_prompt.update_text(w)
				height_prompt.update_text(h)
	sprite.material.set_shader_param(channel, texture)


func _reset() -> void:
	width_prompt.update_text(64)
	height_prompt.update_text(64)
	for channel in channel_buttons:
		channel.reset()
	smart_toggle.pressed = false
	filename_prompt.text = "*.png"
