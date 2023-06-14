extends Node

class_name PlayModeTest

var _test_id: String
var id: String :
	set(val):
		throw_error("Trying to set accessor with private set.")
	get:
		if _test_id.is_empty():
			throw_error("`_test_id` not yet set, but trying to access it.")
		return _test_id

func set_test_id(id):
	_test_id = id

func expect(expected: Variant, found: Variant, msg: String, err_code: int = -1,
 equals: Callable = func(e, f): return e==f) -> void:
	Testing.expect(expected, found, _test_id, msg, err_code, equals)

func throw_error(msg: String, err_code: int = -1) -> void:
	Testing.throw_error(_test_id, msg, err_code)

func istrue(condition: bool, msg: String, err_code: int = -1) -> void:
	# Plugin's version of 'assert()'
	Testing.istrue(condition, _test_id, msg, err_code)

func error_happens(code: Callable, msg: String, err_code: int = -1, is_expected: Callable = func(x):return true) -> void:
	Testing.error_happens(code, _test_id, msg, err_code, is_expected)
