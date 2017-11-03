#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
# curl -qsL https://raw.githubusercontent.com/FulbrightNguyen/happylife/master/Install.sh | bash -- && exec bash
clear
echo ""
echo " ============================================================"
echo "                       DRAGONBALL 0.0.2"
echo ""
echo "                  This will take a few seconds"
echo ""
echo "                DEBUG VERSION WITH A LOT OF OUTPUT"
echo ""
echo " ============================================================"
echo ""
# ============================ LETS MAGIC BEGINS =========================================================================================

echo "(1/6) Update the base system & Install traffic exchange apps..."
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#Install some traffic exchange script on VPS ubuntu 16.04.
#- hitleap.com
#- kilohits.com
#- websyndic.com (Browser)
#- otohits.net (Need memory more than 1GB)
#Requirement
#- SSH client (port forwarding need) or Putty
#- VNC client
sudo su
cd /home/
##PREPARE VNC Server with multiple users
sudo apt update && sudo apt upgrade -y && sudo apt install gnome-core xfce4 xfce4-goodies tightvncserver autocutsel expect -y
#then add users
#Set vncserver root password
/usr/bin/expect << EOF
set timeout -1
spawn vncpasswd
match_max 100000
expect -exact "Using password file /root/.vnc/passwd\r
Password: "
send -- "Win@123\r"
expect -exact "\r
Verify:   "
send -- "Win@123\r"
expect -exact "\r
Would you like to enter a view-only password (y/n)? "
send -- "n\r"
expect eof
exit
EOF

#vncserver -kill :1
#mv /root/.vnc/xstartup /root/.vnc/xstartup.backup
#nano /root/.vnc/xstartup
echo '#!/bin/bash
unset SESSION_MANAGER
[ -r ~/.Xresources ] && xrdb ~/.Xresources
autocutsel -fork
startxfce4 &
' > /root/.vnc/xstartup

#make it executable:  
sudo chmod +x /root/.vnc/xstartup
sudo vncserver :1

#Add another users
USER1='honeycomb01'
#sudo adduser honeycomb01
sudo useradd -m -c "honeycomb01" honeycomb01 -s /bin/bash -d /home/honeycomb01
sudo usermod -aG sudo honeycomb01
echo 'honeycomb01 ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

#Add another users
USER2='honeycomb02'
#sudo adduser honeycomb01
sudo useradd -m -c "honeycomb02" honeycomb02 -s /bin/bash -d /home/honeycomb02
sudo usermod -aG sudo honeycomb02
echo 'honeycomb02 ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

#Add another users
USER3='honeycomb03'
#sudo adduser honeycomb01
sudo useradd -m -c "honeycomb03" honeycomb03 -s /bin/bash -d /home/honeycomb03
sudo usermod -aG sudo honeycomb03
echo 'honeycomb03 ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

echo '#!/bin/sh
myuser="root"
mypasswd="1"
mkdir -p /$myuser/.vnc
echo $mypasswd | vncpasswd -f > /$myuser/.vnc/passwd
chown -R $myuser:$myuser /$myuser/.vnc
chmod 0600 /$myuser/.vnc/passwd' > /home/setVncRootPasswd.sh
sudo chmod 777 /home/setVncRootPasswd.sh
sudo /home/./setVncRootPasswd.sh
sudo rm -rf /home/setVncRootPasswd.sh

echo '#!/bin/sh    
myuser="$1"
mypasswd="1"
mkdir -p /home/$myuser/.vnc
echo $mypasswd | vncpasswd -f > /home/$myuser/.vnc/passwd
chown -R $myuser:$myuser /home/$myuser/.vnc
chmod 0600 /home/$myuser/.vnc/passwd' > /home/setVncUserPasswd.sh
sudo chmod 777 /home/setVncUserPasswd.sh
sudo rm -rf /home/setVncUserPasswd.sh
#reset root vnc passwd

#USER1
#Run command in other user by using
#su user -c "command"
#or
#sudo -u user "command"
su - $USER1 -c "cd /home/"
#install necessary stuff for desktop
su - $USER1 -c "sudo apt install gnome-core xfce4 xfce4-goodies tightvncserver autocutsel -y"
#setVncPasswd.sh
#$ ./setVncPasswd <myuser> <mypasswd>
#su - $USER1 -c "sudo chown -R $USER1 /home/$USER1/setVncPasswd.sh && sudo chmod 777 /home/$USER1/setVncPasswd.sh"
su - $USER1 -c "sudo /home/./setVncUserPasswd.sh honeycomb01"
#su - $USER1 -c "rm -rf /home/$USER1/setVncPasswd.sh"
#su - $USER1 -c "vncserver -kill :2"
#su - $USER1 -c "mv /home/$USER1/.vnc/xstartup /home/$USER1/.vnc/xstartup.backup"
#nano ~/.vnc/xstartup
echo '#!/bin/bash
unset SESSION_MANAGER
[ -r ~/.Xresources ] && xrdb ~/.Xresources
autocutsel -fork
startxfce4 &
' > /home/$USER1/.vnc/xstartup
#make it executable:  
su - $USER1 -c "sudo chown -R $USER1 /home/$USER1/.vnc/xstartup && sudo chmod 777 /home/$USER1/.vnc/xstartup"
su - $USER2 -c "vncserver :2"

#USER2
#Run command in other user by using
#su user -c "command"
#or
#sudo -u user "command"
su - $USER2 -c "cd /home/"
#install necessary stuff for desktop
su - $USER2 -c "sudo apt install gnome-core xfce4 xfce4-goodies tightvncserver autocutsel -y"
#setVncPasswd.sh
#$ ./setVncPasswd <myuser> <mypasswd>
#su - $USER2 -c "sudo chown -R $USER2 /home/$USER2/setVncPasswd.sh && sudo chmod 777 /home/$USER2/setVncPasswd.sh"
su - $USER2 -c "sudo /home/./setVncUserPasswd.sh honeycomb02"
#su - $USER2 -c "rm -rf /home/$USER2/setVncPasswd.sh"
#su - $USER2 -c "vncserver -kill :3"
#su - $USER2 -c "mv /home/$USER2/.vnc/xstartup /home/$USER2/.vnc/xstartup.backup"
#nano ~/.vnc/xstartup
echo '#!/bin/bash
unset SESSION_MANAGER
[ -r ~/.Xresources ] && xrdb ~/.Xresources
autocutsel -fork
startxfce4 &
' > /home/$USER2/.vnc/xstartup
#make it executable:  
su - $USER2 -c "sudo chown -R $USER2 /home/$USER2/.vnc/xstartup && sudo chmod 777 /home/$USER2/.vnc/xstartup"
su - $USER2 -c "vncserver :3"

#USER3
#Run command in other user by using
#su user -c "command"
#or
#sudo -u user "command"
su - $USER3 -c "cd /home/"
#install necessary stuff for desktop
su - $USER3 -c "sudo apt install gnome-core xfce4 xfce4-goodies tightvncserver autocutsel -y"
#setVncPasswd.sh
#$ ./setVncPasswd <myuser> <mypasswd>
#su - $USER3 -c "sudo chown -R $USER3 /home/$USER3/setVncPasswd.sh && sudo chmod 777 /home/$USER3/setVncPasswd.sh"
su - $USER3 -c "sudo /home/./setVncUserPasswd.sh honeycomb03"
#su - $USER3 -c "rm -rf /home/$USER3/setVncPasswd.sh"
#su - $USER3 -c "vncserver -kill :4"
#su - $USER3 -c "mv /home/$USER3/.vnc/xstartup /home/$USER3/.vnc/xstartup.backup"
#nano ~/.vnc/xstartup
echo '#!/bin/bash
unset SESSION_MANAGER
[ -r ~/.Xresources ] && xrdb ~/.Xresources
autocutsel -fork
startxfce4 &
' > /home/$USER3/.vnc/xstartup
#make it executable:  
su - $USER3 -c "sudo chown -R $USER3 /home/$USER3/.vnc/xstartup && sudo chmod 777 /home/$USER3/.vnc/xstartup"
su - $USER3 -c "vncserver :4"


