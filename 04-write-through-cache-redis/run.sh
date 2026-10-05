#!/usr/bin/env bash
set -e
pip install -r requirements.txt
docker compose up -d
echo "Waiting for services to be ready..."
docker compose wait db redis
python write_through_cache.py
docker compose down 