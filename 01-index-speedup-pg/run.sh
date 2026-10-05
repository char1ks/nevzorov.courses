#!/usr/bin/env bash
set -e
pip install -r requirements.txt
docker compose up -d
echo "Waiting for database to be ready..."
docker compose wait db
python index_speedup.py
docker compose down 