#So, switch to root (it is just more easier) and then create vncserver folder and create file as vncservers.conf:
########################################
mkdir -p /etc/vncserver
echo 'VNCSERVERS="1:root 2:honeycomb01 3:honeycomb02 4:honeycomb03"
VNCSERVERARGS[1]="-geometry 1920x1068 -depth 16"
VNCSERVERARGS[2]="-geometry 1920x1068 -depth 16"
VNCSERVERARGS[3]="-geometry 1920x1068 -depth 16"
VNCSERVERARGS[4]="-geometry 1920x1068 -depth 16"
' > /etc/vncserver/vncservers.conf

sudo chmod 777 /etc/vncserver/vncservers.conf
#Create vnc service file
#sudo nano /etc/init.d/vncserver
echo '#!/bin/bash
unset VNCSERVERARGS
VNCSERVERS=""
[ -f /etc/vncserver/vncservers.conf ] && . /etc/vncserver/vncservers.conf
prog=$"VNC server"
start() {
        . /lib/lsb/init-functions
        REQ_USER=$2
        echo -n $"Starting $prog: "
        ulimit -S -c 0 >/dev/null 2>&1
        RETVAL=0
        for display in ${VNCSERVERS}
        do
                export USER="${display##*:}"
                if test -z "${REQ_USER}" -o "${REQ_USER}" == ${USER} ; then
                        echo -n "${display} "
                        unset BASH_ENV ENV
                        DISP="${display%%:*}"
                        export VNCUSERARGS="${VNCSERVERARGS[${DISP}]}"
                        su ${USER} -c "cd ~${USER} && [ -f .vnc/passwd ] && vncserver :${DISP} ${VNCUSERARGS}"
                fi
        done
}
stop() {
        . /lib/lsb/init-functions
        REQ_USER=$2
        echo -n $"Shutting down VNCServer: "
        for display in ${VNCSERVERS}
        do
                export USER="${display##*:}"
                if test -z "${REQ_USER}" -o "${REQ_USER}" == ${USER} ; then
                        echo -n "${display} "
                        unset BASH_ENV ENV
                        export USER="${display##*:}"
                        su ${USER} -c "vncserver -kill :${display%%:*}" >/dev/null 2>&1
                fi
        done
        echo -e "\n"
        echo "VNCServer Stopped"
}
case "$1" in
start)
start $@
;;
stop)
stop $@
;;
restart|reload)
stop $@
sleep 3
start $@
;;
condrestart)
if [ -f /var/lock/subsys/vncserver ]; then
stop $@
sleep 3
start $@
fi
;;
status)
status Xvnc
;;
*)
echo $"Usage: $0 {start|stop|restart|condrestart|status}"
exit 1
esac
' > /etc/init.d/vncserver

#Make the script executable, and add it to the startup scripts:
sudo chmod 777 /etc/init.d/vncserver
update-rc.d vncserver defaults
#Run this if have a warning, your script will still work: sudo apt-get remove insserv
#Start the service
systemctl daemon-reload
service vncserver stop
service vncserver start
#Check that its running
#service vncserver status
#cat ~/.vnc/*.pid
#ps -ef | grep tightvnc
#netstat -nlp | grep vnc

#Go to Desktop
########################################
cd /home/
#Download toolkit from github
#git init
git clone https://github.com/nnquangminh/mmo.git
#git remote add origin https://github.com/nnquangminh/mmo.git
#git pull origin master
#Extract file
sudo tar Jxvf /home/mmo/hit.tar.xz -C /root/Desktop/ && unzip /home/mmo/kilohits.com-viewer-linux-x64.zip -d /root/Desktop/ && unzip /home/mmo/OtohitsApp_3107_Linux.zip -d /root/Desktop/ && unzip /home/mmo/crossover_13.1.3-1.zip -d /root/Desktop/mmo/ && unzip /home/mmo/jingling.zip -d /root/Desktop/ && unzip /home/mmo/proxy_scraper.zip -d /home/proxy
sudo tar Jxvf /home/mmo/hit.tar.xz -C /home/honeycomb01/Desktop/ && unzip /home/mmo/kilohits.com-viewer-linux-x64.zip -d /home/honeycomb01/Desktop/ && unzip /home/mmo/OtohitsApp_3107_Linux.zip -d /home/honeycomb01/Desktop/
sudo tar Jxvf /home/mmo/hit.tar.xz -C /home/honeycomb02/Desktop/ && unzip /home/mmo/kilohits.com-viewer-linux-x64.zip -d /home/honeycomb02/Desktop/ && unzip /home/mmo/OtohitsApp_3107_Linux.zip -d /home/honeycomb02/Desktop/
sudo tar Jxvf /home/mmo/hit.tar.xz -C /home/honeycomb03/Desktop/ && unzip /home/mmo/kilohits.com-viewer-linux-x64.zip -d /home/honeycomb03/Desktop/ && unzip /home/mmo/OtohitsApp_3107_Linux.zip -d /home/honeycomb03/Desktop/
sudo chown honeycomb01 -R /home/honeycomb01/Desktop/* && sudo chmod ugo+x -R /home/honeycomb01/Desktop/* && sudo chown honeycomb02 -R /home/honeycomb02/Desktop/* && sudo chmod ugo+x -R /home/honeycomb02/Desktop/* && sudo chown honeycomb03 -R /home/honeycomb03/Desktop/* && sudo chmod ugo+x -R /home/honeycomb03/Desktop/*
#or 
#Hitleap
# wget https://hitleap.com/viewer/download?platform=Linux -O hit.tar.xz && tar Jxvf hit.tar.xz
##or for vultr vps
# #wget https://www.dropbox.com/s/u1v0e91ofgh0mer/hit.tar.xz?dl=0 -O hit.tar.xz && tar Jxvf hit.tar.xz
#Kilohits
# wget https://www.dropbox.com/s/ytf7kwc1kiiclz9/kilohits.com-viewer-linux-x64.zip?dl=0 -O kilohits.com-viewer-linux-x64.zip && unzip kilohits.com-viewer-linux-x64.zip
#Otohits (Need 1GB memory)
# wget http://www.otohits.net/dl/OtohitsApp_3107_Linux.zip && unzip OtohitsApp_3107_Linux.zip

#Libnss3 (kilohits) libcurl3 (Otohits) firefox(websyndic)
apt install libnss3 libcurl3 firefox -y
#Have the Hitleap, Kilohits, Otohits run when reboot:
mkdir /root/.config/autostart
#sudo nano /usr/local/bin/autostart.sh
echo '#!/bin/bash
export DISPLAY=:1 && firefox | /home/OtohitsApp/./OtohitsApp | /home/kilohits.com-viewer-linux-x64/./kilohits.com-viewer | (/home/app/./HitLeap-Viewer && wait)
' >> /usr/local/bin/autostart.sh

chmod ugo+x /usr/local/bin/autostart.sh
echo '[Desktop Entry]
Type=Application
Exec=/usr/local/bin/autostart.sh
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=Startup Script
' >> /root/.config/autostart/.desktop
#sudo nano ~/.config/autostart/.desktop
chmod ugo+x ~/.config/autostart/.desktop
#Next Install for Jingling & Traffic Spirit
#Install wine
#If have old wine version then run following command to remove
#sudo apt-get remove --purge wine-devel*
#sudo apt-get update
#sudo apt-get autoclean
#sudo apt-get clean
#sudo apt-get autoremove
sudo dpkg --add-architecture i386
sudo apt-add-repository 'https://dl.winehq.org/wine-builds/ubuntu/'
wget https://dl.winehq.org/wine-builds/Release.key && sudo apt-key add Release.key
sudo apt update && sudo apt install winehq-stable -y
#Install winetricks
sudo apt-get install winetricks -y
#Install CrossOver
sudo apt-get -f install
sudo apt-get install gdebi -y
apt-get install python-gtk2 -y
sudo dpkg -i /home/mmo/crossover_13.1.3-1/crossover_13.1.3-1.deb
sudo apt-get -f install
sudo dpkg -i /home/mmo/crossover_13.1.3-1/crossover_13.1.3-1.deb
#To Reconfigure: sudo dpkg-reconfigure /home/mmo/crossover_13.1.3-1/crossover_13.1.3-1.deb
#CRACK CrossOver by copy winewrapper.exe.so file to overwriting existing file in this dir: /opt/cxoffice/lib/wine
cp -rf /home/mmo/crossover_13.1.3-1/crack/winewrapper.exe.so /opt/cxoffice/lib/wine/
#Uninstall CrossOver: 
#sudo /opt/cxoffice/bin/cxuninstall
#cd ~/Desktop
#git clone https://github.com/nnquangminh/mmotoolkit.git
#Install copy/paste text from remote system
#sudo apt-get install autocutsel
#on Desktop screen, run terminal to create other prefix (e.g. : .wine32), set WINEARCH to win32 and run winecfg:
# WINEPREFIX="$HOME/.wine32" WINEARCH=win32 winecfg
# "Set Windows 7"
#Then run winetricks using the last configurations:
# WINEPREFIX="$HOME/.wine32" WINEARCH=win32 winetricks
#Copy gacutil-net40.tar.bz2 file from mmtoolkit dir to /root/.cache/winetricks/dotnet40/ ->rerun
#add ref link to jingling: 
# https://www.tumblr.com/
# https://plus.google.com/
# https://www.facebook.com/
#User has to belong to the "crontab" group
sudo usermod -aG crontab root
sudo usermod -aG crontab honeycomb01
sudo usermod -aG crontab honeycomb02
sudo usermod -aG crontab honeycomb03
sudo chmod ug+x /etc/crontab
#Task management
apt install htop
#Generate a report of the network usage 
apt-get install vnstat
#To monitor the bandwidth usage in realtime, use: vnstat -l -i eth0   
#Disable vps from going to sleep 
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
#Disable screen off or screensaver by caffeine-indicator
# sudo add-apt-repository ppa:caffeine-developers/ppa
# sudo apt-get update
# sudo apt-get install caffeine
#New versions of Caffeine don't show up anywhere. They work in background and disable screensaver
#Run the caffeine indicator from terminal and run the command
#caffeine
#Configure the network interface
#sudo nano /etc/network/interfaces
sed -i s'/dns-nameservers.*/dns-nameservers 8.8.8.8 8.8.4.4/g' /etc/network/interfaces
#Using nameservers 8.8.8.8 and 8.8.4.4 are provided by Google for public use -> dns-nameservers 8.8.8.8 8.8.4.4 ->  Type Ctrl+x to save changes.
#Manually restart your network interface with the new settings
#systemctl restart ifup@eth0
/etc/init.d/networking restart

