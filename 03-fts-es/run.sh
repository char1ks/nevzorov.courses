#!/usr/bin/env bash
set -e
pip install -r requirements.txt
docker compose up -d
echo "Waiting for Elasticsearch to be ready..."
until curl -s http://localhost:9200/_cluster/health | grep -q '"status":"green\|yellow"' > /dev/null 2>&1; do
  echo "Waiting for Elasticsearch..."
  sleep 2
done
python fts.py
docker compose down 