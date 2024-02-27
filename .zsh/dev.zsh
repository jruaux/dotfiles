function rmeclipse() {
    local directory="${1:-.}"

    if [ ! -d "$directory" ]; then
        echo "Error: '$directory' is not a directory."
        return 1
    fi

    find "$directory" \( -name ".classpath" -o -name ".project" -o -name ".settings" \) -exec rm -rf {} +
}