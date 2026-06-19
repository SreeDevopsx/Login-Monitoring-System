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

# ----------------------------------------------------------
# Current Logged In Users
# ----------------------------------------------------------

echo "1. CURRENT LOGGED-IN USERS" >> "$REPORT_FILE"
echo "------------------------------------------------------" >> "$REPORT_FILE"

who >> "$REPORT_FILE"

echo "" >> "$REPORT_FILE"

# ----------------------------------------------------------
# Detailed Session Information
# ----------------------------------------------------------

echo "2. ACTIVE USER SESSIONS" >> "$REPORT_FILE"
echo "------------------------------------------------------" >> "$REPORT_FILE"

w >> "$REPORT_FILE"

echo "" >> "$REPORT_FILE"

# ----------------------------------------------------------
# Last Login Records
# ----------------------------------------------------------

echo "3. LAST 20 LOGIN RECORDS" >> "$REPORT_FILE"
echo "------------------------------------------------------" >> "$REPORT_FILE"

last -n 20 >> "$REPORT_FILE"

echo "" >> "$REPORT_FILE"


# ----------------------------------------------------------
# Failed Login Attempts
# ----------------------------------------------------------

echo "4. FAILED LOGIN ATTEMPTS" >> "$REPORT_FILE"
echo "------------------------------------------------------" >> "$REPORT_FILE"

if [ -f /var/log/btmp ]; then
    sudo lastb | head -20 >> "$REPORT_FILE"
else
    echo "Failed login log not found." >> "$REPORT_FILE"
fi

echo "" >> "$REPORT_FILE"

# ----------------------------------------------------------
# Root Logins
# ----------------------------------------------------------

echo "5. ROOT LOGIN DETECTION" >> "$REPORT_FILE"
echo "------------------------------------------------------" >> "$REPORT_FILE"

last root | head -10 >> "$REPORT_FILE"

echo "" >> "$REPORT_FILE"

# ----------------------------------------------------------
# SSH Login Records
# ----------------------------------------------------------

echo "6. SSH LOGIN HISTORY" >> "$REPORT_FILE"
echo "------------------------------------------------------" >> "$REPORT_FILE"

if [ -f /var/log/auth.log ]; then
    grep "Accepted" /var/log/auth.log | tail -20 >> "$REPORT_FILE"
elif [ -f /var/log/secure ]; then
    grep "Accepted" /var/log/secure | tail -20 >> "$REPORT_FILE"
else
    echo "SSH logs not found." >> "$REPORT_FILE"
fi

echo "" >> "$REPORT_FILE"

# ---------------------------------------------------------- Failed SSH Attempts ----------------------------------------------------------
echo "7. FAILED SSH ATTEMPTS" >> "$REPORT_FILE" 
echo "------------------------------------------------------" >> "$REPORT_FILE" 
if [ -f /var/log/auth.log ]; then
    grep "Failed password" /var/log/auth.log | tail -20 >> "$REPORT_FILE" 
elif [ -f /var/log/secure ]; then 
    grep "Failed password" /var/log/secure | tail -20 >> "$REPORT_FILE"
else 
echo "Failed SSH logs not found." >> "$REPORT_FILE" 
fi
echo "" >> "$REPORT_FILE"

# ---------------------------------------------------------- Login Count ----------------------------------------------------------
echo "8. CURRENT LOGIN COUNT" >> "$REPORT_FILE" 
echo "------------------------------------------------------" >> "$REPORT_FILE" 
who | wc -l >>  "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
