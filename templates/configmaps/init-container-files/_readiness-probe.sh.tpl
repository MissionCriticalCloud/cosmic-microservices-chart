{{- define "configmaps.init-container-files.readiness-probe.sh" -}}
#!/bin/sh
set -x
if [ -n "$1" ]; then host=$1; else host='localhost'; fi
if [ -n "$2" ]; then port=$2; else port=80; fi
if [ -n "$3" ]; then path=$3; else path='/'; fi
if [ -n "$4" ]; then statusCode=$4; else statusCode=200; fi
if [ -n "$5" ]; then headers=$5; else headers=''; fi
if [ -n "$6" ]; then initialDelaySeconds=$6; else initialDelaySeconds=0; fi
if [ -n "$7" ]; then timeoutSeconds=$7; else timeoutSeconds=10; fi
if [ -n "$8" ]; then periodSeconds=$8; else periodSeconds=10; fi
if [ -n "$9" ]; then failureThreshold=$9; else failureThreshold=3; fi

protocol='HTTP/1.1'

sleep $initialDelaySeconds
attemps=1
while [[ $attemps -le $failureThreshold ]]; do
  if printf "GET %s %s\nHost: %s\n%s\n\n" $path $protocol $host "$headers" | nc $host $port -w $timeoutSeconds | grep -Fqs "$protocol $statusCode"; then
    exit 0
  else
    if [ $attemps -lt $failureThreshold ]; then sleep $periodSeconds; fi
    let "attemps=attemps+1"
  fi
done

exit 1
{{- end -}}
