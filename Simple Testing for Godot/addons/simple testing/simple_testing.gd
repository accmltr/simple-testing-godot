@tool
extends EditorPlugin

var dock: Control

func _enter_tree():
	dock = load("res://addons/simple testing/ui/dock.tscn").instantiate()
	add_control_to_dock(EditorPlugin.DOCK_SLOT_LEFT_UR, dock)


func _exit_tree():
	remove_control_from_docks(dock)
	dock.queue_free()
