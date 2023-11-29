## Configuração BD:<br />

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
