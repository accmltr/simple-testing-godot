# Simple Testing Godot

A small testing framework for the Godot 4 game engine that simplifies the process of creating and running unit tests within your Godot projects.

## Features

- Easy-to-use unit testing framework for GDScript projects
- Intuitive interface displaying test results in a tree structure
- SimpleError class for error handling
- UnitTest class as a base for user-defined tests
- Auto-refresh and auto-run feature to automatically update and run tests when changes are detected

## Installation

1. Download or clone this repository into the `addons` directory of your Godot 4 project.
2. In the Godot Editor, navigate to `Project` > `Project Settings` > `Plugins` and enable the `Simple Testing` plugin.

**Note:** You can add this repo as a git submodule to your own git project.

## Usage

### Creating Unit Tests

1. Create a new script that extends the `UnitTest` class provided by the plugin.
2. Define your test functions with names starting with `test_`, such as `test_example_function`.
3. Use the `istrue` function provided by the `UnitTest` class to assert conditions within your test functions.
4. Use the `error_happens` function to check whether a block of code triggers an error as expected.

#### istrue

`istrue` has the following parameters:

- `condition` (bool): The condition to be evaluated. If the condition is not true, an error will be logged.
- `msg` (String): The error message to display if the condition is not true.
- `err_code` (int, optional): An error code for the error, with a default value of -1.

Example usage:

```gd
istrue(result == 2, "Addition failed")
```

#### error_happens

`error_happens` has the following parameters:

- `code` (Callable): A Callable object that represents the code block that is expected to trigger an error.
- `msg` (String): The error message to display if the expected error does not occur.
- `err_code` (int, optional): An error code for the error, with a default value of -1.
- `is_expected` (Callable, optional): A Callable object that takes a `SimpleError` object as its argument and returns a boolean. The function should return `true` if the error passed to it is the expected error. If not provided, the function defaults to returning `true` for any error.

Example usage:

```gd
# without check callable:
var error_prone_code = func():
    istrue(0 == 10, "0 did not equal 10")
error_happens(error_prone_code, "The error prone code did not have any errors")

# with check callable:
var error_prone_code_2 = func():
    istrue(1 == 2, "1 did not equal 2", 8)

var check = func(e: SimpleError):
    return e.err_code == 8

error_happens(error_prone_code_2, "Expected error did not happen.", 1, check)
```


### Running Unit Tests

1. Open the `Simple Testing` dock within the Godot Editor.
2. Click the `Refresh` button to rebuild the tree and display the available unit tests.
3. Click the `Run All` button to run all the unit tests and view the results in the tree structure.

### Auto-Refresh and Auto-Run

- Enable the `Auto-Refresh` checkbox to automatically rebuild the tree and

## Contributing

Contributions are welcome! Please feel free to submit issues and pull requests to help improve the Simple Testing Godot plugin.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.
