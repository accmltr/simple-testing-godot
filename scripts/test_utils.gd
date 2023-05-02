@tool
extends Node

func float_equals(value1: float, value2: float, epsilon: float) -> bool:
	return abs(value1 - value2) <= epsilon
