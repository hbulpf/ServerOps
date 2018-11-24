#!/bin/bash

docker run -d -p 3000:3000 \
    --name metabase \
    --restart always  \
    metabase/metabase