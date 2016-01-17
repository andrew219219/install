#!/bin/sh

function __main(){
	set -e
	if [ ! -d ~/.vim/bundle/Vundle.vim ] ; then
		git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim --depth=1
	fi
	cat configs/vimrc_vundle > $HOME/.vimrc
	vim +PluginInstall +qall
	cat configs/vimrc_origin >> $HOME/.vimrc
}

__main
