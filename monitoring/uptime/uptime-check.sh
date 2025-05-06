#!/bin/bash
# NOTE: For local testing, using 'localhost' as the domain. Replace with your domain or public IP for production.
URL="http://localhost/health"
STATUS=$(curl -s -o /dev/null -w "%{http_code}" $URL)
if [ "$STATUS" -ne 200 ]; then
  echo "DOWN: $URL"
  exit 1
else
  echo "UP: $URL"
fi 