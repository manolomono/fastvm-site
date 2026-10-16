#!/usr/bin/env bash
# Sube la landing al VPS y (re)arranca el contenedor. No necesita sudo. La versión de GitHub Pages
# sale sola del push a main.
set -euo pipefail
cd "$(dirname "$0")"
HOST=${HOST:-116.203.176.165}
ssh "$HOST" 'mkdir -p fastvm-site/site'
rsync -az --delete index.html style.css "$HOST:fastvm-site/site/"
rsync -az --delete deploy docker-compose.yml "$HOST:fastvm-site/"
ssh "$HOST" 'cd fastvm-site && docker compose up -d && sleep 2 && curl -fsS -o /dev/null -w "Fast VM responde: %{http_code}\n" http://127.0.0.1:9113/'
