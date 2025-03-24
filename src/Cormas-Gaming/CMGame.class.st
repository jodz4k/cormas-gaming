Class {
	#name : 'CMGame',
	#superclass : 'CMSimulation',
	#instVars : [
		'server'
	],
	#category : 'Cormas-Gaming',
	#package : 'Cormas-Gaming'
}

{ #category : 'initialization' }
CMGame >> initialize [

	super initialize.
	server := CMGameHttpServer new.
]

{ #category : 'running' }
CMGame >> runStep [

	super runStep.
	"do something else"
]
