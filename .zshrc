#--------------------------------------------------------------

## DIRECTORY ALIASES
alias blazer2=/home/adam/Code/blazer-theme-2.0
alias gme=/home/adam/Code/goodnessme-website
alias homees=/home/adam/Code/homees

## UPDATE ALIASES (to avoid remembering package names)
# https://developer.chrome.com/tags/new-in-chrome/
alias update:chrome="yaourt -S google-chrome"
# https://code.visualstudio.com/updates
alias update:vscode="yaourt -S visual-studio-code-bin" # official non OSS version

## GIT ALIASES
alias co="git checkout"
alias gs="git status"
alias gd='git diff'
alias pr="hub pull-request"
alias pusht="git push && git push --tag"
alias unstash="git stash show -p | git apply -R"
alias merge="git merge"
alias sts="git status"
alias whodeleted="git log --full-history --"

# push/pull commands
alias push="git push"
alias p="push"
alias pull="git pull"
alias pushem='git push origin master'
alias pullem='git pull origin master'
alias pullemm='git pull origin main'

# log commands
alias gl='git log'
alias glog='git log --oneline'

# and add commit commands
alias ga='git add'
alias gac='git add . && git commit -m'
alias gacp='gac && p'
alias gc='git commit -m'
alias amend="git commit --amend"
alias ammend='amend'
alias commitcount='git rev-list HEAD --count'
alias commit='git commit'
alias untracked:dry='git clean -n'
alias untracked:del='git clean -fx' # both tracked and untracked
alias untracked:dir:del='git clean -fd'
alias untracked:ignored:del='git clean -fX'
alias untracked:unignored:del='git clean -f'

# branch commands
alias gb='git branch'
alias branch='git branch'
alias branch:new='git checkout -b'
alias cob='branch:new' # "git CheckOut -B"
alias branch:del='git branch -D'
alias branch:rename='git branch -M'
alias branch:all='git branch -a'
alias branch:contains='git branch --contains' # branch:contains {sha} check which branches contain a commit
alias branch:remotes='git branch -r'
alias branch:unmerged='git branch -r --no-merged'
alias branch:merged='git branch -r --merged'
alias branch:prune:dry='git remote prune origin --dry-run'
alias branch:prune='git remote prune origin'

# pushes and sets git origin with curr branch.
# psu stands for "push, set upstream"
function psu {
  branch=$(git rev-parse --abbrev-ref HEAD)
  git push -u origin $branch
}

# pulls from a remote origin with same name as curr branch
function pusu {
  branch=$(git rev-parse --abbrev-ref HEAD)
  git pull origin $branch
}

# stash commands
alias stash:list="git stash list"

## usage: $ stash: apply 0
function stash:apply {
  if [ ! -n "$1" ]; then
    echo "Apply a stash number"
  else
    git stash apply stash@{$1}
  fi
}

function stash:drop {
  if [ ! -n "$1" ]; then
    echo "Apply a stash number"
  else
    git stash drop stash@{$1}
  fi
}

## UNIX ALIASES
alias upgrade="sudo pacman -Syyu"
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano -w PKGBUILD'
alias more=less
alias l="launch"
alias start="sudo systemctl start"
alias stop="sudo systemctl stop"
alias status="sudo systemctl status"
alias python="/usr/bin/python2.7"
alias t="touch"
alias path="which"
# alias cat="bat"
alias yoghurt="yaourt"
# alias rimraf="rm -rf"
alias kernel="mhwd-kernel -li"
alias userlist="cat /etc/passwd"
alias functions="print -l ${(ok)functions[(I)[^_]*]}" # list shell functions

## NODE/JSN/NPM ALIASES
alias tsn='ts-node'
alias lint:tsc='npx eslint "src/**/*.{tsx,ts,js}"'
alias nrb="npm run build"
alias st="npm start"
alias launch="npm run build && npx http-server dist/"
alias babel="npx babel --watch src --out-dir . --presets react-app/prod"
alias log="DEBUG=\"brain:*,-brain:*-trace\" npm start"
alias trace="DEBUG=\"brain:*\" npm start"
alias watch="npm run watch"
alias reactapp="npm init -y && npm i react react-dom babel-loader @babel/core @babel/preset-react webpack webpack-cli webpack-dev-server && mkdir src public public/scripts && touch src/index.js public/index.html && touch webpack.config.js"
alias build="npm run build"
alias serve="npm run serve"
alias dev="npm run dev"
alias devo="npm run develop"
alias fresh="npm run fresh"
alias connect="npm run connect"
alias deploy="npm run deploy"
alias audit="npm audit --production" # see https://overreacted.io/npm-audit-broken-by-design/
alias i="npm install"
alias listlinked="npm ls -g --depth=0 --link=true"
alias run="npm run" # lists npm scripts
# see https://sabljakovich.medium.com/how-to-use-npm-packages-with-node-js-repl-sessions-cd77300ebfe2
alias node_repl_w_global_packages="NODE_PATH=$(npm root -g) node"