#Auto restart a crashed app
echo '#!/bin/bash
COUNTER=0
while [  $COUNTER -lt 10 ]; do
/home/app/./HitLeap-Viewer && /home/kilohits.com-viewer-linux-x64/./kilohits.com-viewer > /dev/null 2>&1
sleep 10800 #3 hour
killall /home/app/./HitLeap-Viewer && /home/kilohits.com-viewer-linux-x64/./kilohits.com-viewer > /dev/null 2>&1
sleep 10
done' >> /root/autorestartCrashedApp
sudo chmod +x /root/autorestartCrashedApp
sudo chown root /root/autorestartCrashedApp
#crontab -e
echo '0 * * * * root /root/autorestartCrashedApp' >> /etc/crontab

#Done!


echo "(2/6) Run unlimited hitleap and kilohits viewer"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#PREPARE VNC Server with multiple users 
#We must seperate all linux users' TMP directories. That is the problem why traffic exchange viewers don't run multiple.
#STEP 1 : Seperating tmp directories for each user
#Press CTRL ALT T and open terminal screen
#type this on terminal screen:
echo 'if [[ -O /home/$USER/tmp && -d /home/$USER/tmp ]]; then
TMPDIR=/home/$USER/tmp
else
# You may wish to remove this line, it is there in case
# a user has put a file ‘tmp’ in there directory or a
rm -rf /home/$USER/tmp 2> /dev/null
mkdir -p /home/$USER/tmp
TMPDIR=$(mktemp -d /home/$USER/tmp/XXXX)
fi

TMP=$TMPDIR
TEMP=$TMPDIR

export TMPDIR TMP TEMP

' >> /etc/profile
#type reboot on your terminal screen to restart your system with new settings
# reboot
#We are ready to run multiple traffic exchange viewers but we need proxy settings to each viewers now. We will install the proxychains for this
#STEP 2: Installing proxychains
#Press CTRL ALT T and open terminal screen
#Install proxychains-ng
#Type these commands one by one for add proxychains-ng repository
#sudo add-apt-repository ppa:hda-me/proxychains-ng
#sudo apt-get update
cd /home
#or cd /srv 
git clone https://github.com/rofl0r/proxychains-ng.git
cd proxychains-ng
./configure --prefix=/usr --sysconfdir=/etc
make && make install
sudo make install-config
#Install Parallel
wget ftp://ftp.gnu.org/gnu/parallel/parallel-latest.tar.bz2
tar -jxvf parallel-latest.tar.bz2
#find  /home -type d -iname "parallel-*"
dirtemp=$(find /home -type d -iname "parallel-*" -maxdepth 3 -print | grep 'parallel-*' | head -n 1)
cd $dirtemp
./configure && make
make install

