@tool
extends Node

var _is_testing: bool = false # True while testing is happening. [For internal use]
var _cached_errors: Array[String] # All errors since last `_collect_errors()` call. [For internal use]


func istrue(condition: bool, src: Object, msg: String, err_code: int = -1) -> void:
	# Checks a given condition and triggers an error if it's not met.
	# 
	# This method is designed to provide more context about the error's source and display a custom error message
	# alongside an optional error code. It also supports a testing mode that caches errors instead of raising them.
	#
	# Params:
	#   - condition (bool): The condition to be checked.
	#   - src (Object): The source object that generated the error.
	#   - msg (String): A custom error message to be displayed if the condition fails.
	#   - err_code (int): An optional error code to be included in the error message (default: -1).
	#
	# Usage example:
	#   istrue(player.health > 0, self, "Player health must be greater than 0")
	#
	# When _is_testing is enabled, instead of raising errors, the errors are stored in the _cached_errors array.
	
	# Stringify the source's error:
	var src_string: String = str(src)
	if src is Node:
		if src.is_inside_tree():
			src_string = src.get_path()
		else:
			src_string = src.name
	if src is Resource:
		src_string = src.resource_path
	
	# Create the error string:
	var err_string
	if not err_code == -1:
		err_string = "Error(src: %s, msg: %s, err_code: %s)" % [src_string, msg, err_code]
	else:
		err_string = "Error(src: %s, msg: %s)" % [src_string, msg]
	
	if _is_testing and not condition:
		# Cache the error:
		_cached_errors.append(err_string)
	else:
		# When not testing, follow standard procedure for handling runtime errors:
		assert(condition, err_string)

func _collect_errors() -> Array[String]:
	# Retrieves all cached errors and clears the cache.
	# IMPORTANT: This is a method intended for internal use by the plugin.
	var result = _cached_errors.duplicate()
	_cached_errors.clear()
	return result

