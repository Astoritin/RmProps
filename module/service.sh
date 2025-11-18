#!/system/bin/sh
MODDIR=${0%/*}

CONFIG_DIR="/data/adb/rmprops"

CONFIG_FILE="${CONFIG_DIR}/rmprops.conf"
REMOVED_PROPS="${CONFIG_DIR}/.removed_props.txt"

MOD_INTRO="Remove specific system properties."
MODULE_PROP="$MODDIR/module.prop"

get_config_var() {
    key=$1
    config_file=$2

    if [ -z "$key" ] || [ -z "$config_file" ]; then
        return 1
    elif [ ! -f "$config_file" ]; then
        return 2
    fi
    
    value=$(awk -v key="$key" '
        BEGIN {
            key_regex = "^" key "="
            found = 0
            in_quote = 0
            value = ""
        }
        $0 ~ key_regex && !found {
            sub(key_regex, "")
            remaining = $0

            sub(/^[[:space:]]*/, "", remaining)

            if (remaining ~ /^"/) {
                in_quote = 1
                remaining = substr(remaining, 2)

                if (match(remaining, /"([[:space:]]*)$/)) {
                    value = substr(remaining, 1, RSTART - 1)
                    in_quote = 0
                } else {
                    value = remaining
                    while ((getline remaining) > 0) {
                        if (match(remaining, /"([[:space:]]*)$/)) {
                            line_part = substr(remaining, 1, RSTART - 1)
                            value = value "\n" line_part
                            in_quote = 0
                            break
                        } else {
                            value = value "\n" remaining
                        }
                    }
                    if (in_quote) exit 1
                }
                found = 1
            } else {
                gsub(/^[[:space:]]+|[[:space:]]+$/, "", remaining)
                value = remaining
                found = 1
            }
            if (found) exit 0
        }
        END {
            if (!found) exit 1
            gsub(/[[:space:]]+$/, "", value)
            print value
        }
    ' "$config_file")

    awk_exit_state=$?
    case $awk_exit_state in
        1)  return 5
            ;;
        0)  ;;
        *)  return 6
            ;;
    esac

    value=$(echo "$value" | dos2unix | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' | sed 's/'\''/'\\\\'\'''\''/g' | sed 's/[$;&|<>`"()]/\\&/g')

    if [ -n "$value" ]; then
        echo "$value"
        return 0
    else
        return 1
    fi
}

clean_duplicate_items() {

    filed=$1

    [ -z "$filed" ] && return 1
    [ ! -f "$filed" ] && return 2

    awk '!seen[$0]++' "$filed" > "${filed}.tmp"
    mv "${filed}.tmp" "$filed"
    return 0

}

update_config_var() {
    key_name="$1"
    file_path="$2"
    expected_value="$3"
    append_mode="${4:-false}"

    if [ -z "$key_name" ] || [ -z "$file_path" ]; then
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

rmprops() {

    props_list=$1

    [ -z "$props_list" ] && return 1

    for prop in $props_list; do
        prop_value="$(resetprop "$prop")"
        if [ -n "$prop_value" ]; then
            echo "$prop=$prop_value" >> "$REMOVED_PROPS"
            resetprop -p -d "$prop"
        fi
    done

}

props_list_count() {

    props_list_to_count=$1

    if [ -z "$props_list_to_count" ]; then
        echo "-999"
        return 1
    elif [ -s "$props_list_to_count" ]; then
        count_result=$(grep -vE '^[[:space:]]*(#|$)' "$props_list_to_count" 2>/dev/null | wc -l)
    else
        count_result=$(echo "$props_list_to_count" | grep -vE '^[[:space:]]*(#|$)' | wc -l)
    fi
    
    echo "$count_result"
    return 0
}

remove_specific_props() {

    remove_props=$(get_config_var "remove_props" "$CONFIG_FILE") || remove_props=false
    remove_pi_props=$(get_config_var "remove_pi_props" "$CONFIG_FILE") || remove_pi_props=true

    props_to_remove=""
    pi_props_to_remove=""
    [ "$remove_props" = true ] && props_to_remove=$(get_config_var "props_to_remove" "$CONFIG_FILE")
    [ "$remove_pi_props" = true ] && pi_props_to_remove=$(resetprop | grep -E "(pihook|pixelprops|spoof|entryhooks)" | sed -r "s/^\[([^]]+)\].*/\1/")

    target_list=$(printf '%s%s%s\n' "$props_to_remove" "${props_to_remove:+$'\n'}" "$pi_props_to_remove")
    rmprops "$target_list"

    clean_duplicate_items "$REMOVED_PROPS"

}

get_status_desc() {

    md_type="$1"
    md_enabled="$2"
    md_count="$3"
    
    if [ "$md_enabled" = "true" ]; then
        echo "✅${md_type} props (${md_count})"
    else
        echo "❎${md_type} props removal disabled"
    fi

}

moddesc_update() {

    custom_count=0
    pif_count=0
    removed_count=0

    [ -n "$props_to_remove" ] && custom_count=$(props_list_count "$props_to_remove")
    [ -n "$pi_props_to_remove" ] && pif_count=$(props_list_count "$pi_props_to_remove")
    [ -f "$REMOVED_PROPS" ] && removed_count=$(props_list_count "$REMOVED_PROPS")
    
    custom_desc=$(get_status_desc "Custom" "$remove_props" "$custom_count")
    pif_desc=$(get_status_desc "PIF" "$remove_pi_props" "$pif_count")
    
    desc_parts="$custom_desc, $pif_desc"
    if [ "$removed_count" -gt 0 ]; then
        desc_parts="$desc_parts, 📌${removed_count} props removed"
    fi
    
    DESCRIPTION="[$desc_parts] $MOD_INTRO"
    update_config_var "description" "$MODULE_PROP" "$DESCRIPTION"
}

if [ "$FROM_ACTION" = true ]; then
    remove_specific_props
    moddesc_update
    return 0
fi

while [ "$(getprop sys.boot_completed)" != "1" ]; do
    sleep 1
done

remove_specific_props
moddesc_update
