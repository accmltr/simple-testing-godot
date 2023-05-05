extends Resource

class_name Person

var _first_name: String
var first_name: String:
	get:
		return _first_name

func _init(first_name: String):
	# Ensure a Person has first name:
	Testing.istrue(not first_name.is_empty(), self, "Persons must be created with first names.")
	
	_first_name = first_name
