#!/usr/bin/env bash
set -e
pip install -r requirements.txt
docker compose up -d
python fts.py
docker compose down 