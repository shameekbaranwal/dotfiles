
#!/bin/bash

# Read JSON input
input=$(cat)

# Extract values
model=$(echo "$input" | jq -r '.model.display_name')
cwd_full=$(echo "$input" | jq -r '.workspace.current_dir')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // "0"')
total_input=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')
total_output=$(echo "$input" | jq -r '.context_window.total_output_tokens // 0')

# Get last 2 directory components
cwd=$(echo "$cwd_full" | awk -F'/' '{if (NF<=2) print $0; else print $(NF-1)"/"$NF}')

# Get git branch (skip locks for safety)
cd "$cwd_full" 2>/dev/null
branch=$(git -c core.useBuiltinFSMonitor=false rev-parse --abbrev-ref HEAD 2>/dev/null || echo "no git")

# Quirky emoji array (changes randomly each prompt)
emojis=("🦄" "🦖" "🐙" "🦀" "🦩" "🦝" "🦔" "🦦" "🦥" "🦘" "🐡" "🦚" "🦜" "🦢" "🦫" "🐌" "🦗" "🐞" "🦋" "🐛" "🦐" "🦑" "🐠" "🦈" "🐚" "🌵" "🍄" "🌶️" "🥑" "🧇" "🧀" "🥨" "🌮" "🧆" "🧊" "🔮" "🎲" "🎯" "🎪" "🪐" "🌙" "⚡" "🔥" "💎" "🎭" "🎨" "🎸" "🎺" "🎷" "🪕")

# Get random emoji (seeded by nanoseconds for variety)
random_idx=$(( $(date +%N | sed 's/^0*//') % ${#emojis[@]} ))
random_emoji="${emojis[$random_idx]}"

# Calculate cost (Claude pricing per 1M tokens)
# Using Claude Opus 4 pricing: $15/1M input, $75/1M output
input_cost=$(echo "scale=6; $total_input * 15 / 1000000" | bc -l)
output_cost=$(echo "scale=6; $total_output * 75 / 1000000" | bc -l)
total_cost=$(echo "scale=2; $input_cost + $output_cost" | bc -l)

# Get session start time from transcript file
transcript=$(echo "$input" | jq -r '.transcript_path')
if [ -f "$transcript" ]; then
    start_time=$(stat -c %Y "$transcript" 2>/dev/null || stat -f %B "$transcript" 2>/dev/null)
    current_time=$(date +%s)
    session_seconds=$((current_time - start_time))
    session_hours=$((session_seconds / 3600))
    session_mins=$(((session_seconds % 3600) / 60))
    session_secs=$((session_seconds % 60))

    if [ $session_hours -gt 0 ]; then
        time_str="${session_hours}h ${session_mins}m ${session_secs}s"
    elif [ $session_mins -gt 0 ]; then
        time_str="${session_mins}m ${session_secs}s"
    else
        time_str="${session_secs}s"
    fi
else
    time_str="0s"
fi

# Generate progress bar for context with color
progress_bar() {
    local pct=$1
    local width=15
    local filled=$(printf "%.0f" "$(echo "scale=2; $pct * $width / 100" | bc)")
    local empty=$((width - filled))

    # Choose color based on usage
    local color
    if (( $(echo "$pct < 75" | bc -l) )); then
        color="\033[32m"  # Green
    elif (( $(echo "$pct < 90" | bc -l) )); then
        color="\033[33m"  # Yellow
    else
        color="\033[31m"  # Red
    fi

    printf "${color}["
    for ((i=0; i<filled; i++)); do printf "█"; done
    for ((i=0; i<empty; i++)); do printf "░"; done
    printf "]\033[0m"
}

# Line 1: Model | emoji cwd | emoji branch
printf "%s | 📁 %s | 🌿 %s\n" "$model" "$cwd" "$branch"

# Line 2: Random emoji + Context with progress bar (left half) | Cost and Time (right half)
context_bar=$(progress_bar "$used_pct")
printf "%s %s %.1f%%    \033[32m\$%.2f\033[0m | %s\n" "$random_emoji" "$context_bar" "$used_pct" "$total_cost" "$time_str"

