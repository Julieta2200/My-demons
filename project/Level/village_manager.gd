extends Node

enum STATES {ZERO, LILITH, GARY, INA, SHINY, ORI}

var state: STATES

func set_state(s: STATES):
	state = s

func get_state() -> STATES:
	return state
