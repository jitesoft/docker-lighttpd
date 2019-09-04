#!/bin/ash
# Why wget? Well, because there is a primitive wget in alpine by default!
if [[ ${SKIP_HEALTHCHECK} = "true" ]]; then
    exit 0
fi

wget --spider -O/dev/null "127.0.0.1:${PORT}" || exit 1
