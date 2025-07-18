Class {
	#name : 'CMState',
	#superclass : 'Object',
	#instVars : [
		'round',
		'activePlayers',
		'timer'
	],
	#category : 'Cormas-Gaming',
	#package : 'Cormas-Gaming'
}

{ #category : 'accessing' }
CMState >> activePlayers [

	^ activePlayers 
]

{ #category : 'accessing' }
CMState >> addActivePlayers: ipCollection [

	activePlayers addAll: ipCollection
]

{ #category : 'initialization' }
CMState >> initialize [

	super initialize.
	round := 1.
	activePlayers := Set new.
	timer := 60.
]

{ #category : 'accessing' }
CMState >> round [

	^ round
]

{ #category : 'accessing' }
CMState >> round: aNumber [

	round := aNumber
]

{ #category : 'accessing' }
CMState >> timer [

	^ timer
]

{ #category : 'accessing' }
CMState >> timer: aNumber [

	timer := aNumber
]
