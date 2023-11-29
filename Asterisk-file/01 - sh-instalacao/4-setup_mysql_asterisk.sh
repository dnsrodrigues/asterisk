#!/bin/bash
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

##Acessando o banco de dados
# mysql -u root

##Criando usuário e senha para o banco de dados
# '''
# CREATE USER 'asterisk'@'localhost' IDENTIFIED BY '123456';
# CREATE DATABASE asterisk;
# GRANT ALL privileges on asterisk.* to 'asterisk'@'localhost' identified by '123456';
# FLUSH privileges;
# quit;
# '''

##Configurando o arquivo config.ini usuario e senha do banco de dados
# vim /usr/src/asterisk/contrib/ast-db-manage/config.ini

##Configurando o arquivo alembic.ini
# cd /usr/src/asterisk/contrib/ast-db-manage
# alembic -c config.ini upgrade head

##Acessando o banco de dados
# mysql -u asterisk -p

##Verificando se o banco de dados foi criado
# '''
# show databases;
# use asterisk;
# show tables;
# quit;
# '''

##Criar tabela faltante
# '''
# CREATE TABLE `queue_log` (
#   `id` bigint(255) unsigned NOT NULL AUTO_INCREMENT,
#   `time` varchar(26) NOT NULL DEFAULT '',
#   `callid` varchar(40) NOT NULL DEFAULT '',
#   `queuename` varchar(20) NOT NULL DEFAULT '',
#   `agent` varchar(20) NOT NULL DEFAULT '',
#   `event` varchar(20) NOT NULL DEFAULT '',
#   `data` varchar(100) NOT NULL DEFAULT '',
#   `data1` varchar(40) NOT NULL DEFAULT '',
#   `data2` varchar(40) NOT NULL DEFAULT '',
#   `data3` varchar(40) NOT NULL DEFAULT '',
#   `data4` varchar(40) NOT NULL DEFAULT '',
#   `data5` varchar(40) NOT NULL DEFAULT '',
#   `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
#   PRIMARY KEY (`id`),
#   KEY `queue` (`queuename`),
#   KEY `event` (`event`)
# ) DEFAULT CHARSET=utf8
# '''

##Criando usuário e senha para o banco de dados phpmyadmin
# mysql -u root -p

# '''
# show databases;
# use phpmyadmin;
# CREATE USER 'user'@'localhost' IDENTIFIED BY '123456';
# grant all on phpmyadmin.*to user@localhost;
# FLUSH privileges;
# quit;
# '''

##Acessar BD pelo phpmyadmin
# ip-da-maquina/phpmyadmin (no navegador)
