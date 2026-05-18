#!/usr/bin/env bash
set -e
pip install -r requirements.txt
docker compose up --build --abort-on-container-exit