# cormas-gaming
Cormas extension adding support for serious games by implementation of serious game: Planet C, play again?

```st
Metacello new
  baseline: 'CormasGaming';
  repository: 'github://cormas/cormas-gaming:main';
  load
```

# 🌍 Planet C, play again? – Web-Based Simulation Game

**Planet C** is a serious game implemented in [Pharo](https://pharo.org/) using the [Cormas](https://cormas.org/#/) agent-based modeling framework. It includes a web interface powered by **Zinc HTTP Components**, allowing players to interact via browser or mobile in real time.

**The whole project is still in progress and in implementing and testing phase.**

---

## Main Classes

### 1. `CMGameHttpServer`
Manages HTTP logic and route dispatching via Zinc.

#### 🔧 Key Methods
- `start2`  
  Starts the Zinc server and maps the following routes:
  - `/home`, `/game`, `/game/harvester`, `/game/parkmanager`, `/click`, `/submit`, `/style.css`
- `clientIPAddressFrom:`  
  Extracts the user's IP address.
- `homePageHtml`, `roleSelectionPageHtml`, `harvesterPageHtml`, `parkManagerPageHtml`  
  HTML page templates returned for different routes.
- `gameCss`  
  Returns CSS code used by all frontend pages.

---

### 2. `CMGame` (subclass of `CMSimulation`)
Core logic of the game — handles state, players, rounds, and events.

#### Instance Variables
- `players` — `Dictionary` mapping IP addresses to roles
- `pendingEvents` — `OrderedCollection` of player events
- `submittedThisRound` — `Set` of IPs that submitted during current round
- `state` — instance of `CMState`, holding the round/timer info

#### Role Management
- `assignRole:to:` — Assigns a role (e.g., 'harvester') to a player's IP
- `roleFor:` — Returns the role for a given IP

#### Submission Tracking
- `markSubmitted:` — Adds a player's IP to the submitted set
- `hasPlayerSubmitted:` — Checks if IP has already submitted
- `allPlayersSubmitted` — Checks if all active players submitted
- `resetSubmittedPlayers` — Clears submitted set for new round

#### Round Control
- `startNextRound` — Advances to the next round and resets submission state
- `isGameOver` — Returns true if round limit exceeded
- `restartGame` — Resets all game state to initial

#### Event Management
- `addEvent:` — Adds a new `CMClickEvent` to the queue
- `processPendingEvents` — Iterates through events and processes them

#### Timer (Optional Server-Side)
- `resetTimer` — Sets timer to 60 seconds
- `decrementTimer` — Decreases timer by 1
- `isTimerExpired` — Checks if timer reached 0

#### Status and Debugging
- `isPlayerActive:` — Checks if a player (by IP) is currently active
- `currentStatus` — Returns string with current round, timer, and number of players

---

### 3. `CMState`
 Holds shared state for the current simulation session.

#### Attributes
- `round` — current round number (`Integer`)
- `activePlayers` — `Set` of IP addresses
- `timer` — countdown value (`Integer`, optional)


## 4. CMClickEvent

Encapsulates a player's action during a turn (e.g., selected cells).

### 🧾 Attributes
- `ip` — Player’s IP address  
- `role` — `'harvester'` or `'parkmanager'`  
- `cells` — List of selected grid coordinates  

### Usage
- Created via the `/click` route  
- Stored in `CMGame >> pendingEvents`  
- Later processed in `processPendingEvents`  

---

## Technologies Used

- **Pharo** – Pure object-oriented language and environment  
- **Cormas** – Multi-agent simulation framework  
- **Zinc HTTP Components** – Lightweight HTTP server and dispatcher  
- **NeoJSON** – JSON parsing and generation  
- **HTML / CSS / JavaScript** – Frontend interface  

---

## 🚀 Running the Server

1. Open the Pharo image with all project classes loaded.

2. In a workspace, run:

```smalltalk
CMGameHttpServer new start.