#STEP 3: Configuring proxychains and proxies
#We will define each proxy on each other configuration file, create each proxy for another configuration file 
#just change it proxychains57 to proxychains58, proxychains59 or whatever you want and create your proxy configuration files
cp /etc/proxychains.conf /etc/honeycomb01.conf
cp /etc/proxychains.conf /etc/honeycomb02.conf
cp /etc/proxychains.conf /etc/honeycomb03.conf
#or by manual: sudo touch /etc/honeycomb01.conf
#You need to define another conf file for each proxy. It is easy. Type this command for edit configuration file:
#sudo nano /etc/honeycomb01.conf
#Delete everthing on conf file and add these lines or edit your conf file like this:
#(Write under)
#dynamic_chain
#tcp_read_time_out 15000
#tcp_connect_time_out 8000
#[ProxyList] http IP_NUMBER PORT_NUMBER USER_NAME PASSWORD
#(End)
#eg: http 116.48.136.128 8080
#STEP 4: Installing traffic viewers
#Open firefox and login to your kilohits account. Click viewer and click linux viewer to download it. After download finished extract it.
#STEP 5: Running viewer with proxychains
#Type this command on the terminal screen to run first viewer
# proxychains4 -f /etc/proxychains57.conf /home/USER_NAME/Downloads/PATH_TO_VIEWER/VIEWER_NAME
#eg:remote from root: export DISPLAY=:2 && proxychains4 -f /etc/honeycomb01.conf /home/honeycomb01/Desktop/kilohits.com-viewer-linux-x64/kilohits.com-viewer
# proxychains4 -f /etc/honeycomb01.conf /home/honeycomb01/Desktop/app/HitLeap-Viewer
# proxychains4 -f /etc/honeycomb01.conf /home/honeycomb01/Desktop/kilohits.com-viewer-linux-x64/kilohits.com-viewer
#-f /etc /etc/proxychains57.conf line means you are running viewer with this proxy settings. 
#You can change this and run multiple viewers with each proxy settings. Dont run another instance on the same user for same viewer, 
#it will use same proxy. Create another user and change proxy conf settings and run the viewer.
#STEP 6: Run multiple viewers
#Create another user on ubuntu
#Switch to new user
#Download or copy viewer to this users home directory or whereever you want
#Change proxy configuration file on the command line proxychains4 and run another viewer, like this:
# proxychains4 -f /etc/honeycomb01.conf /home/honeycomb01/Desktop/app/HitLeap-Viewer
# proxychains4 -f /etc/honeycomb02.conf /home/honeycomb02/Desktop/app/HitLeap-Viewer
# proxychains4 -f /etc/honeycomb01.conf /home/honeycomb01/Desktop/kilohits.com-viewer-linux-x64/kilohits.com-viewer
# proxychains4 -f /etc/honeycomb02.conf /home/honeycomb02/Desktop/kilohits.com-viewer-linux-x64/kilohits.com-viewer
# proxychains4 -f /etc/anotherconf.conf /home/USER_NAME/Downloads/PATH_TO_VIEWER/VIEWER_NAME
#ProxyList
#cd ~/
#git clone https://github.com/FulbrightNguyen/dragonball.git
#cd dragonball
 chmod ugo+x /home/proxy/*
# cd /home/proxy
# ./proxy_scraper.sh
#login honeycomb01 user
 su $USER1
 su $USER1 -c "cd /home/"
#Have the proxychains4 run when reboot:
#nano ~/autoHoneycomb01
echo '#!/bin/bash
proxychains4 -f /etc/honeycomb01.conf /home/honeycomb01/Desktop/app/HitLeap-Viewer && proxychains4 -f /etc/honeycomb01.conf /home/honeycomb01/Desktop/kilohits.com-viewer-linux-x64/kilohits.com-viewer > /dev/null 2>&1
' >> /home/honeycomb01/autoHoneycomb01
chmod ugo+x /home/honeycomb01/autoHoneycomb01
#At the bottom of crontab file add the line then save the file below: (Ctrl+w+v)
#echo '0 * * * * export DISPLAY=:2 && honeycomb01 /home/honeycomb01/autoHoneycomb01' >> /etc/crontab
sed -i '$ a 0 * * * * export DISPLAY=:2 && honeycomb01 /home/honeycomb01/./autoHoneycomb01' /etc/crontab


#login honeycomb02 user
su $USER2
su $USER2 -c "cd /home/"
#Have the proxychains4 run when reboot:
#nano ~/autoHoneycomb02
echo '#!/bin/bash
proxychains4 -f /etc/honeycomb02.conf /home/honeycomb02/Desktop/kilohits.com-viewer-linux-x64/kilohits.com-viewer > /dev/null 2>&1
' >> /home/honeycomb02/autoHoneycomb02
chmod ugo+x /home/honeycomb02/autoHoneycomb02
#At the bottom of crontab file add the line then save the file below: (Ctrl+w+v)
#echo '0 * * * * export DISPLAY=:3 && honeycomb02 /home/honeycomb02/autoHoneycomb02' >> /etc/crontab
sed -i '$ a 0 * * * * export DISPLAY=:3 && honeycomb02 /home/honeycomb02/./autoHoneycomb02' /etc/crontab

#login honeycomb03 user
su $USER3
su $USER3 -c "cd /home/"
#Have the proxychains4 run when reboot:
#nano ~/autoHoneycomb03
echo '#!/bin/bash
proxychains4 -f /etc/honeycomb03.conf /home/honeycomb02/Desktop/kilohits.com-viewer-linux-x64/kilohits.com-viewer > /dev/null 2>&1
' >> /home/honeycomb02/autoHoneycomb03
chmod ugo+x /home/honeycomb02/autoHoneycomb03
#At the bottom of crontab file add the line then save the file below: (Ctrl+w+v)
#echo '0 * * * * export DISPLAY=:3 && honeycomb02 /home/honeycomb02/autoHoneycomb03' >> /etc/crontab
sed -i '$ a 0 * * * * export DISPLAY=:3 && honeycomb02 /home/honeycomb02/./autoHoneycomb03' /etc/crontab



echo "(3/6) eBesucher hang up money tutorial (LXDE + VNC + restarter)"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#Hang up conditions: VPS memory 512M or more; A European IP VPS
##PREPARE VNC Server with multiple users
#Use cpulimit to limit the use of firefox to prevent stuck
########################################
sudo apt-get install cpulimit
# linux -> cpulimit -> "sudo apt-get install cpulimit " then "cpulimit -p PID -l 10 -v" -> this means limit this pid to 10% if cpu. You can also just use paths or names like "cpulimit -e firefox -l 10 -v".
# limit firefox use 50% cpu utilization 
# sudo cpulimit -e firefox -l 50 > /dev/null 2>&1
#(2)Install the browser and Flash
cd /home/mmo/
#It is recommended to install two browsers to switch at any time
#Install Firefox:
#sudo apt-get install firefox -y
#Install chrome (optional)
sudo wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt-get -f install -y
sudo dpkg -i google-chrome-stable_current_amd64.deb
#run Google Chrome as root
#Edit the /usr/bin/google-chrome and add the "--no-sandbox" or "–user-data-dir" at the end of the last line
sed -i 's/\bexec -a "$0" "$HERE/chrome" "$@"\b/& --no-sandbox/' /usr/bin/google-chrome
#\b: a zero-width word boundary
#&: refer to that portion of the pattern space which matched
#Install Flash
#Method:
tar zxvf install_flash_player_11_linux.x86_64.tar.gz
mkdir -p ~/.mozilla/plugins/
cp libflashplayer.so ~/.mozilla/plugins/
cp libflashplayer.so /usr/lib/mozilla/plugins/
cp -r usr /usr
#Latest download address https://get.adobe.com/flashplayer/otherversions/
#(3)Install Java (optional)
#Debian:
# echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee /etc/apt/sources.list.d/webupd8team-java.list
# echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
# apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
# apt-get update
# apt-get install oracle-java8-installer
#INSTALL JAVA
echo "Ubuntu Java Installer (Oracle JDK)"
sudo apt-get install -y software-properties-common
sudo add-apt-repository -y ppa:webupd8team/java && apt-get update
sudo echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
sudo echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 seen true" | debconf-set-selections
sudo apt-get install -y oracle-java8-installer
#select Java version (Optional)
#update-alternatives --config java
#Open and edit /etc/profile file
#sudo nano /etc/profile
sed -i '$ a export JAVA_HOME="/usr/lib/jvm/java-8-oracle/jre/bin/java"' /etc/profile
#append a line after last line
# sed '$ a This is the last line' file
#Put following line in last line of the file, copy jre path from previous command:
#export JAVA_HOME="/usr/lib/jvm/java-8-oracle/jre/bin/java"
#Or copy the path from your preferred installation and then open /etc/environment
# nano /etc/environment
#At the end of this file, add the following line
# JAVA_HOME="/usr/lib/jvm/java-8-oracle/jre/bin/java"
#Reload this file, so that changes can get applied effectively
source /etc/profile
#(4)Install the restarter (optional)
#The restarter is an on-hook helper provided by ebesucher that automatically restarts the browser 
#when the browser has an error (surfing the window, stuck, crashing, etc.), which greatly facilitates us to hang up and avoid manual maintenance. 
#Download restarter
sudo wget https://www.ebesucher.com/data/restarter-setup-others.v1.2.03.zip
#sudo apt-get install unzip
sudo unzip restarter-setup-others.v1.2.03.zip -d /home/restarter
chmod 777 /home/restarter/*
#Install java and restarter, through the vnc viewer into the desktop, start the terminal interface root terminal enter the following command:
export LANG="en_US.UTF-8" 
java -jar /home/restarter/restarter.jar
su - $USER1 -c "java -jar /home/restarter/restarter.jar"
su - $USER2 -c "java -jar /home/restarter/restarter.jar"
su - $USER3 -c "java -jar /home/restarter/restarter.jar"
#(5)Set the restarter (optional)
#Start the restarter after the need to set the restarter
#Enter username and CODE can found in http://www.ebesucher.com/restarter.html 
#Please note: In order to run the restarter, you need the internal access code of the software ("Enter the generated password"). 
#On the first run of the software, you can just copy and paste the following code:
#XnR27ozqOc7S 
#Choose language language 
# Has three options, here to see your address: https://www.ebesucher.com/punkteverdienen.html
#Select the browser
#chrome need to manually set the path /opt/google/chrome/chrome --no-sandbox
#Click on the start surfbar to start the firefox to start surfing
#(5)Start surfing
#Install the Firefox plugin and set up your username
# https://www.ebesucher.com/data/firefoxaddon/latest.xpi
#Check if flash is installed successfully
#Click on the plug and start hang up
#Choose one of the most integrated areas (need to manually enter the address, the default click plugin is. Com)
# http://www.ebesucher.de/surfbar/nnquangminh
# http://www.ebesucher.com/surfbar/nnquangminh
# http://www.ebesucher.ru/surfbar/nnquangminh
# http://www.ebesucher.es/surfbar/nnquangminh
# http://www.ebesucher.fr/surfbar/nnquangminh
#(6)optimization
#The browser does not save history this is important because you've been surfing if you save history, which will result in a lot of log files. 
#Into the firefox preferences-privacy-history, set to never remember history 
#Make scripts, restart the browser and restarter regularly

#$USER1
#Firefox:
su - $USER1 -c "dbus-uuidgen > /var/lib/dbus/machine-id"
#Auto restart Autosurf Firefox
echo '#!/bin/bash
export DISPLAY=:2
while [ 1 ]
do
        echo "Stop Firefox"
        pgrep firefox && killall -9 firefox
        sleep 5
        /usr/bin/firefox -private http://10khits.com/surf https://www.websyndic.com/wv3/?p=surf01 http://www.hit4hit.org/user/earn-auto-website-view.php http://klixion.com/surf.php?id=23425 http://twistrix.com/surf3.php?Mc=de09a22d5e6419eb78430ce2dcbead81 https://www.ultraviews.net/Browser/?Username=nnquangminh > /dev/null 2>&1
        echo "Restart Firefox"
        sleep 300
done' > /home/honeycomb01/autorestartFirefoxAutosurfUser1.sh
sudo chmod a+x /home/honeycomb01/autorestartFirefoxAutosurfUser1.sh
sudo chown $USER1 /home/honeycomb01/autorestartFirefoxAutosurfUser1.sh
#Auto restart Ebesucher Firefox
echo '#!/bin/sh
export DISPLAY=:2
cd ~/
rm -rf ~/.vnc/*.log /tmp/plugtmp* > /dev/null 2>&1
killall firefox > /dev/null 2>&1
killall java > /dev/null 2>&1
/usr/bin/firefox -private http://www.ebesucher.com/surfbar/nnquangminh > /dev/null 2>&1
/usr/bin/java -jar ~/restarter.jar > /dev/null 2>&1' > /home/honeycomb01/autorestartFirefoxEbesucherUser1.sh
#cpulimit -e firefox -l 50 > /dev/null 2>&1
#Where, http://www.ebesucher.com/surfbar/username in the username to your user name
#to the script to add executable permissions 
sudo chmod a+x /home/honeycomb01/autorestartFirefoxEbesucherUser1.sh
sudo chown $USER1 /home/honeycomb01/autorestartFirefoxEbesucherUser1.sh
#*/3 * * * * [ -z "`ps -ef | grep java | grep -v grep`" ] && nohup bash /root/restart > /dev/null 2>&1 &
#The command will be 3 minutes to detect whether the process called java process, if not run the restart script. 
#So that the machine can automatically restart after the accident, if the VPS is running unstable or suspended animation, etc., 
#can be synchronized with the regular restart to achieve the purpose of automation. 
#Note that the test conditions are only applicable to you only run a Restarter this instance, if there are other JAVA instance, you can not determine whether the Restarter run!
# run this crontab entry every 9 minutes
#sed -i '$ a */9 * * * * /home/honeycomb01/autorestartFirefoxAutosurfUser1.sh' /var/spool/cron/crontabs/$USER1
#sed -i '$ a */9 * * * * /home/honeycomb01/autorestartFirefoxEbesucherUser1.sh' /var/spool/cron/crontabs/$USER1
# run this crontab entry every 3 hours
#sed -i '$ a 0 */3 * * * /home/honeycomb01/autorestartFirefoxEbesucherUser1.sh' /var/spool/cron/crontabs/$USER1
# run this crontab entry every 9 minutes
sed -i '$ a */9 * * * * honeycomb01 /home/honeycomb01/autorestartFirefoxAutosurfUser1.sh' /etc/crontab
sed -i '$ a */9 * * * * honeycomb01 /home/honeycomb01/autorestartFirefoxEbesucherUser1.sh' /etc/crontab
#Chrome:
# nano /home/honeycomb01/autorestartChromeEbesucherUser1.sh
echo '#!/bin/sh
export DISPLAY=:2
cd ~/
rm -rf ~/.vnc/*.log /tmp/plugtmp* > /dev/null 2>&1
killall java > /dev/null 2>&1
killall chrome > /dev/null 2>&1
/opt/google/chrome/chrome --new-tab http://www.ebesucher.com/surfbar/nnquangminh --no-sandbox  > /dev/null 2>&1
/usr/bin/java -jar ~/restarter.jar > /dev/null 2>&1
' > /home/honeycomb01/autorestartChromeEbesucherUser1.sh
#Where, http://www.ebesucher.com/surfbar/username in the username to your user name
#to the script to add executable permissions 
sudo chmod a+x /home/honeycomb01/autorestartChromeEbesucherUser1.sh
sudo chown $USER1 /home/honeycomb01/autorestartChromeEbesucherUser1.sh
#edit cron
#sudo nano /etc/crontab
#setup once every hour the script
# 0 * * * * honeycomb01 ~/autorestartChromeEbesucherUser1.sh
sed -i '$ a */9 * * * * honeycomb01 /home/honeycomb01/autorestartChromeEbesucherUser1.sh' /etc/crontab
#restart cron
sudo service cron restart
#End USER1

