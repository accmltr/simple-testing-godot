extends UnitTest

func test_plus():
	istrue(1 + 1 == 3, self, "1 + 1 did not equal 3")
	istrue(1 + 2 == 3, self, "1 + 2 did not equal 3")
