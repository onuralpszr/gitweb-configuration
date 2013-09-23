#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   	echo "This script must be run as root" 1>&2
   		exit 1
   		else 
   	 echo "Installing proper Git and git-web package for further usage."
   	 	sleep 5
   	 	yum -y install git git-daemon gitweb git-all
   	 echo "Packages has been installed or already installed"
   	 	sleep 5
   	 echo "************************************************************"
   	 echo "Git user gonna create"
   	 	useradd -U -d /var/cache/git -s /usr/libexec/git-core/git-shell git
   	 	chown -R git:git /var/cache/git
   	 	chmod 755 /var/cache/git
   	 echo "************************************************************"
   	 echo "SSH key file placeholder gonna create"
   	 	mkdir /var/cache/git/.ssh
   	 	chmod 700 /var/cache/git/.ssh
   	 	touch /var/cache/git/.ssh/authorized_keys
   	 	chown -R git:git .ssh/
   	 echo "************************************************************"
   	 echo "Git-web server config file gonna be copy to proper place" 1>&2
   	 echo "File List gonna be copy."
   		 tree
   	 	sleep 5
   	 echo "************************************************************"
   	 echo "Service File copying to /etc/init.d/"
   	 	sleep 5
   	 	cp -r git /etc/init.d/git
   	 	chmod 755 /etc/init.d/git
   	 	sleep 5
   	 echo "************************************************************"
   	 echo "Git Service file creating and enable on boot"
   	 echo "You can cancel by using systemctl disable git.service command as a root"
   	 	cp -r .service/git.service /lib/systemd/system/
   	 	systemctl enable git.service
   	 	syscemctl start git.service
   	 	sleep 5
   	 echo "************************************************************"
   	 echo "Git-web apache config copying to /etc/httpd/conf.d/ "
   	 echo "Also initial config file gonna back-up and file extension will be .bak"
   	 	cp -r /etc/httpd/conf.d/git.conf /etc/httpd/conf.d/git.conf.bak
   	 	cp -r ./configuration/git.conf /etc/httpd/conf.d
   	 	sleep 5
   	 echo "************************************************************"
   	 echo "Git-web server config file copying to /etc/"
   	 echo "Also initial config file gonna back-up and file extension will be .bak"
   	 	cp -r /etc/gitweb.conf /etc/gitweb.conf.bak
   	 	cp -r ./configuration/gitweb.conf /etc/gitweb.conf
   	 	sleep 5
   	 echo "************************************************************"
   	 echo "Httpd server gonna start and enable for all start."
   	 	systemctl start httpd.service
   	 	systemctl enable httpd.service
   	 echo "************************************************************"
   exit 	
   fi

