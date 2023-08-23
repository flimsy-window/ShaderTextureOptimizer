tool
extends EditorPlugin

var dock: Control

func _enter_tree() -> void:
	dock = load("res://addons/shader_texture_optimizer/plugin.tscn").instance()
	dock.connect("texture_generated", self, "_scan")
	add_control_to_dock(EditorPlugin.DOCK_SLOT_LEFT_BR, dock)

func _scan():
	var editor: = get_editor_interface()
	var file_system: = editor.get_resource_filesystem()
	file_system.scan()

func _exit_tree() -> void:
	remove_control_from_docks(dock)
	dock.free()
