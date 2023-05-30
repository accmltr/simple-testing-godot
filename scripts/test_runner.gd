extends Node

class_name TestRunner

func _ready():
	get_window().mode = Window.MODE_MINIMIZED
	Testing.on_test_runner.emit(self)
	
	print("Running all tests.")
	
	Testing.testing_complete.emit("All OK")
