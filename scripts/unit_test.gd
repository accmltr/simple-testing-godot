extends Node

class_name UnitTest

func expect(expected: Variant, found: Variant, msg: String, err_code: int = -1,
 equals: Callable = func(e, f): return e==f) -> void:
	Testing.expect(expected, found, self, msg, err_code, equals)

func throw_error(msg: String, err_code: int = -1) -> void:
	Testing.throw_error(self, msg, err_code)

func istrue(condition: bool, msg: String, err_code: int = -1) -> void:
	# Plugin's version of 'assert()'
	Testing.istrue(condition, self, msg, err_code)

func error_happens(code: Callable, msg: String, err_code: int = -1, is_expected: Callable = func(x):return true) -> void:
	Testing.error_happens(code, self, msg, err_code, is_expected)
