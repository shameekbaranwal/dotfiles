# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git 
	zsh-syntax-highlighting 
	zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"
# source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias mysql=/usr/local/mysql/bin/mysql
alias mysqladmin=/usr/local/mysql/bin/mysqladmin

# export MAVEN_HOME=~/Desktop/code/libs/apache-maven-3.6.3
# export PATH=$PATH:$MAVEN_HOME/bin

# export JAVA_HOME=`/usr/libexec/java_home -v 1.8.0_421`
# export PATH=$PATH:$JAVA_HOME/bin



alias vim="nvim"

eval "$(zoxide init zsh)"
alias cd="z"

# kafka aliases
alias zoorunbrew="/opt/homebrew/opt/kafka/bin/zookeeper-server-start /opt/homebrew/etc/kafka/zookeeper.properties"
alias kafrunbrew="/opt/homebrew/opt/kafka/bin/kafka-server-start /opt/homebrew/etc/kafka/server.properties"
alias brewprefix="/opt/homebrew"

# setup fzf
source <(fzf --zsh)
alias f='vim "$(fzf)"'

# kafka and zookeeper runner
alias zoorun="bin/zookeeper-server-start.sh config/zookeeper.properties"
alias kafkarun="bin/kafka-server-start.sh config/server.properties"



alias ibrew='arch -x86_64 /usr/local/bin/brew'
alias mbrew='arch -arm64e /opt/homebrew/bin/brew'

# export PATH="/usr/local/Homebrew/Cellar/openssl@1.0/1.0.2u/bin/:$PATH"
export PATH="/opt/homebrew/opt/openssl@1.0/bin:$PATH"

# open pycharm or intellij from terminal
alias pycharm='open -na "PyCharm CE.app" --args "$@" $1'
alias intellij='open -na "Intellij IDEA CE.app" --args "$@" $1'

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin/"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

export LDFLAGS="-L/opt/homebrew/opt/mysql-client/lib"
export CPPFLAGS="-I/opt/homebrew/opt/mysql-client/include"

export PKG_CONFIG_PATH="/opt/homebrew/opt/mysql-client/lib/pkgconfig"
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

penv() {
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
  pyenv activate $1
}

# ln -s /opt/homebrew/opt/mysql@8.4 /opt/homebrew/opt/mysql

export PATH="/opt/homebrew/opt/mysql/bin:$PATH"

export DYLD_LIBRARY_PATH="/usr/local/opt/mysql-client/lib:$DYLD_LIBRARY_PATH"

alias ngd="docker compose build && docker compose up -d"
export LESS='-SFX'

bpsql() {
    psql --host="$1" --port="5432" --username=root --password --dbname="$2"
}

bmsql() {
    mycli -u root -p -h $1 $2
}

export PSQL_PAGER='pspg -X -b'
export PATH="/opt/homebrew/opt/mysql@8.0/bin:$PATH"

export LDFLAGS="-L/opt/homebrew/opt/mysql@8.0/lib"
export CPPFLAGS="-I/opt/homebrew/opt/mysql@8.0/include"

export PKG_CONFIG_PATH="/opt/homebrew/opt/mysql@8.0/lib/pkgconfig"
eval "$(rbenv init - zsh)"


decompress() {
    local result=$(echo "$1" | python3 -c "import gzip, base64, sys; print(gzip.decompress(base64.b64decode(sys.stdin.read().strip())).decode())")
    echo "$result"
    echo "$result" | pbcopy
    echo "✓ Copied to clipboard"
}

decompressV2() {
    echo "Enter compressed string: \n"
    read input
    local result=$(echo "$input" | python3 -c "import gzip, base64, sys; print(gzip.decompress(base64.b64decode(sys.stdin.read().strip())).decode())")
    echo "$result"
    echo "$result" | pbcopy
    echo "✓ Copied to clipboard"
}


