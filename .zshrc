# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/bin:/usr/local/bin/:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/adam/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="bunnyruni"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
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
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

#--------------------------------------------------------------

# User configuration

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

#--------------------------------------------------------------

## ENVIRONMENT VARIABLES
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
PATH="/home/adam/.gem/ruby/2.6.0/bin":$PATH

export GIT_EDITOR='nano'

# Adds vscode to the $EDITOR global for rails credentials
export EDITOR="/bin/code --wait"

export NVM_DIR="$HOME/.nvm"
. "$NVM_DIR/nvm.sh" # This loads nvm

#--------------------------------------------------------------

## ALIASES
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano -w PKGBUILD'
alias more=less
alias inotify="sudo echo fs.inotify.max_user_watches=524288 | sudo tee /etc/sysctl.d/40-max-user-watches.conf && sudo sysctl --system"
alias weather="curl wttr.in/sydney"
alias agent="~/.datadog-agent/bin/agent"
alias zshrc="kate ~/.zshrc"
alias be="bundle exec"
alias ber="bundle exec rake"
alias gs="git status"
alias gac="git add . && git commit -m"
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias go='git checkout'
alias rc='rails c'
alias rs='rails s'
alias r='rspec'
alias push="git push"
alias p="push"
alias pull="git pull"
alias pushem='git push origin master'
alias pullem='git pull origin master'
alias gl="git log"
alias nrb="npm run build"
alias st="npm start"
alias launch="npm run build && npx http-server dist/"
alias l="launch"
alias resource="source ~/.bashrc && source ~/.zshrc"
alias dexus="cd /home/adam/Code/Work/dex012-brainwaves-brain/ && nvm use"
alias babel="npx babel --watch src --out-dir . --presets react-app/prod"
alias log="DEBUG=\"brain:*,-brain:*-trace\" npm start"
alias trace="DEBUG=\"brain:*\" npm start"
alias k="kill -9"
alias start="sudo systemctl start"
alias stop="sudo systemctl stop"
alias status="sudo systemctl status"
alias pr="hub pull-request"
alias pusht="git push && git push --tag"
alias unstash="git stash show -p | git apply -R"
alias watch="npm run watch"
alias ozh="cd ~/Code/ozh001-annual-report"
alias reactapp="npm init -y && npm i react react-dom babel-loader @babel/core @babel/preset-react webpack webpack-cli webpack-dev-server && mkdir src public public/scripts && touch src/index.js public/index.html && touch webpack.config.js"
alias build="npm run build"
alias serve="npm run serve"
alias portfolio="cd /home/adam/Code/myportfolio/content/"
alias gp="git add . && git commit -m 'random change' && git push"
alias mlc="cd ~/Code/Projects/mlc001-strategic-plan"

function mkcd {
  if [ ! -n "$1" ]; then
    echo "Enter a directory name"
  elif [ -d $1 ]; then
    echo "\`$1' already exists"
  else
    mkdir $1 && cd $1
  fi
}


# The next line updates PATH for Netlify's Git Credential Helper.
if [ -f '/home/adam/.netlify/helper/path.zsh.inc' ]; then source '/home/adam/.netlify/helper/path.zsh.inc'; fi


# automatically calls `nvm use` in a directory with .nvmrc
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
