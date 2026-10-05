#!/usr/bin/env bash
set -e
pip install -r requirements.txt
docker compose up -d
echo "Waiting for database to be ready..."
until docker compose exec -T db pg_isready -U test -d testdb > /dev/null 2>&1; do
  echo "Waiting for database..."
  sleep 2
done
python index_speedup.py
docker compose down 