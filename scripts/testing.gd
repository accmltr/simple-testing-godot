@tool
extends Node

var _dock: Node
var _is_testing: bool = false # True while testing is happening. [For internal use]
var _is_expecting_errors: bool = false # Used by 'error_happens'
var _cached_errors: Array[SimpleError] # All errors since last `_collect_errors()` call. [For internal use]
var _error_happens_cache: Array[SimpleError] # Stores errors during 'error_happens()' execution.

func throw_error(src: Object, msg: String, err_code: int = -1) -> void:
	var error = SimpleError.new(src, msg, err_code)
	_handle_error(error)

func expect(expected: Variant, found: Variant, src: Object, msg: String, 
 err_code: int = -1, equals: Callable = func(e, f): return e==f) -> void:
	if not equals.call(expected, found):
		var gen_msg = "expected: %s, found: %s" % [expected, found]
		var error = SimpleError.new(src, msg, err_code, gen_msg)
		_handle_error(error)

func istrue(condition: bool, src: Object, msg: String, err_code: int = -1) -> void:
	# Checks a given condition and triggers an error if it's not met.
	# 
	# This method is designed to provide more context about the error's source and display a custom error message
	# alongside an optional error code. It also supports a testing mode that caches errors instead of raising them.
	#
	# Params:
	#   - condition (bool): The condition to be checked.
	#   - src (Object): The source object using this method.
	#   - msg (String): A custom error message to be displayed if the condition fails.
	#   - err_code (int): An optional error code to be included in the error message (default: -1).
	#
	# Usage example:
	#   istrue(player.health > 0, self, "Player health must be greater than 0")
	#
	# When _is_testing is enabled, instead of raising errors, the errors are stored in the _cached_errors array.
	
	# If conidition not met, generate simple error:
	if not condition:
		var error = SimpleError.new(src, msg, err_code)
		_handle_error(error)

func error_happens(code: Callable, src: Object, msg: String, err_code: int = -1, is_expected: Callable = func(x):return true) -> void:
	# This method checks if the code provided generates an error as expected.
	# Params:
	#   - code (Callable): Provided callable that is expected to generate an error when called.
	#   - src (Object): The source object using this method
	#   - msg (String): A custom error message to be displayed if the code provides unexpected errors or zero errors.
	#   - err_code (int): An optional error code to be included in the error message (default: -1).
	#   - is_expected (Callable): An optional callable, used to see if the error generated is the/an expected error.
	# 
	# Usage example:
	#   var code = func() :
	#      var player_level = -1
	#      return Player.new("Player 1", player_level)
	#   
	#   var check = func(error: SimpleError) :
	#      var code_check = error.err_code == 1
	#      var msg_check = error.msg == "Player level must be in the range 0 to 100."
	#      return code_check and msg_check
	#   
	#   # Make sure expected error happens:
	#   var m = "Creating a Player instance with level = -1 should not work."
	#   error_happens(code, self, m, ERR_BUG, check)
	#
	
	# Setup:
	_is_expecting_errors = true
	_error_happens_cache = []
	var success = false
	
	# Run the code that is supposed to generate an error:
	code.call()
	if _error_happens_cache.size() == 1:
		var cached_error = _error_happens_cache.front()
		
		# Use provided callable to check if the cached error is the/an expected one:
		var result = is_expected.call(cached_error)
		assert(result is bool, "'is_expected' needs to be a callable that returns a bool.")
		success = result
	
	# Clean up:
	_is_expecting_errors = false
	_error_happens_cache = []
	
	if not success:	
		# Generate error.
		var error = SimpleError.new(src, msg, err_code)
		_handle_error(error)
#
## Aux method for 'error_happens'.
#func _empty_callable():
#	pass

# Aux method for 'error_happens'.
func _error_happens_cache_func(simple_error: SimpleError) -> void:
	# Simply stores the error string in the '_error_happens_cache' array.
	_error_happens_cache.append(simple_error)

# Aux method for 'istrue' and 'error_happens'
func _handle_error(simple_error: SimpleError) -> void:
	# Handles simple errors generated by Testing.
	
	if _is_expecting_errors:
		_error_happens_cache.append(simple_error)
	elif _is_testing:
		_cached_errors.append(simple_error)
	else:
		# When not testing, follow standard procedure for handling runtime errors:
		assert(false, simple_error.output)
	
	on_error.emit(simple_error)

func _collect_errors() -> Array[SimpleError]:
	# Retrieves all cached errors and clears the cache.
	# IMPORTANT: This is a method intended for internal use by the plugin.
	var result = _cached_errors.duplicate()
	_cached_errors.clear()
	return result

func _on_test_runner_completed()
