#!/bin/zsh

for f in .??*
do
    [[ "$f" == ".git" ]] && continue

    echo "$f"
    ln -s $HOME/kalidots/$f $HOME/$f
done

mkdir -p $HOME/.config 2>/dev/null
mkdir -p $HOME/kalidots/nvim/backup 2>/dev/null
ln -s $HOME/kalidots/nvim $HOME/.config/nvim
ln -s $HOME/kalidots/git $HOME/.config/git
zcompile ${HOME}/.zshrc

# apt packages
sudo apt install zsh neovim tmux xsel git tree curl wget source-highlight ctags global software-properties-common snapd
~/kalidots/nim_build.sh
pip install neovim

## zplug
git clone https://github.com/zplug/zplug $ZPLUG_HOME
## tmux plugins
mkdir -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
## fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
## powerline font
git clone https://github.com/powerline/fonts.git --depth=1 && cd fonts && ./install.sh && cd .. & rm -rf fonts
fc-cache -vf
