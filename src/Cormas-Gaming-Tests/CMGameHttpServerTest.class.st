Class {
	#name : 'CMGameHttpServerTest',
	#superclass : 'TestCase',
	#instVars : [
		'game',
		'server2',
		'server'
	],
	#category : 'Cormas-Gaming-Tests',
	#package : 'Cormas-Gaming-Tests'
}

{ #category : 'running' }
CMGameHttpServerTest >> setUp [

	super setUp.
	server := CMGameHttpServer new.
	server start2.
	(Delay forSeconds: 1) wait.
]

{ #category : 'running' }
CMGameHttpServerTest >> tearDown [

	ZnServer default stop. 
	super tearDown
]

{ #category : 'tests' }
CMGameHttpServerTest >> testClientIPAddressFrom [

	| fakeRequest ip |
	fakeRequest := ZnRequest new.
	fakeRequest headers
		at: ZnConstants remoteAddressHeader
		put: '192.168.1.100'.

	ip := server clientIPAddressFrom: fakeRequest.

	self assert: ip equals: '192.168.1.100'
]

{ #category : 'tests' }
CMGameHttpServerTest >> testClientIPAddressFromIfAbsent [

	| fakeRequest ip |
	fakeRequest := ZnRequest new.

	ip := server clientIPAddressFrom: fakeRequest.

	self assert: ip equals: '-'
]

{ #category : 'tests' }
CMGameHttpServerTest >> testGameCssContainsBasicRules [

	| css |
	css := server gameCss.

	self assert: (css includesSubstring: 'font-family').
	self assert: (css includesSubstring: '#grid').
	self assert: (css includesSubstring: '.cell')
]

{ #category : 'running' }
CMGameHttpServerTest >> testGetHomePage [

	| response |
	 response := (ZnClient new
        url: 'http://localhost:9090/home';
        get;
        yourself).
	self assert: response isSuccess.
	self assert: (response entity contents includesSubstring: 'Start')
]

{ #category : 'running' }
CMGameHttpServerTest >> testHtmlTemplatesNotEmpty [
	self deny: server homePageHtml isEmpty.
	self deny: server roleSelectionPageHtml isEmpty.
	self deny: server harvesterPageHtml isEmpty.
	self deny: server parkManagerPageHtml isEmpty.

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
