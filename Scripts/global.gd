extends Node

var gameStarted: bool

var QueenAnt: CharacterBody2D
var PlayerAlive: bool
var PlayerDamageZone: Area2D
var PlayerDamagaAmount: int
var PlayerHitBox: Area2D

var EnemyDamageZone: Area2D
var EnemyDamageAmount: int

var current_wave: int
var moving_to_next_wave: bool
