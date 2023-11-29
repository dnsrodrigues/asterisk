#!/bin/bash

echo -e "\e[1;36mINICIANDO INSTALAÇÃO, APERTE ENTER\e[0m"
read -p ""

echo -e "\e[1;35m#\e[0m"
echo -e "\e[1;35m#\e[0m"
echo -e "\e[1;35mCUSTOMIZAÇÕES DE TERMINAL E LOG\e[0m"
## customizações de terminal e log
apt install wget vim atop htop nmap whowatch mtr htop rsync acl locate ethtool screen lshw hdparm ttyrec tcpdump auditd sudo openssh-server libsox-fmt-base dialog unzip autoconf -y

echo -e "\e[1;35m#\e[0m"
echo -e "\e[1;35m#\e[0m"
echo -e "\e[1;35mEDITAR PERMISSÃO DE ACESSO ROOT SSH\e[0m"
## editar permição de acesso root SSH
nano /etc/ssh/sshd_config

echo -e "\e[1;35m#\e[0m"
echo -e "\e[1;35m#\e[0m"
echo -e "\e[1;35mRESETAR SSH\e[0m"
## resetar ssh
sudo service ssh restart


echo -e "\e[1;35m#\e[0m"
echo -e "\e[1;35m#\e[0m"
echo -e "\e[1;36mCOMEÇAR A INSTALAR O ASTERISK, ENTER PARA CONTINUAR\e[0m"
read -p ""

## ambiente de produção - Asterisk 20
set -ueo pipefail

# Atualiza o sistema
DEBIAN_FRONTEND=noninteractive apt-get update -qq
DEBIAN_FRONTEND=noninteractive apt-get upgrade -y -qq

# Instala dependências
DEBIAN_FRONTEND=noninteractive apt-get install -y -qq --no-install-recommends \
  odbc-postgresql aptitude mpg123 sox make gcc g++ unixodbc unixodbc-dev wget \
  iputils-ping vim autoconf binutils-dev build-essential ca-certificates curl \
  ffmpeg figlet automake sudo file libcurl4-openssl-dev libedit-dev libgsm1-dev \
  libogg-dev libpopt-dev libresample1-dev libspandsp-dev libspeex-dev \
  libspeexdsp-dev libsqlite3-dev libsrtp2-dev libssl-dev libvorbis-dev \
  libxml2-dev libxslt1-dev lsof tcpdump iftop odbcinst portaudio19-dev procps \
  uuid uuid-dev xmlstarlet bzip2 subversion git cmake libtool libpcap-dev

# Remove pacotes não necessários
apt-get purge -y -qq --auto-remove

# Limpa o cache de pacotes
rm -rf /var/lib/apt/lists/*

# Cria diretório e baixa o código-fonte do Asterisk 20
mkdir -p /usr/src/asterisk
cd /usr/src/asterisk
curl -sL http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-20-current.tar.gz | tar --strip-components 1 -xz

# Executa o ./configure
./configure --prefix=/usr --libdir=/usr/lib --with-pjproject-bundled --with-jansson-bundled --with-resample --with-ssl=ssl --with-srtp

# Compila e instala o Asterisk
make -j$(nproc) all
make install
make samples
ldconfig

# Criação de usuários e permissões
groupadd asterisk
useradd -r -d /var/lib/asterisk -g asterisk asterisk
usermod -aG audio,dialout asterisk
chown -R asterisk.asterisk /etc/asterisk /var/{lib,log,spool}/asterisk /usr/lib/asterisk
chmod -R 750 /var/spool/asterisk

# Limpa o diretório de codecs
rm -rf /usr/src/codecs

# Remove pacotes de desenvolvimento
DEVPKGS="$(dpkg -l | grep '\-dev' | awk '{print $2}' | xargs)"
DEBIAN_FRONTEND=noninteractive apt-get purge --yes -qq \
  autoconf build-essential bzip2 cpp m4 make patch perl perl-modules pkg-config xz-utils ${DEVPKGS}

# Limpa o cache de pacotes novamente
rm -rf /var/lib/apt/lists/*

echo "Instalação concluída com sucesso!"

echo -e "\e[1;35m#\e[0m"
echo -e "\e[1;35m#\e[0m"
echo -e "\e[1;36mLIMPAR ARQUIVOS DESNECESSÁRIOS DA INSTALAÇÃO DO ASTERISK, ENTER PARA CONTINUAR\e[0m"
read -p ""

##clean files, not used 
echo "" > /etc/asterisk/func_odbc.conf
echo "" > /etc/asterisk/cdr_pgsql.conf
echo "" > /etc/asterisk/cdr_odbc.conf 
echo "" > /etc/asterisk/cdr_manager.con
echo "" > /etc/asterisk/cdr_custom.conf
echo "" > /etc/asterisk/cdr_beanstalkd.conf
echo "" > /etc/asterisk/cel_custom.conf
echo "" > /etc/asterisk/cel_pgsql.conf

echo -e "\e[1;35m#\e[0m"
echo -e "\e[1;35m#\e[0m"
echo -e "\e[1;36mINSTALAR O MYSQL, ENTER PARA CONTINUAR\e[0m"
read -p ""

##install mysql for asterisk20lts, fazer manualmente.

cd /

##Fazer update
apt update

##Instalar Mariadb
apt install -y unixodbc odbcinst mariadb-client mariadb-server odbc-mariadb

##Desabilitar Mariadb
systemctl enable mariadb

##Start Mariadb
systemctl start mariadb

##Instalar python3-pip
apt install python3-pip -y

##Instalar python3.11-venv
apt install python3.11-venv -y

##Criar ambiente virual venv
python3 -m venv venv

##Ativar ambiente virual venv
. /venv/bin/activate

##Instalar alembic
pip install alembic

##Instalar psycopg2-binary
pip install psycopg2-binary

##Instalar mysql-connector-python
pip install mysql-connector-python

##Instalar python3-pymysql
apt install python3-pymysql/stable python3-mysqldb/stable -y

##Instalar python3-dev
apt-get install python3-dev default-libmysqlclient-dev build-essential -y

##Instalar mysqlclient
pip install mysqlclient

##Instalar importlib_metadata==1.5.2
pip install "importlib_metadata==1.5.2"

##Instalar zipp==1.2.0
pip install "zipp==1.2.0"

##Instalar configparser==3.8.1
pip install "configparser==3.8.1"

##Instalar phpmyadmin e apache2
apt install phpmyadmin -y

##Restart no apache
systemctl restart apache2

##Instalar o php
apt install php8.*-mysqli

##Restart no apache
systemctl restart apache2

##Renomeando arquivo de configuração
cd /usr/src/asterisk/contrib/ast-db-manage
mv config.ini.sample config.ini

##Configurando parametros do MariaDB como senha
/usr/bin/mysql_secure_installation

echo -e "\e[1;32mINSTALAÇÃO FINALIZADA COM SUCESSO........\e[0m"
