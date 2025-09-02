# Fork of cormas-gaming, ESUG project
Cormas architecture extension which is meant to add support for serious games by implementation of serious game: "Planet C, play again?". 

```st
Metacello new
  baseline: 'CormasGaming';
  repository: 'github://cormas/cormas-gaming:main';
  load
```

# Short introduction

**Planet C** is a serious game implemented in [Pharo](https://pharo.org/) using the [Cormas](https://cormas.org/#/) agent-based modeling framework. It includes a web interface powered by **Zinc HTTP Components**, allowing players to interact via browser or mobile in real time.

**The whole project is the part of Google Summer of Code and it will be prolonged on the official Cormas github.**

Bigger explanation of the background can be found on Wiki on this link: [Introduction](https://github.com/jodz4k/cormas-gaming/wiki/Introduction).
All of the products which become out of the project and future work is presented here [Wiki](https://github.com/jodz4k/cormas-gaming/wiki).

---


## Running the Server

1. Open the Pharo image with all project classes loaded.

2. In a workspace, run:

```smalltalk
CMGameHttpServer new start.
