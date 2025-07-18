Class {
	#name : 'CMGame',
	#superclass : 'CMSimulation',
	#instVars : [
		'server',
		'players',
		'pendingEvents',
		'submittedThisRound',
		'currentRound',
		'state'
	],
	#category : 'Cormas-Gaming',
	#package : 'Cormas-Gaming'
}

{ #category : 'initialization' }
CMGame >> addEvent: anEvent [

	pendingEvents add: anEvent
]

{ #category : 'initialization' }
CMGame >> allPlayersSubmitted [

	^ submittedThisRound size = state activePlayers size.
]

{ #category : 'initialization' }
CMGame >> assignRole: aRole to: anIP [
  players at: anIP put: aRole.

]

{ #category : 'accessing' }
CMGame >> currentRound [

	^ currentRound
]

{ #category : 'accessing' }
CMGame >> currentRound: anObject [

	currentRound := anObject
]

{ #category : 'initialization' }
CMGame >> currentStatus [
	^ 'Round: ', state round asString,
		' | Players: ', state activePlayers size asString,
		' | Timer: ', state timer asString.
]

{ #category : 'initialization' }
CMGame >> decrementTimer [
	state timer: state timer - 1.
]

{ #category : 'initialization' }
CMGame >> hasPlayerSubmitted: ip [

	^ submittedThisRound includes: ip
]

{ #category : 'initialization' }
CMGame >> initialize [

	super initialize.
	players := Dictionary new.
	pendingEvents := OrderedCollection new.
	submittedThisRound := Set new.
	currentRound := 1.
	state := CMState new.
]

{ #category : 'initialization' }
CMGame >> isGameOver [

	^ state round > 5
]

{ #category : 'initialization' }
CMGame >> isPlayerActive: ip [

	^ state activePlayers includes: ip
]

{ #category : 'initialization' }
CMGame >> isTimerExpired [

	^ state timer <= 0
]

{ #category : 'initialization' }
CMGame >> markSubmitted: ip [

	submittedThisRound add: ip
]

{ #category : 'accessing' }
CMGame >> pendingEvents [

	^ pendingEvents
]

{ #category : 'accessing' }
CMGame >> pendingEvents: anObject [

	pendingEvents := anObject
]

{ #category : 'as yet unclassified' }
CMGame >> phone1Clicked [

	Transcript
		show: 'CMGame reacting to Phone 1!';
		cr
]

{ #category : 'as yet unclassified' }
CMGame >> phone2Clicked [
	Transcript show: 'CMGame reacting to Phone 2!'; cr.
]

{ #category : 'accessing' }
CMGame >> players [

	^ players
]

{ #category : 'accessing' }
CMGame >> players: anObject [

	players := anObject
]

{ #category : 'initialization' }
CMGame >> processPendingEvents [
	pendingEvents do: [ :ev |
		Transcript show: 'Processing event: ', ev printString; cr.
		"TODO: implement game logic per event"
	].
	pendingEvents := OrderedCollection new.
]

{ #category : 'initialization' }
CMGame >> resetSubmittedPlayers [

	submittedThisRound := Set new.
]

{ #category : 'initialization' }
CMGame >> resetTimer [
	state timer: 60.
]

{ #category : 'initialization' }
CMGame >> restartGame [

	state := CMState new.
	players := Dictionary new.
	submittedThisRound := Set new.
	pendingEvents := OrderedCollection new
]

{ #category : 'as yet unclassified' }
CMGame >> roleFor: ip [
    ^ players at: ip ifAbsent: [ 'unknown' ].

]

{ #category : 'running' }
CMGame >> runStep [

	super runStep.
	"do something else"
]

{ #category : 'accessing' }
CMGame >> server [

	^ server
]

{ #category : 'accessing' }
CMGame >> server: anObject [

	server := anObject
]

{ #category : 'initialization' }
CMGame >> startNextRound [

	self resetSubmittedPlayers.
	state round: state round + 1.
	Transcript
		show: 'Starting round ' , state round asString;
		cr.
]

{ #category : 'accessing' }
CMGame >> state [

	^ state
]

{ #category : 'accessing' }
CMGame >> state: anObject [

	state := anObject
]

{ #category : 'accessing' }
CMGame >> submittedThisRound [

	^ submittedThisRound
]

{ #category : 'accessing' }
CMGame >> submittedThisRound: anObject [

	submittedThisRound := anObject
]
