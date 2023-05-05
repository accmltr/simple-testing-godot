extends Resource

class_name Transaction

var _amount: float
var _person_a: Person
var _person_b: Person

var amount: float :
	get:
		return _amount
var person_a: Person :
	get:
		return _person_a
var person_b: Person :
	get:
		return _person_b

func _init(amount: float, person_a: Person, person_b: Person):
	# Ensure that params are valid:
	Testing.istrue(amount > 0, self, "amount must be positive")
	Testing.istrue(person_a != null, self, "person_a cannot be null")
	Testing.istrue(person_b != null, self, "person_b cannot be null")
	
	_amount = amount
	_person_a = person_a
	_person_b = person_b

func add(other: Transaction) -> Transaction:
	# Create a new Transaction that will add the effects of this
	# one and the `other`.
	if amount - other.amount > 0:
		return Transaction.new(amount - other.amount, person_a, person_b)
	else:
		return Transaction.new(other.amount - amount, person_b, person_a)

func _to_string() -> String:
	var result: String = "Transaction("
	result += "amount: " + str(amount) + ", "
	result += "person_a: " + person_a.first_name + ", "
	result += "person_b: " + person_b.first_name
	result += ")"
	return result

func equals(other: Transaction) -> bool:
	return (amount == other.amount and
	person_a == other.person_a and
	person_b == other.person_b)
