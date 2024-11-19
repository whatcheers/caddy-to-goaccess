#!/bin/bash

# Define paths
LOG_SOURCE="/var/log/caddy/dev-access.log"
LOG_DEST="$HOME/dev-access.log"
PYTHON_SCRIPT="./convert-caddy-to-goaccess.py"
PARSED_LOG="$HOME/dev-access-parsed.log"
HTML_REPORT="$HOME/report.html"

# Get the hostname dynamically
HOSTNAME=$(hostname)

# Step 1: Copy the log file to home directory
echo "Copying log file from $LOG_SOURCE to $LOG_DEST..."
cp $LOG_SOURCE $LOG_DEST

# Step 2: Run the Python script to convert logs
echo "Parsing log file using Python script..."
python3 $PYTHON_SCRIPT < $LOG_DEST > $PARSED_LOG

# Step 3: Generate HTML report with GoAccess
echo "Generating HTML report using GoAccess..."
goaccess $PARSED_LOG \
    --log-format='%h %^[%d:%t %^] "%r" %s %b' \
    --date-format='%d/%b/%Y' \
    --time-format='%H:%M:%S' \
    -o $HTML_REPORT

if [ $? -ne 0 ]; then
    echo "Failed to generate the HTML report. Check permissions or syntax."
    exit 1
fi

# Step 4: Serve the report using Python's HTTP server
echo "Serving the report on http://$HOSTNAME:8543/report.html"
python3 -m http.server 8543 --directory $HOME
