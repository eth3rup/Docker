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

Este comando también permite filtrar la información para obtener sólo los datos que nos interesen haciendo uso del parámetro ```-p``` y de la ubicación del campo en la taxonomía del reporte JSON. Por ejemplo, si quisiéramos conocer la IP que tiene el contenedor en la red de Docker (hablaremos de ella más adelante), usaríamos la expresión ```-f '{{.NetworkSettings.IPAddress}}```:

```bash
eth3rup@debian:~$ docker container inspect -f '{{.NetworkSettings.IPAddress}} ab0b901e7e27
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

Gestión de imágenes
===============================================================================================================================
Hasta ahora hemos visto cómo podemos trabajar con contenedores a partir de imágenes ya existentes. Ahora daremos un paso más y empezaremos a crear nuestras propias imágenes.

#### Generar una imagen en Docker
A la hora de generar una imagen en Docker deberemos tener en cuenta dos elementos esenciales: 

* El archivo ***Dockerfile***, que va a contener toda la información necesaria para generar la imagen.
* El comando ```Docker build```, que se encargará de interpretar ese archivo y construir la imagen.

##### El archivo *Dockerfile*
La redacción del archivo Dockerfile es la clave para la creación de la imagen. Hay una amplia variedad de instrucciones para incluir en este archivo (puedes consultarlas todas en la [Documentación oficial de Docker](https://docs.docker.com/engine/reference/builder/)).

Para introducirnos en la redacción de este archivo, vamos a comenzar con un ejemplo muy sencillo en el que crearemos una imagen para una aplicación web que queremos desarrollar en Python con Flask.


> **⚠️ A tener en cuenta...**
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


Una primera aproximación al archivo Dockerfile sería la siguiente:

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

> **⚠️ A tener en cuenta...**
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
1) Que el tamaño del contenedor no aumente, y así sea más manejable.
2) Que se mantengan datos con independencia del contenedor.
* ``COPY . /miapp``
Añade archivos en la imagen desde un lugar externo (nuestro equipo u otro lugar).
* ``RUN pip install -r requisitos.txt``
Ejecuta una orden. En este caso, instala los paquetes que he recogido en el archivo ```requisitos.txt```, el cual he copiado a la imagen en el paso anterior.
* ``ENTRYPOINT ["python"]``
Ejecuta el comando.
* ``CMD ["miapp.py"]``
La orden ```CMD``` tiene un funcionamiento similar a ```ENTRYPOINT```. Sin embargo, cuando van combinadas, ```CMD``` actúa como los parámetros que llevaría la orden lanzada por ```ENTRYPOINT```. En este caso, se ejecutaría la sentencia ```python miapp.py```

```bash
eth3rup@debian:~$ docker build -t appflask .
[+] Building 39.4s (11/11) FINISHED                              docker:default
 => [internal] load build definition from Dockerfile                       0.2s
 => => transferring dockerfile: 286B                                       0.2s
 => [internal] load .dockerignore                                          0.1s
 => => transferring context: 2B                                            0.0s
 => [internal] load metadata for docker.io/library/ubuntu:latest           1.7s
 => [1/6] FROM docker.io/library/ubuntu:latest@sha256:2b7412e6465c3c7fc5b  0.0s
 => [internal] load build context                                         14.0s
 => => transferring context: 92.04MB                                      13.2s
 => CACHED [2/6] RUN apt-get update -y                                     0.0s
 => CACHED [3/6] RUN apt-get install -y python3-pip python-dev-is-python3  0.0s
 => CACHED [4/6] WORKDIR /miapp                                            0.0s
 => [5/6] COPY . /miapp                                                   12.1s
 => [6/6] RUN pip install -r requisitos.txt                                7.6s
 => exporting to image                                                     3.3s 
 => => exporting layers                                                    3.2s 
 => => writing image sha256:f2f451ec30fbd463526bf64de5b549b499089666a73d2  0.0s 
 => => naming to docker.io/library/appflask                                0.0s
 ```

Si consultamos nuestro repositorio de imágenes, podremos observar que se ha creado satisfactoriamente:

```bash
eth3rup@debian:~$ docker image list -a
REPOSITORY   TAG       IMAGE ID       CREATED         SIZE
appflask     latest    f2f451ec30fb   24 seconds ago   604MB
```

...y ya podremos correr un contenedor basado en esta imagen:

```bash
eth3rup@debian:~$ docker container run --name app1 -it -p 5000:5000 -d appflask
55c3e2b64486c11706b5f240a6d2d191a2102558bc7b6ec873faf798ddf0d960
```

[![img03-appflask.png](https://i.postimg.cc/wTYTTj2h/img03-appflask.png)](https://postimg.cc/Dm5KxFtZ)


#### Importar imágenes de Docker Hub
Para cre
#### Exportar imágenes a Docker Hub
Para cre
#### Listar imágenes en Docker
Para cre

#### Listar imágenes en Docker
Para cre
