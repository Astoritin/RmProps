#!/system/bin/sh
MODDIR=${0%/*}

MOD_INTRO="Remove specific system properties."

MOD_DIR="/data/adb/modules/rmprops"
LITE_MOD_DIR="/data/adb/lite_modules/rmprops"

POST_D="/data/adb/post-fs-data.d"
CLEANUP_SH=".rmprops_cleanup.sh"
CLEANUP_PATH="${POST_D}/${CLEANUP_SH}"

update_config_var() {
    key_name="$1"
    file_path="$2"
    expected_value="$3"
    append_mode="${4:-false}"

    if [ -z "$key_name" ] || [ -z "$expected_value" ] || [ -z "$file_path" ]; then
        return 1
    elif [ ! -f "$file_path" ]; then
        return 2
    fi

    if grep -q "^${key_name}=" "$file_path"; then
        [ "$append_mode" = true ] && return 0
        sed -i "/^${key_name}=/c\\${key_name}=${expected_value}" "$file_path"
    else
        [ -n "$(tail -c1 "$file_path")" ] && echo >> "$file_path"
        printf '%s=%s\n' "$key_name" "$expected_value" >> "$file_path"
    fi

    result_update_value=$?
    return "$result_update_value"
}

if [ -f "${MOD_DIR}/disable" ]; then
    update_config_var "description" "${MOD_DIR}/module.prop" "$MOD_INTRO"
elif [ -f "${LITE_MOD_DIR}/disable" ]; then
    update_config_var "description" "${LITE_MOD_DIR}/module.prop" "$MOD_INTRO"
fi

rm -f "$CLEANUP_PATH"