# Taller de Docker

![Docker Image](https://i.postimg.cc/DfXJXcmg/it-works-on-my-machine.png)
#### Introducción al uso de Docker

## Índice y Estructura Principal
- [Instalación de Docker en Debian](#instalación-de-docker-en-debian)
- [Uso de la ayuda en Docker](#uso-de-la-ayuda-en-docker)
- [Componentes de Docker](#componentes-de-docker)
     * [Arquitectura de Docker](#arquitectura-de-docker)
     * [Información sobre Docker](#información-sobre-docker)
     * [Docker Hub](#docker-hub)
     * [Información de las imágenes de Docker Hub](#información-de-las-imágenes-de-docker-hub)
     * [Acceder a Docker desde terminal](#acceder-a-docker-hub-desde-terminal)
     * [Purgar el sistema Docker](#purgar-el-sistema-docker)
- [Gestión de contenedores](#Gestión-de-contenedores)
     * [Crear contenedores](#crear-contenedores)
     * [Listar contenedores](#listar-contenedores)
     * [Mostrar información del contenedor](#mostrar-información-del-contenedor)
     * [Mostrar uso de recursos del contenedor](#mostrar-uso-de-recursos-del-contenedor)
     * [Detener un contenedor](#detener-un-contenedor)
     * [Ejecutar un contenedor](#ejecutar-un-contenedor)
     * [Eliminar un contenedor](#eliminar-un-contenedor)
     * [Mover información](#mover-información)
     * [Ejecutar un comando en un contenedor](#ejecutar-un-comando-en-un-contenedor)
     * [Conectar a la terminal de un contenedor](#conectar-a-la-terminal-de-un-contenedor)
- [Gestión de imágenes](#Gestión-de-imágenes)
     * [Generar una imagen en Docker](#generar-una-imagen-en-docker)
       * [El archivo *Dockerfile*](#el-archivo-dockerfile)
       * [El comando ``docker image build``](#el-comando-docker-image-build)
       * [La caché de Docker](#la-caché-de-docker)
     * [Exportar imágenes a Docker Hub](#exportar-imágenes-a-docker-hub)
     * [Importar imágenes de Docker Hub](#importar-imágenes-de-docker-hub)
     * [Listar imágenes en Docker](#listar-imágenes-en-docker)
     * [Mostrar información de una imagen](#mostrar-información-de-una-imagen)
     * [Eliminar una imagen](#eliminar-una-imagen)
- [Gestión de volúmenes](#gestión-de-volúmenes)
     * [Crear un volumen](#crear-un-volumen)
     * [Listar volúmenes](#listar-volúmenes)
     * [Mostrar información de un volumen](#mostrar-información-de-un-volumen)
     * [Eliminar un volumen](#eliminar-un-volumen)
- [Redes en Docker](#redes-en-docker)
     * [Crear una red en Docker](#crear-una-red-en-docker)
     * [Listar redes](#listar-redes)
     * [Mostrar información de una red](#mostrar-información-de-una-red)
     * [Conectar un contenedor a una red](#conectar-un-contenedor-a-una-red)
     * [Desconectar un contenedor de una red](#desconectar-un-contenedor-de-una-red)
     * [Eliminar una red en Docker](#eliminar-una-red-en-docker)
- [Orquestación de contenedores](#orquestación-de-contenedores)
     * [Docker Compose](#docker-compose)
        * [El archivo _docker-compose.yml_](#el-archivo-docker-composeyml)
        * [Los comandos de Docker Compose](#los-comandos-de-docker-compose)
            * [Levantar el escenario](#levantar-el-escenario)
            * [Detener el escenario](#detener-el-escenario)
            * [Iniciar el escenario](#iniciar-el-escenario)     
            * [Eliminar el escenario](#eliminar-el-escenario)
        * [Optimización de las variables de entorno](#optimización-de-las-variables-de-entorno)

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
> Si has añadido tu usuario al grupo ```docker```, necesitarás reiniciar sesión para que apliquen los cambios.



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
#### Arquitectura de Docker
La arquitectura de Docker está sustentada en tres elementos:
* **Cliente**: corresponde al equipo desde el cual el usuario ejecuta las órdenes de Docker.
* **Docker Engine**: comprende el núcleo de Docker. Está gestionado por el _**demonio de Docker**_. Puede correr en la misma máquina que el cliente (que es lo habitual), pero también puede funcionar en remoto. En este elemento se ejecutan todas las órdenes que lanza el cliente, encargándose también del alojamiento de las imágenes y los contenedores.
* **Registro**: constituye un repositorio de imágenes. El _Docker Engine_ se nutrirá de este repositorio. El registro funciona realmente como un servicio, por lo que pueden utilizarse tantos como se deseen, en cualquier ubicación.

De forma visual, la relación de estos elementos se muestra en la siguiente imagen:

![img05-dockerhub.png](https://miro.medium.com/v2/resize:fit:1100/format:webp/1*09i6gCc0tBhSsXToKA7Cnw.png)
 

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

- **Imágenes privadas:** sólo están disponibles para el propietario. Para acceder a estas imágenes desde nuestro Docker necesitaremos estar logueados en Docker Hub (ver el apartado [Acceder a Docker Hub desde terminal](#acceder-a-docker-hub-desde-terminal) )
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

##### Acceder a Docker Hub desde terminal
Cuando queramos acceder a imágenes privadas, será necesario que estemos logueados en Docker Hub para poder importarla a nuestro Docker Engine. Esto se hace a través del comando ```docker login```:
```bash
eth3rup@debian:~$ docker login
Log in with your Docker ID or email address to push and pull images from Docker Hub. If you don't have a Docker ID, head over to https://hub.docker.com/ to create one.
You can log in with your password or a Personal Access Token (PAT). Using a limited-scope PAT grants better security and is required for organizations using SSO. Learn more at https://docs.docker.com/go/access-tokens/

Username: eth3rup
Password: 
WARNING! Your password will be stored unencrypted in /home/eth3rup/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store

Login Succeeded

```

#### Purgar el sistema Docker
Cuando llevemos un tiempo trabajando con Docker, es posible que nos encontremos con un montón de imágenes, contenedores, redes,... que queramos eliminar. Además, no debemos olvidar que la caché de Docker también irá creciendo y nos ocupará espacio en disco.
Por ello, conviene que conozcamos la existencia del comando ```docker system prune -a``` , cuya finalidad es eliminar:
* Todos los contenedores que no estén en ejecución.
* Todas las redes que no estén en uso por, al menos, un contenedor.
* Todas las imágenes sin un contenedor asociado.
* La caché de Docker.

Aquí podemos observar un ejemplo de su ejecución:

```bash
eth3rup@debian:~$ docker system prune -a
WARNING! This will remove:
  - all stopped containers
  - all networks not used by at least one container
  - all images without at least one container associated to them
  - all build cache

Are you sure you want to continue? [y/N] y
Deleted Images:
deleted: sha256:210933dc23d8252a72ba9a364a3fc1270ca052bb8f774ed96f09c6cbdf47d1ed
untagged: httpd:latest
untagged: httpd@sha256:ed6db4a8c394d075c9c59a3dbd61a3818cd302d9948057f1e19046e5bffec027
deleted: sha256:75a48b16cd565cdaff0cfcbe3462c292e56108a22b9733c0a04a9dc1cbd7a774
deleted: sha256:27311d7559ba0793954c4f3961c8823da774219d330a1ba4c0b57ead5e4a331a
deleted: sha256:86d50a544a6cbba8a8776cf28a02eed90194d252ac965f12b76a597c8a3f8239
deleted: sha256:0192b2c6215c2c06b309421b9734f29e00470b3c110eed300e981070ba0ef992
deleted: sha256:a1594487706cdf37bc27b66789e61b8eec4adc5cb3d9a712fcdf60b8e245575b
deleted: sha256:cb4596cc145400fb1f2aa56d41516b39a366ecdee7bf3f9191116444aacd8c90

Deleted build cache objects:
q8ylpvosg0gf54zjv4b18h9fb
6fo6qud7e29rgf2o3ix15orzb
2wx16abj4o7fktspahm2v1v8y
vw8qng803c7tkxd91x3f3olwu
prqohfis748vfanmtadxoijen
q83utl9kf9a2l19o4egwe893z
xjtnvq3mmhtl8og958gqgqxqt
dvwkv57bagc2a7m44scryxdar
xwdiq3vejsmbdzcct79kcavmm
k23jlthc8rgj07rtququoceur
riylk0oc7uonjihb9ssfj7wln

Total reclaimed space: 924.7MB
```

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

Si ahora abrimos el navegador y escribimos ```http://localhost:80```, veremos corriendo ```nginx```.

[![img01-nginx.png](https://i.postimg.cc/8Pt841ZB/img01-nginx.png)](https://postimg.cc/8jJnPVQj)

#### Listar contenedores
Para ver los contenedores que tengo en mi Docker Engine se utiliza la orden ```docker container list``` con la siguiente sintaxis:

```docker container list [OPCIONES]```

En nuestro caso, la ejecución del comando produciría la siguiente salida:
```bash
eth3rup@debian:~$ docker container list
CONTAINER ID   IMAGE     COMMAND                  CREATED       STATUS       PORTS                               NAMES
ab0b901e7e27   nginx     "/docker-entrypoint.…"   36 seconds ago   Up 35 seconds   0.0.0.0:80->80/tcp, :::80->80/tcp   wizardly_bhabha

```

Vamos a ver el significado de los campos que se muestran...
* CONTAINER ID
Hace alusión al ID del contenedor. Como se puede comprobar, corresponde con el encabezado de la cadena hexadecimal que nos generó cuando lo creamos.
* IMAGE
Referencia la imagen que hemos utilizado para crear este contenedor.
* COMMAND
Indica el comando que se ha ejecutado para lanzar el contenedor.
* CREATED
Da información sobre el tiempo que hace que se creó el contenedor.
* STATUS
Da información sobre el estado del contenedor (en esencia, si está levantado o no) y cuánto tiempo lleva así.
* PORTS
Señala los puertos que expone el contenedor y cómo están mapeados.
* NAMES
Es el nombre que se le asigna al contenedor. Por defecto, si no se establece lo contrario a la hora de crear el contenedor (con el parámetro ```--name nombre_contenedor```), Docker le asigna un nombre "aleatorio"

A continuación vamos a crear otro contenedor de _nginx_ al que vamos a asignar como nombre _web2_:

```bash
eth3rup@debian:~$ docker run --name web2 -d nginx
ff089f6486f2468e71abae88f629fb8e5fcd0f310f5bcd6dfa23acf4dabf8922
eth3rup@debian:~$ docker container list
CONTAINER ID   IMAGE     COMMAND                  CREATED              STATUS              PORTS                               NAMES
ff089f6486f2   nginx     "/docker-entrypoint.…"   About a minute ago   Up About a minute   80/tcp                              web2
ab0b901e7e27   nginx     "/docker-entrypoint.…"   10 minutes ago          Up 10 minutes       0.0.0.0:80->80/tcp, :::80->80/tcp   wizardly_bhabha
```

Advertimos que en el proceso de creación, como Docker Engine ya tiene la imagen, no necesita ir a buscarla a Docker Hub, de modo que la operación es casi instantánea y sólo nos devuelve el ID.

> **⚠ Importante:**
> La orden ```docker container list``` realmente muestra la relación de contenedores en ejecución. Si queremos tener la lista de todos los contenedores (en ejecución y parados) habrá que ejecutar la orden ```docker container list -a ```.

Una opción muy interesante de ```docker container list``` es la de listar sólo los ID de los contenedores. Esta información nos será después muy util para realizar operaciones "masivas" con ellos.
Esto se consigue con la opción ```-q```, como se puede ver a continuación:

```bash
eth3rup@debian:~$ docker container list -q
ff089f6486f2
ab0b901e7e27
```

#### Mostrar información del contenedor
Si queremos tener más información de un contenedor de la que nos arroja el comando ```docker container list```, podemos utilizar el comando ```docker container inspect``` con la siguiente sintaxis:

```docker container inspect [OPCIONES] CONTENEDOR [CONTENEDOR...]```

En realidad, como se aprecia en la sintaxis, es posible consultar información de uno o varios contenedores a la vez.

Para referenciar a los contenedores se puede utilizar su ID o su nombre, indistintamente.

En nuestro caso, la ejecución del comando produciría la siguiente salida en formato JSON:
```bash
eth3rup@debian:~$ docker container inspect ab0b901e7e27
[
    {
        "Id": "ab0b901e7e2700265cb848b4c5b8972e39fbe3c42ae3e0afe5f683f64cb0496d",
        "Created": "2023-10-25T15:30:45.666585423Z",
        "Path": "/docker-entrypoint.sh",
        "Args": [
            "nginx",
            "-g",
            "daemon off;"
        ],
        "State": {
            "Status": "running",
            "Running": true,
            "Paused": false,
            "Restarting": false,
            "OOMKilled": false,
            "Dead": false,
            "Pid": 2322,
            "ExitCode": 0,
            "Error": "",
            "StartedAt": "2023-10-25T15:30:48.206118096Z",
            "FinishedAt": "0001-01-01T00:00:00Z"
        },
        "Image": "sha256:593aee2afb642798b83a85306d2625fd7f089c0a1242c7e75a237846d80aa2a0",
        "ResolvConfPath": "/var/lib/docker/containers/ab0b901e7e2700265cb848b4c5b8972e39fbe3c42ae3e0afe5f683f64cb0496d/resolv.conf",
        "HostnamePath": "/var/lib/docker/containers/ab0b901e7e2700265cb848b4c5b8972e39fbe3c42ae3e0afe5f683f64cb0496d/hostname",
        "HostsPath": "/var/lib/docker/containers/ab0b901e7e2700265cb848b4c5b8972e39fbe3c42ae3e0afe5f683f64cb0496d/hosts",
        "LogPath": "/var/lib/docker/containers/ab0b901e7e2700265cb848b4c5b8972e39fbe3c42ae3e0afe5f683f64cb0496d/ab0b901e7e2700265cb848b4c5b8972e39fbe3c42ae3e0afe5f683f64cb0496d-json.log",
        "Name": "/wizardly_bhabha",
        "RestartCount": 0,
        "Driver": "overlay2",
        "Platform": "linux",
        "MountLabel": "",
        "ProcessLabel": "",
        "AppArmorProfile": "docker-default",
        "ExecIDs": null,
        "HostConfig": {
            "Binds": null,
            "ContainerIDFile": "",
            "LogConfig": {
                "Type": "json-file",
                "Config": {}
            },
            "NetworkMode": "default",
            "PortBindings": {
                "80/tcp": [
                    {
                        "HostIp": "",
                        "HostPort": "80"
                    }
                ]
            },
...

```

Este comando también permite filtrar la información para obtener sólo los datos que nos interesen haciendo uso del parámetro ```-f``` y de la ubicación del campo en la taxonomía del reporte JSON. Por ejemplo, si quisiéramos conocer la IP que tiene el contenedor en la red de Docker (hablaremos de ella más adelante), usaríamos la expresión ```-f '{{.NetworkSettings.IPAddress}}'```:

```bash
eth3rup@debian:~$ docker container inspect -f '{{.NetworkSettings.IPAddress}}' ab0b901e7e27
172.17.0.2
```

#### Mostrar uso de recursos del contenedor
Además de la información "estática" del contenedor, podemos obtener datos del uso de los recursos del contenedor sin necesidad de correr comandos en su interior. Para ello haremos uso del comando ```docker container stats```, que tiene la siguiente sintaxis:

```docker container stats [OPCIONES] [CONTENEDOR...]```

La salida de este comando nos dará una visualización en tiempo real del consumo de los principales recursos, de forma similar a cuando ejecutamos el comando top en nuestro terminal.
Durante el tiempo que estemos visualizando esta información, la ventana no podrá utilizarse para otra cosa. Si queremos salir, ejecutaremos la combinación de teclas ```[Ctrl]+[C]```

Para obtener una única "captura" de información, emplearemos la opción ```--no-stream```:
```bash
eth3rup@debian:~$ docker container stats --no-stream web2
CONTAINER ID   NAME      CPU %     MEM USAGE / LIMIT     MEM %     NET I/O           BLOCK I/O         PIDS
ff089f6486f2   web2      0.03%     12.86MiB / 1.921GiB   0.65%     5.33kB / 1.18kB   1.66MB / 28.7kB   82
```

#### Detener un contenedor
Cuando no queramos hacer uso del contenedor, podemos detener su ejecución con el comando ```docker container stop```, que tiene la siguiente sintaxis:

```docker container stop [OPCIONES] CONTENEDOR [CONTENEDOR...]```

Como en el caso de ```docker container inspect```, aquí también podremos detener uno o varios contenedores a la vez y, para referenciar a los contenedores, se puede utilizar su ID o su nombre, indistintamente.

En nuestro caso, si quisiéramos parar el contenedor que tenemos actualmente en ejecución, lanzaríamos la siguiente orden:

```bash
eth3rup@debian:~$ docker container stop ab0b901e7e27
ab0b901e7e27
```

Como podemos observar, la salida que nos da ese comando es el ID del contenedor.

Si ahora listamos de nuevo los contenedores (con el parámetro ```-a``` para ver los que no están en ejecución) obtenemos el siguiente resultado:

```bash
eth3rup@debian:~$ docker container list -a
CONTAINER ID   IMAGE     COMMAND                  CREATED       STATUS                     PORTS     NAMES
ff089f6486f2   nginx     "/docker-entrypoint.…"   7 minutes ago   Up 6 minutes               80/tcp    web2
ab0b901e7e27   nginx     "/docker-entrypoint.…"   17 minutes ago   Exited (0) 25 seconds ago             wizardly_bhabha

```

> **😎 Truco**
> Para detener todos los contenedores que hay en ejecución utilizando una única orden, vamos a recurrir a la salida del comando ```docker container list -q``` y combinarla de la siguiente manera:
```docker container stop `docker container list -q` ```


#### Ejecutar un contenedor
Si queremos lanzar un contenedor que tenemos parado, debemos hacer uso del comando ```docker container start```, que tiene la siguiente sintaxis:

```docker container start [OPCIONES] CONTENEDOR [CONTENEDOR...]```

De nuevo, y como en el caso de ```docker container start```, aquí también podremos iniciar uno o varios contenedores a la vez y, para referenciar a los contenedores, se puede utilizar su ID o su nombre, indistintamente.

En nuestro caso, si quisiéramos volver a lanzar el contenedor que habíamos detenido, lanzaríamos la siguiente orden:

```bash
eth3rup@debian:~$ docker container start ab0b901e7e27
ab0b901e7e27
```
La salida que nos da ese comando es, de nuevo, el ID del contenedor.

Si ahora vuelvo a consultar el listado de contenedores, obtenemos el siguiente resultado:

```bash
eth3rup@debian:~$ docker container list
CONTAINER ID   IMAGE     COMMAND                  CREATED       STATUS                     PORTS     NAMES
ff089f6486f2   nginx     "/docker-entrypoint.…"   7 minutes ago   Up 6 minutes               80/tcp    web2
ab0b901e7e27   nginx     "/docker-entrypoint.…"   17 minutes ago   Up 9 seconds             wizardly_bhabha
```

> **😎 Truco**
> Para lanzar todos los contenedores que hay parados utilizando una única orden, vamos a recurrir a la salida del comando ```docker container list -qa``` y combinarla de la siguiente manera:
```docker container stop `docker container list -qa` ```
La opción ```-qa``` devuelve los ID de todos los contenedores (parados y en ejecución) y cuando Docker vaya a lanzarlos, **los contenedores que ya estén en ejecución los obviará**.

#### Eliminar un contenedor
Cuando llegue el momento en el que un contenedor ya no me resulte útil o no me interese, puedo eliminarlo de mi Docker Engine. Esto se hace con el comando ```docker container rm```, que tiene la siguiente sintaxis:

```docker container rm [OPCIONES] CONTENEDOR [CONTENEDOR...]```

Como en los casos anteriores, podremos detener uno o varios contenedores a la vez usando el ID o su nombre, indistintamente.

Si procedemos a eliminar un contenedor en ejecución (por ejemplo, _web2_) obtendremos lo siguiente:

```bash
eth3rup@debian:~$ docker container rm web2
Error response from daemon: You cannot remove a running container ff089f6486f2468e71abae88f629fb8e5fcd0f310f5bcd6dfa23acf4dabf8922. Stop the container before attempting removal or force remove
```

Así pues, tendremos dos opciones:
a) Parar el contenedor y después eliminarlo
```bash
eth3rup@debian:~$ docker container stop web2
web2
eth3rup@debian:~$ docker container rm web2
web2
```

b) Forzar la eliminación del contenedor, aún cuando se encuentre en ejecución.
```bash
eth3rup@debian:~$ docker container rm -f web2
web2
```

Más adelante veremos que se pueden asociar volúmenes a un contenedor. De esta manera, en el caso de que se quieran almacenar datos de forma persistente y ajena al contenedor, se puede hacer con total independencia. Sin embargo, cuando eliminamos el contenedor, si no establecemos lo contrario, los volúmenes, al ser persistentes, no se eliminan.

En el caso de que se quieran eliminar volúmenes asociados al contenedor cuando queramos eliminar el contenedor, haremos uso de la opción ```-v```.

> **⚠️ Importante**
> Los volúmenes sólo se podrán eliminar si no están asociados a otro contenedor.


#### Mover información
En ocasiones puede ser necesario mover información (archivos) desde nuestro equipo al contenedor o viceversa. Para ello haremos uso del comando ```docker container cp```, que tiene la siguiente sintaxis.

```docker container cp [OPCIONES] RUTA_ORIGEN RUTA_DESTINO```

El movimiento de información se puede hacer desde o hacia el contenedor. Hay que tener en cuenta que para referenciar la ruta del contenedor se utilizará el formato ```NOMBRE_CONTENEDOR:RUTA_EN_CONTENEDOR```

Por ejemplo, si tenemos un contenedor en ejecución llamado _web3_ al que le hemos cargado una imagen de _Apache_ (imagen _httpd_) y queremos recuperar el archivo _index.html_ original, utilizaríamos la siguiente orden:

```bash
eth3rup@debian:~$ docker container cp web2:/usr/local/apache2/htdocs/index.html .
Successfully copied 2.05kB to /home/eth3rup/.
```

Del mismo modo, si quisiéramos colocar una nueva versión de ese archivo en el contenedor, la orden sería esta:

```bash
eth3rup@debian:~$ docker container cp index.html web3:/usr/local/apache2/htdocs/
Successfully copied 2.05kB to web3:/usr/local/apache2/htdocs/
```

...y, en efecto, si accedemos a localhost comprobamos que el archivo está actualizado.

[![img02-apache.png](https://i.postimg.cc/zDMdJSn9/img02-apache.png)](https://postimg.cc/s1YPmWHc)

#### Ejecutar un comando en un contenedor
Es posible ejecutar un comando en un contenedor a través de la orden ```docker container exec```, que tiene la siguiente sintaxis:

```docker container exec [OPCIONES] CONTENEDOR COMANDO [ARGUMENTOS]```

Un ejemplo muy simple sería lanzar la orden ```ls```

Como se ve, la salida muestra el mismo resultado que si hubiera ejecutado ls en el terminal de ese "equipo".

```bash
eth3rup@debian:~$ docker container exec web3 ls
bin
build
cgi-bin
conf
error
htdocs
icons
include
logs
modules
```

Si quisiéramos realizar más operaciones sobre el contenedor, lo realmente útil es lanzar una consola interactiva:

```bash
eth3rup@debian:~$ docker container exec -it web3 /bin/bash
root@88c3ddffc5da:/usr/local/apache2# ls
bin  build  cgi-bin  conf  error  htdocs  icons  include  logs	modules
root@88c3ddffc5da:/usr/local/apache2# 
```

Esto permite acceder al contenedor y lanzar una consola, de forma que las órdenes que ejecutemos serán en su interior.
Para salir de la consola simplemente usamos la orden ```exit```


#### Conectar a la terminal de un contenedor
Otra forma más ágil de conectar a la terminal de un **contenedor en ejecución** es a través de la orden ```docker container attach```, que tiene la siguiente sintaxis: 

```docker container attach [OPCIONES] CONTENEDOR```

Aquí tenemos un ejemplo:

```bash
eth3rup@debian:~$ docker run -dit --name ejemplo alpine
aad5c393d98c4cef82f575151cf87c3f204008ec6c704a1974c6b0279c0cd273

eth3rup@debian:~$ docker docker attach ejemplo
/ # ls
bin    etc    lib    mnt    proc   run    srv    tmp    var
dev    home   media  opt    root   sbin   sys    usr
```

Para salir del contenedor sin detenerlo, se hace ``[Ctrl]+[P]`` y posteriormente ``[Ctrl]+[Q]``. Esto producirá la salida y nos devolverá a nuestra línea de comandos:

```bash
/ # read escape sequence
eth3rup@debian:~$ 
```


Gestión de imágenes
===============================================================================================================================
Hasta ahora hemos visto cómo podemos trabajar con contenedores a partir de imágenes ya existentes. Ahora daremos un paso más y empezaremos a crear nuestras propias imágenes.

#### Generar una imagen en Docker
A la hora de generar una imagen en Docker deberemos tener en cuenta dos elementos esenciales: 

* El archivo ***Dockerfile***, que va a contener toda la información necesaria para generar la imagen.
* El comando ```Docker image build```, que se encargará de interpretar ese archivo y construir la imagen.

##### El archivo *Dockerfile*
La redacción del archivo Dockerfile es la clave para la creación de la imagen. Hay una amplia variedad de instrucciones para incluir en este archivo (puedes consultarlas todas en la [Documentación oficial de Docker](https://docs.docker.com/engine/reference/builder/)).

Para introducirnos en la redacción de este archivo, vamos a comenzar con un ejemplo muy sencillo en el que crearemos una imagen para una aplicación web que queremos desarrollar en Python con Flask.


> **⚠️ A tener en cuenta...**
>
> En este ejemplo, el contenido del archivo de ejemplo de aplicación web _**miapp.py**_ es este:
> ```
>from flask import Flask
>
>app = Flask(__name__)
>
>@app.route('/')
>def hello_world():
>    return 'Hola Mundo'
>
>if __name__ == '__main__':
>    app.run(debug=True,host='0.0.0.0')
>
>```


Una primera aproximación al archivo _**Dockerfile**_ sería la siguiente:

```bash
FROM ubuntu:latest
RUN apt-get update -y
RUN apt-get install -y python3-pip python-dev-is-python3
WORKDIR /miapp
ENV TEST=True
EXPOSE 5000
VOLUME /datos_miapp
COPY . /miapp
RUN pip install -r requisitos.txt
ENTRYPOINT ["python"]
CMD ["miapp.py"]
```

> **👉 A tener en cuenta...**
>
> En este ejemplo, el contenido del archivo _**requisitos.txt**_ es este:
> ```
>blinker==1.6.3
>click==8.1.7
>Flask==3.0.0
>itsdangerous==2.1.2
>Jinja2==3.1.2
>MarkupSafe==2.1.3
>Werkzeug==3.0.1
>```

A continuación comentamos la finalidad de cada una de las líneas del archivo _**Dockerfile**_

* ``FROM ubuntu:latest``
Partimos de la imagen oficial de ubuntu en su última versión (``latest``). A partir de aquí, cada instrucción del archivo va a ir añadiendo una capa a la imagen descargada.

* ``RUN apt-get update -y``
``RUN apt-get install -y python3-pip python-dev-is-python3``
Se actualiza el repositorio del sistema y se instalan los paquetes que se van a necesitar de Python3.

* ``WORKDIR /miapp``
Establece el directorio de trabajo del contenedor, que actuará como "raiz" para las operaciones del tipo ```COPY```, ```RUN```, ```CMD``` o ```ENTRYPOINT```.
* ``ENV DEBUG=True``
Fija la variable de entorno DEBUG y le asigna un valor. Esta variable irá al contexto del contenedor.
* ``EXPOSE 5000``
Establece un puerto de escucha en el contenedor. Pueden establecerse varios, tanto TCP como UDP. Por defecto, si no se establece lo contrario, se consideran TCP.
* ``VOLUME /datos_miapp``
Permite generar volúmenes persistentes a la vida del contenedor. Así se consiguen dos cosas:
  * Que el tamaño del contenedor no aumente, y así sea más manejable.
  * Que se mantengan datos con independencia del contenedor.
* ``COPY . /miapp``
Añade archivos en la imagen desde un lugar externo (nuestro equipo u otro lugar).
* ``RUN pip install -r requisitos.txt``
Ejecuta una orden. En este caso, instala los paquetes que he recogido en el archivo ```requisitos.txt```, el cual he copiado a la imagen en el paso anterior.
* ``ENTRYPOINT ["python"]``
Ejecuta el comando.
* ``CMD ["miapp.py"]``
La orden ```CMD``` tiene un funcionamiento similar a ```ENTRYPOINT```. Sin embargo, cuando van combinadas, ```CMD``` actúa como los parámetros que llevaría la orden lanzada por ```ENTRYPOINT```. En este caso, se ejecutaría la sentencia ```python miapp.py```

##### El comando ``docker image build``
Para construir la imagen utilizamos el comando ```docker image build``` con la siguiente sintaxis:

```docker image build [OPCIONES] CONTEXTO```

El _contexto_ por defecto es la ruta desde la que operamos (lo que normalmente indicaremos con ```.```). De todas las opciones que tiene el comando, para nuestro propósito vamos a optar por utilizar ```-t``` para asignarle un nombre a la imagen que nos permita manipularla posteriormente de forma más sencilla.

```bash
eth3rup@debian:~$ docker image build -t appflask .
[+] Building 184.0s (11/11) FINISHED                             docker:default
 => [internal] load build definition from Dockerfile                       0.2s
 => => transferring dockerfile: 286B                                       0.1s
 => [internal] load .dockerignore                                          0.2s
 => => transferring context: 2B                                            0.0s
 => [internal] load metadata for docker.io/library/ubuntu:latest           2.3s
 => [1/6] FROM docker.io/library/ubuntu:latest@sha256:2b7412e6465c3c7fc5b  0.5s
 => => resolve docker.io/library/ubuntu:latest@sha256:2b7412e6465c3c7fc5b  0.1s
 => => sha256:2b7412e6465c3c7fc5bb21d3e6f1917c167358449fe 1.13kB / 1.13kB  0.0s
 => => sha256:c9cf959fd83770dfdefd8fb42cfef0761432af36a764c07 424B / 424B  0.0s
 => => sha256:e4c58958181a5925816faa528ce959e487632f4cfd1 2.30kB / 2.30kB  0.0s
 => [internal] load build context                                         21.1s
 => => transferring context: 127.83MB                                     20.9s
 => [2/6] RUN apt-get update -y                                           25.6s
 => [3/6] RUN apt-get install -y python3-pip python-dev-is-python3       115.5s
 => [4/6] WORKDIR /miapp                                                   0.4s 
 => [5/6] COPY . /miapp                                                   11.6s 
 => [6/6] RUN pip install -r requisitos.txt                                5.7s 
 => exporting to image                                                    21.2s 
 => => exporting layers                                                   21.2s 
 => => writing image sha256:0f434183eb1c32e731e6b6538da7a3970b8c6fa8f5e35  0.0s 
 => => naming to docker.io/library/appflask                                0.0s
 ```

Cada uno de los pasos que se llevan a cabo en el proceso de generación de la imagen producen una de estas dos cosas:
  * Una capa sobre la anterior.
  * Metadatos en la imagen.
Así, el proceso de generación de la imagen sería, en realidad, la generación de capas sobre una imagen original (en nuestro caso, sobre *ubuntu:latest*)


Si consultamos nuestro repositorio de imágenes, podremos observar que se ha creado satisfactoriamente:

```bash
eth3rup@debian:~$ docker image list -a
REPOSITORY   TAG       IMAGE ID       CREATED         SIZE
appflask     latest    0f434183eb1c   24 seconds ago   604MB
```

...y ya podremos correr un contenedor basado en esta imagen:

```bash
eth3rup@debian:~$ docker container run --name app1 -it -p 5000:5000 -d appflask
55c3e2b64486c11706b5f240a6d2d191a2102558bc7b6ec873faf798ddf0d960
```

[![img03-appflask.png](https://i.postimg.cc/wTYTTj2h/img03-appflask.png)](https://postimg.cc/Dm5KxFtZ)


##### La caché de Docker
Como hemos visto, el proceso de generación de una imagen es una acción secuencial en la que se va leyendo el archivo *Dockerfile*.
Este proceso tiene un "problema" importante, ya que si debemos repetirlo, hay que pasar por cada una de las órdenes del archivo para obtener la imagen.
El hecho de que la organización de la imagen sea por capas, va a permitir optimizar bastante el proceso, ya que permite "porcionar" el procedimiento en secuencias más simples.

Vamos a verlo con un ejemplo muy sencillo: en el caso de la aplicación web con Flask, cambiaremos el archivo miapp.py para que en lugar de mostrar "Hola Mundo" muestre "Nueva versión". El resto lo mantendremos tal cual estaba.

Una vez modificado ese archivo, volvemos a construir la imagen:

```bash
eth3rup@debian:~$ docker image build -t appflask .
[+] Building 44.9s (11/11) FINISHED                              docker:default
 => [internal] load build definition from Dockerfile                       0.3s
 => => transferring dockerfile: 286B                                       0.1s
 => [internal] load .dockerignore                                          0.2s
 => => transferring context: 2B                                            0.1s
 => [internal] load metadata for docker.io/library/ubuntu:latest           2.4s
 => [1/6] FROM docker.io/library/ubuntu:latest@sha256:2b7412e6465c3c7fc5b  0.0s
 => [internal] load build context                                          6.0s
 => => transferring context: 27.90MB                                       5.7s
 => CACHED [2/6] RUN apt-get update -y                                     0.0s
 => CACHED [3/6] RUN apt-get install -y python3-pip python-dev-is-python3  0.0s
 => CACHED [4/6] WORKDIR /miapp                                            0.0s
 => [5/6] COPY . /miapp                                                   23.3s
 => [6/6] RUN pip install -r requisitos.txt                               10.2s
 => exporting to image                                                     2.1s 
 => => exporting layers                                                    2.1s 
 => => writing image sha256:4d6fcf77f8e8a04b9828c4d397b26d6f267659747a5e3  0.0s 
 => => naming to docker.io/library/appflask                                0.0s
```

Si consultamos de nuevo nuestro repositorio de imágenes, podremos observar que se ha creado satisfactoriamente:

```bash
eth3rup@debian:~$ docker image list -a
REPOSITORY   TAG       IMAGE ID       CREATED         SIZE
appflask     latest    4d6fcf77f8e8   30 seconds ago   603MB
```

...y ya podremos correr un contenedor basado en esta nueva imagen:

```bash
eth3rup@debian:~$ docker container run --name app2 -it -p 5000:5000 -d appflask
0e7bd3c69a05dabf0ab98c23db613dc81669ce30bdbc11f1a1203d8c45f19477
```

[![img03-appflaskv2.png](https://i.postimg.cc/bNTQw2Qn/img03-appflaskv2.png)](https://postimg.cc/mtPcdkpZ)

Si comparamos esta construcción con la que hicimos originalmente, vemos lo siguiente:

1) Las acciones 2, 3 y 4 aparecen con la etiqueta ```CACHED```. Esto es así porque **Docker ha guardado en su caché** la información de estas capas y en el proceso de construcción, al comprobar que no suponen un cambio sobre la construcción original, en lugar de procesarlas de nuevo, las replica desde la caché. De esta manera nos ahorramos los 141.5 segundos que hubiera llevado (aproximadamente) repetir esos pasos.

2) La acción 5 ya difiere de la construcción original (porque hemos variado el contenido de ```/miapp```), de forma que a partir de aquí abandona la caché y genera nuevas capas ejecutando las sentencias del archivo *Dockerfile*.

> **⚠️ Importante**
>
> Desde el momento en que haya una diferencia sobre las capas cacheadas, la caché se invalida y el resto se va a generar nuevo, con independencia de que líneas posteriores a la que produjo el cambio no generasen modificaciones, ya que la capa sobre la que se asentarían sería nueva.

De aquí sacamos una conclusión muy importante, y es que el orden en que se plantean las diferentes instrucciones del archivo *Dockerfile* va a favorecer (o no) la optimización de las imágenes; esencialmente cuando están sujetas a cambios.

Si la orden ```COPY . /miapp``` la hubiéramos colocado antes de las operaciones 2, 3 y 4, el cambio en ```/miapp``` habría ocasionado que la información cacheada no hubiera servido, con lo que la construcción exigiría un nuevo paso por ellas cada vez que quisiéramos hacer un cambio ahí. Por ese motivo, a la hora de redactar un archivo _Dockerfile_ conviene que el orden de las operaciones haga que aquellas que previsiblemente vayan a producir cambios estén lo más abajo posible; así se verían afectadas menos capas y la caché se optimizaría.


> **⚠️ Importante**
>
> **La caché de Docker es local.** Por este motivo, la primera vez que hagamos la construcción de una imagen, se ejecutarán todas sus capas aunque tengamos esa imagen en un registro de Docker.


#### Exportar imágenes a Docker Hub
Como vimos en el apartado [Acceder a Docker Hub desde terminal](#acceder-a-docker-hub-desde-terminal), para poder exportar imágenes a nuestro espacio de Docker Hub, necesitaremos estar logueados en él, con independencia de que las imágenes las establezcamos como públicas o privadas.


> **👉 A tener en cuenta...**
>
> La **versión gratuita de Docker Hub** sólo nos permitirá disponer de **un repositorio privado**, por lo que sólo podremos exportar una imagen de este modo (con todas las versiones que queramos, eso sí). 


Antes de exportar nuestra imagen a Docker Hub debemos tener en cuenta que es indispensable que ésta esté etiquetada correctamente. El formato de la etiqueta será:

**```usuario/repositorio:etiqueta```**

Para cambiar la etiqueta de una imagen utilizamos el comando ```docker image tag```, que tiene la siguiente sintaxis:

```docker image tag IMAGEN_ORIG[:TAG] IMAGEN_DEST[:TAG]```

Por ejemplo, si queremos preparar la imagen de la aplicación web en Flask que creamos en el apartado anterior, lo haríamos así:

```bash
eth3rup@debian:~$ docker tag appflask:latest iesalisal/appflask:latest

eth3rup@debian:~$ docker image list -a
REPOSITORY           TAG       IMAGE ID       CREATED       SIZE
iesalisal/appflask   latest    4d6fcf77f8e8   3 hours ago   603MB
appflask             latest    4d6fcf77f8e8   3 hours ago   603MB
```

En cualquier caso, para subir una imagen a Docker Hub haremos uso del comando ```docker imagen push```, que tiene la siguiente sintaxis:

```docker imagen push [OPCIONES] IMAGEN:TAG```

Siguiendo el ejemplo del apartado anterior, si quisiéramos subir la imagen de la aplicación web en Flask, lo haríamos así:

```bash
eth3rup@debian:~$ docker push iesalisal/appflask
Using default tag: latest
The push refers to repository [docker.io/iesalisal/appflask]
6f20fdcc571c: Pushed 
3917bb451bd0: Pushed 
90d39bb08065: Pushed 
69c2d7607ab8: Pushed 
fce8565643ef: Pushed 
256d88da4185: Pushed 
latest: digest: sha256:18d17cba5d1b9d244d6ceab8394588427510ed394e74743cdddb347351518c90 size: 1583
```

Y, como podemos comprobar, ya la tenemos publicada en nuestro perfil de Docker Hub

[![img05-dockerhub.png](https://i.postimg.cc/tJMRVLLx/img05-dockerhub.png)](https://postimg.cc/0K71TH5k)


#### Importar imágenes de Docker Hub
En el apartado [Crear contenedores](#crear-contenedores) vimos como la operación ```docker container run``` producía una importación de una imagen si no la teníamos disponible en nuestro Docker Engine.
En cualquier caso, es posible importar una imagen sin necesidad de crear un contenedor que haga uso de ella. Para ello hacemos uso del comando ```docker image pull```, que tiene la siguiente sintaxis:

```docker image pull [OPCIONES] IMAGEN:TAG```

En el caso de que quisiéramos importar la imagen de la aplicación web en Flask que subimos anteriormente, lo haríamos así:

```bash
eth3rup@debian:~$ docker pull iesalisal/appflask
latest: Pulling from iesalisal/appflask
Digest: sha256:18d17cba5d1b9d244d6ceab8394588427510ed394e74743cdddb347351518c90
Status: Image is up to date for iesalisal/appflask:latest
docker.io/iesalisal/appflask:latest
```
El proceso ha comprobado que ya teníamos en nuestro Docker Engine la misma imagen que hay en nuestro Docker Hub (mismo hash), por lo que no la descarga.
Incluso si eliminamos la imagen, veremos que obtenemos el mismo resultado, ya que contamos con la [caché de Docker](#la-caché-de-docker).
Si [purgamos el sistema Docker](#purgar-el-sistema-docker) y volvemos a repetir el proceso, entonces veremos que la importación se hace como si se tratara de cualquier otra imagen (teniendo en cuenta que debemos estar logueados en Docker Hub, porque esta imagen es privada).

```bash
eth3rup@debian:~$ docker pull iesalisal/appflask
Using default tag: latest
latest: Pulling from iesalisal/appflask
43f89b94cd7d: Pull complete 
b132c322eb4a: Pull complete 
b168825a7ee8: Pull complete 
103f0a6688c3: Pull complete 
61eb57fa7f24: Pull complete 
dcf51077e7d4: Pull complete 
Digest: sha256:18d17cba5d1b9d244d6ceab8394588427510ed394e74743cdddb347351518c90
Status: Downloaded newer image for iesalisal/appflask:latest
docker.io/iesalisal/appflask:latest
```
Si lo que buscamos es descargar una imagen de una versión concreta, en Docker Hub podemos consultar para una imagen todas las disponibles. Así, por ejemplo, si deseamos descargar la versión _edge_ de la imagen _alpine_, ejecutaríamos la siguiente orden:

```bash
eth3rup@debian:~$ docker image pull alpine:edge
edge: Pulling from library/alpine
b790c763077d: Pull complete 
Digest: sha256:f2d1645cd73c7e54584dc225da0b5229d19223412d719669ebda764f41396853
Status: Downloaded newer image for alpine:edge
docker.io/library/alpine:edge
```

> **👉 A tener en cuenta...**
>
> Por defecto, Docker busca una imagen en el repositorio general ```library``` y en la versión ```latest```. Si queremos una imagen de un repositorio concreto en una versión concreta, deberemos indicarlo en la orden.

#### Listar imágenes en Docker
Para listar las imágenes que tenemos descargadas en nuestro Docker Engine utilizamos del comando ```docker imagen list```, que tiene la siguiente sintaxis:

```docker image list [OPCIONES] IMAGEN:TAG```

Así, si queremos ver todas nuestras imágenes, no aplicaríamos ningún "filtro":

```bash
eth3rup@debian:~$ docker image list
REPOSITORY           TAG       IMAGE ID       CREATED          SIZE
appflask             latest    4d6fcf77f8e8   3 hours ago       603MB
iesalisal/appflask   latest    4d6fcf77f8e8   3 hours ago       603MB
alpine               edge      23d4cb6bdebe   8 weeks ago      7.38MB
```

#### Mostrar información de una imagen
Del mismo modo que podíamos [consultar la información de un contenedor](#mostrar-información-del-contenedor) con ```docker container inspect```, también podemos consultar la información de una imagen con el comando ```docker image inspect``` con la siguiente sintaxis:

```docker image inspect [OPCIONES] IMAGEN [IMAGEN...]```

En realidad, como se aprecia en la sintaxis, es posible consultar información de una o varias imágenes a la vez.

Para referenciar a las imágenes, como nos pasaba con los contenedores, se puede utilizar su ID o su nombre, indistintamente.

En nuestro caso, la ejecución del comando para la imagen ```appflask``` produciría la siguiente salida en formato JSON:
```bash
eth3rup@debian:~$ docker image inspect appflask
[
    {
        "Id": "sha256:28aee5e55114320f616acc3b61914b1264a7b51fe55cea2bfb56b2ab4983333f",
        "RepoTags": [
            "appflask:latest"
        ],
        "RepoDigests": [],
        "Parent": "",
        "Comment": "buildkit.dockerfile.v0",
        "Created": "2023-10-31T12:52:03.500648195+01:00",
        "Container": "",
        "ContainerConfig": {
            "Hostname": "",
            "Domainname": "",
            "User": "",
            "AttachStdin": false,
            "AttachStdout": false,
            "AttachStderr": false,
            "Tty": false,
            "OpenStdin": false,
            "StdinOnce": false,
            "Env": null,
            "Cmd": null,
            "Image": "",
            "Volumes": null,
            "WorkingDir": "",
            "Entrypoint": null,
            "OnBuild": null,
            "Labels": null
        },
        "DockerVersion": "",
        "Author": "",
        "Config": {
            "Hostname": "",
            "Domainname": "",
            "User": "",
            "AttachStdin": false,
            "AttachStdout": false,
            "AttachStderr": false,
            "ExposedPorts": {
                "5000/tcp": {}
            },
            "Tty": false,
            "OpenStdin": false,
            "StdinOnce": false,
            "Env": [
                "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
                "DEBUG=True"
            ],
            "Cmd": [
                "miapp.py"
            ],
            "ArgsEscaped": true,
            "Image": "",
            "Volumes": {
                "/datos_miapp": {}
            },
            "WorkingDir": "/miapp",
            "Entrypoint": [
                "python"
            ],
            "OnBuild": null,
            "Labels": {
                "org.opencontainers.image.ref.name": "ubuntu",
                "org.opencontainers.image.version": "22.04"
            }
...
]

```

Este comando también permite filtrar la información para obtener sólo los datos que nos interesen haciendo uso del parámetro ```-f``` y de la ubicación del campo en la taxonomía del reporte JSON. Por ejemplo, si quisiéramos conocer el volumen persistente que monta la imagen, usaríamos la expresión ```-f '{{.Config.Volumes}}'```:

```bash
eth3rup@debian:~$ docker image inspect -f '{{.Config.Volumes}}' appflask
map[/datos_miapp:{}]
```

#### Eliminar una imagen
Como nos pasaba con los contenedores, se puede dar el caso de que una imagen ya no resulte útil o no interese. Entonces podemos optar por eliminarla del Docker Engine con el comando ```docker image rm```, que tiene la siguiente sintaxis:

```docker image rm [OPCIONES] IMAGEN [IMAGEN...]```

Como en los casos anteriores, podremos eliminar una o varias imágenes a la vez usando el ID o su nombre, indistintamente.

Si procedemos a eliminar una imagen que se está usando contenedor (esté o no en ejecución) obtendremos lo siguiente:

```bash
eth3rup@debian:~$ docker image rm appflask
Error response from daemon: conflict: unable to remove repository reference "appflask" (must force) - container e7d0a615a147 is using its referenced image 4d6fcf77f8e8
```

En esta situación, tenemos dos opciones:
a) Eliminar el contenedor y posteriormente la imagen.
```bash
eth3rup@debian:~$ docker container rm app1
app1
eth3rup@debian:~$ docker image rm appflask
Untagged: appflask:latest
Deleted: sha256:28aee5e55114320f616acc3b61914b1264a7b51fe55cea2bfb56b2ab4983333f
```

b) Forzar la eliminación de la imagen. El contenedor seguirá funcionando con normalidad.
```bash
eth3rup@debian:~$ docker image rm -f appflask
Untagged: appflask:latest
Deleted: sha256:28aee5e55114320f616acc3b61914b1264a7b51fe55cea2bfb56b2ab4983333f
```

Gestión de volúmenes
===============================================================================================================================
Los contenedores funcionan, por defecto, como entidades aisladas, aunque sabemos que podemos exponer puertos del contenedor para comunicarlo con una red y también que podemos mover información al contenedor con los comandos ```COPY``` y ```ADD``` del archivo ```Dockerfile```.

Sin embargo, esto no evita que cuando se elimine el contenedor también se eliminen los archivos que contiene.

Si queremos utilizar información cuando trabajamos con contenedores que se mantenga independiente de éstos disponemos de dos opciones:
* **Volúmenes de host:** consiste en montar directorios de nuestro host en el contenedor, que es lo que hemos venido haciendo hasta ahora.
* **Volúmenes de datos:** actúan como una "unidad de disco" (volumen) al que pueden acceder varios contenedores. Son un objeto más en Docker, como los contenedores o las imágenes.

Por regla general, utilizaremos los volúmenes de datos para almacenar información que el contenedor pueda generar "de forma autónoma" (el ejemplo más claro son las bases de datos) y volúmenes de host cuando el movimiento de información entre host y contenedor lo produzcamos nosotros de forma habitualmente manual (por ejemplo, código fuente de una aplicación que estemos desarrollando).

#### Crear un volumen
Para crear un volumen hacemos uso del comando ```docker volume create```, que tiene la siguiente sintaxis:

```docker volume create [OPCIONES] [VOLUMEN]```

Si quisiéramos crear un volumen para alojar la base de datos de un Wordpress, lo haríamos así:

```bash
eth3rup@debian:~$ docker volume create miwordpress-db
miwordpress-db
```

#### Listar volúmenes
Para tener la relación de volúmenes disponibles, utilizamos el comando ```docker volume list```, que tiene la siguiente sintaxis:

```docker volume list [OPCIONES]```

En nuestro caso...

```bash
eth3rup@debian:~$ docker volume list
DRIVER    VOLUME NAME
local     miwordpress-db
```

#### Mostrar información de un volumen
Como sucedía con contenedores e imágenes, también vamos a poder consultar la información de un volumen. Esto lo haremos con el comando ```docker volume inspect``` que tiene la siguiente sintaxis:

```docker volume inspect [OPCIONES] VOLUMEN [VOLUMEN...]```

Como se aprecia en la sintaxis, es posible consultar información de uno o varios contenedores a la vez.

En nuestro caso, la ejecución del comando para el volumen ```miwordpress-db``` produciría la siguiente salida en formato JSON:
```bash
eth3rup@debian:~$ docker volume inspect miwordpress-db
[
    {
        "CreatedAt": "2023-11-02T18:46:14+01:00",
        "Driver": "local",
        "Labels": null,
        "Mountpoint": "/var/lib/docker/volumes/miwordpress-db/_data",
        "Name": "miwordpress-db",
        "Options": null,
        "Scope": "local"
    }
]
```

#### Eliminar un volumen
Cuando ya no necesitemos el volumen, podemos eliminarlo **siempre que no esté en uso** en un contenedor. El comando empleado es ```docker volume rm```, que tiene la siguiente sintaxis:

```docker volume rm [OPCIONES] VOLUMEN [VOLUMEN]```

En nuestro caso...

```bash
eth3rup@debian:~$ docker volume rm miwordpress-db
miwordpress-db
```

> **⚠ Importante:**
>
> La operación de eliminado de un volumen **no puede deshacerse**. Cuando se elimina un volumen, se pierde toda la información que aloja en su interior.

Redes en Docker
===============================================================================================================================
Con la instalación de Docker se crean tres redes de manera predefinida:

* Red ```bridge```, utiliza el interfaz ```docker0``` y la subred ```172.17.0.0/16```. Cuando creamos contenedores y exponemos sus puertos, por defecto, a través de DHCP los conecta a esta red. 

* Red ```host```, que asimila la misma IP que nuestro equipo.

* Red ```none```, que no asigna ninguna IP al contenedor, por lo que no es accesible a través de red. ünicamente dispone del interfaz _loopback_ para hablar consigo mismo.

Estas tres redes están definidas por su **driver**, que es quien establece que sean de un tipo u otro. Es decir, tenemos tres tipos de driver:
* _**bridge**_
* _**host**_
* _**none**_

#### Crear una red en Docker
Además de las redes predefinidas, es posible crear redes personalizadas. Se pueden crear de cualquiera de los tres tipos (según el driver que se elija), aunque lo más común es definir redes de tipo _**bridge**_

Para crear un volumen hacemos uso del comando ```docker network create```, que tiene la siguiente sintaxis:

```docker network create [OPCIONES] RED```

Si no se establece ninguna opción, Docker crea una red tipo  _**bridge**_ que será una red independiente y no se solapará con la predefinida ni otras existentes: ```172.18.0.0/16```, ```172.19.0.0/16```,...

```bash
eth3rup@debian:~$ docker network create mired1
a4aa408b62eb338a808da55efd86f97590ae112dac20b1d4b8002f262ea1fd5c
```

Si ahora consultamos las redes de nuestro equipo, veremos que aparece esta nueva red:

```bash
eth3rup@debian:~$ sudo ifconfig
br-a4aa408b62eb: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        inet 172.18.0.1  netmask 255.255.0.0  broadcast 172.18.255.255
        ether 02:42:c8:06:12:cd  txqueuelen 0  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
docker0: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        inet 172.17.0.1  netmask 255.255.0.0  broadcast 172.17.255.255
        inet6 fe80::42:8cff:fe09:b21  prefixlen 64  scopeid 0x20<link>
        ether 02:42:8c:09:0b:21  txqueuelen 0  (Ethernet)
        RX packets 10694  bytes 522013 (509.7 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 15221  bytes 261798303 (249.6 MiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
...
```

...como la red creada es de tipo _**bridge**_, aparece con el prefijo ```br```.

Además, se puede ver que la red creada es independiente de la red _**bridge**_ predefinida, que aparece bajo el interfaz ```docker0```.

#### Listar redes
Si queremos conocer la relación de redes disponibles, utilizamos el comando ```docker network list```, que tiene la siguiente sintaxis:

```docker network list [OPCIONES]```

En nuestro caso...

```bash
eth3rup@debian:~$ docker network list
NETWORK ID     NAME      DRIVER    SCOPE
cbf3509aa90c   bridge    bridge    local
ce2870c7e71b   host      host      local
a4aa408b62eb   mired1    bridge    local
d15815d2f0d7   none      null      local
```
...se puede ver como están las tres redes predefinidas y, además, la red ```mired1``` que hemos creado anteriormente.

#### Mostrar información de una red
Podemos consultar información de una red de forma similar a como hemos hecho con otros objetos de Docker. Haremos uso del comando ```docker network inspect```, que tiene esta sintaxis:

```docker network inspect [OPCIONES] RED [RED...]```

En realidad, como se aprecia en la sintaxis, es posible consultar información de una o varias redes a la vez.

Para referenciar a las redes, como nos pasaba con los contenedores y las imágenes, se puede utilizar su ID o su nombre, indistintamente.

En nuestro caso, la ejecución del comando para ver información de la red ```mired1``` produciría la siguiente salida en formato JSON:
```bash
eth3rup@debian:~$ docker network inspect mired1
[
    {
        "Name": "mired1",
        "Id": "a4aa408b62eb338a808da55efd86f97590ae112dac20b1d4b8002f262ea1fd5c",
        "Created": "2023-11-02T19:32:26.104771011+01:00",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": {},
            "Config": [
                {
                    "Subnet": "172.18.0.0/16",
                    "Gateway": "172.18.0.1"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {},
        "Options": {},
        "Labels": {}
    }
]
```

Este comando también permite filtrar la información para obtener sólo los datos que nos interesen haciendo uso del parámetro ```-f``` y de la ubicación del campo en la taxonomía del reporte JSON. Por ejemplo, si quisiéramos saber si está habilitada para IPv6, usaríamos la expresión ```-f '{{.EnableIPv6}}'```:

```bash
eth3rup@debian:~$ docker image inspect -f '{{.EnableIPv6}}' mired1
false
```

#### Conectar un contenedor a una red
Para conectar un contenedor a una red concreta (por ejemplo, a nuestra red ``mired1``) tenemos dos opciones:
a) Establecerlo a la hora de correr el contenedor, usando el parámetro ```--network```.
```bash
eth3rup@debian:~$ docker container run -dit --name hostA --network mired1 alpine
cfb8f27c5da9547b710c7f707818fb786ab7b31383bbc8cf71c7176027d4eae2
eth3rup@debian:~$ docker container inspect hostA
...
           "Networks": {
                "mired1": {
                    "IPAMConfig": null,
                    "Links": null,
                    "Aliases": [
                        "cfb8f27c5da9"
                    ],
                    "NetworkID": "a4aa408b62eb338a808da55efd86f97590ae112dac20b1d4b8002f262ea1fd5c",
                    "EndpointID": "f49bf72d382d463206bc06f2eb97b5c44d3cfa9e5031f85474048101210b82b5",
                    "Gateway": "172.18.0.1",
                    "IPAddress": "172.18.0.2",
                    "IPPrefixLen": 16,
                    "IPv6Gateway": "",
                    "GlobalIPv6Address": "",
                    "GlobalIPv6PrefixLen": 0,
                    "MacAddress": "02:42:ac:14:00:02",
                    "DriverOpts": null
                }
...
```
b) Conectarlo a la red posteriormente, usando el comando ``docker network connect``. En este caso, la sintaxis del comando es la siguiente:

``docker network connect [OPCIONES] RED CONTENEDOR``

Para nuestro caso, sería así: 

```bash
eth3rup@debian:~$ docker container run -dit --name hostB alpine
668814a2240e57335108ad74ec3045c8d572cdde9d359bd9a424948e4f6e6178
eth3rup@debian:~$ docker network connect mired1 hostB
eth3rup@debian:~$ docker container inspect hostB
...
            "Networks": {
                "bridge": {
                    "IPAMConfig": null,
                    "Links": null,
                    "Aliases": null,
                    "NetworkID": "cbf3509aa90cd09da168e696c1bb6979cfcc460af0e35f52bc838740d1488126",
                    "EndpointID": "530666b4a6451686d9f2f5377a93e0c111677737faa610987428cb539cd23caa",
                    "Gateway": "172.17.0.1",
                    "IPAddress": "172.17.0.2",
                    "IPPrefixLen": 16,
                    "IPv6Gateway": "",
                    "GlobalIPv6Address": "",
                    "GlobalIPv6PrefixLen": 0,
                    "MacAddress": "02:42:ac:11:00:02",
                    "DriverOpts": null
                },
                "mired1": {
                    "IPAMConfig": {},
                    "Links": null,
                    "Aliases": [
                        "668814a2240e"
                    ],
                    "NetworkID": "a4aa408b62eb338a808da55efd86f97590ae112dac20b1d4b8002f262ea1fd5c",
                    "EndpointID": "4d60487c41c48f5e0ad93b94524b74c0c416dd913bd5b43502d563398e13ac03",
                    "Gateway": "172.18.0.1",
                    "IPAddress": "172.18.0.3",
                    "IPPrefixLen": 16,
                    "IPv6Gateway": "",
                    "GlobalIPv6Address": "",
                    "GlobalIPv6PrefixLen": 0,
                    "MacAddress": "02:42:ac:14:00:03",
                    "DriverOpts": {}
                }

...
```

> **👉 A tener en cuenta...**
>
> El contenedor ``hostB``, al crearlo, como no especificamos nada, lo asignó a la red predefinida de tipo _**bridge**_. En el siguiente punto veremos cómo podemos desvincularlo de esa red.


Los dos contenedores (``hostA`` y ``hostB``) se encuentran ahora vinculados a la misma red (``mired``), por lo que están comunicados.

Vamos a comprobarlo haciendo lanzando un ``ping``:

```bash
eth3rup@debian:~$ docker attach hostA
/ # ping -c 3 hostB
PING hostB (172.18.0.3): 56 data bytes
64 bytes from 172.18.0.3: seq=0 ttl=64 time=0.383 ms
64 bytes from 172.18.0.3: seq=1 ttl=64 time=0.154 ms
64 bytes from 172.18.0.3: seq=2 ttl=64 time=0.148 ms

--- hostB ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 0.148/0.228/0.383 ms
/ # 
```

> **👉 A tener en cuenta...**
>
> Podemos emplear los nombres de los contenedores en lugar de las direcciones IP porque Docker utiliza un servidor DNS configurado en cada contenedor, que le permite resolver el nombre del resto de contenedores que están en su misma red.



#### Desconectar un contenedor de una red
Al igual que podemos conectar un contenedor a una red, también podemos desconectarlo. Esto lo hacemos con el comando ```docker network disconnect```, que tiene la siguiente sintaxis:

```docker network disconnect [OPCIONES] RED CONTENEDOR```

Así, si quisiéramos desconectar nuestro contenedor ``hostB`` de la red ``bridge`` predefinida, haríamos lo siguiente:

```bash
eth3rup@debian:~$ docker network disconnect bridge hostB
eth3rup@debian:~$ docker container inspect hostB
...
            "Networks": {
                "mired1": {
                    "IPAMConfig": {},
                    "Links": null,
                    "Aliases": [
                        "668814a2240e"
                    ],
                    "NetworkID": "a4aa408b62eb338a808da55efd86f97590ae112dac20b1d4b8002f262ea1fd5c",
                    "EndpointID": "4d60487c41c48f5e0ad93b94524b74c0c416dd913bd5b43502d563398e13ac03",
                    "Gateway": "172.18.0.1",
                    "IPAddress": "172.18.0.3",
                    "IPPrefixLen": 16,
                    "IPv6Gateway": "",
                    "GlobalIPv6Address": "",
                    "GlobalIPv6PrefixLen": 0,
                    "MacAddress": "02:42:ac:14:00:03",
                    "DriverOpts": {}
                }

...
```

#### Eliminar una red en Docker
Como sucedía con los volúmenes, podemos eliminar un red **siempre que no esté en uso** por uno o más contenedores. El comando empleado es ```docker network rm```, que tiene la siguiente sintaxis:

```docker volume rm RED [RED]```

Si queremos eliminar la red ``mired1``, que está siendo usada por los contenedores ``hostA`` y ``hostB``...

```bash
eth3rup@debian:~$ docker network rm mired1
Error response from daemon: error while removing network: network mired1 id a4aa408b62eb338a808da55efd86f97590ae112dac20b1d4b8002f262ea1fd5c has active endpoints
```

Si tuviéramos una red ``mired2`` que no estuviera usada, podríamos eliminarla sin problemas:

```bash
eth3rup@debian:~$ docker network rm mired2
mired2
```




Orquestación de contenedores
===============================================================================================================================
El uso de contenedores, como es visto, es extremadamente útil y flexible. Podemos definir una inmensa variedad de configuraciones de imágenes y contenedores. Sin embargo, hay un aspecto importante a tener en cuenta, y es que debemos establecer de antemano una configuración y, si esta cambia, ya nos serviría.

Esto se ve muy claro con un sencillo ejemplo: imaginemos que queremos montar un entorno para un _Wordpress_. Neecesitaríamos...
* Entorno de _Wordpress_.
* Entorno de base de datos, por ejemplo, _MariaDB_.

La forma más simple sería crear una única imagen en la que tengamos _Wordpress+MariaDB_. Pero, ¿qué problema nos genera este planteamiento? De todos, el principal es que cualquier cambio en uno de los dos entornos implicaría una modificación en la versión. Por este motivo, los paradigmas actuales tienen al uso de _**microservicios**_.

Si adoptamos un modelo de microservicios, los entornos de Wordpress y MariaDB irían separados. De esta manera, un cambio en uno de ellos no afectaría al otro. Como vemos, Docker es una magnífica herramienta para implementar el modelo de microservicios. Además, disponemos de imágenes oficiales tanto de _Wordpress_ como de _MariaDB_, por lo que la implementación no debería generar mucha complicación.

Sin embargo, vemos que este modelo, si tenemos que construirlo manualmente, implica una considerable carga de trabajo, ya que tendríamos que...
* Levantar un contenedor para _Wordpress_.
* Levantar un contenedor para _MariaDB_.
* Vincular ambos contenedores (para que _Wordpress_ pueda hacer uso de _MariaDB_).

...y es precisamente aquí donde entra el concepto de la _**orquestación**_, que no es más que el planteamiento de automatizar la generación de escenarios de contenedores.

#### Docker Compose
La principal herramienta para la orquestación de contenedores se llama ```Docker Compose```.
Esta herramienta funciona en todos los entornos y dispone de una nutrida variedad de comandos para gestionar prácticamente la totalidad de escenarios en Docker.

> **⚠ Importante:**
>
> Es posible que te encuentres algún entorno en el que se utilice ```docker-compose``` (con un guión) en lugar de  ```docker compose``` (con un espacio). Ambos son ``Docker Compose``. Se diferencian en que el primero es la versión ``v1`` y el segundo la versión ``v2``. La versión ``v1`` está "discontinuada" y ya no recibe actualizaciones, por lo que, si es tu caso, sería recomendable que actualizaras tu versión de Docker, ya que actualmente se incluye la versión ``v2`` en la propia instalación y no es necesario instalarla como un plugin, que era lo que sucedía con la ``v1``.

##### El archivo docker-compose.yml

La forma de funcionamiento de ```docker compose``` es muy similar a la que tenía ```docker build```. En este caso, la base será un archivo llamado ```docker-compose.yml``` (en formato YAML).


> **👉 A tener en cuenta...**
>
> Tanto ```docker build``` como  ```docker compose``` tienen unos archivos por defecto (```Dockerfile``` para el primer caso y ```docker-compose.yml``` para el segundo). Sin embargo, pueden asignarse otros nombres a los archivos e indicarlo después en la orden con el parámetro ```-f``` para que vaya a ese fichero en lugar al que tiene asignado por defecto.


En la ayuda oficial de Docker está recogida [toda la información sobre la sintaxis del dichero ```docker-compose.yml```](https://docs.docker.com/compose/compose-file/03-compose-file/).

El archivo ```docker-compose.yml``` se organiza esencialmente en las siguientes secciones:
* _**Versión**_ (opcional).
* _**Servicios**_ (obligatoria).
* _**Volúmenes**_ (opcional).
* _**Redes**_ (opcional). 

Existen dos secciones "avanzadas" (_**configs**_ y _**secrets**_) a partir de la versión 3.1, que también son opcionales.

Para nuestro propósito, al igual que hicimos para el archivo ```Dockerfile``` vamos a partir de un ejemplo en el que utilizaremos el escenario que hemos introducido de _Wordpress_. Para ello, una primera aproximación muy simple del archivo ```docker-compose.yml``` sería esta:

```yaml
version: '3.1'

services:
    db:
        image: mariadb:11.0
        volumes:
            - data:/var/lib/mysql
        environment:
            - MYSQL_ROOT_PASSWORD=pass.de.root
            - MYSQL_DATABASE=wordpress
            - MYSQL_USER=manager
            - MYSQL_PASSWORD=pass.de.manager
        networks:
            - lan1
    web:
        image: wordpress:6.3.2
        depends_on:
            - db
        volumes:
            - ./wp:/var/www/html
        environment:
            - WORDPRESS_DB_USER=manager
            - WORDPRESS_DB_PASSWORD=pass.de.manager
            - WORDPRESS_DB_HOST=db
        networks:
            - lan1
        ports:
            - 8080:80
networks:
    lan1:
        driver: bridge
volumes:
    data:
```


A continuación comentamos la finalidad de cada una de las líneas del archivo _**docker-compose.yml**_:

```yaml
version: '3.1'
```
Hace alusión a la versión de la especificación de Docker Compose que vamos a utilizar. Aunque no es necesario, la añadimos porque facilita mucho el trabajo a la hora de hacer modificaciones ya que, como vimos, la versión conlleva cambios.

```yaml
services:
    db:
    ...
    web:
    ...
```
Recoge los dos entornos que vamos a necesitar: el de base de datos (que llamamos ``db``) y el de Wordpress (que llamamos ``web``).


```yaml
    db:
        image: mariadb:11.0
        volumes:
            - data:/var/lib/mysql
        environment:
            - MYSQL_ROOT_PASSWORD=pass.de.root
            - MYSQL_DATABASE=wordpress
            - MYSQL_USER=manager
            - MYSQL_PASSWORD=pass.de.manager
        networks:
            - lan1
```
 
**image:** especifica la imagen de Docker que se utilizará.
**volumes:** monta el volumen ``data`` para almacenar los datos de ``mysql``. Como veremos más adelante, ese volumen está definido como objeto Docker, así que será un volumen persistente.
**environment:** genera las variables de entorno que se necesitarán para configurar la base de datos.
**networks:** asigna al contenedor la red ``lan1``.  

```yaml
    web:
        image: wordpress:6.3.2
        depends_on:
            - db
        volumes:
            - ./wp:/var/www/html
        environment:
            - WORDPRESS_DB_USER=manager
            - WORDPRESS_DB_PASSWORD=pass.de.manager
            - WORDPRESS_DB_HOST=db
        ports:
            - 8080:80
        networks:
            - lan1
```

**image:** especifica la imagen de Docker que se utilizará.
**depends on:** establece que el contenedor dependa de otro, de forma que éste no pueda iniciarse hasta que aquel del que dependa no lo esté. En nuestro caso, nos asegura que Wordpress no se inicie hasta que la base de datos esté operativa.
**volumes:** monta el directorio ``./wp`` para comunicar con ``/var/www/html``. Cuando hablamos de volúmenes, mencionamos que para el intercambio de código fuente suele preferirse un montaje sobre directorio a crear un volumen persistente.
**environment:** genera las variables de entorno que se necesitarán para configurar WordPress.
**ports**: mapea el puerto 80 del contenedor con el puerto 8080 de nuestro host.
**networks:** asigna al contenedor la red ``lan1``. De esta manera, los dos contenedores estarán en la misma red. 

```yaml
networks:
    lan1:
        driver: bridge
```

Crea una red de tipo _bridge_ con el nombre ``lan1``. Esta red será la que utilizarán los dos contenedores para comunicarse.

```yaml
volumes:
    data:
```

Crea el volumen persistente ``data`` el cual, como vemos, utilizará el contenedor ``db`` para alojar la base de datos.

##### Los comandos de Docker Compose

Como se puede consultar en la [ayuda de Docker Compose](https://docs.docker.com/compose/reference/), existe una amplia variedad de comandos para operar sobre los objetos recogidos en la orquestación definida en nuestro docker-compose.yml

###### Levantar el escenario

La operación principal en Docker Compose es levantar el escenario que hemos definido en el archivo de configuración. Para eso utilizamos el comando ```docker compose up```. Lo recomendable es utilizar también el parámetro ``-d``, ya que así lo ejecutamos sin que nuestra terminal quede vinculado y podemos seguir operando con ella.

Vamos a lanzar nuestro escenario de Wordpress:

```bash
eth3rup@debian:~$ docker compose up -d
+] Running 31/2
 ✔ web 21 layers [⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]      0B/0B      Pulled          102.7s 
 ✔ db 8 layers [⣿⣿⣿⣿⣿⣿⣿⣿]      0B/0B      Pulled                          96.5s 
[+] Running 4/4
 ✔ Network eth3rup_lan1     Created                                     1.1s 
 ✔ Volume "eth3rup_data"    Created                                     0.1s 
 ✔ Container eth3rup-db-1   Started                                     1.4s 
 ✔ Container eth3rup-web-1  Started                                     0.1s 
```
Una vez finalizado el despliegue, podemos comprobar que todos los objetos definidos en nuestro docker-compose.yml han sido creados y los contenedores están en ejecución:

```bash
eth3rup@debian:~$ docker network list
NETWORK ID     NAME              DRIVER    SCOPE
5dce7c28d72a   bridge            bridge    local
ce2870c7e71b   host              host      local
28bc6c3d411b   eth3rup_lan1      bridge    local
a4aa408b62eb   mired1            bridge    local
d15815d2f0d7   none              null      local

eth3rup@debian:~$ docker volume list
DRIVER    VOLUME NAME
local     eth3rup_data

eth3rup@debian:~$ docker container list
CONTAINER ID   IMAGE             COMMAND                  CREATED              STATUS              PORTS                                   NAMES
b19cf2a496ae   wordpress:6.3.2   "docker-entrypoint.s…"   About a minute ago   Up About a minute   0.0.0.0:8080->80/tcp, :::8080->80/tcp   eth3rup-web-1
6e2583294181   mariadb:11.0      "docker-entrypoint.s…"   About a minute ago   Up About a minute   3306/tcp                                eth3rup-db-1
```

Si accedemos a la IP asignada al contenedor de WordPress, tendremos ya levantado el servicio, listo para los primeros pasos de su instalación.

[![mg06-wp.png](https://i.postimg.cc/fb1wHcC8/mg06-wp.png)](https://postimg.cc/jWQ02JGf)

Si se detuviera Docker, al volver a iniciarlo nos encontraríamos con que los contenedores no se inician automáticamente. Para volver a levantarlos, utilizaríamos de nuevo la orden ``docker compose up -d``.

```bash
eth3rup@debian:~$ docker compose up -d
[+] Running 2/2
 ✔ Container eth3rup-db-1   Started                                                                                                     0.3s 
 ✔ Container eth3rup-web-1  Started                                                                                                     0.2s
```

Para no tener que preocuparse por esto, se puede definir en el archivo de configuración de los contenedores que se quieran "auto-levantar" la línea

```restart: always```

Si volviésemos a ejecutar la orden ``docker compose up -d`` nos encontraríamos con el siguiente resultado:

```bash
eth3rup@debian:~$ docker compose up -d
[+] Running 2/0
 ✔ Container eth3rup-db-1   Running                                                                                                     0.0s 
 ✔ Container eth3rup-web-1  Running                                                                                                     0.0s
```

Como sucedía con _Dockerfile_, la ejecución de ``docker compose up`` sólo produce "cambios" si hubiera alguna modificación sobre los elementos que hemos definido en _docker-compose.yml_.

Otra cuestión importante que vemos a la hora de levantar el escenario es que a los nombres de los contenedores, redes y volúmenes que hemos establecido en el archivo de configuración se **les ha añadido el prefijo del directorio de trabajo** (es decir, nuestro contexto). Esto es así porque cada proyecto tiene su propio espacio de nombres para servicios, volúmenes y redes, lo que evita la colisión de nombres.

Si deseamos forzar a usar un nombre sin que tenga este prefijo, debemos especificarlo en el archivo de configuración. Así, para nuestro ejemplo, quedaría como se muestra a continuación:

```yaml
version: '3.1'

services:
    db:
        image: mariadb:11.0
        container_name: midb
        restart: always
        volumes:
            - data:/var/lib/mysql
        environment:
            - MYSQL_ROOT_PASSWORD=pass.de.root
            - MYSQL_DATABASE=wordpress
            - MYSQL_USER=manager
            - MYSQL_PASSWORD=pass.de.manager
        networks:
            - lan1
    web:
        image: wordpress:6.3.2
        container_name: miwp
        restart: always
        depends_on:
            - db
        volumes:
            - ./wp:/var/www/html
        environment:
            - WORDPRESS_DB_USER=manager
            - WORDPRESS_DB_PASSWORD=pass.de.manager
            - WORDPRESS_DB_HOST=db
        networks:
            - lan1
        ports:
            - 8080:80
networks:
    lan1:
        driver: bridge
        name: lan1
volumes:
    data:
        name: data
```
Si volvemos a ejecutar ``docker compose up -d`` de este escenario "optimizado" obtendríamos lo siguiente:

```bash
eth3rup@debian:~$ docker compose up -d
[+] Running 6/6
 ✔ Network lan1               Created                                                                                                      2.2s 
 ✔ Volume "data"              Created                                                                                                      0.0s
 ✔ Container eth3rup-db-1   Recreated                                                                                                   5.8s 
 ✔ Container eth3rup-web-1  Recreated                                                                                                   2.4s 
 ✔ Container midb              Started                                                                                                     3.1s 
 ✔ Container miwp              Started                                                                                                     1.8s
```

Al consultar los objetos, veremos que ha generado una red nueva ``lan1`` y un volumen nuevo ``data``, y también que ha eliminado los contenedores originales para crear los contenedores con los nombres ``midb`` y ``miwp``. Como el servicio de WordPress estaba montado en un volumen no persistente, al eliminar el contenedor se ha eliminado la información asociada, por lo que deberemos volver a hacer una instalación nueva de WordPress.

###### Detener el escenario
Si necesitamos detener todos los servicios (contenedores) que forman parte del escenario definido en ``docker-compose.yml`` podemos hacerlo a través del comando ``docker compose stop``, que tiene la siguiente sintaxis:


``docker compose stop  [OPCIONES] [SERVICIO]``

Para nuestro caso, sería así...

```bash
eth3rup@debian:~$ docker compose stop
[+] Stopping 2/2
 ✔ Container miwp   Stopped                                                                                                     3.9s 
 ✔ Container midb   Stopped                                                                                                     1.9s
```

Como se aprecia en la sintaxis del comando, también habría sido posible detener servicios de forma selectiva. Esto es especialmente útil cuando el escenario está compuesto por un número considerable de servicios y no queremos detenerlos todos. En este sentido, el comando ``docker compose stop [SERVICIO]`` podría pensarse que es equivalente al comando ``docker container stop [CONTENEDOR]``. Sin embargo, hay un matiz importante, y es que **``docker compose stop [SERVICIO]`` nos garantiza que la parada se hará de forma coherente y ajustada a las configuraciones definidas en el archivo de configuración.** Así, en nuestro caso, puesto que el servicio web depende del servicio de base de datos, los detendrá en orden: primero el servicio web y después el de base de datos. Este orden es el inverso al que se utilizó en la creación; eso es, el inverso al definido en el ``docker-compose.yml``.

**La detención también afecta a los volúmenes y redes** que estén implicados, asegurando que no se eliminen los volúmenes persistentes y que las conexiones de red se limpien y no dejen redes huérfanas. 

###### Iniciar el escenario
Si necesitamos volver a ejecutar todos los servicios (contenedores) que forman parte del escenario definido en ``docker-compose.yml`` podemos hacerlo a través del comando ``docker compose start``, que tiene la siguiente sintaxis:


``docker compose start  [OPCIONES] [SERVICIO]``

Para nuestro caso, sería así...

```bash
eth3rup@debian:~$ docker compose start
[+] Stopping 2/2
 ✔ Container midb   Started                                                                                                     3.9s 
 ✔ Container miwp   Started                                                                                                     1.9s
```

> **👉 A tener en cuenta...**
>
> El comando ```docker compose start``` funciona para servicios definidos en el archivo de configuración que han sido previamente parados (ya sea "accidentalmente" o mediante la orden  ```docker compose stop```). Es decir, los contenedores deben existir. De no ser así, la orden a utilizar debería ser ``docker compose up``.

Al igual que comentamos en el apartado anterior, podría pensarse en una equivalencia entre los comandos ``docker compose start [SERVICIO]`` y ``docker container start [CONTENEDOR]``. Sin embargo, el uso de **``docker compose start [SERVICIO]`` nos garantiza que el arranque se hará de forma coherente y ajustada a las configuraciones definidas en el archivo de configuración.**
 
###### Eliminar el escenario
Cuando ya no necesitemos el escenario, podemos eliminarlo haciendo uso del comando ``docker compose down``. Este comando se encargará de detener los servicios para eliminarlos si éstos estuvieran en ejecución, como se puede ver a continuación:

```bash
eth3rup@debian:~$ docker compose down
[+] Running 3/3
 ✔ Container miwp  Removed                                                                                                                 1.6s 
 ✔ Container midb  Removed                                                                                                                 0.7s 
 ✔ Network lan1    Removed                                                                                                                 0.5s
 ```

Si se diera el caso de querer eliminar también los volúmenes persistentes definidos en el archivo de configuración, se deberá ejecutar el comando con el parámetro ``-v``.

```bash
eth3rup@debian:~$ docker compose down -v
[+] Running 4/4
 ✔ Container miwp  Removed                                                                                                                 1.5s 
 ✔ Container midb  Removed                                                                                                                 0.7s 
 ✔ Volume data     Removed                                                                                                                 0.0s 
 ✔ Network lan1    Removed                                                                                                                 0.5s
 ```

Si sólo queremos eliminar los servicios (contenedores) de nuestro escenario, manteniendo el resto, usaríamos el comando ``docker compose rm``. En realidad el comando elimina los servicios detenidos, por lo que si tenemos servicios activos, tendremos que forzar su parada previa con el parámetro ``-s``.

Así, para el escenario que hemos venido utilizando quedaría como sigue...

```bash
eth3rup@debian:~$ docker compose rm -s
[+] Stopping 2/2
 ✔ Container miwp  Stopped                                                                                                                 1.5s 
 ✔ Container midb  Stopped                                                                                                                 0.8s 
? Going to remove miwp, midb Yes
[+] Removing 2/0
✔ Container midb  Removed                                                                                                                  0.0s 
 ✔ Container miwp  Removed                                                                                                                 0.0s
```
Es importante tener en cuenta que la operación ha eliminado sólo los servicios. Las redes y los volúmenes se mantienen, como se puede observar:

```bash
eth3rup@debian:~$ docker network list
NETWORK ID     NAME              DRIVER    SCOPE
5dce7c28d72a   bridge            bridge    local
ce2870c7e71b   host              host      local
28bc6c3d411b   eth3rup_lan1      bridge    local
a4aa408b62eb   mired1            bridge    local
536110a74fb1   lan1              bridge    local
d15815d2f0d7   none              null      local

eth3rup@debian:~$ docker volume list
DRIVER    VOLUME NAME
local     data
local     eth3rup_data

eth3rup@debian:~$ docker container list
CONTAINER ID   IMAGE             COMMAND                  CREATED              STATUS              PORTS                                   NAMES
```

##### Optimización de las variables de entorno

El uso de las variables de entorno en _Docker Compose_ es muy interesante. Hasta ahora sabemos que podemos definir variables de entorno para nuestros servicios en el archivo ``docker-compose.yml`` usando el campo ``environment``. El ámbito de estas variables será el servicio para el que han sido definidas. Por ejemplo...

```yaml
    web:
        image: wordpress:6.3.2
        container_name: miwp
        restart: always
        depends_on:
            - db
        volumes:
            - ./wp:/var/www/html
        environment:
            - WORDPRESS_DB_USER=manager
            - WORDPRESS_DB_PASSWORD=pass.de.manager
            - WORDPRESS_DB_HOST=db
        networks:
            - lan1
        ports:
            - 8080:80
```

En el caso de que no se desee pasar las variables con sus valores en el archivo ``docker-compose.yaml``, es posible derivar la consulta a un archivo externo. Por ejemplo, tendríamos un archivo ``variables-miwp.env`` con las variables...

```bash
variables-miwp.env
 WORDPRESS_DB_USER=manager
 WORDPRESS_DB_PASSWORD=pass.de.manager
 WORDPRESS_DB_HOST=db
```

...y después lo referenciaríamos en el ``docker-compose.yml``

```yaml
    web:
        image: wordpress:6.3.2
        container_name: miwp
        restart: always
        depends_on:
            - db
        volumes:
            - ./wp:/var/www/html
        env_file:
            - variables-miwp.env
        networks:
            - lan1
        ports:
            - 8080:80
```

También es posible utilizar variables de entorno de nuestro host. Esto nos va a ayudar mucho a manipular nuestros escenarios, ya que nos permitirá parametrizar partes del archivo ``docker-compose.yml`` para que no sea necesario modificarlo. Para utilizar estas variables se emplea la misma sintaxis que en ``bash``. 

Vamos a ver unos ejemplos:
 * Utilizamos una variable de entorno del sistema ``PWD``, de forma que ``${PWD}`` estaría devolviendo la ruta del directorio en el que nos encontramos.
 * Utilizamos una variable que hemos definido nosotros previamente en el sistema llamada ``VERSION``, por lo que ``${VERSION}`` nos devolvería el valor que le hubiéramos dado a esa variable.
 * Utilizamos un valor por defecto, para cubrir el caso de que la variable no esté definida o su valor sea nulo. De esta manera, ``${VERSION:-6.3.2}`` evaluaría si existe la variable ``VERSION``; si no existe o tiene un valor nulo, se le asignaría el valor ``'6.3.2'`` y en caso contrario se usaría el valor que tuviera definido.

 Aplicados estos ejemplos, podríamos obtener algo como esto:

 ```yaml
    web:
        image: wordpress:${VERSION:-6.3.2}
        container_name: miwp
        restart: always
        depends_on:
            - db
        volumes:
            - ${PWD}/wp:/var/www/html
        env_file:
            - variables-miwp.env
        networks:
            - lan1
        ports:
            - 8080:80
```