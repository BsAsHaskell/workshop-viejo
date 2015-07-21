Workshop 1 - Servidor Rest con Scotty
=====================================

Este repositorio es para el 1er Workshop del
[Buenos Aires Haskell Meetup](http://www.meetup.com/Buenos-Aires-Haskell-Meetup/)
y consta de un simple servidor web que devuelve JSON
hecho con [Scotty](https://github.com/scotty-web/scotty)

## Forma manual

### Instalando GHC y Cabal

GHC es el principal compilador de Haskell y Cabal
la herramienta de desarrollo de librerías y programas.

Para el los Workshops nos parece apropiado que todos respeten estas versiones:

* ghc --version >= 7.8.1
* cabal --version >= 1.20

Instalar ambos es relativamente simple y como hacerlo lo explica muy bien
el nuevo sitio oficial: [http://www.haskell.org/downloads](http://www.haskell.org/downloads)

### Compilando

```bash
git clone https://github.com/BsAsHaskell/workshop-1
cd workshop-1
```

tenemos que crear una *sandbox*, un tipo de contenedor estilo
*virtualenv* de python o como la carpeta *node_modules* de npm:

```bash
cabal sandbox init
```

Ahora hacemos la instalación de las dependencias con

```bash
sudo apt-get install zlib1g-dev
cabal install --only-dependencies
```

### Corriendo

Si todo salió bien, hacemos:

```bash
cabal run
```

que compila el binario y lo corre, y listo!

```bash
firefox localhost:3000
```

## Vagrant Way

```bash
vagrant up
vagrant ssh
cd /vagrant
./deploy.sh
echo :D
cabal run
```

y en el host:

```bash
firefox 192.168.50.10:3000
```
