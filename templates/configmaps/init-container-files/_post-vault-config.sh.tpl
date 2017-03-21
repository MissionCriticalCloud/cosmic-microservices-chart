{{- define "configmaps.init-container-files.post-vault-config.sh" -}}
#!/bin/sh
set -x

host='localhost'
port=80
headers=''

while getopts 'h:p:H:' OPTION
do
  case $OPTION in
  h)    host="$OPTARG"
        ;;
  p)    port="$OPTARG"
        ;;
  H)    headers="$OPTARG"
        ;;
  esac
done

function post_it {
    endpoint=$1
    /bin/sh /scripts/readiness-probe.sh -h ${host} -p ${port} -P "/v1/secret/${endpoint}" -H "${headers}" -x 1
    if [ $? -eq 1 ]; then
        echo "Post config"
        body="$(cat /scripts/${endpoint}-config.json)"
        body_length=${#body}
        /bin/sh /scripts/readiness-probe.sh -m POST -h ${host} -p ${port} -P "/v1/secret/${endpoint}" -s 204 -b "${body}" -H "${headers}\nContent-Type: application/json\nContent-Length: ${body_length}"
    fi
}
post_it cosmic-usage-api
post_it cosmic-metrics-collector
{{- end -}}
