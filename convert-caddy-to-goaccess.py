import json
import sys
from datetime import datetime

def parse_log_line(line):
    try:
        log = json.loads(line)
        ip = log.get("request", {}).get("remote_ip", "-")
        method = log.get("request", {}).get("method", "-")
        uri = log.get("request", {}).get("uri", "-")
        proto = log.get("request", {}).get("proto", "-")
        status = log.get("status", "-")
        size = log.get("size", 0)
        ts = log.get("ts", None)

        if ts:
            # Convert timestamp to human-readable format
            dt = datetime.utcfromtimestamp(ts).strftime('%d/%b/%Y:%H:%M:%S +0000')
        else:
            dt = "-"

        # Format as COMBINED log format
        return f'{ip} - - [{dt}] "{method} {uri} {proto}" {status} {size}'
    except Exception as e:
        return None

if __name__ == "__main__":
    for line in sys.stdin:
        formatted = parse_log_line(line.strip())
        if formatted:
            print(formatted)