## UTILITY/HELPER ALIASES
alias homees='cd ~/Code/Homees/frontend && code . && st'
alias job="xdg-open https://www.notion.so/ && $job_name && code . && cd design/ && st"
alias jobdir="cd $job_name"
alias inotify="echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p"
alias weather="curl wttr.in/sydney"
alias zshrc="code ~/.zshrc"
alias resource="source ~/.zshrc" # alias resource="source ~/.bashrc && source ~/.zshrc"
alias k="kill -9"
alias sync:up="cd ~/.dotfiles/ && ./sync_up.sh"
alias sync:down="cd ~/.dotfiles/ && ./sync_down.sh"
alias c="code"
alias gp="git add . && git commit -m 'random change' && git push"
alias gpp="cd /home/adam/Documents/ && git add . && git commit -m 'random change' && git push"
alias calc="node -p"
alias dockerclean="docker volume prune && docker rm $(docker ps -a -q) -f"
#alias wp="docker-compose exec wordpress php -d memory_limit=512M /usr/local/bin/wp --allow-root"
alias wpexport="wp export --stdout --skip_comments > config/dev-content.xml\n"
alias dc="docker-compose"
alias dotfiles="cd ~/.dotfiles"
alias getpublicip="curl http://checkip.amazonaws.com/"

## OTHER ALIASES







#--------------------------------------------------------------

# Paths
# Add new path with colon separation
export PATH=$HOME/bin:/usr/local/bin/:/home/adam/Code/emsdk:/home/adam/Code/emsdk/upstream/emscripten:$PATH

# # The next line updates PATH for Netlify's Git Credential Helper.
# if [ -f '/home/adam/.netlify/helper/path.zsh.inc' ]; then source '/home/adam/.netlify/helper/path.zsh.inc'; fi

# # deno
# export DENO_INSTALL="/home/adam/.deno"
# export PATH="$DENO_INSTALL/bin:$PATH"

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
  emoji
)

#--------------------------------------------------------------

## ENVIRONMENT VARIABLES
export GIT_EDITOR='code --wait'
export EDITOR=/usr/bin/nano
export ZSH="/home/adam/.oh-my-zsh" # Path to your oh-my-zsh installation.
# export SSH_KEY_PATH="~/.ssh/rsa_id"

#--------------------------------------------------------------

# LOADERS
source $ZSH/oh-my-zsh.sh # Enables oh-my-zsh

# The next line updates PATH for the Google Cloud SDK.
# if [ -f '/home/adam/google-cloud-sdk/path.zsh.inc' ]; then . '/home/adam/google-cloud-sdk/path.zsh.inc'; fi

# # The next line enables shell command completion for gcloud.
# if [ -f '/home/adam/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/adam/google-cloud-sdk/completion.zsh.inc'; fi

# path for rubygems
PATH="`ruby -e 'puts Gem.user_dir'`/bin:$PATH"

#--------------------------------------------------------------
# functions

function mkcd {
  if [ ! -n "$1" ]; then
    echo "Enter a directory name"
  elif [ -d $1 ]; then
    echo "\`$1' already exists"
  else
    mkdir $1 && cd $1
  fi
}

function getssl {
  if [ ! -n "$1" ]; then
    echo "Enter a domain name, eg https://cms.test.com"
  else
    curl --insecure -vvI $1 2>&1 | awk 'BEGIN { cert=0 } /^\* SSL connection/ { cert=1 } /^\*/ { if (cert) print }'
  fi
}

#--------------------------------------------------------------

# Load NVM https://github.com/nvm-sh/nvm#install--update-script
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. $NVM_DIR/nvm.sh --no-use # This loads nvm

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
    # echo "Reverting to nvm default version"
    # nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

#--------------------------------------------------------------

# # https://starship.rs/guide/#%F0%9F%9A%80-installation
# eval "$(starship init zsh)"
# export STARSHIP_CONFIG=~/.dotfiles/starship.toml

# export PNPM_HOME="/home/adam/.local/share/pnpm"
# export PATH="$PNPM_HOME:$PATH"
export PATH=~/.npm-global/bin:$PATH

# pnpm
export PNPM_HOME="/home/adam/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
