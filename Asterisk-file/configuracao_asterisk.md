## Configuração Asterisk:<br />

- Mover arquivos de configuração para os diretorios corretos:
``` 
cd /tmp/
mv asterisk/*.conf /etc/asterisk/
rm -rf asterisk.tar
rm -rf asterisk/
``` 
<br/>

- Criar um arquivo de inicialização do Asterisk "asterisk.service" e colar o arquivo no caminho /etc/systemd/system/ com o conteudo a baixo:
``` 
[Unit]
Description=Asterisk PBX and telephony daemon
After=network.target

[Service]
Type=forking
PIDFile=/var/run/asterisk/asterisk.pid
ExecStart=/usr/sbin/asterisk -C /etc/asterisk/asterisk.conf
ExecReload=/bin/kill -HUP $MAINPID
ExecStop=/bin/kill -TERM $MAINPID

[Install]
WantedBy=multi-user.target
``` 
<br/>

- Recarregue os serviços do systemd para reconhecer as alterações e inicie o serviço do Asterisk:
``` 
systemctl daemon-reload
systemctl start asterisk
``` 
<br/>

- Habilite o serviço para iniciar automaticamente no boot:
``` 
systemctl enable asterisk
``` 
<br/>

- Agora, verifique o status do serviço:
``` 
systemctl status asterisk
``` 
<br/>

- entrar no CLI do Asterisk e ver o log de erros:
``` 
asterisk -rvvv
core reload
``` 
<br/>

- Configurar os arquivos no caminho /etc/asterisk pjsip.conf:
<br/>

- Configurar arquivo no caminho /etc/asterisk extensions.conf:
<br/>

- Dar um restart no Asterisk:
``` 
asterisk -rvvv
core restart now
``` 
<br/>

- Configurar arquivo log full ativar a opção full.log e dar um restart no asterisk:
``` 
vim /etc/asterisk/logger.conf
``` 
<br/>

- Restart no asterisk:
``` 
systemctl restart asterisk.service
``` 
<br/>

- Visualizar log full:
``` 
less /var/log/asterisk/full.log
``` 
<br/>

- Colocar os audios em pt-br, criar diretorio em:
``` 
mkdir /var/lib/asterisk/sounds/pt-br
``` 
<br/>

- baixar e descompactar os arquivos no diretorio criado:
``` 
cd /var/lib/asterisk/sounds/pt-br
curl -sLO https://www.asterisksounds.org/sites/asterisksounds.org/files/sounds/pt-BR/download/asterisk-sounds-core-pt-BR-3.8.3.zip && unzip -q asterisk-sounds-core-pt-BR-3.8.3.zip
curl -sLO https://www.asterisksounds.org/sites/asterisksounds.org/files/sounds/pt-BR/download/asterisk-sounds-extra-pt-BR-1.11.10.zip && unzip -q asterisk-sounds-extra-pt-BR-1.11.10.zip
``` 
<br/>

- Excluir os arquivos zip baixados após extração:
``` 
cd /var/lib/asterisk/sounds/pt-br
rm asterisk-sounds-core-pt-BR-3.8.3.zip
rm asterisk-sounds-extra-pt-BR-1.11.10.zip
``` 
<br/>

- Alterar a permissão da pasta:
``` 
find /var/lib/asterisk//sounds//pt-br/ -type d -exec chmod 0775 {} \;
``` 
<br/>

- Converter formato de todos os audios para o formato dos codecs necessarios:
``` 
wget https://raw.githubusercontent.com/dnsrodrigues/asterisk/main/Asterisk-file/02%20-%20arquivos-config-asterisk/%23arquivos-config/convert.sh ; bash convert.sh
``` 
