# Taller de Docker

![Docker Image](https://i.postimg.cc/DfXJXcmg/it-works-on-my-machine.png)
#### Introducción al uso de Docker

## Índice y Estructura Principal
- [Punto 1](#Punto-1)
- [Punto 2](#Punto-2)
     * [Subapartado 2a](#sub-2a)
       * [Sub 2a1](#sub-2a1)
- [Uso de la ayuda en Docker](#Uso-de-la-ayuda-en-Docker)
- [Componentes de Docker](#Componentes-de-Docker)
     * [Información sobre Docker](#Información-sobre-Docker)
- [Gestión de contenedores](#Gestión-de-contenedores)
     * [Subapartado 2a](#sub-2a)
- [Gestión de imágenes](#Gestión-de-imágenes)

        
     

Punto 1
===============================================================================================================================
Texto.

#### epigrafe A 2orden

texto.

#### epigrafe B 2orden

texto con enlace '**compra**'.

Ahora va código 

```bash
┌─[josecarlos@debian]─[/home/josecarlos/Desktop/Red]
└──╼ #ifconfig wlan0
wlan0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.1.187  netmask 255.255.255.0  broadcast 192.168.1.255
        inet6 fe80::1d28:6b2b:a941:5796  prefixlen 64  scopeid 0x20<link>
        ether e4:70:b8:d3:93:5d  txqueuelen 1000  (Ethernet)
        RX packets 6426576  bytes 9229384163 (8.5 GiB)
        RX errors 0  dropped 5  overruns 0  frame 0
        TX packets 1160899  bytes 162727829 (155.1 MiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```
y seguimos

Instalación de Docker en Debian
===============================================================================================================================
La instalación de Docker depende del sistema operativo sobre el que estemos trabajando. Además, para algunos sistemas existen diferentes métodos para hacer la instalación.

Nosotros nos vamos a centrar en una instalación rápida y sencilla a través de línea de comandos, **utilizando el repositorio apt**, para lo que habrá que seguir los siguientes pasos:

```bash
#Actualizamos el repositorio
sudo apt update

#Instalamos paquetes necesarios
sudo apt install apt-transport-https ca-certificates curl gnupg2 software-properties-common

#Añadimos la clave gpg para el repositorio oficial de Docker
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

#Agregamos las fuentes de APT del repositorio oficial de Docker
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"

#Actualizamos el repositorio (incluirá las fuentes que acabamos de meter)
sudo apt update

#Instalamos Docker
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

```

Por defecto, Docker solo pueden ejecutarlo ```root``` y quienes pertenezcan al grupo ```docker```. Para evitar tener que poner ```sudo``` en cada orden, es recomendable añadir nuestro usuario al grupo de ```docker```:

```bash
sudo usermod -aG docker ${USER}
```

> **⚠ Importante:**
> si has añadido tu usuario al grupo ```docker```, necesitarás reiniciar sesión para que apliquen los cambios.



Uso de la ayuda en Docker
===============================================================================================================================
En Docker hay una gran cantidad de comandos y, para cada uno, un buen puñado de parámetros y opciones.
La relación de todos los comandos disponibles en Docker se obtiene a través de la orden ```docker --help```:

```bash
eth3rup@debian:~$ docker --help

Usage:  docker [OPTIONS] COMMAND

A self-sufficient runtime for containers

Common Commands:
  run         Create and run a new container from an image
  exec        Execute a command in a running container
  ps          List containers
  build       Build an image from a Dockerfile
  pull        Download an image from a registry
  push        Upload an image to a registry
  images      List images
  login       Log in to a registry
  logout      Log out from a registry
  search      Search Docker Hub for images
  version     Show the Docker version information
  info        Display system-wide information

Management Commands:
  builder     Manage builds
  buildx*     Docker Buildx (Docker Inc., v0.11.2)
  compose*    Docker Compose (Docker Inc., v2.21.0)
  container   Manage containers
  context     Manage contexts
  image       Manage images
  manifest    Manage Docker image manifests and manifest lists
  network     Manage networks
  plugin      Manage plugins
  system      Manage Docker
  trust       Manage trust on Docker images
  volume      Manage volumes

Swarm Commands:
  swarm       Manage Swarm

Commands:
  attach      Attach local standard input, output, and error streams to a running container
  commit      Create a new image from a container's changes
  cp          Copy files/folders between a container and the local filesystem
  create      Create a new container
  diff        Inspect changes to files or directories on a container's filesystem
  events      Get real time events from the server
  export      Export a container's filesystem as a tar archive
  history     Show the history of an image
  import      Import the contents from a tarball to create a filesystem image
  inspect     Return low-level information on Docker objects
  kill        Kill one or more running containers
  load        Load an image from a tar archive or STDIN
  logs        Fetch the logs of a container
  pause       Pause all processes within one or more containers
  port        List port mappings or a specific mapping for the container
  rename      Rename a container
  restart     Restart one or more containers
  rm          Remove one or more containers
  rmi         Remove one or more images
  save        Save one or more images to a tar archive (streamed to STDOUT by default)
  start       Start one or more stopped containers
  stats       Display a live stream of container(s) resource usage statistics
  stop        Stop one or more running containers
  tag         Create a tag TARGET_IMAGE that refers to SOURCE_IMAGE
  top         Display the running processes of a container
  unpause     Unpause all processes within one or more containers
  update      Update configuration of one or more containers
  wait        Block until one or more containers stop, then print their exit codes

Global Options:
      --config string      Location of client config files (default
                           "/home/eth3rup/.docker")
  -c, --context string     Name of the context to use to connect to the
                           daemon (overrides DOCKER_HOST env var and
                           default context set with "docker context use")
  -D, --debug              Enable debug mode
  -H, --host list          Daemon socket to connect to
  -l, --log-level string   Set the logging level ("debug", "info",
                           "warn", "error", "fatal") (default "info")
      --tls                Use TLS; implied by --tlsverify
      --tlscacert string   Trust certs signed only by this CA (default
                           "/home/eth3rup/.docker/ca.pem")
      --tlscert string     Path to TLS certificate file (default
                           "/home/eth3rup/.docker/cert.pem")
      --tlskey string      Path to TLS key file (default
                           "/home/eth3rup/.docker/key.pem")
      --tlsverify          Use TLS and verify the remote
  -v, --version            Print version information and quit

Run 'docker COMMAND --help' for more information on a command.

For more help on how to use Docker, head to https://docs.docker.com/go/guides/
```

Cada uno de los comandos tiene, a su vez, una ayuda específica. Así, por ejemplo, si queremos conocer qué operaciones tenemos disponibles para la gestión de contenedores, usaríamos la orden ```docker container --help```:

```bash
eth3rup@debian:~$ docker container --help

Usage:  docker container COMMAND

Manage containers

Commands:
  attach      Attach local standard input, output, and error streams to a running container
  commit      Create a new image from a container's changes
  cp          Copy files/folders between a container and the local filesystem
  create      Create a new container
  diff        Inspect changes to files or directories on a container's filesystem
  exec        Execute a command in a running container
  export      Export a container's filesystem as a tar archive
  inspect     Display detailed information on one or more containers
  kill        Kill one or more running containers
  logs        Fetch the logs of a container
  ls          List containers
  pause       Pause all processes within one or more containers
  port        List port mappings or a specific mapping for the container
  prune       Remove all stopped containers
  rename      Rename a container
  restart     Restart one or more containers
  rm          Remove one or more containers
  run         Create and run a new container from an image
  start       Start one or more stopped containers
  stats       Display a live stream of container(s) resource usage statistics
  stop        Stop one or more running containers
  top         Display the running processes of a container
  unpause     Unpause all processes within one or more containers
  update      Update configuration of one or more containers
  wait        Block until one or more containers stop, then print their exit codes

Run 'docker container COMMAND --help' for more information on a command.

```
...y, siguiendo la misma operativa, si quisiéramos conocer las opciones del comando ```rm``` en la gestión de contenedores, escribiriamos la orden ```docker container rm --help```:

```bash
eth3rup@debian:~$ docker container --help

Usage:  docker container rm [OPTIONS] CONTAINER [CONTAINER...]

Remove one or more containers

Aliases:
  docker container rm, docker container remove, docker rm

Options:
  -f, --force     Force the removal of a running container (uses SIGKILL)
  -l, --link      Remove the specified link
  -v, --volumes   Remove anonymous volumes associated with the container
```

Además de la propia ayuda del sistema, en la [web oficial de Docker](https://docs.docker.com/engine/reference/commandline/cli/) se proporciona ayuda detallada y extendida de todos los comandos, incluyendo ejemplos y explicaciones de casos de uso. 

Componentes de Docker
===============================================================================================================================
Texto.
#### Información sobre Docker
Hay dos comandos que nos dan información sobre Docker:

El primero de ellos es ```docker version```:


```bash
eth3rup@debian:~$ docker version
Client: Docker Engine - Community
 Version:           24.0.6
 API version:       1.43
 Go version:        go1.20.7
 Git commit:        ed223bc
 Built:             Mon Sep  4 12:32:10 2023
 OS/Arch:           linux/amd64
 Context:           default

Server: Docker Engine - Community
 Engine:
  Version:          24.0.6
  API version:      1.43 (minimum version 1.12)
  Go version:       go1.20.7
  Git commit:       1a79695
  Built:            Mon Sep  4 12:32:10 2023
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.6.24
  GitCommit:        61f9fd88f79f081d64d6fa3bb1a0dc71ec870523
 runc:
  Version:          1.1.9
  GitCommit:        v1.1.9-0-gccaecfc
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0

```

Este comando nos proporciona información sobre la versión de Docker que estamos ejecutando (tanto el cliente como el servidor).

Un apunte a tener en cuenta es que en la información del servidor nos indica cuál es la versión mínima que necesitamos de Docker cliente. Cuando la instalación del servidor es en local, la versión suele coincidir, pero en el caso de que no fuera así, deberíamos asegurarnos de que el cliente tiene, al menos esa versión requerida.

Cuando la versión del cliente es superior a la del servidor, por defecto, se hace un "downgrade" de la versión del cliente para que soporte la API del servidor y puedan "entenderse".

El otro comando es ```docker info```: 

```bash
eth3rup@debian:~$ docker info
Client: Docker Engine - Community
 Version:    24.0.6
 Context:    default
 Debug Mode: false
 Plugins:
  buildx: Docker Buildx (Docker Inc.)
    Version:  v0.11.2
    Path:     /usr/libexec/docker/cli-plugins/docker-buildx
  compose: Docker Compose (Docker Inc.)
    Version:  v2.21.0
    Path:     /usr/libexec/docker/cli-plugins/docker-compose

Server:
 Containers: 0
  Running: 0
  Paused: 0
  Stopped: 0
 Images: 0
 Server Version: 24.0.6
 Storage Driver: overlay2
  Backing Filesystem: extfs
  Supports d_type: true
  Using metacopy: false
  Native Overlay Diff: true
  userxattr: false
 Logging Driver: json-file
 Cgroup Driver: systemd
 Cgroup Version: 2
 Plugins:
  Volume: local
  Network: bridge host ipvlan macvlan null overlay
  Log: awslogs fluentd gcplogs gelf journald json-file local logentries splunk syslog
 Swarm: inactive
 Runtimes: io.containerd.runc.v2 runc
 Default Runtime: runc
 Init Binary: docker-init
 containerd version: 61f9fd88f79f081d64d6fa3bb1a0dc71ec870523
 runc version: v1.1.9-0-gccaecfc
 init version: de40ad0
 Security Options:
  apparmor
  seccomp
   Profile: builtin
  cgroupns
 Kernel Version: 6.1.0-13-amd64
 Operating System: Debian GNU/Linux 12 (bookworm)
 OSType: linux
 Architecture: x86_64
 CPUs: 1
 Total Memory: 3.824GiB
 Name: debian
 ID: cbb9c283-ced8-45d7-88b0-7353637c7858
 Docker Root Dir: /var/lib/docker
 Debug Mode: false
 Experimental: false
 Insecure Registries:
  127.0.0.0/8
 Live Restore Enabled: false
```

Este comando da mucha más información, ya que incluye datos de los contenedores y las imágenes que se están gestionando, así como de los plugins que están instalados.

#### Docker Hub
Aunque es posible tener repositorios privados, existe un repositorio (registro) llamado **Docker Hub** en la que podremos colocar nuestras imágenes y también utilizar imágenes de otros usuarios que ponen a disposición de los demás.

En Docker Hub existen, en general, dos tipos de imágenes:

- **Imágenes privadas:** sólo están disponibles para el propietario.
- **Imágenes públicas:** están disponibles para todos los usuarios de Docker Hub.
   - **Imágenes oficiales de Docker:** forman parte de repositorios básicos esenciales que sirven como punto de partida para la mayoría de los usuarios. Estas imágenes están etiquetadas con la siguiente imagen:
   ![Docker Official Image](https://docs.docker.com/trusted-content/images/official-image-badge-iso.png)
   - **Imágenes no oficiales:** son el resto de las imágenes. Cabe destacar que Docker ha incluido una categoría de "contenido verificado" en la que incluye, además de las imágenes oficiales, las de publicadores verificados y las de contenido Open Source esponsorizado por Docker.

> **👁‍🗨 Consejo:**
> siempre que sea posible, se recomienda utilizar las imágenes oficiales, ya que suelen estar más actualizadas y documentadas que el resto. Además, con ellas se minimizan los problemas de seguridad que pudieran producirse al ejecutar contenido desconocido.

Pensando especialmente en las imágenes no oficiales, existe la posibilidad de realizar una revisión de su contenido antes de ejecutarla. En este sentido, Docker proporciona una herramienta de análisis llamada Docker Scout, que dispone de funcionalidades básicas para la versión gratuita de Docker y otras avanzadas para los planes de pago de Docker Hub.

También hay otras herramientas como Snyk (https://snyk.io/) que proporcionan análisis de imágenes.

##### Información de las imágenes de Docker Hub
Cuando accedemos a una imagen de Docker Hub, obtenemos por regla general la siguiente información:
- El **comando para importar la imagen** a nuestro Docker Engine.
- **Información sobre la imagen**, que suele incluir (especialmente en las imágenes oficiales) una guía sobre cómo utilizar la imagen, si es necesario definir parámetros (como contraseñas, puertos,...) y otra información de interés.
- **Tags o etiquetas**, que se emplean para diferenciar las versiones que se van publicando. De todas las etiquetas disponibles, destacamos la etiqueta ```latest```, que hace alusión a la última versión publicada de la imagen



Gestion de contenedores
===============================================================================================================================

> **⚠ Importante:**
> Docker, en su origen, gestionaba únicamente contenedores. En la actualidad gestiona más elementos. Por este motivo, la sintaxis recomendada para los comandos de gestión de contenedores es ```docker container [COMANDO]...```. Sin embargo, es posible que tanto en este taller como en otra documentación que consultes, veas que se omite ```container``` en la orden. Si bien funciona de las dos maneras, esta última está desaconsejada, por lo que conviene que te acostumbres a utilizar la orden completa.


#### Crear contenedores
Para crear un contenedor se utiliza la orden ```docker container run``` con la siguiente sintaxis:

```docker container run [OPCIONES] nombre_imagen [COMANDO] [ARGUMENTOS...]```

Por defecto, Docker buscará la imagen en el Docker Engine, y si no la tuviera, iría a buscarla a Docker Hub.

En este primer ejemplo, vamos a montar un contenedor de nginx a partir de la imagen oficial, la cual no hemos descargado previamente: 

```bash
eth3rup@debian:~$ docker run -d -p 80:80 nginx
Unable to find image 'nginx:latest' locally
latest: Pulling from library/nginx
a378f10b3218: Pull complete 
5b5e4b85559a: Pull complete 
508092f60780: Pull complete 
59c24706ed13: Pull complete 
1a8747e4a8f8: Pull complete 
ad85f053b4ed: Pull complete 
3000e3c97745: Pull complete 
Digest: sha256:add4792d930c25dd2abf2ef9ea79de578097a1c175a16ab25814332fe33622de
Status: Downloaded newer image for nginx:latest
ab0b901e7e2700265cb848b4c5b8972e39fbe3c42ae3e0afe5f683f64cb0496d

```
Como no es capaz de encontrar la imagen en nuestro Docker Engine, va a Docker Hub a por ella.

Por defecto, si no le decimos nada y existen varias versiones de una misma imagen, descarga la que lleva la etiqueta latest.

La descarga de la imagen se hace por capas, en paralelo, como hablaremos más adelante en la sección de [Gestión de imágenes](#Gestión-de-imágenes)

Una vez ha terminado la descarga, asigna un **ID al contenedor** que genera, que es la cadena hexadecimal que se muestra en la última línea.

asaaaaaaa

#### Listar contenedores
Texto.
#### Para y reanudar contenedores
Texto.
#### Mostrar información del contenedor
Texto.
#### Ejecutar un comando en un contenedor
Texto.
#### Mover información
Texto.

Gestión de imágenes
===============================================================================================================================
Texto.
#### Importar imágenes de Docker Hub
Para cre
#### Exportar imágenes a Docker Hub
Para cre
#### Listar imágenes en Docker
Para cre
