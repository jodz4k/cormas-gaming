Class {
	#name : 'CMGameHttpServer',
	#superclass : 'Object',
	#instVars : [
		'game'
	],
	#category : 'Cormas-Gaming',
	#package : 'Cormas-Gaming'
}

{ #category : 'private' }
CMGameHttpServer >> clientIPAddressFrom: aRequest [
	^ aRequest headers
		at: ZnConstants remoteAddressHeader
		ifAbsent: [ '-' ]
		
]

{ #category : 'html' }
CMGameHttpServer >> gameCss [
	^ 'body {
  font-family: Arial;
  text-align: center;
  margin-top: 40px;
}

#grid {
  display: grid;
  grid-template-columns: repeat(5, 60px);
  grid-gap: 5px;
  justify-content: center;
}

.cell {
  width: 60px;
  height: 60px;
  border: 1px solid #444;
  background-color: #eee;
  cursor: pointer;
}

.selected {
  background-color: #4CAF50;
  color: white;
}

#timer {
  font-size: 24px;
  margin: 20px;
}

#submitBtn {
  margin-top: 20px;
  padding: 10px 20px;
  font-size: 16px;
}'
]

{ #category : 'html' }
CMGameHttpServer >> harvesterPageHtml [

	^ '<!DOCTYPE html>
<html>
<head>
  <title>Planet C Game</title>
  <link rel="stylesheet" href="/style.css">
</head>
<body>
  <h2>Harvester View</h2>
  <div id="timer">Time left: <span id="timeLeft">60</span>s</div>
  <div id="grid"></div>
  <button id="submitBtn">Harvest</button>

  <script>
    const grid = document.getElementById("grid");
    const timeLeftDisplay = document.getElementById("timeLeft");
    const selectedCells = new Set();
    const role = "harvester";

    let time = 60;
    const countdown = setInterval(() => {
      time--;
      timeLeftDisplay.textContent = time;
      if (time <= 0) {
        clearInterval(countdown);
        alert("Time''s up! Waiting for others...");
        document.getElementById("submitBtn").disabled = true;
      }
    }, 1000);

    for (let row = 0; row < 5; row++) {
      for (let col = 0; col < 5; col++) {
        const cell = document.createElement("div");
        cell.className = "cell";
        cell.dataset.row = row;
        cell.dataset.col = col;
        cell.onclick = () => {
          const key = `${row}-${col}`;
          if (selectedCells.has(key)) {
            selectedCells.delete(key);
            cell.classList.remove("selected");
          } else {
            selectedCells.add(key);
            cell.classList.add("selected");
          }
        };
        grid.appendChild(cell);
      }
    }

    document.getElementById("submitBtn").onclick = () => {
      const cells = Array.from(selectedCells);
      fetch("/click", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ role, cells })
      }).then(() => {
        fetch("/submit", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ role })
        }).then(() => {
          alert("Move submitted!");
          document.getElementById("submitBtn").disabled = true;
        });
      });
    };
  </script>
</body>
</html>'
]

