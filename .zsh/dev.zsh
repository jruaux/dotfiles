function rmeclipse() {
    if [ -z "$1" ]; then
        echo "Usage: rmeclipse <directory>"
        return 1
    fi

    find "$1" \( -name ".classpath" -o -name ".project" -o -name ".settings" \) -exec rm -rf {} +
}