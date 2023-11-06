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
