#!/usr/bin/env bash
# Start JupyterLab; the folder containing this script is mounted as /sharedFolder
set -e
cd "$(dirname "$0")"

IMAGE="ghcr.io/reproduciblebioinformatics/protein_analysis:latest"
PORT="${PORT:-8888}"
TOKEN="$(head -c 16 /dev/urandom | od -An -tx1 | tr -d ' \n')"
URL="http://127.0.0.1:${PORT}/lab?token=${TOKEN}"

if ! docker info >/dev/null 2>&1; then
  echo "Docker Desktop is not running. Start it and try again."
  exit 1
fi

docker pull "$IMAGE"
echo "JupyterLab will be available at: $URL"
echo "Press Ctrl+C to stop."
( sleep 5; open "$URL" ) &

docker run --rm -it \
  -p "127.0.0.1:${PORT}:8888" \
  -e JUPYTER_TOKEN="$TOKEN" \
  -v "$PWD":/sharedFolder \
  "$IMAGE"