{ #category : 'html' }
CMGameHttpServer >> homePageHtml [

	^ '<html><head>
  <link rel="stylesheet" href="/style.css">
</head><body><img src="/planetclogo.png" alt="Planet C Logo" width="200" />
	<form action="/game" method="get">
	  <button type="submit">Start</button>
	</form></body></html>'
]

{ #category : 'private' }
CMGameHttpServer >> initialize [

	super initialize.
	game := CMGame new.
]

{ #category : 'html' }
CMGameHttpServer >> parkManagerPageHtml [

	^ '<!DOCTYPE html>
<html>
<head>
  <title>Planet C Game</title>
  <link rel="stylesheet" href="/style.css">
</head>
<body>
  <h2>Park Manager View</h2>
  <div id="timer">Time left: <span id="timeLeft">60</span>s</div>
  <div id="grid"></div>
  <button id="submitBtn">Protect</button>

  <script>
    const grid = document.getElementById("grid");
    const timeLeftDisplay = document.getElementById("timeLeft");
    const selectedCells = new Set();
    const role = "parkManager";

    let time = 60;
    const countdown = setInterval(() => {
      time--;
      timeLeftDisplay.textContent = time;
      if (time <= 0) {
        clearInterval(countdown);
        alert("Time''s up! Waiting for others...");
        document.getElementById("submitBtn").disabled = true;
      }
    }, 1000);

    for (let row = 0; row < 5; row++) {
      for (let col = 0; col < 5; col++) {
        const cell = document.createElement("div");
        cell.className = "cell";
        cell.dataset.row = row;
        cell.dataset.col = col;
        cell.onclick = () => {
          const key = `${row}-${col}`;
          if (selectedCells.has(key)) {
            selectedCells.delete(key);
            cell.classList.remove("selected");
          } else {
            selectedCells.add(key);
            cell.classList.add("selected");
          }
        };
        grid.appendChild(cell);
      }
    }

    document.getElementById("submitBtn").onclick = () => {
      const cells = Array.from(selectedCells);
      fetch("/click", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ role, cells })
      }).then(() => {
        fetch("/submit", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ role })
        }).then(() => {
          alert("Move submitted!");
          document.getElementById("submitBtn").disabled = true;
        });
      });
    };
  </script>
</body>
</html>'
]

{ #category : 'html' }
CMGameHttpServer >> roleSelectionPageHtml [

	^ '<html><head>
  <link rel="stylesheet" href="/style.css">
</head><body><h1>What role are you?</h1>
	<form action="/game/harvester" method="get">
	  <button type="submit">Harvester</button>
	</form>
	<form action="/game/parkmanager" method="get">
	  <button type="submit">Park Manager</button>
	</form></body></html>'
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
CMGameHttpServer >> start2 [

	| delegate |
	ZnServer default ifNotNil: [ ZnServer stopDefault ].
	delegate := ZnDispatcherDelegate new.

	delegate map: '/home' to: [ :request :response |
		response entity: (ZnEntity html: self homePageHtml) ].

	delegate map: '/game' to: [ :request :response |
		response entity: (ZnEntity html: self roleSelectionPageHtml) ].

	delegate map: '/game/harvester' to: [ :request :response |
			| ip |
			ip := self clientIPAddressFrom: request.
			game assignRole: 'harvester' to: ip.
			response entity: (ZnEntity html: self harvesterPageHtml) ].

	delegate map: '/game/parkmanager' to: [ :request :response |
			| ip |
			ip := self clientIPAddressFrom: request.
			game assignRole: 'parkmanager' to: ip.
			response entity: (ZnEntity html: self parkManagerPageHtml) ].

	delegate map: '/style.css' to: [ :request :response |
			| entity |
			entity := ZnEntity text: self gameCss.
			entity contentType: ZnMimeType textCss.
			response entity: entity ].

	delegate map: '/submit' to: [ :request :response |
			| ip json role |
			ip := self clientIPAddressFrom: request.
			json := NeoJSONReader fromString: request entity contents.
			role := json at: 'role'.
			game markSubmitted: ip.

			game allPlayersSubmitted ifTrue: [
					Transcript
						show: 'All players submitted. Advancing round...';
						cr.
					game processPendingEvents.
					game startNextRound ].
			game currentStatus.
			response entity: (ZnEntity text: 'Submission received') ].

	delegate map: '/click' to: [ :request :response |
			| ip json role cells event |
			ip := self clientIPAddressFrom: request.
			json := NeoJSONReader fromString: request entity contents.
			role := json at: 'role'.
			cells := json at: 'cells'.

			event := CMClickEvent new.
			event
				ip: ip;
				role: role;
				cells: cells.
			game addEvent: event.
			game currentStatus.
			response entity: (ZnEntity text: 'Click registered') ].

	(ZnServer startDefaultOn: 9090)
		logToTranscript;
		delegate: delegate
]

{ #category : 'accessing' }
CMGameHttpServer >> stop [

	ZnServer default stop.
]
