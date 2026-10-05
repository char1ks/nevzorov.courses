#!/usr/bin/env bash
set -e
pip install -r requirements.txt
docker compose up -d
python index_slowdown.py
docker compose down 