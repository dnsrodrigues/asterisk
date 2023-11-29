#!/bin/bash

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
