extends Resource

class_name SimpleError

var _initializing: bool = false
var src: Object :
	set(value):
		if _initializing:
			src = value
		else:
			assert(false, "Tried to set immutable variable.")
var msg: String :
	set(value):
		if _initializing:
			msg = value
		else:
			assert(false, "Tried to set immutable variable.")
var err_code: int :
	set(value):
		if _initializing:
			err_code = value
		else:
			assert(false, "Tried to set immutable variable.")
var output: String :
	set(value):
		if _initializing:
			output = value
		else:
			assert(false, "Tried to set immutable variable.")

func _init(src: Object, msg: String, err_code: int = -1):
	_initializing = true
	self.src = src
	self.msg = msg
	self.err_code = err_code
	self.output = _get_output()
	_initializing = false

func _get_output() -> String:
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
		err_string = "Error(src: \"%s\", msg: \"%s\", err_code: \"%s\")" % [src_string, msg, err_code]
	else:
		err_string = "Error(src: \"%s\", msg: \"%s\")" % [src_string, msg]
	
	return err_string
