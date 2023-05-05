extends UnitTest

# Unit tests for the Transaction class.

func test_add():
	var a = Person.new("Person A")
	var b = Person.new("Person B")
	var t1 = Transaction.new(10, a, b)
	var t2 = Transaction.new(7, b, a)
	var expected = Transaction.new(3, a, b)
	var found = t1.add(t2)
	var comparor = func(t1: Transaction, t2: Transaction):
		return t1.equals(t2)
	
	var err_msg = ""
	expect(expected, found, err_msg, -1, comparor)