#$USER2
#Firefox:
su - $USER2 -c "dbus-uuidgen > /var/lib/dbus/machine-id"
#Auto restart Autosurf Firefox
echo '#!/bin/bash
export DISPLAY=:3
while [ 1 ]
do
        echo "Stop Firefox"
        pgrep firefox && killall -9 firefox
        sleep 5
        /usr/bin/firefox -private http://10khits.com/surf https://www.websyndic.com/wv3/?p=surf01 http://www.hit4hit.org/user/earn-auto-website-view.php http://klixion.com/surf.php?id=23425 http://twistrix.com/surf3.php?Mc=de09a22d5e6419eb78430ce2dcbead81 https://www.ultraviews.net/Browser/?Username=nnquangminh > /dev/null 2>&1
        echo "Restart Firefox"
        sleep 300
done' > /home/honeycomb01/autorestartFirefoxAutosurfUSER2.sh
sudo chmod a+x /home/honeycomb01/autorestartFirefoxAutosurfUSER2.sh
sudo chown $USER2 /home/honeycomb01/autorestartFirefoxAutosurfUSER2.sh
#Auto restart Ebesucher Firefox
echo '#!/bin/sh
export DISPLAY=:3
cd ~/
rm -rf ~/.vnc/*.log /tmp/plugtmp* > /dev/null 2>&1
killall firefox > /dev/null 2>&1
killall java > /dev/null 2>&1
/usr/bin/firefox -private http://www.ebesucher.com/surfbar/nnquangminh > /dev/null 2>&1
/usr/bin/java -jar ~/restarter.jar > /dev/null 2>&1' > /home/honeycomb01/autorestartFirefoxEbesucherUSER2.sh
#cpulimit -e firefox -l 50 > /dev/null 2>&1
#Where, http://www.ebesucher.com/surfbar/username in the username to your user name
#to the script to add executable permissions 
sudo chmod a+x /home/honeycomb01/autorestartFirefoxEbesucherUSER2.sh
sudo chown $USER2 /home/honeycomb01/autorestartFirefoxEbesucherUSER2.sh
#*/3 * * * * [ -z "`ps -ef | grep java | grep -v grep`" ] && nohup bash /root/restart > /dev/null 2>&1 &
#The command will be 3 minutes to detect whether the process called java process, if not run the restart script. 
#So that the machine can automatically restart after the accident, if the VPS is running unstable or suspended animation, etc., 
#can be synchronized with the regular restart to achieve the purpose of automation. 
#Note that the test conditions are only applicable to you only run a Restarter this instance, if there are other JAVA instance, you can not determine whether the Restarter run!
# run this crontab entry every 9 minutes
#sed -i '$ a */9 * * * * /home/honeycomb01/autorestartFirefoxAutosurfUSER2.sh' /var/spool/cron/crontabs/$USER2
#sed -i '$ a */9 * * * * /home/honeycomb01/autorestartFirefoxEbesucherUSER2.sh' /var/spool/cron/crontabs/$USER2
# run this crontab entry every 3 hours
#sed -i '$ a 0 */3 * * * /home/honeycomb01/autorestartFirefoxEbesucherUSER2.sh' /var/spool/cron/crontabs/$USER2
# run this crontab entry every 9 minutes
sed -i '$ a */9 * * * * honeycomb01 /home/honeycomb01/autorestartFirefoxAutosurfUSER2.sh' /etc/crontab
sed -i '$ a */9 * * * * honeycomb01 /home/honeycomb01/autorestartFirefoxEbesucherUSER2.sh' /etc/crontab
#Chrome:
# nano /home/honeycomb01/autorestartChromeEbesucherUSER2.sh
echo '#!/bin/sh
export DISPLAY=:3
cd ~/
rm -rf ~/.vnc/*.log /tmp/plugtmp* > /dev/null 2>&1
killall java > /dev/null 2>&1
killall chrome > /dev/null 2>&1
/opt/google/chrome/chrome --new-tab http://www.ebesucher.com/surfbar/nnquangminh --no-sandbox  > /dev/null 2>&1
/usr/bin/java -jar ~/restarter.jar > /dev/null 2>&1
' > /home/honeycomb01/autorestartChromeEbesucherUSER2.sh
#Where, http://www.ebesucher.com/surfbar/username in the username to your user name
#to the script to add executable permissions 
sudo chmod a+x /home/honeycomb01/autorestartChromeEbesucherUSER2.sh
sudo chown $USER2 /home/honeycomb01/autorestartChromeEbesucherUSER2.sh
#edit cron
#sudo nano /etc/crontab
#setup once every hour the script
# 0 * * * * honeycomb01 ~/autorestartChromeEbesucherUSER2.sh
sed -i '$ a */9 * * * * honeycomb01 /home/honeycomb01/autorestartChromeEbesucherUSER2.sh' /etc/crontab
#restart cron
sudo service cron restart
#End USER2

