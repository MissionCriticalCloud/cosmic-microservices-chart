{{- define "configmaps.init-container-files.readiness-probe.sh" -}}
#!/bin/sh

if [ -n "$1" ]; then host=$1; else host='localhost'; fi
if [ -n "$2" ]; then port=$2; else port=80; fi
if [ -n "$3" ]; then path=$3; else path='/'; fi
if [ -n "$4" ]; then statusCode=$4; else statusCode=200; fi
if [ -n "$5" ]; then initialDelaySeconds=$5; else initialDelaySeconds=0; fi
if [ -n "$6" ]; then timeoutSeconds=$6; else timeoutSeconds=10; fi
if [ -n "$7" ]; then periodSeconds=$7; else periodSeconds=10; fi
if [ -n "$8" ]; then failureThreshold=$8; else failureThreshold=3; fi

protocol='HTTP/1.1'

sleep $initialDelaySeconds
attemps=1
while [[ $attemps -le $failureThreshold ]]; do
  if printf "GET %s %s\nHost: %s\n\n" $path $protocol $host | nc $host $port -w $timeoutSeconds | grep -Fqs "$protocol $statusCode"; then
    exit 0
  else
    if [ $attemps -lt $failureThreshold ]; then sleep $periodSeconds; fi
    ((attemps++))
  fi
done

exit 1
{{- end -}}
