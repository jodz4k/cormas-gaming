Class {
	#name : 'CMStateTest',
	#superclass : 'TestCase',
	#instVars : [
		'state'
	],
	#category : 'Cormas-Gaming-Tests',
	#package : 'Cormas-Gaming-Tests'
}

{ #category : 'running' }
CMStateTest >> setUp [

	super setUp.
	state := CMState new.
]

{ #category : 'running' }
CMStateTest >> testAddActivePlayers [

	| players |
	players := #( '192.168.0.1' '192.168.0.2' ).

	state addActivePlayers: players.

	players do: [ :ip | self assert: (state activePlayers includes: ip) ]
]

{ #category : 'running' }
CMStateTest >> testInitialize [

    self assert: state round equals: 1.
    self assert: state timer equals: 60.
    self assert: state activePlayers isEmpty.
]

{ #category : 'running' }
CMStateTest >> testRoundAccess [

	state round: 5.
	self assert: state round equals: 5
]

{ #category : 'running' }
CMStateTest >> testTimerAccess [

	state timer: 30.
	self assert: state timer equals: 30
]