#$USER3
#Firefox:
su - $USER3 -c "dbus-uuidgen > /var/lib/dbus/machine-id"
#Auto restart Autosurf Firefox
echo '#!/bin/bash
export DISPLAY=:4
while [ 1 ]
do
        echo "Stop Firefox"
        pgrep firefox && killall -9 firefox
        sleep 5
        /usr/bin/firefox -private http://10khits.com/surf https://www.websyndic.com/wv3/?p=surf01 http://www.hit4hit.org/user/earn-auto-website-view.php http://klixion.com/surf.php?id=23425 http://twistrix.com/surf3.php?Mc=de09a22d5e6419eb78430ce2dcbead81 https://www.ultraviews.net/Browser/?Username=nnquangminh > /dev/null 2>&1
        echo "Restart Firefox"
        sleep 300
done' > /home/honeycomb01/autorestartFirefoxAutosurfUSER3.sh
sudo chmod a+x /home/honeycomb01/autorestartFirefoxAutosurfUSER3.sh
sudo chown $USER3 /home/honeycomb01/autorestartFirefoxAutosurfUSER3.sh
#Auto restart Ebesucher Firefox
echo '#!/bin/sh
export DISPLAY=:4
cd ~/
rm -rf ~/.vnc/*.log /tmp/plugtmp* > /dev/null 2>&1
killall firefox > /dev/null 2>&1
killall java > /dev/null 2>&1
/usr/bin/firefox -private http://www.ebesucher.com/surfbar/nnquangminh > /dev/null 2>&1
/usr/bin/java -jar ~/restarter.jar > /dev/null 2>&1' > /home/honeycomb01/autorestartFirefoxEbesucherUSER3.sh
#cpulimit -e firefox -l 50 > /dev/null 2>&1
#Where, http://www.ebesucher.com/surfbar/username in the username to your user name
#to the script to add executable permissions 
sudo chmod a+x /home/honeycomb01/autorestartFirefoxEbesucherUSER3.sh
sudo chown $USER3 /home/honeycomb01/autorestartFirefoxEbesucherUSER3.sh
#*/3 * * * * [ -z "`ps -ef | grep java | grep -v grep`" ] && nohup bash /root/restart > /dev/null 2>&1 &
#The command will be 3 minutes to detect whether the process called java process, if not run the restart script. 
#So that the machine can automatically restart after the accident, if the VPS is running unstable or suspended animation, etc., 
#can be synchronized with the regular restart to achieve the purpose of automation. 
#Note that the test conditions are only applicable to you only run a Restarter this instance, if there are other JAVA instance, you can not determine whether the Restarter run!
# run this crontab entry every 9 minutes
#sed -i '$ a */9 * * * * /home/honeycomb01/autorestartFirefoxAutosurfUSER3.sh' /var/spool/cron/crontabs/$USER3
#sed -i '$ a */9 * * * * /home/honeycomb01/autorestartFirefoxEbesucherUSER3.sh' /var/spool/cron/crontabs/$USER3
# run this crontab entry every 3 hours
#sed -i '$ a 0 */3 * * * /home/honeycomb01/autorestartFirefoxEbesucherUSER3.sh' /var/spool/cron/crontabs/$USER3
# run this crontab entry every 9 minutes
sed -i '$ a */9 * * * * honeycomb01 /home/honeycomb01/autorestartFirefoxAutosurfUSER3.sh' /etc/crontab
sed -i '$ a */9 * * * * honeycomb01 /home/honeycomb01/autorestartFirefoxEbesucherUSER3.sh' /etc/crontab
#Chrome:
# nano /home/honeycomb01/autorestartChromeEbesucherUSER3.sh
echo '#!/bin/sh
export DISPLAY=:4
cd ~/
rm -rf ~/.vnc/*.log /tmp/plugtmp* > /dev/null 2>&1
killall java > /dev/null 2>&1
killall chrome > /dev/null 2>&1
/opt/google/chrome/chrome --new-tab http://www.ebesucher.com/surfbar/nnquangminh --no-sandbox  > /dev/null 2>&1
/usr/bin/java -jar ~/restarter.jar > /dev/null 2>&1
' > /home/honeycomb01/autorestartChromeEbesucherUSER3.sh
#Where, http://www.ebesucher.com/surfbar/username in the username to your user name
#to the script to add executable permissions 
sudo chmod a+x /home/honeycomb01/autorestartChromeEbesucherUSER3.sh
sudo chown $USER3 /home/honeycomb01/autorestartChromeEbesucherUSER3.sh
#edit cron
#sudo nano /etc/crontab
#setup once every hour the script
# 0 * * * * honeycomb01 ~/autorestartChromeEbesucherUSER3.sh
sed -i '$ a */9 * * * * honeycomb01 /home/honeycomb01/autorestartChromeEbesucherUSER3.sh' /etc/crontab
#restart cron
sudo service cron restart
#End USER3


echo "(4/6) Install a StorJshare miner"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#How to install a StorJ miner on Ubuntu via Command Line
#----------------------------------------------------------------------------------------------------------------------------------------
#sudo apt-get remove nodejs -y
#sudo apt-get remove npm
#sudo rm -rf /usr/local/bin/npm /usr/local/share/man/man1/node* /usr/local/lib/dtrace/node.d ~/.npm ~/.node-gyp /opt/local/bin/node opt/local/include/node /opt/local/lib/node_modules 
#sudo rm -rf /usr/local/lib/node*
#sudo rm -rf /usr/local/include/node*
#sudo rm -rf /usr/local/bin/node*
########################################
cd /home/
sudo apt-get install -y build-essential curl git m4 ruby texinfo libbz2-dev libcurl4-openssl-dev libexpat-dev libncurses-dev zlib1g-dev
sudo curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt-get install -y build-essential
sudo wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash

export NVM_DIR="/root/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
 
nvm install --lts
sudo apt-get update -y
sudo node-gyp rebuild -y
sudo apt-get dist-upgrade -y
sudo apt-get install git python build-essential -y
sudo npm install --global storjshare-daemon
#sudo npm install storjshare-daemon --global --no-optional
# sudo npm install --global storjshare-daemon
# sudo npm install -g npm-install-missing
# sudo npm install -g storjshare-daemon --unsafe-perm
#sudo npm install -g storjshare-daemon
#Start the StorJ daemon service with this command:
sudo storjshare daemon
#Check which drives want to configure StorJ storage to sit on. Run this command:
# df -h
#Find out GB free on /. Let’s create storj folders on those drives for StorJ:
sudo mkdir /storj
#Configure a StorJ share location with a command like this:
#After running the storjshare-create command, it brings up an editor that lets you review and change any configuration details you need to. 
#Just type this command to save and close the editor:
# :wq
echo '#!/usr/bin/expect -f
set timeout -1
spawn sudo storjshare-create --storj 0xAF99AaBBD2fF63C3cb6855E5BE87F243b7f88D09 --storage /storj --size 5GB
send ":wq\r\n"
expect off' > configStorj.sh
chmod 777 configStorj.sh
./configStorj.sh
rm -rf configStorj.sh
#Make a copy of config file. The storjshare config file will be a path like this: 
# /root/.config/storjshare/configs/d616431de0ee853f9eb5043040d07e3bb29d08cd.json
#Lets add this configured StorJ path to the StorJshare daemon service with this command:
sudo storjshare start --config /root/.config/storjshare/configs/d616431de0ee853f9eb5043040d07e3bb29d08cd.json
#Check StorJ service status
#sudo storjshare status
################################################################################################################################################# 
#NTP synchronization for GNU+Linux systems
#Having a system correctly synchronized with NTP is essential to ensure optimal functionality of the Storj Share nodes. 
#If the synchronization is off by more than 500 milliseconds, the nodes will start to fail as it does not keep the same time as 
#all the other nodes on the network. As most messages have a time-stamp, it is essential to have a good synchronization for optimal performance.
#Open up a terminal and type in the following commands:
sudo apt-get install ntp ntpdate -y
sudo service ntp stop
sudo ntpdate -s time.nist.gov
sudo service ntp start
# timedatectl status
# timedatectl list-timezones
# sudo timedatectl set-timezone <your timezone>
#e.g. "sudo timedatectl set-timezone Europe/Rome"
sudo timedatectl set-timezone UTC
#Alternatively
#Edit the ntp config file: 
# sudo nano /etc/ntp.conf
#You’ll find a lot of lines in that file, but the important ones are the server lines. 
#You can get a list of server addresses at pool.ntp.org, find the preferred ones for your area, and then add them to the file. 
#For example if you are in the Italy:
sed -i s'/server 0.ubuntu.pool.ntp.org/server 0.it.pool.ntp.org/g' /etc/ntp.conf
sed -i s'/server 1.ubuntu.pool.ntp.org/server 1.it.pool.ntp.org/g' /etc/ntp.conf
sed -i s'/server 2.ubuntu.pool.ntp.org/server 2.it.pool.ntp.org/g' /etc/ntp.conf
sed -i s'/server 3.ubuntu.pool.ntp.org/server 3.it.pool.ntp.org/g' /etc/ntp.conf
#Then you’ll need to restart or start the NTPD service:
/etc/init.d/ntpd restart 
# or 
ntpd restart
#Have the Storjshare daemon run when reboot:
echo '#!/bin/bash
 sudo storjshare daemon && sudo storjshare start --config $(find /root/.config/storjshare/configs/ -type f -name "*.json" | head -n 1) > /dev/null 2>&1
 ' > /root/.config/storjshare/storjdaemon

