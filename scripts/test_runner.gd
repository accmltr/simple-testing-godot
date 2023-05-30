extends Node

class_name TestRunner

signal started()
signal test_started(test_name: String)
signal test_finished(test_name: String, passed: bool)
signal finished()

func _ready():
	started.emit()
	
	
	var tests: Array[PackedScene] = []
	
	for t in tests:
		var o = t.instantiate()
		o.tree_exited.connect(_on_test_free.bind(t.resource_name))
		add_child(o)
		test_started.emit(t.resource_name)


func _on_test_free(test_name: String):
	var errors = Testing._collect_errors()
	if errors.size() > 0:
		test_finished.emit(test_name, false)
	test_finished.emit(test_name, true)
	
	if get_children().size() == 0:
		finished.emit()
