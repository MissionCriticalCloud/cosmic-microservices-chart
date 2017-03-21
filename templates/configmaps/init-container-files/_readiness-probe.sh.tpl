{{- define "configmaps.init-container-files.readiness-probe.sh" -}}
#!/bin/sh
set -x

method=GET
host='localhost'
port=80
path='/'
statusCode=200
body=''
headers=''
initialDelaySeconds=0
timeoutSeconds=10
periodSeconds=10
failureThreshold=3

while getopts 'm:h:p:P:s:b:H:d:t:w:x:' OPTION
do
  case $OPTION in
  m)    method="$OPTARG"
        ;;
  h)    host="$OPTARG"
        ;;
  p)    port="$OPTARG"
        ;;
  P)    path="$OPTARG"
        ;;
  s)    statusCode="$OPTARG"
        ;;
  b)    body="$OPTARG"
        ;;
  H)    headers="$OPTARG"
        ;;
  d)    initialDelaySeconds="$OPTARG"
        ;;
  t)    timeoutSeconds="$OPTARG"
        ;;
  w)    periodSeconds="$OPTARG"
        ;;
  x)    failureThreshold="$OPTARG"
        ;;
  esac
done



protocol='HTTP/1.1'

sleep $initialDelaySeconds
attemps=1
while [[ $attemps -le $failureThreshold ]]; do
  if printf "${method} ${path} ${protocol}\nHost: ${host}\n${headers}\n\n${body}\n"  | nc $host $port -w $timeoutSeconds | grep -Fqs "$protocol $statusCode"; then
    exit 0
  else
    if [ $attemps -lt $failureThreshold ]; then sleep $periodSeconds; fi
    let "attemps=attemps+1"
  fi
done

exit 1
{{- end -}}
