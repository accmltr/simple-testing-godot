extends Node

class_name TestRunner

const PATH = "res://tests/test_scenes/"

signal started()
signal test_started(test_name: String)
signal test_finished(test_name: String, passed: bool)
signal finished()

var _alive: Array[String]
var _quite_queued: bool = false
var _quite_frame_counter: int = 30

func _ready():
	started.emit()
	Testing._is_testing = true
	
	print("Running Play-Mode Tests")
	print("----------------------------------------------")
	
	for t in _get_test_scenes() as Array[PlayModeTest]:
		var o = t.instantiate()
		var id = t.resource_path
		o.set_test_id(id)
		o.tree_exited.connect(_on_test_free.bind(id))
		add_child(o)
		_alive.append(id)
		test_started.emit(id)

func _process(_delta):
	if _quite_queued && _quite_frame_counter > 0:
		_quite_frame_counter -= 1
		if _quite_frame_counter == 0:
			get_tree().quit()

func _on_test_free(test_id: String):
	var errors = Testing._collect_errors_by_id(test_id)
	if errors.size() > 0:
		test_finished.emit(test_id, false)
		print("✘ ", test_id)
		for e in errors.values():
			print("   -", e)
	else:
		test_finished.emit(test_id, true)
		print("✔ ", test_id)
	
	_alive.remove_at(_alive.find(test_id))
	if _alive.is_empty():
		print("----------------------------------------------")
		print("Testing Complete")
		Testing._is_testing = false
		finished.emit()
		_quite_queued = true

func _get_test_scenes(path: String = PATH) -> Array[PackedScene]:
	var test_scenes: Array[PackedScene] = []
	
	# Open given path:
	var dir = DirAccess.open(path)
	if not dir:
		print("An error occurred when trying to access the path: " + path)
		return test_scenes
	
	# Recursively search for test scenes:
	dir.list_dir_begin()
	var file_name = dir.get_next()
	
	while file_name != "":
		var full_path = path + file_name
		
		if dir.current_is_dir():
			var sub_t_scenes = _get_test_scenes(full_path + "/")
			
			for t in sub_t_scenes:
				test_scenes.append(t)
			
		elif file_name.ends_with(".tscn"):
			var s = ResourceLoader.load(full_path)
			test_scenes.append(s)
		
		file_name = dir.get_next()
	
	dir.list_dir_end()
	return test_scenes

func _shorten_path(path: String) -> String:
	return path.trim_prefix("res://tests/test scenes/")