chmod uga+x /root/.config/storjshare/storjdaemon
sed -i '$ a @reboot root /root/.config/storjshare/storjdaemon' /etc/crontab
#At the bottom of crontab file add the line then save the file below: (Ctrl+w+v)
#restart cron
sudo service cron restart

#Done!


echo "(5/6) Set Up Web Server Application for Production"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# =================== WEB SERVER DATA ========================

SERVER_NAME="Univerchain"
SERVER_IP=$(ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)

USER="dragonball"
SUDO_PASSWORD="greatway@123"
MYSQL_ROOT_PASSWORD="bestway@123"

# SSH access via password will be disabled. Use keys instead.
PUBLIC_SSH_KEYS="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC6tFAz2cweXLFl95dLZWhhrsFODUm0Ic1l36B9IEZmkh43XKHzVWF6fiPsXmENv66ZUs+LJcgLNg34CDEfJ4+KBI6L8guAxc4nel30GSg7fo1NdtzedcbK+YVhSwtMi/Bv9jhXlBNvnSAC3lCtFzejb7lQTPqvf5ufgyTETeTkZdylsqHXD/5wug6nrYs0bNoSZc7LC/p7lmu50MckI8+aIwDjRjqRdayUUcvC8A9KQGWg79LwtE5SllugbdgH2jcyIZFj4hpkZegwXkVsaM+yu9T/oGhRXxXbZORYssdCOOD0M4oQofbrelm9fbRmHzSFtKQqxzQreMPgOSec4VLT bigbee"

# if vps not contains swap file - create it
SWAP_SIZE="1G"

TIMEZONE="Etc/GMT+0" # lits of avaiable timezones: ls -R --group-directories-first /usr/share/zoneinfo

# =================== LET'S GET STARTED ==========================================================================================

# Prefer IPv4 over IPv6 - make apt-get faster

sudo sed -i "s/#precedence ::ffff:0:0\/96  100/precedence ::ffff:0:0\/96  100/" /etc/gai.conf

# Required Packages
apt-get -y install python-software-properties libssl-dev git-core pkg-config build-essential curl gcc g++ openssl libreadline6 libreadline6-dev zlib1g zlib1g-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion traceroute

# Upgrade The Base Packages
apt-get update
apt-get upgrade -y

# Add A Few PPAs To Stay Current

apt-get install -y --force-yes software-properties-common

apt-add-repository ppa:nginx/development -y
apt-add-repository ppa:chris-lea/redis-server -y
apt-add-repository ppa:ondrej/apache2 -y
apt-add-repository ppa:ondrej/php -y

# Update Package Lists

apt-get update

# Base Packages

apt-get install -y --force-yes fail2ban libmcrypt4 libpcre3-dev \
make python2.7 python-pip supervisor ufw unattended-upgrades unzip whois zsh mc p7zip-full htop

# Install Python Httpie

pip install httpie

# Disable Password Authentication Over SSH

sed -i "/PasswordAuthentication yes/d" /etc/ssh/sshd_config
echo "" | sudo tee -a /etc/ssh/sshd_config
echo "" | sudo tee -a /etc/ssh/sshd_config
echo "PasswordAuthentication no" | sudo tee -a /etc/ssh/sshd_config

# Restart SSH

ssh-keygen -A
service ssh restart

# Set The Hostname If Necessary

echo "$SERVER_NAME" > /etc/hostname
sed -i "s/127\.0\.0\.1.*localhost/127.0.0.1 $SERVER_NAME localhost/" /etc/hosts
hostname $SERVER_NAME

# Set The Timezone

ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime

# Create The Root SSH Directory If Necessary

if [ ! -d /root/.ssh ]
then
    mkdir -p /root/.ssh
    touch /root/.ssh/authorized_keys
fi

# Setup User

useradd $USER
mkdir -p /home/$USER/.ssh
adduser $USER sudo

# Setup Bash For User

chsh -s /bin/bash $USER
cp /root/.profile /home/$USER/.profile
cp /root/.bashrc /home/$USER/.bashrc

# Set The Sudo Password For User

PASSWORD=$(mkpasswd $SUDO_PASSWORD)
usermod --password $PASSWORD $USER

# Build Formatted Keys & Copy Keys To User

cat > /root/.ssh/authorized_keys << EOF
$PUBLIC_SSH_KEYS
EOF

cp /root/.ssh/authorized_keys /home/$USER/.ssh/authorized_keys

# Create The Server SSH Key

ssh-keygen -f /home/$USER/.ssh/id_rsa -t rsa -N ''

# Copy Github And Bitbucket Public Keys Into Known Hosts File

ssh-keyscan -H github.com >> /home/$USER/.ssh/known_hosts
ssh-keyscan -H bitbucket.org >> /home/$USER/.ssh/known_hosts

# Setup Site Directory Permissions

chown -R $USER:$USER /home/$USER
chmod -R 755 /home/$USER
chmod 700 /home/$USER/.ssh/id_rsa

# Setup Unattended Security Upgrades

cat > /etc/apt/apt.conf.d/50unattended-upgrades << EOF
Unattended-Upgrade::Allowed-Origins {
    "Ubuntu xenial-security";
};
Unattended-Upgrade::Package-Blacklist {
    //
};
EOF

cat > /etc/apt/apt.conf.d/10periodic << EOF
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Download-Upgradeable-Packages "1";
APT::Periodic::AutocleanInterval "7";
APT::Periodic::Unattended-Upgrade "1";
EOF

# Setup UFW Firewall

ufw allow 22
ufw allow 80
ufw allow 443
ufw --force enable

# Allow FPM Restart

echo "$USER ALL=NOPASSWD: /usr/sbin/service php7.0-fpm reload" > /etc/sudoers.d/php-fpm

# Configure Supervisor Autostart

systemctl enable supervisor.service
service supervisor start

# Configure Swap Disk

if [ -f /swapfile ]; then
    echo "Swap exists."
else
    fallocate -l $SWAP_SIZE /swapfile
    chmod 600 /swapfile
    mkswap /swapfile
    swapon /swapfile
    echo "/swapfile none swap sw 0 0" >> /etc/fstab
    echo "vm.swappiness=30" >> /etc/sysctl.conf
    echo "vm.vfs_cache_pressure=50" >> /etc/sysctl.conf
fi

# Install Base PHP Packages

apt-get install -y --force-yes php7.0-cli php7.0-dev \
php-sqlite3 php-gd \
php-curl php7.0-dev \
php-imap php-mysql php-memcached php-mcrypt php-mbstring \
php-xml php-imagick php7.0-zip php7.0-bcmath php-soap \
php7.0-intl php7.0-readline

