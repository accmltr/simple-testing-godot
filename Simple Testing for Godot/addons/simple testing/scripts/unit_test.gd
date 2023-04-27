extends Node

class_name UnitTest

func istrue(condition: bool, src: Object, msg: String, err_code: int = -1) -> void:
	# Plugin's version of 'assert()'
	Testing.istrue(condition, src, msg, err_code)

func error_happens(code: Callable, src: Object, msg: String, err_code: int = -1, is_expected: Callable = func(x):return true) -> void:
	Testing.error_happens(code, src, msg, err_code, is_expected)
