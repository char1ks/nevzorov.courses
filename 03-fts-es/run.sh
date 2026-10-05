#!/usr/bin/env bash
set -e
pip install -r requirements.txt
docker compose up -d
echo "Waiting for Elasticsearch to be ready..."
docker compose wait elasticsearch
python fts.py
docker compose down 