# Install Composer Package Manager

curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# Misc. PHP CLI Configuration

sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.0/cli/php.ini
sudo sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.0/cli/php.ini
sudo sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/7.0/cli/php.ini
sudo sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php/7.0/cli/php.ini

# Configure Sessions Directory Permissions

chmod 733 /var/lib/php/sessions
chmod +t /var/lib/php/sessions

# Install Nginx & PHP-FPM

apt-get install -y --force-yes nginx php7.0-fpm

# Generate dhparam File

openssl dhparam -out /etc/nginx/dhparams.pem 2048

# Disable The Default Nginx Site

rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
service nginx restart

# Tweak Some PHP-FPM Settings

sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.0/fpm/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.0/fpm/php.ini
sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/7.0/fpm/php.ini
sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/7.0/fpm/php.ini
sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php/7.0/fpm/php.ini
sed -i "s/short_open_tag.*/short_open_tag = On/" /etc/php/7.0/fpm/php.ini

# Setup Session Save Path

sed -i "s/\;session.save_path = .*/session.save_path = \"\/var\/lib\/php5\/sessions\"/" /etc/php/7.0/fpm/php.ini
sed -i "s/php5\/sessions/php\/sessions/" /etc/php/7.0/fpm/php.ini

# Configure Nginx & PHP-FPM To Run As User

sed -i "s/user www-data;/user $USER;/" /etc/nginx/nginx.conf
sed -i "s/# server_names_hash_bucket_size.*/server_names_hash_bucket_size 64;/" /etc/nginx/nginx.conf
sed -i "s/^user = www-data/user = $USER/" /etc/php/7.0/fpm/pool.d/www.conf
sed -i "s/^group = www-data/group = $USER/" /etc/php/7.0/fpm/pool.d/www.conf
sed -i "s/;listen\.owner.*/listen.owner = $USER/" /etc/php/7.0/fpm/pool.d/www.conf
sed -i "s/;listen\.group.*/listen.group = $USER/" /etc/php/7.0/fpm/pool.d/www.conf
sed -i "s/;listen\.mode.*/listen.mode = 0666/" /etc/php/7.0/fpm/pool.d/www.conf

# Configure A Few More Server Things

sed -i "s/;request_terminate_timeout.*/request_terminate_timeout = 60/" /etc/php/7.0/fpm/pool.d/www.conf
sed -i "s/worker_processes.*/worker_processes auto;/" /etc/nginx/nginx.conf
sed -i "s/# multi_accept.*/multi_accept on;/" /etc/nginx/nginx.conf

# Install A Catch All Server

cat > /etc/nginx/sites-available/catch-all << EOF
server {
    return 404;
}
EOF

ln -s /etc/nginx/sites-available/catch-all /etc/nginx/sites-enabled/catch-all

cat > /etc/nginx/sites-available/default << EOF
server {
    listen 80;
    listen [::]:80 default_server ipv6only=on;
    server_name univerchain.org;
    root /var/www/html/php;

    index index.html index.htm index.php;

    charset utf-8;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }

    access_log off;
    error_log  /var/log/nginx/univerchain.org-error.log error;

    error_page 404 /index.php;

    location ~ \.php$ {
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass unix:/var/run/php/php7.0-fpm.sock;
        fastcgi_index index.php;
        include fastcgi_params;
    }

    location ~ /\.ht {
        deny all;
    }
}
server {
    listen 80;
    listen [::]:80 ipv6only=on;
    server_name pitvietnam.com;
    
    root /var/www/html/node;
    index index.html index.htm;

    client_max_body_size 10G;
    
    access_log /var/log/nginx/pitvietnam.log; 
    
    location / {
      proxy_set_header X-Real-IP $remote_addr;
      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
      proxy_set_header X-NginX-Proxy true;
      proxy_pass http://localhost:8080;
      proxy_set_header Host $http_host;
      proxy_cache_bypass $http_upgrade;
      proxy_redirect off;
    }
}
EOF

# Restart Nginx & PHP-FPM Services

if [ ! -z "\$(ps aux | grep php-fpm | grep -v grep)" ]
then
    service php7.0-fpm restart
fi

service nginx restart
service nginx reload

# Add User To www-data Group

usermod -a -G www-data $USER
id $USER
groups $USER

# Install Node.js

curl --silent --location https://deb.nodesource.com/setup_5.x | bash -

apt-get update

sudo apt-get install -y --force-yes nodejs

npm install -g pm2
npm install -g gulp

# Set The Automated Root Password

export DEBIAN_FRONTEND=noninteractive

debconf-set-selections <<< "mysql-community-server mysql-community-server/data-dir select ''"
debconf-set-selections <<< "mysql-community-server mysql-community-server/root-pass password $MYSQL_ROOT_PASSWORD"
debconf-set-selections <<< "mysql-community-server mysql-community-server/re-root-pass password $MYSQL_ROOT_PASSWORD"

# Install MySQL

apt-get install -y mysql-server

# Configure Password Expiration

echo "default_password_lifetime = 0" >> /etc/mysql/mysql.conf.d/mysqld.cnf

# Configure Access Permissions For Root & User

sed -i '/^bind-address/s/bind-address.*=.*/bind-address = */' /etc/mysql/mysql.conf.d/mysqld.cnf
mysql --user="root" --password="$MYSQL_ROOT_PASSWORD" -e "GRANT ALL ON *.* TO root@'$SERVER_IP' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
mysql --user="root" --password="$MYSQL_ROOT_PASSWORD" -e "GRANT ALL ON *.* TO root@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
service mysql restart

mysql --user="root" --password="$MYSQL_ROOT_PASSWORD" -e "CREATE USER '$USER'@'$SERVER_IP' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
mysql --user="root" --password="$MYSQL_ROOT_PASSWORD" -e "GRANT ALL ON *.* TO '$USER'@'$SERVER_IP' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION;"
mysql --user="root" --password="$MYSQL_ROOT_PASSWORD" -e "GRANT ALL ON *.* TO '$USER'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION;"
mysql --user="root" --password="$MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"

# MongoDB
# add mongodb 10gen package to /etc/apt/sources.list.d
touch /etc/apt/sources.list.d/mongo.list
echo "deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen" > /etc/apt/sources.list.d/mongo.list
# 10gen package required GPG key, imports it
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
# update your apt-get list
sudo apt-get update
# install mongodb-10gen
sudo apt-get install mongodb-10gen -y
# starting MongoDB
sudo service mongodb start
# stoping MongoDB
sudo service mongodb stop
# restarting MongoDB
sudo service mongodb restart

#Install bower, grunt

npm install -g bower
npm install -g grunt-cli

# Install & Configure Redis Server

apt-get install -y redis-server
sed -i 's/bind 127.0.0.1/bind 0.0.0.0/' /etc/redis/redis.conf
service redis-server restart

# Install & Configure Memcached

apt-get install -y memcached
sed -i 's/-l 127.0.0.1/-l 0.0.0.0/' /etc/memcached.conf
service memcached restart

# Install & Configure Beanstalk

apt-get install -y --force-yes beanstalkd
sed -i "s/BEANSTALKD_LISTEN_ADDR.*/BEANSTALKD_LISTEN_ADDR=0.0.0.0/" /etc/default/beanstalkd
sed -i "s/#START=yes/START=yes/" /etc/default/beanstalkd
/etc/init.d/beanstalkd start


echo "(6/6) Add DRAGONBALL aliases"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo "" >> ~/.bashrc
echo "# DRAGONBALL ALIASES" >> ~/.bashrc
echo "alias res='cd /root/Desktop/'" >> ~/.bashrc
echo "alias proxy='cd /home/proxy'" >> ~/.bashrc
echo "alias gl='pm2 l'" >> ~/.bashrc
echo "alias glog='pm2 logs'" >> ~/.bashrc
echo "alias gstart='pm2 start'" >> ~/.bashrc
echo "alias gstop='pm2 stop'" >> ~/.bashrc
echo ""
# Finishing Up
apt-get -y autoremove
apt-get -y clean
apt-get -y autoclean
echo " ============================================================"
echo "                   DRAGONBALL SETUP complete!"
echo ""
echo "                Please run this command to init:"
echo "                           res"
echo "                           proxy"
echo ""
echo " ============================================================"
echo ""
