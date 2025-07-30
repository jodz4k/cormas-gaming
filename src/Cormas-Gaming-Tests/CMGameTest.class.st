Class {
	#name : 'CMGameTest',
	#superclass : 'TestCase',
	#instVars : [
		'game',
		'server'
	],
	#category : 'Cormas-Gaming-Tests',
	#package : 'Cormas-Gaming-Tests'
}

{ #category : 'running' }
CMGameTest >> setUp [

	super setUp.
	game := CMGame new.
	
]

{ #category : 'running' }
CMGameTest >> tearDown [

	
	super tearDown
]

{ #category : 'running' }
CMGameTest >> testAddEvent [

	| event |
	event := CMClickEvent new.
	game addEvent: event.
	self assert: (game pendingEvents includes: event).
]

{ #category : 'running' }
CMGameTest >> testAssignRole [

	| ip |
	ip := '127.0.0.1'.
	game assignRole: 'harvester' to: ip.
	self assert: (game roleFor: ip) equals: 'harvester'.
]

{ #category : 'running' }
CMGameTest >> testInitialization [

	self assert: game players isEmpty.
	self assert: game pendingEvents isEmpty.
	self assert: game submittedThisRound isEmpty.
	self assert: game currentRound equals: 1.
	self assert: game state round equals: 1
]

{ #category : 'running' }
CMGameTest >> testIsPlayerActive [

	| ip |
	ip := '10.0.0.3'.
	game state addActivePlayers: ip.
	self assert: (game isPlayerActive: ip)
]

{ #category : 'running' }
CMGameTest >> testSubmissionTracking [

	| ip |
	ip := '127.0.0.1'.
	game markSubmitted: ip.
	self assert: (game hasPlayerSubmitted: ip).
]
