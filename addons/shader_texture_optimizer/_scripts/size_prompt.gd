tool
extends LineEdit

signal update_size(size)

func _unfocus():
	_format_text(text)

func _check_text_input(new_text: String):
	if !new_text.is_valid_integer() && new_text.length():
		var t = text
		t.erase(t.length()-1, 1)
		text = t
	elif new_text.is_valid_integer():
		var t: = clamp(new_text.to_int(), 0, 512)
		text = str(t)

func _format_text(t: String):
	if t.is_valid_integer():
		emit_signal("update_size", t.to_int())

func _on_smart_toggle(button_pressed: bool) -> void:
	editable = !button_pressed
	
func update_text(t: int):
	var e: = editable
	editable = true
	text = str(t)
	editable = e
