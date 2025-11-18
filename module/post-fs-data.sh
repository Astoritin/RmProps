#!/system/bin/sh
MODDIR=${0%/*}

POST_D="/data/adb/post-fs-data.d"
CLEANUP_SH=".rmprops_cleanup.sh"
CLEANUP_PATH="${POST_D}/${CLEANUP_SH}"

if [ ! -f "$CLEANUP_PATH" ]; then
    [ ! -d "$POST_D" ] && mkdir -p "$POST_D"
    cat "$MODDIR/${CLEANUP_SH}" > "$CLEANUP_PATH"
    chmod +x "$CLEANUP_PATH"
fi