checksize() {
    local result=$(du -sh $1/* | sort -hr)
    echo "$result"
}


wake_manjaro() {
    ssh shameek@box.bream-carp.ts.net "./wake.sh"
}

export PATH="$HOME/.local/bin:$PATH"

# Secrets live in an untracked file, never in this repo.
[ -f ~/.secrets.zsh ] && source ~/.secrets.zsh


export EDITOR='nvim'


eval "$(_H20_COMPLETE=zsh_source h20)"

# Per-repo named patches. Stored under <git-common-dir>/patches/<name>.patch
# so they're scoped to the repo (not committed) and shared across worktrees.

_patch-dir() {
    local d
    d="$(git rev-parse --git-common-dir 2>/dev/null)" || {
        echo "❌ Not in a git repository" >&2
        return 1
    }
    echo "$d/patches"
}

# save-patch <name> — snapshot current working tree (staged + unstaged) vs HEAD
save-patch() {
    if [[ -z "$1" ]]; then
        echo "Usage: save-patch <name>" >&2
        return 1
    fi
    if [[ "$1" == */* || "$1" == .* ]]; then
        echo "❌ Patch name must not contain '/' or start with '.'" >&2
        return 1
    fi
    local dir; dir="$(_patch-dir)" || return 1
    mkdir -p "$dir"
    local patch_file="$dir/$1.patch"

    if git diff --quiet HEAD; then
        echo "❌ No changes to save"
        return 1
    fi
    [[ -f "$patch_file" ]] && echo "⚠️  Overwriting existing patch: $1"
    git diff HEAD > "$patch_file"
    echo "✅ Saved patch '$1' to $patch_file"
    git diff --stat HEAD
}

# list-patches — show all patches saved for this repo
list-patches() {
    local dir; dir="$(_patch-dir)" || return 1
    if [[ ! -d "$dir" ]] || ! compgen -G "$dir/*.patch" > /dev/null 2>&1; then
        echo "No patches saved in this repo (looked in $dir)"
        return 0
    fi
    echo "Patches in $dir:"
    local f name files bytes
    for f in "$dir"/*.patch; do
        name="$(basename "$f" .patch)"
        files="$(grep -c '^diff --git ' "$f")"
        bytes="$(wc -c < "$f" | tr -d ' ')"
        printf "  %-30s  %3s file(s)  %7s bytes\n" "$name" "$files" "$bytes"
    done
}

# apply-patch <name> — apply a previously saved patch on top of the working tree
apply-patch() {
    if [[ -z "$1" ]]; then
        echo "Usage: apply-patch <name>" >&2
        echo "       (run 'list-patches' to see available patches)" >&2
        return 1
    fi
    local dir; dir="$(_patch-dir)" || return 1
    local patch_file="$dir/$1.patch"
    if [[ ! -f "$patch_file" ]]; then
        echo "❌ Patch '$1' not found at $patch_file"
        echo "   Run 'list-patches' to see available patches"
        return 1
    fi

    if ! git diff --quiet HEAD; then
        echo "⚠️  You have uncommitted changes. Stash them first? (y/n)"
        read -q && echo && git stash push -m "before applying patch '$1'"
    fi

    # First try a clean apply (silent — we expect it to fail when context drifted)
    if git apply "$patch_file" 2>/dev/null; then
        echo "✅ Applied patch '$1' cleanly"
        git diff --stat HEAD
        return 0
    fi

    # Clean apply failed — retry with 3-way merge so conflicts leave markers in files
    echo "⚠️  Clean apply failed — retrying with 3-way merge…"
    git apply --3way "$patch_file"
    local rc=$?

    local conflicted
    conflicted="$(git diff --name-only --diff-filter=U 2>/dev/null)"

    if [[ -n "$conflicted" ]]; then
        echo ""
        echo "⚠️  Patch applied with conflicts in:"
        echo "$conflicted" | sed 's/^/    /'
        echo ""
        echo "Resolve the conflict markers, then 'git add' the files."
        echo "(To bail out: 'git checkout -- <file>' to discard, or 'git stash pop' if you stashed earlier.)"
        return 1
    fi

    if [[ $rc -eq 0 ]]; then
        echo "✅ Applied patch '$1' via 3-way merge"
        git diff --stat HEAD
        return 0
    fi

    echo "❌ Failed to apply patch — 3-way base unavailable (patch references blobs not in this repo)."
    return 1
}

# bun completions
[ -s "/Users/shameek/.bun/_bun" ] && source "/Users/shameek/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"



# alfred CLI completions
eval "$(_ALFRED_COMPLETE=zsh_source alfred)"
