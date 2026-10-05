#!/usr/bin/env bash
set -e
pip install -r requirements.txt
docker compose up -d
echo "Waiting for services to be ready..."
until docker compose exec -T db pg_isready -U test -d testdb > /dev/null 2>&1; do
  echo "Waiting for database..."
  sleep 2
done
until docker compose exec -T redis redis-cli ping > /dev/null 2>&1; do
  echo "Waiting for Redis..."
  sleep 2
done
python write_through_cache.py
docker compose down 