# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="ys"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git rails ruby bundler)

# User configuration

export PATH="/Users/jesse/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

export GITHUB_API_TOKEN=ac470149e62bf95f9ca3e5b29a522e345115f75e

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

ulimit -n 10240

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias zshconf="vim ~/.zshrc"
alias bbsh="~/src/gc/script/bbsh"
alias mux="boot_tmux_env"
alias redis="redis-server config/redis.conf"

# git aliases
alias grm='git rm'
alias grb='git rebase'
alias gbr='git branch'

# src dir aliases
alias cdgc='cd ~/src/gc'
alias cdcr='cd ~/src/crimson'
alias cdhe='cd ~/src/health_records'
alias cdse='cd ~/src/security_engine'
alias cdrr='cd ~/src/roles_on_routes'
alias cdcm='cd ~/src/care_management_engine'
alias cdno='cd ~/src/notification'

# rails aliases
alias dbmigrate='rake db:migrate && RAILS_ENV=test rake db:migrate'
alias devtail="less -r -n +F log/development.log"
alias testtail="less -r -n +F log/test.log"
alias rollback="rake db:rollback && RAILS_ENV=test rake db:rollback"
alias testprep="rake db:test:prepare --trace"
alias devsql="mysql --user=root --database navcan_development"
alias testsql="mysql --user=root --database navcan_test"

alias alltests="time rake spec:no_acceptance; time cucumber --format=progress -t ~@run_solo -t ~@in_progress -t ~@javascript features; time rake spec:acceptance:no_javascript"

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

