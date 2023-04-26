extends UnitTest

func test_plus():
	istrue(1 + 1 == 2, self, "1 + 1 did not equal 3")
	istrue(1 + 2 == 3, self, "1 + 2 did not equal 3", 3)

func test_error_happens():
	var error_prone_code = func() :
		istrue(0 == 10, self, "0 did not equal 10")
	error_happens(error_prone_code, self, "The error prone code did not have any errors :(")
