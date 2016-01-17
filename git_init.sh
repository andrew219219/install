#!/bin/sh

GIT_USER=$USER
GIT_MAIL=wangguohui@lianjia.com


function __main(){
	set -e
	which git
	git config --global user.name $GIT_USER
	git config --global user.email $GIT_MAIL
	if [ ! -f $HOME/.ssh/id_rsa.pub ] ; then
   		ssh-keygen -t rsa -C $GIT_MAIL
	fi

	git config --global alias.st status
	git config --global alias.ci commit
	git config --global alias.co checkout
	git config --global alias.pl pull
	git config --global color.ui true
}

__main
