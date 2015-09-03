Workshop 1 - Servidor Rest con Scotty
=====================================

Este repositorio es para el 1er Workshop de
[BAHM](http://www.meetup.com/Buenos-Aires-Haskell-Meetup/)
y consta de un simple servidor web que devuelve JSON
hecho con [Scotty](https://github.com/scotty-web/scotty)

## Instalando GHC y Stack

GHC es el principal compilador de Haskell y Stack la nueva build tool.


Instalar GHC es relativamente simple y como hacerlo lo explica muy bien
el sitio oficial: [http://www.haskell.org/downloads](http://www.haskell.org/downloads).

Stack es bastante automático también, lo pueden encontrar [acá](https://github.com/commercialhaskell/stack).

## Compilando

Clonamos el repo

```bash
$ git clone https://github.com/BsAsHaskell/workshop-1
$ cd workshop-1
```

y dejamos que `stack` haga su magia:

```bash
$ stack build
```

Esto, en teoría, baja las dependencias isoladamente y si no encuentra GHC
pide que corramos `stack setup` que se encarga de hacerlo.

## Corriendo

Si todo salió bien, hacemos:

```bash
.stack-work/install/x86_64-linux/lts-2.15/7.8.4/bin/workshop1
```
y listo!

```bash
curl localhost:3000/episodes/
curl localhost:3000/episodes/1
```
