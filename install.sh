#!/bin/bash

base=`pwd`

vimPackageName=vim-7.3.tar.bz2
vimUnzipFolderName=vim73
vimPackageRemote=ftp://ftp.vim.org/pub/vim/unix/vim-7.3.tar.bz2
vimPackageLocal=$base/$vimPackageName
vimTargetFolder=$HOME/local/vim

function downloadSrcPackage() {
	# arg1 is download address, arg2 is local full path
	remoteAddress=$1
	localFullPath=$2
	echo "start downloading from $remoteAddress to $localFullPath"
	if [[ -f $localFullPath ]]; then
		echo "File exists. Download skip."
		return
	else
		echo "Download start!"
		wget $remoteAddress
		echo "Download finished!"
	fi
}

function unzipPackage() {
	# arg1 is local file full path
	localFullPath=$1
	tar xf $localFullPath
}

function checkTargetExist() {
	# arg1 is targetFolder
	targetFolder=$1
	echo $targetFolder
	if [[ ! -d $localFullPath ]]; then
		read -p "The target Folder $targetFolder exists. Force install? (y/n)" -n 1 f
		echo ""
		if [[ $f"x" == "yx" ]]; then
			rm -fr $targetFolder
		else
			exit 0 
		fi
	fi
}

function install_vim() {
	checkTargetExist $vimTargetFolder
	downloadSrcPackage $vimPackageRemote $vimPackageLocal
	rm $vimUnzipFolderName -fr
	unzipPackage $vimPackageLocal
	cd $vimUnzipFolderName
	./configure --prefix=$vimTargetFolder
	cpuCount=`cat /proc/cpuinfo | grep processor | wc -l`
	make -j$cpuCount && make install
}

function install_tmux() {
	echo "tmux will come out soon;"
}

function main() {
	if [[ $# != 1 ]]; then 
		echo "Let me know what you wanna to install!"
		return ;
	else
		install_$1
	fi
}

main $@
