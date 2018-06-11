# Profiling=====================================================================
#zmodload zsh/zprof && zprof

# Path==========================================================================
export ZPLUG_HOME=${HOME}/.zplug
export NIM_HOME=${HOME}/.Nim
#export NODEBREW_HOME=${HOME}/.nodebrew/current
export PATH=${NIM_HOME}/bin:$PATH

# Editor========================================================================
export EDITOR=nvim
export PAGER=less
export VIM=/usr/share/nvim
export VIMRUNTIME=/usr/share/nvim/runtime
