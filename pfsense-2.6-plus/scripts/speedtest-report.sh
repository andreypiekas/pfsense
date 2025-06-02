#!/bin/sh

DIRECTORYREPORT="/usr/local/www/speedtest"
INTERFACE01="vtnet1"

SOURCE01=$(/sbin/ifconfig $INTERFACE01 | grep -w inet | sed -e 's/^[[:space:]]*//' | cut -d ' ' -f2)
DESCRIPTION01=$(/sbin/ifconfig $INTERFACE01 | grep -w description | sed -e 's/^[[:space:]]*//' | cut -d ' ' -f2)
PAGEREPORT01="$INTERFACE01.html"

if [ -d "$DIRECTORYREPORT" ]; then
  echo "Diretório: $DIRECTORYREPORT - OK"
else
  /bin/mkdir "$DIRECTORYREPORT"
  echo "Diretório: $DIRECTORYREPORT criado com sucesso!!!"
fi

if [ -f "$DIRECTORYREPORT/$PAGEREPORT01" ]; then
  echo "Arquivo $DIRECTORYREPORT/$PAGEREPORT01 - OK"
else
  /usr/local/bin/speedtest-cli --csv-header > "$DIRECTORYREPORT/$PAGEREPORT01"
  echo "Arquivo $DIRECTORYREPORT/$PAGEREPORT01 criado com sucesso!!!"
fi

/usr/local/bin/speedtest-cli --secure --source=$SOURCE01 --csv >> "$DIRECTORYREPORT/$PAGEREPORT01"
echo "Relatório do SpeedTest gerado com sucesso em: $DIRECTORYREPORT/$PAGEREPORT01"
