# Fork of cormas-gaming, ESUG project
Cormas architecture extension which is meant to add support for serious games such as "Planet C, play again?". 

# Short introduction

**Planet C** is a serious game implemented in [Pharo](https://pharo.org/) using the [Cormas](https://cormas.org/#/) agent-based modeling framework. It includes a web interface powered by **Zinc HTTP Components**, allowing players to interact via browser or mobile in real time.

**The whole project is the part of Google Summer of Code and it will be prolonged on the official Cormas github.**

Bigger explanation of the background can be found on Wiki on this link: [Introduction](https://github.com/jodz4k/cormas-gaming/wiki/Introduction).
All of the products which become out of the project and future work is presented here [Wiki](https://github.com/jodz4k/cormas-gaming/wiki).

Main contribution is MVP of playable architecture and research paper which can be found on this link: add link.

---

# Loading project 

Before loading **CormasGaming**, you first need to install **Cormas** into your Pharo image.  
You can find instructions and download links on the official [Cormas website](https://cormas.org/#/).  

Once Cormas is installed, load **CormasGaming** with:  

```smalltalk
Metacello new
  baseline: 'CormasGaming';
  repository: 'github://cormas/cormas-gaming:main';
  load
```

## Running the Server  

1. Open the Pharo image with all project classes loaded.  

2. In a Playground, run:  

```smalltalk
CMGameHttpServer new start.
```
And if you want to have a transcript of the server responses, run:

```smalltalk
Transcript open.
```

After that, open your web browser and go to:

http://localhost:9090/home

To stop the server write following code in playground:

```smalltalk
CMGameHttpServer stop.
```

