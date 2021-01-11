# Paths
# Add new path with colon separation
export PATH=$HOME/bin:/usr/local/bin/:/home/adam/Code/emsdk:/home/adam/Code/emsdk/upstream/emscripten:$PATH

if [ -f '/home/adam/.netlify/helper/path.zsh.inc' ]; then source '/home/adam/.netlify/helper/path.zsh.inc'; fi # Adds Netlify's Git Credential Helper to PATH

# deno
export DENO_INSTALL="/home/adam/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# Start ssh
eval `ssh-agent` &> /dev/null
ssh-add ~/.ssh/id_rsa &> /dev/null

#--------------------------------------------------------------

# ZSH theme (https://github.com/robbyrussell/oh-my-zsh/wiki/Themes)
ZSH_THEME="bunnyruni"

#--------------------------------------------------------------

# ZSH Flags (Commented out = disabled)
# CASE_SENSITIVE="true"
# HYPHEN_INSENSITIVE="true" # case-sens must be off. _ and - will be interchangeable.
# DISABLE_AUTO_UPDATE="true" # Disables bi-weekly auto update checks
# export UPDATE_ZSH_DAYS=13 # change how often to auto-update (in days)
# DISABLE_LS_COLORS="true"
# DISABLE_AUTO_TITLE="true" # Terminal Title
# ENABLE_CORRECTION="true"
# COMPLETION_WAITING_DOTS="true" # display red dots whilst waiting for completion

# ZSH Plugins, loaded from ~/.oh-my-zsh/plugins/
# Space separated values. eg plugins=(git ruby)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

#--------------------------------------------------------------

## ENVIRONMENT VARIABLES
export GIT_EDITOR='nano'
export EDITOR=/usr/bin/nano
export NVM_DIR="$HOME/.nvm"
export ZSH="/home/adam/.oh-my-zsh" # Path to your oh-my-zsh installation.
# export SSH_KEY_PATH="~/.ssh/rsa_id"

#--------------------------------------------------------------

# LOADERS
source $ZSH/oh-my-zsh.sh # Enables oh-my-zsh
. "$NVM_DIR/nvm.sh" # This loads nvm

#--------------------------------------------------------------

job_name=/home/adam/Code/ozh003_website/frontend

## ALIASES
alias job="xdg-open https://www.notion.so/ && $job_name && code . && cd design/ && st"
alias jobdir="cd $job_name"
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano -w PKGBUILD'
alias more=less
alias inotify="echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p"
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
# alias resource="source ~/.bashrc && source ~/.zshrc"
alias resource="source ~/.zshrc"
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
alias gpp="cd /home/adam/Documents/ && gp"
alias calc="node -p"
alias dockerclean="docker volume prune && docker rm $(docker ps -a -q) -f"
#alias wp="docker-compose exec wordpress php -d memory_limit=512M /usr/local/bin/wp --allow-root"
alias wpexport="wp export --stdout --skip_comments > config/dev-content.xml\n"
alias dc="docker-compose"
alias glog="git log --oneline"
alias c="code"
alias t="touch"
alias path="which"
alias sync_up="cd ~/.dotfiles/ && ./sync_up.sh"
alias sync_down="cd ~/.dotfiles/ && ./sync_down.sh"
alias cat="bat"
alias yoghurt="yaourt"
alias dotfiles="cd ~/.dotfiles"
alias rimraf="rm -rf"
alias strictnode="node --use_strict"
alias kernel="mhwd-kernel -li"
alias userlist="cat /etc/passwd"

function mkcd {
  if [ ! -n "$1" ]; then
    echo "Enter a directory name"
  elif [ -d $1 ]; then
    echo "\`$1' already exists"
  else
    mkdir $1 && cd $1
  fi
}

#--------------------------------------------------------------

# Automatically calls `nvm use` in a directory with .nvmrc
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

#--------------------------------------------------------------

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/adam/google-cloud-sdk/path.zsh.inc' ]; then . '/home/adam/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/adam/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/adam/google-cloud-sdk/completion.zsh.inc'; fi

# The next line updates PATH for Netlify's Git Credential Helper.
if [ -f '/home/adam/.netlify/helper/path.zsh.inc' ]; then source '/home/adam/.netlify/helper/path.zsh.inc'; fi
