Class {
	#name : 'CMClickEvent',
	#superclass : 'Object',
	#instVars : [
		'ip',
		'role',
		'cells'
	],
	#category : 'Cormas-Gaming',
	#package : 'Cormas-Gaming'
}

{ #category : 'accessing' }
CMClickEvent >> cells [

	^ cells
]

{ #category : 'accessing' }
CMClickEvent >> cells: anObject [

	cells := anObject
]

{ #category : 'initialization' }
CMClickEvent >> initialize [
	super initialize.
	cells := OrderedCollection new.
]

{ #category : 'accessing' }
CMClickEvent >> ip [

	^ ip
]

{ #category : 'accessing' }
CMClickEvent >> ip: anObject [

	ip := anObject
]

{ #category : 'accessing' }
CMClickEvent >> role [

	^ role
]

{ #category : 'accessing' }
CMClickEvent >> role: anObject [

	role := anObject
]
