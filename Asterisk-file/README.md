# Repositório de instalção do Asterisk 20LTS no Debin 12


## Instalação:<br/>

**-> Acessar como root**<br/> 
```
apt update && apt upgrade -y
apt install curl -y
```

- Arquivos de configuração e scripts sh de instalação:<br/>
``` 
cd /tmp/ && curl -fsSL https://github.com/dnsrodrigues/asterisk/releases/download/config-asterisk/asterisk.tar -o asterisk.tar && tar xvf asterisk.tar 
```

```
cd /tmp/sh
bash 1-terminal_custom.sh
bash 2-install_asterisk.sh
bash 3-cleanfiles_asterisk.sh
bash 4-setup_mysql_asterisk.sh

OR

bash 9-install_completa.sh
```

- #[Configuração do BD](https://github.com/dnsrodrigues/asterisk/blob/main/Asterisk-file/Configuração BD.md)<br />

- #[Configuração do Asterisk](https://github.com/dnsrodrigues/Asterisk-20LTS/blob/main/configuracao_de_arq_asterisk.md)<br/>
