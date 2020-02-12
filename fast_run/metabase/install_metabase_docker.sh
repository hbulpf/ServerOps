#!/bin/bash

docker run -d -p 3000:3000 \
  -v /data/metabase_data:/metabase-data \
  -e "MB_DB_FILE=/metabase-data/metabase.db" \
  --name metabase metabase/metabase \
  --restart=always