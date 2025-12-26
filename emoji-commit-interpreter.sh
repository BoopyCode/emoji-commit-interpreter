#!/bin/bash
# Emoji Commit Interpreter - Because "fixed stuff" tells us nothing
# Translates emoji commits into something resembling human language

# Emoji dictionary - because hieroglyphs need translation
EMOJI_DB=(
    ["🚀"]="Deployed to production (or just wishful thinking)"
    ["🐛"]="Squashed a bug (probably introduced yesterday)"
    ["✨"]="Added shiny new feature (that will break tomorrow)"
    ["🔧"]="Fixed configuration (for the third time)"
    ["📝"]="Updated documentation (lies)"
    ["🚧"]="Work in progress (always will be)"
    ["💥"]="Breaking change (oops)"
    ["🎨"]="Improved code style (made it prettier, not better)"
    ["⚡️"]="Performance improvement (maybe 0.1% faster)"
    ["🔒"]="Security fix (hopefully)"
    ["🧪"]="Added tests (that will never run)"
    ["♻️"]="Refactored code (moved the mess around)"
    ["🔥"]="Removed code (probably important)"
    ["🚚"]="Moved files (to confuse everyone)"
    ["👷"]="CI/CD changes (more YAML, yay)"
)

# Show help because nobody reads this
show_help() {
    echo "Emoji Commit Interpreter - Decrypting commit hieroglyphs"
    echo "Usage: $0 [commit_message]"
    echo "Example: $0 '🚀 Deploy stuff'"
    echo "Available emojis:"
    for emoji in "${!EMOJI_DB[@]}"; do
        echo "  $emoji - ${EMOJI_DB[$emoji]}"
    done | sort
}

# Main function - where the magic (not really) happens
interpret_commit() {
    local msg="$1"
    
    # Empty message? Classic developer move
    if [[ -z "$msg" ]]; then
        echo "Error: Empty commit message - the ultimate mystery"
        return 1
    fi
    
    # Extract first emoji (if any)
    local emoji=$(echo "$msg" | grep -oE '[^[:space:]]' | head -1)
    
    # Check if it's in our dictionary
    if [[ -n "${EMOJI_DB[$emoji]}" ]]; then
        echo "Commit Translation:"
        echo "  Original: $msg"
        echo "  Meaning:  ${EMOJI_DB[$emoji]}"
        echo "  Translation: $(echo "$msg" | sed "s/^$emoji//" | xargs)"
    else
        echo "Unknown emoji: '$emoji' - Probably meaningless like the commit"
        echo "Raw message: $msg"
    fi
}

# Script entry point - where dreams of readable commits die
if [[ "$1" == "--help" ]] || [[ "$1" == "-h" ]]; then
    show_help
elif [[ $# -eq 1 ]]; then
    interpret_commit "$1"
else
    # Interactive mode - for when you're feeling adventurous
    echo "Enter a commit message (or press Ctrl+D to exit):"
    echo "(Example: 🐛 Fix critical bug that wasn't critical)"
    while read -r line; do
        interpret_commit "$line"
        echo ""
    done
fi
