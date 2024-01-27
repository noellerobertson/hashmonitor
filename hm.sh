#!/bin/bash

# Change everyone's passwords.
quick_change_pass() {
    read -p "Enter the password you want to set all users to including root: " password
        for user in `awk -F: '($3>=1000)&&($1!="nobody"){print $1}' /etc/passwd`
    do
        echo "$password" | sudo passwd --stdin "$user"
    done
}

# Lock non-users.

lock_all_non_users() {
    for user in `awk -F: '($1!="root")&&($1!="nobody")&&($1!="sysadmin"){print $1}' /etc/passwd`
    do
        passwd -l $user
    done
}

# UFW 

sudo ufw --force disable
sudo ufw --force reset
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 53
sudo ufw --force enable
sudo ufw reload
sudo cp -r /etc/bind /srv/

