#!/bin/sh
# Autor: Robson Vaamonde
# Site: www.procedimentosemti.com.br
# Facebook: facebook.com/ProcedimentosEmTI
# Facebook: facebook.com/BoraParaPratica
# YouTube: youtube.com/BoraParaPratica
# Linkedin: https://www.linkedin.com/in/robson-vaamonde-0b029028/
# Instagram: https://www.instagram.com/procedimentoem/?hl=pt-br
# Github: https://github.com/vaamonde
# Data de criação: 06/10/2022
# Data de atualização: 03/10/2022
# Versão: 0.07
# Testado e homologado para a versão do pfSense 2.6.x e Plus 22.x
# Testado e homologado para a versão do SpeedTest 2.1.x

DIRECTORYREPORT="/usr/local/www/speedtest"
INTERFACE01="vtnet1"
SOURCE01=$(/sbin/ifconfig $INTERFACE01 | /usr/bin/grep -w inet | /usr/bin/sed -e 's/^[[:space:]]*//' | /usr/bin/cut -d ' ' -f2)
DESCRIPTION01=$(/sbin/ifconfig $INTERFACE01 | /usr/bin/grep -w description | /usr/bin/sed -e 's/^[[:space:]]*//' | /usr/bin/cut -d ' ' -f2)
PAGEREPORT01="$INTERFACE01.html"

if [ -d "$DIRECTORYREPORT" ]; then
  echo -e "Diretório: $DIRECTORYREPORT - OK"
else
  /bin/mkdir $DIRECTORYREPORT
  echo -e "Diretório: $DIRECTORYREPORT criado com sucesso!!!"
fi

if [ -f "$DIRECTORYREPORT/$PAGEREPORT01" ]; then
  echo -e "Arquivo $DIRECTORYREPORT/$PAGEREPORT01 - OK"
else
  /usr/local/bin/speedtest-cli --csv-header > "$DIRECTORYREPORT/$PAGEREPORT01"
  echo -e "Arquivo $DIRECTORYREPORT/$PAGEREPORT01 criado com sucesso!!!"
fi

/usr/local/bin/speedtest-cli --secure --source=$SOURCE01 --csv >> "$DIRECTORYREPORT/$PAGEREPORT01"
echo -e "Relatório do SpeedTest gerado com sucesso em: $DIRECTORYREPORT/$PAGEREPORT01"
