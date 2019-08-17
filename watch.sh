#!/bin/sh
set -e
set -o pipefail

INPUT=${INPUT:-/scss}
OUTPUT=${OUTPUT:-/output}
INOTIFY_EXTRA_ARGS=${INOTIFY_EXTRA_ARGS}

echo "Watching ${INPUT}"
inotifywait --monitor --event modify,create,delete,move --format '%:e %w%f %f' "${INPUT}" ${INOTIFY_EXTRA_ARGS} |
while read event file_path file_name
do
  css_file_name="${file_name%.*}.css"
  if [ "$event" = "DELETE" ]; then
    echo "[${event}] ${file_name} was removed, deleting..."
    rm -f ${OUTPUT}/${css_file_name}
  else
    echo "[${event}] ${file_name} has changed, recompiling..."
    sassc "$@" ${file_path} > ${OUTPUT}/${css_file_name} || true
  fi
done
