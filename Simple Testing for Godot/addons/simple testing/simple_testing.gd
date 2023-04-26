@tool
extends EditorPlugin

var dock: Control

# When the plugin is added/activated:
func _enter_tree():
	# Load the "Testing" singleton:
	add_autoload_singleton("Testing", "res://addons/simple testing/scripts/testing.gd")
	add_autoload_singleton("TestUtils", "res://addons/simple testing/scripts/test_utils.gd")
	
	# Load editor dock:
	dock = load("res://addons/simple testing/dock/dock.tscn").instantiate()
	dock.editor_interface = get_editor_interface()
	add_control_to_dock(EditorPlugin.DOCK_SLOT_LEFT_UR, dock)

# When the plugin is removed/deactivated:
func _exit_tree():
	# Clean up assets:
	remove_autoload_singleton("Testing")
	remove_autoload_singleton("TestUtils")
	remove_control_from_docks(dock)
	dock.queue_free()
