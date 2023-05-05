extends Node

class_name UnitTest

func expect(expected: Object, found: Object, msg: String, err_code: int = -1) -> void:
	Testing.expect(expected, found, self, msg, err_code)

func throw_error(msg: String, err_code: int = -1) -> void:
	Testing.throw_error(self, msg, err_code)

func istrue(condition: bool, msg: String, err_code: int = -1) -> void:
	# Plugin's version of 'assert()'
	Testing.istrue(condition, self, msg, err_code)

func error_happens(code: Callable, msg: String, err_code: int = -1, is_expected: Callable = func(x):return true) -> void:
	Testing.error_happens(code, self, msg, err_code, is_expected)
