#!/bin/sh
set -e
set -o pipefail

INPUT=${INPUT:-/scss}
OUTPUT=${OUTPUT:-/output}

echo "Watching ${INPUT}"
inotifywait --monitor --recursive --event modify,create,delete,move --format '%:e %w%f %f' "${INPUT}" | while read event file_path file_name
do
  if [ "$event" = "DELETE" ]; then
    echo "[${event}] ${file_name} was removed, deleting..."
    rm -f ${OUTPUT}/${file_name}
  else
    echo "[${event}] ${file_name} has changed, recompiling..."
    sassc --style compressed ${file_path} > ${OUTPUT}/${file_name} || true
  fi
done
