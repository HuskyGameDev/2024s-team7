extends Node

## enum for attacks
enum ATTACK {
	LIGHT,
	HEAVY,
	SPECIAL,
	SUPER
}

## enum for direction
enum DIRECTION {
	NEUTRAL,
	UP,
	DOWN,
	SIDE
}

## This is the player's weapon
var weapon: Weapon

## The items the player has
var items: Array[int]
