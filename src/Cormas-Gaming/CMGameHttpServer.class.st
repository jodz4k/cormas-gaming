Class {
	#name : 'CMGameHttpServer',
	#superclass : 'Object',
	#category : 'Cormas-Gaming',
	#package : 'Cormas-Gaming'
}

{ #category : 'private' }
CMGameHttpServer >> clientIPAddressFrom: aRequest [
	^ aRequest headers
		at: ZnConstants remoteAddressHeader
		ifAbsent: [ '-' ]
]

{ #category : 'accessing' }
CMGameHttpServer >> start [

	(ZnServer startDefaultOn: 9090)
		logToTranscript;
		delegate: (
			ZnDispatcherDelegate new
				map: '/hello'
				to: [ :request :response |
					Transcript crTrace: (self clientIPAddressFrom: request).
					response entity: (ZnEntity html: '<h1>hello!</h1>') ])
]

{ #category : 'accessing' }
CMGameHttpServer >> stop [

	ZnServer default stop.
]
