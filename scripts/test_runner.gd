extends Node

class_name TestRunner

const PATH = "res://tests/test scenes/"

signal started()
signal test_started(test_name: String)
signal test_finished(test_name: String, passed: bool)
signal finished()

var _alive: Array[String]

func _ready():
	started.emit()
	
	print(_get_test_scenes())
	
	for t in _get_test_scenes():
		var o = t.instantiate()
		var id = t.resource_path
		o.tree_exited.connect(_on_test_free.bind(id))
		add_child(o)
		_alive.append(id)
		test_started.emit(id)
		print("Test scene started: ", id)

func _on_test_free(test_id: String):
	print("Done with test scene: ", test_id)
	var errors = Testing._collect_errors()
	if errors.size() > 0:
		test_finished.emit(test_id, false)
	_alive.remove_at(_alive.find(test_id))
	test_finished.emit(test_id, true)
	
	if _alive.is_empty():
		finished.emit()
		get_tree().quit()
	else:
		print("Tests remaining: ", _alive.size())

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
