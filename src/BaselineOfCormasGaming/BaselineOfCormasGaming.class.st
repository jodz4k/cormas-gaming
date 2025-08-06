Class {
	#name : 'BaselineOfCormasGaming',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfCormasGaming',
	#package : 'BaselineOfCormasGaming'
}

{ #category : 'baselines' }
BaselineOfCormasGaming >> baseline: spec [

	<baseline>

	spec for: #common do: [

		spec
			package: 'Cormas-Gaming'
			with: [ spec requires: #('Cormas-Core') ];
		
			package: 'Cormas-Gaming-Tests'
			with: [ spec requires: #('Cormas-Gaming') ] ].

]
