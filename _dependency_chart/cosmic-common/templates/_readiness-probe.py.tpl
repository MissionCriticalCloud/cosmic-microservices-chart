{{- define "cosmic-common.readiness-probe.py" -}}
import argparse
import time
import http.client
import json

parser = argparse.ArgumentParser()

parser.add_argument('--host', default='localhost')
parser.add_argument('--port', type=int, default=80)
parser.add_argument('--timeout', type=int, default=10, help='in seconds')
parser.add_argument('--tls', action='store_true', default=False)

parser.add_argument('--method', default='GET')
parser.add_argument('--path', default='/')
parser.add_argument('--headers', default='{}')
parser.add_argument('--status', type=int, default=200)

parser.add_argument('--initial-delay', type=int, default=0, help='in seconds')
parser.add_argument('--period', type=int, default=5, help='in seconds')
parser.add_argument('--failure-threshold', type=int, default=3)

args = parser.parse_args()

time.sleep(args.initial_delay)
attempts=1
while attempts <= args.failure_threshold:
    try:
        connection = http.client.HTTPSConnection(args.host, args.port, timeout=args.timeout) if args.tls \
            else http.client.HTTPConnection(args.host, args.port, timeout=args.timeout)
        connection.request(args.method, args.path, headers=json.loads(args.headers))
        response = connection.getresponse()
        assert response.status == args.status, 'HTTP status %s is different than expected: %s' % (response.status, args.status)
    except:
        attempts += 1
        if attempts <= args.failure_threshold:
            time.sleep(args.period)
            continue
        raise
    else:
        connection.close()
        break
{{- end -}}
