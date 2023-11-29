## Configuração BD:<br />

- Acessando o banco de dados:
``` 
mysql -u root 
```
<br/>

- Criando usuário e senha para o banco de dados:
``` 
CREATE USER 'asterisk'@'localhost' IDENTIFIED BY '123456';
CREATE DATABASE asterisk;
GRANT ALL privileges on asterisk.* to 'asterisk'@'localhost' identified by '123456';
FLUSH privileges;
quit; 
```
<br/>

- Configurando o arquivo config.ini usuario e senha do banco de dados:
```
vim /usr/src/asterisk/contrib/ast-db-manage/config.ini
```
<br/>

- Configurando o arquivo alembic.ini:
```
. /venv/bin/activate

cd /usr/src/asterisk/contrib/ast-db-manage
alembic -c config.ini upgrade head
```
<br/>

- Acessando o banco de dados:
```
mysql -u asterisk -p
```
<br/>

- Verificando se o banco de dados foi criado:
```
show databases;
use asterisk;
show tables;
quit;
```
<br/>

- Criando usuário e senha para o banco de dados phpmyadmin:
```
mysql -u root -p

show databases;
use phpmyadmin;
CREATE USER 'user'@'localhost' IDENTIFIED BY '123456';
grant all on phpmyadmin.*to user@localhost;
FLUSH privileges;
quit;
```
<br/>

- Acessar BD pelo phpmyadmin:
```
ip-da-maquina/phpmyadmin (no navegador)
```
<br/>

- Criar tabela faltante:
```
CREATE TABLE `queue_log` (
  `id` bigint(255) unsigned NOT NULL AUTO_INCREMENT,
  `time` varchar(26) NOT NULL DEFAULT '',
  `callid` varchar(40) NOT NULL DEFAULT '',
  `queuename` varchar(20) NOT NULL DEFAULT '',
  `agent` varchar(20) NOT NULL DEFAULT '',
  `event` varchar(20) NOT NULL DEFAULT '',
  `data` varchar(100) NOT NULL DEFAULT '',
  `data1` varchar(40) NOT NULL DEFAULT '',
  `data2` varchar(40) NOT NULL DEFAULT '',
  `data3` varchar(40) NOT NULL DEFAULT '',
  `data4` varchar(40) NOT NULL DEFAULT '',
  `data5` varchar(40) NOT NULL DEFAULT '',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `queue` (`queuename`),
  KEY `event` (`event`)
) DEFAULT CHARSET=utf8
```
