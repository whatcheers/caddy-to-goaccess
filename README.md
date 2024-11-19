# Caddy to GoAccess Log Converter

A utility tool that converts Caddy JSON access logs to a format compatible with GoAccess for web log analysis and visualization.

## Overview

This tool processes Caddy's JSON-formatted access logs and converts them into the COMBINED log format, making them compatible with GoAccess for generating beautiful HTML reports of your web traffic.

## Prerequisites

- Python 3.x
- GoAccess
- Caddy server with JSON logging enabled
- Bash shell (for automatic conversion script)

## Installation

1. Clone this repository:
git clone https://github.com/yourusername/caddy-to-goaccess.git
cd caddy-to-goaccess

2. Make the conversion script executable:
chmod +x auto-convert.sh

## Usage

### Manual Conversion

python3 convert-caddy-to-goaccess.py < input.log > output.log

### Automatic Conversion and Report Generation

Use the provided shell script for automatic conversion and report generation:
./auto-convert.sh

The script will:
1. Copy Caddy logs from the source location
2. Convert the logs to COMBINED format
3. Generate an HTML report using GoAccess
4. Serve the report on port 8543

## Configuration

The `auto-convert.sh` script uses these default paths:
- Source log: `/var/log/caddy/dev-access.log`
- Temporary log location: `$HOME/dev-access.log`
- Parsed log: `$HOME/dev-access-parsed.log`
- HTML report: `$HOME/report.html`

Modify these paths in the script as needed for your environment.

## Log Format

The converter transforms Caddy's JSON logs into the following COMBINED format:

%h %^[%d:%t %^] "%r" %s %b

Where:
- %h: Remote host (IP address)
- %d: Date
- %t: Time
- %r: First line of request
- %s: Status code
- %b: Size of response in bytes


### Common Issues

1. **Permission Denied**
   ```bash
   chmod +x auto-convert.sh
   ```

2. **Python Script Not Found**
   - Ensure you're in the correct directory
   - Verify the Python script path in auto-convert.sh

3. **GoAccess Not Installed**
https://goaccess.io/

