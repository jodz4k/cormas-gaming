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
	server start.
	
]

{ #category : 'running' }
CMGameHttpServerTest >> tearDown [

	ZnServer default stop. 
	super tearDown
]

{ #category : 'running' }
CMGameHttpServerTest >> testClickRoute [
    | json clickResponse |

    json := NeoJSONObject new.
    json at: 'role' put: 'harvester'.
    json at: 'cells' put: #('0-0' '1-1').
	self halt.
    clickResponse := (ZnClient new
        url: 'http://localhost:9090/click';
        entity: (ZnEntity text: (NeoJSONWriter toString: json));
        method: 'POST';
        contentType: ZnMimeType applicationJson;
        yourself).

    self assert: clickResponse isSuccess.
    self assert: (clickResponse contents includesSubstring: 'Click registered').
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
CMGameHttpServerTest >> testGetGamePage [

    | response |
    response := (ZnClient new
        url: 'http://localhost:9090/game';
        get;
        yourself).

    self assert: response isSuccess.
    self assert: (response entity contents includesSubstring: 'What role are you?').
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
