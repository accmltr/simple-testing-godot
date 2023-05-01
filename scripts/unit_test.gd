extends Node

class_name UnitTest

func istrue(condition: bool, msg: String, err_code: int = -1) -> void:
	# Plugin's version of 'assert()'
	Testing.istrue(condition, self, msg, err_code)

func error_happens(code: Callable, msg: String, err_code: int = -1, is_expected: Callable = func(x):return true) -> void:
	Testing.error_happens(code, self, msg, err_code, is_expected)
