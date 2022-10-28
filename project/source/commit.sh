
function commit {
	if [[ -f "$MANIFEST_TMP" ]]; then
		cat "$MANIFEST_TMP" > "$MANIFEST"
		rm -f "$MANIFEST_TMP"
	else
		continue
	fi
}

