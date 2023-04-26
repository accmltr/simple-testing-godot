extends Node

class_name UnitTest

func istrue(condition: bool, src: Object, msg: String, err_code: int = -1) -> void:
	# Plugin's version of 'assert()'
	Testing.istrue(condition, src, msg, err_code)

#func throws_error(code: Callable, ) -> void:
#	# Ensures that the given code generates an error.
	
