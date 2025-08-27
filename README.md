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


## Running the Server

1. Open the Pharo image with all project classes loaded.

2. In a workspace, run:

```smalltalk
CMGameHttpServer new start.
