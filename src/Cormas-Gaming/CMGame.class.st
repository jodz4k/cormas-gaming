Class {
	#name : 'CMGame',
	#superclass : 'CMSimulation',
	#instVars : [
		'server',
		'players'
	],
	#category : 'Cormas-Gaming',
	#package : 'Cormas-Gaming'
}

{ #category : 'initialization' }
CMGame >> assignRole: aRole to: anIP [
  players at: anIP put: aRole.

]

{ #category : 'initialization' }
CMGame >> initialize [

	super initialize.
	server := CMGameHttpServer new.
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

{ #category : 'running' }
CMGame >> runStep [

	super runStep.
	"do something else"
]
