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
				map: '/phone1'
				to: [ :request :response |
					response entity: (ZnEntity html: '
						<html>
							<body>
								<h2>Phone 1</h2>
								<button onclick="fetch(''/click1'')">Click 1</button>
							</body>
						</html>') ];

				map: '/phone2'
				to: [ :request :response |
					response entity: (ZnEntity html: '
						<html>
							<body>
								<h2>Phone 2</h2>
								<button onclick="fetch(''/click2'')">Click 2</button>
							</body>
						</html>') ];

				map: '/click1'
				to: [ :request :response |
					Transcript show: 'Phone 1 clicked!'; cr.
					response entity: (ZnEntity text: 'Phone 1 received') ];

				map: '/click2'
				to: [ :request :response |
					Transcript show: 'Phone 2 clicked!'; cr.
					response entity: (ZnEntity text: 'Phone 2 received') ]
		)

]

{ #category : 'accessing' }
CMGameHttpServer >> stop [

	ZnServer default stop.
]
