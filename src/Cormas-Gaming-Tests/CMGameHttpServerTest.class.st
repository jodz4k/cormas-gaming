Class {
	#name : 'CMGameHttpServerTest',
	#superclass : 'TestCase',
	#instVars : [
		'game',
		'server2'
	],
	#category : 'Cormas-Gaming-Tests',
	#package : 'Cormas-Gaming-Tests'
}

{ #category : 'running' }
CMGameHttpServerTest >> setUp [

	super setUp.
	server2 := CMGameHttpServer new.
	server2 start2.
]

{ #category : 'running' }
CMGameHttpServerTest >> tearDown [

	super tearDown.

	server2 stop
]

{ #category : 'enumerating' }
CMGameHttpServerTest >> testMainPage [

  self withServerDo: [ :server |
    | client |
    client := ZnClient new.
    client url: server localUrl; addPath: #image.
    client get.
    self assert: client isSuccess.
    self assert: (client entity contentType matches: ZnMimeType textHtml).
    self assert: (client contents includesSubstring: 'Image').
    client close ]
]

{ #category : 'enumerating' }
CMGameHttpServerTest >> withServerDo: block [

	| server |
	server := ZnServer on: 1700 + 10 atRandom.
	[
		server start.
		self assert: server isRunning & server isListening.
		server delegate: CMGameHttpServer new.
		block cull: server ] ensure: [ server stop ]
]
