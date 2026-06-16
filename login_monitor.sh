#!/bin/bash

# ==========================================================
# Login Monitoring System
# Author: SreeDevopsX
# Purpose: Monitor Linux login activity
# ==========================================================

REPORT_DIR="$HOME/login_monitor_reports"
mkdir -p "$REPORT_DIR"

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
REPORT_FILE="$REPORT_DIR/login_report_$TIMESTAMP.txt"

echo "======================================================" > "$REPORT_FILE"
echo "            LOGIN MONITORING REPORT"
echo "======================================================" >> "$REPORT_FILE"
echo "Generated : $(date)" >> "$REPORT_FILE"
echo "Hostname  : $(hostname)" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
