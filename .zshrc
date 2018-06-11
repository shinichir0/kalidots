# Setting===================================================================
HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000
bindkey -e
# zstyle :compinstall filename '/home/shin-ichiro/.zshrc'

# autoload -Uz compinit compinit -u

# Zsh setting===============================================================
setopt auto_cd
function chpwd() { ls --color }
function dict() {
    grep $1 ~/kalidots/dict/gene.txt -E -A 1 -wi --color=always | less -FX
}
function jdict() {
    grep $1 ~/kalidots/dict/gene.txt -E -B 1 -wi --color=always | less -FX
}
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
alias ...='cd ../..'
alias ....='cd ../../..'
setopt auto_pushd
setopt pushd_ignore_dups
setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
precmd () {
  echo -ne "\e]2;${PWD}\a"
  echo -ne "\e]1;${PWD:t}\a"
}
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Alias=====================================================================
alias ls='ls --color'
alias la='ls -a'
alias ll='ls -l'
alias pipu='pip list --outdated --format=columns | awk "{print $1}" | tail -n +3 | xargs pip install -U 2>/dev/null || echo "pip: No Packages to Update"'
alias pipu3='pip3 list --outdated --format=columns | awk "{print $1}" | tail -n +3 | xargs pip3 install -U 2>/dev/null || echo "pip3: No Packages to Update"'
alias pipup='pip install --upgrade pip'
alias pipup3='pip3 install --upgrade pip'
alias vi='VIM=/usr/share/vim VIMRUNTIME=/usr/share/vim/vim74 vi'
alias vim='nvim'
alias svim='sudoedit'
alias py='python3'
alias ipy='ipython'
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'
alias tree="tree -I 'nimcache'"

# Export====================================================================
export NVIM_PYTHON_LOG_FILE=/tmp/log
export NVIM_PYTHON_LOG_LEVEL=DEBUG  
export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket
export CLICOLOR=1
export PERCOL='fzf'
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
if (type /usr/share/source-highlight/src-hilite-lesspipe.sh &> /dev/null); then
    export LESS='-R'
    export LESSOPEN='| /usr/share/source-highlight/src-hilite-lesspipe.sh %s'
fi
export XDG_CONFIG_HOME=${HOME}/.config
export XDG_CACHE_HOME=${HOME}/.cache
export XDG_DATA_HOME=${HOME}/.local/share
export SHELL=/usr/bin/zsh
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# Prompt====================================================================
export PROMPT='
%F{red}%n@%m$%f '
export RPROMPT='%F{red}[%~]%f'
function rprompt-git-current-branch {
    local branch_name st branch_status

    if [ ! -e ".git" ]; then
        return
    fi
    branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
    st=`git status 2> /dev/null`
    if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
        branch_status="%F{green}"
    elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
        branch_status="%F{blue}?"
    elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
        branch_status="%F{blue}+"
    elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
        branch_status="%F{yellow}!"
    elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
        echo "%F{red}!(no branch)"
        return
    else
        branch_status="%F{blue}"
    fi
    echo "${branch_status}[$branch_name]"
}
setopt prompt_subst
export RPROMPT='`rprompt-git-current-branch`'$RPROMPT

# Tmux======================================================================
if [[ ! -n $TMUX ]]; then
  # get the IDs
  ID="`tmux list-sessions`"
  if [[ -z "$ID" ]]; then
    tmux new-session
  fi
  create_new_session="Create New Session"
  ID="$ID\n${create_new_session}:"
  ID="`echo $ID | $PERCOL | cut -d: -f1`"
  if [[ "$ID" = "${create_new_session}" ]]; then
    tmux new-session
  elif [[ -n "$ID" ]]; then
    tmux attach-session -t "$ID"
  else
    :  # Start terminal normally
  fi
fi

# Zplug=====================================================================
source ${ZPLUG_HOME}/init.zsh

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "olivierverdier/zsh-git-prompt"
zplug "b4b4r07/enhancd", use:init.sh

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load

# Zcompile==================================================================
if [ ~/.zshrc -nt ~/.zshrc.zwc ]; then
    zcompile ~/.zshrc
fi

# Profiling=================================================================
if (type zprof > /dev/null 2>&1); then
    zprof
fi
#===========================================================================
