#######################################################
# taken from:-www.bashscripts.org
# with our own twists
# Modified by jim@willeke.com
# Last Modified 3/7/2009 8:35:19 AM
# Running on OpenSUSE 10
#######################################################
#
# SCRIPT: bashenvironment
# AUTHOR: jim@willeke.com
# DATE:   03/27/11 07:12:16
T_VER=1.1A								# Script Version Number
# REV:    1.12.T (Valid are A, B, D, T, Q, and P)
#               (For Alpha, Beta, Dev, Test, QA, and Production)
#
# PLATFORM: (SPECIFY: AIX, HP-UX, Linux, OpenBSD, Solaris, other flavor, 
#                      or Not platform dependent)
#
# REQUIREMENTS: If this script has requirements that need to be noted, this
#               is the place to spell those requirements in detail. 
#
#         EXAMPLE:  OpenSSH is required for this shell script to work.
#
# PURPOSE: Give a clear, and if necessary, long, description of the
#          purpose of the shell script. This will also help you stay
#          focused on the task at hand.
#
# REV LIST:
# MODIFICATION: 
# 2011-09-03-06:51:40 - Added hostname to terminal title
#
#
# set -n   # Uncomment to check script syntax, without execution.
#          # NOTE: Do not forget to put the # comment back in or
#          #       the shell script will never execute!
# set -x   # Uncomment to debug this shell script
#
##########################################################
#         DEFINE FILES AND VARIABLES HERE
##########################################################
PATH=$PATH:/usr/lib/festival/ ;export PATH
# Promot
#export PS1="[\t \u]$ "
export PS1="\u@\H > "
HOSTNAME=`hostname`
export TITLEBAR="\[\033]0;$LOGNAME@$HOSTNAME\007]"
export EDITOR=/usr/bin/joe
export HISTFILESIZE=3000 # the bash history should save 3000 commands
export HISTCONTROL=ignoredups #don't put duplicate lines in the history.
alias hist='history | grep $1' #Requires one input
# Define a few Color's
BLACK='\e[0;30m'
BLUE='\e[0;34m'
GREEN='\e[0;32m'
CYAN='\e[0;36m'
RED='\e[0;31m'
PURPLE='\e[0;35m'
BROWN='\e[0;33m'
LIGHTGRAY='\e[0;37m'
DARKGRAY='\e[1;30m'
LIGHTBLUE='\e[1;34m'
LIGHTGREEN='\e[1;32m'
LIGHTCYAN='\e[1;36m'
LIGHTRED='\e[1;31m'
LIGHTPURPLE='\e[1;35m'
YELLOW='\e[1;33m'
WHITE='\e[1;37m'
NC='\e[0m'              # No Color
# Sample Command using color: 
# echo -e "${CYAN}This is BASH ${RED}${BASH_VERSION%.*}${CYAN} - DISPLAY on ${RED}$DISPLAY${NC}\n"

#######################################################
# SOURCED ALIAS'S AND SCRIPTS
#######################################################

### Begin insertion of our alias's ###
#source ~/.bbips/commandline/bbipsbashrc
### END bbips alias's ###

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# enable programmable completion features
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

if [ -f "/opt/novell/eDirectory/bin/ndspath" ]
	then
		. /opt/novell/eDirectory/bin/ndspath
		EDIRECTORY="`ndsstat |grep 'Product Version:'`"
		if [ -n "$EDIRECTORY" ]
		then
		  EDIRECTORY="eDirectory $EDIRECTORY"
		else
		  EDIRECTORY="No Edirectory"
		fi
else
	EDIRECTORY="No Edirectory"
	echo "WARNING: Could not find . /opt/novell/eDirectory/bin/ndspath"	
fi

##########################################################
# Alias's to local workstations
##########################################################
alias rootfrancis='ssh francis.willeke.com -l root'
alias rootbratton='ssh bratton.willeke.com -l root'
alias rootxenhost='ssh xenhost.willeke.com -l root'
alias rootsa='ssh sa.willeke.com -l root'
alias rootmini='ssh swb-mini01.willeke.com -l jwilleke'
##########################################################
# alias ANYNAMEHERE='ssh YOURWEBSITE.com -l USERNAME -p PORTNUMBERHERE'
##########################################################
# Alias's to some of my BashScripts
##########################################################
#alias bics='sh /home/crouse/scripts/bics/bics.sh'
##########################################################
##########################################################
# Alias's to modified commands
##########################################################
alias cls=clear
alais h=history
alias nds='ndsmanage'
alias mess='tail -f -n25 /var/log/messages'
alias myntpdate='ntpdate -q time.willeke.com'
alias nds='ndsmanage'
alias nslookup='nslookup -sil'
alias path='echo PATH=$PATH'
#alias ps='ps auxf'
alias home='cd ~'
alias pg='ps aux | grep'  #requires an argument
alias un='tar -zxvf'
alias mountedinfo='df -hT'
alias ping='ping -c 10'
alias openports='netstat -nape --inet'
alias ns='netstat -alnp --protocol=inet | grep -v CLOSE_WAIT | cut -c-6,21-94 | tail +2'
alias du1='du -h --max-depth=1'
alias da='date "+%Y-%m-%d %A    %T %Z"'
#alias ebrc='pico ~/.bashrc'
##########################################################
# Alias to multiple ls commands
##########################################################
alias la='ls -Al'               # show hidden files
alias ls='ls -aF --color=always' # add colors and file type extensions
alias lx='ls -lXB'              # sort by extension
alias lk='ls -lSr'              # sort by size
alias lc='ls -lcr'      # sort by change time
alias lu='ls -lur'      # sort by access time
alias lr='ls -lR'               # recursive ls
alias lt='ls -ltr'              # sort by date
alias lm='ls -al |more'         # pipe through 'more'

alias 000='chmod 000'
alias 644='chmod 644'
alias 755='chmod 755'

##########################################################
# Alias Shortcuts to graphical programs.
##########################################################
#alias kwrite='kwrite 2>/dev/null &'
#alias firefox='firefox 2>/dev/null &'
#alias gaim='gaim 2>/dev/null &'
#alias kate='kate 2>/dev/null &'
#alias suk='kdesu konqueror 2>/dev/null &'

# Alias xterm and aterm
#alias term='xterm -bg AntiqueWhite -fg Black &'
#alias termb='xterm -bg AntiqueWhite -fg NavyBlue &'
#alias termg='xterm -bg AntiqueWhite -fg OliveDrab &'
#alias termr='xterm -bg AntiqueWhite -fg DarkRed &'
#alias aterm='aterm -ls -fg gray -bg black'
#alias xtop='xterm -fn 6x13 -bg LightSlateGray -fg black -e top &'
#alias xsu='xterm -fn 7x14 -bg DarkOrange4 -fg white -e su &'

# Alias for lynx web browser
alias bbc='lynx -term=vt100 http://news.bbc.co.uk/text_only.stm'
alias nytimes='lynx -term=vt100 http://nytimes.com'
alias dmregister='lynx -term=vt100 http://desmoinesregister.com'
##########################################################
# SPECIAL ALIAS
# Sync the bashrc file form hosts
# could add other items to the file.
#######################################################
alias envsync='rsync -qa rsync://xenhost/rootenv /root'
##########################################################
# SPECIAL FUNCTIONS
#######################################################

netinfo ()
{
echo "--------------- Network Information ---------------"
/sbin/ifconfig | awk /'inet addr/ {print $2}'
echo ""
/sbin/ifconfig | awk /'Bcast/ {print $3}'
echo ""
/sbin/ifconfig | awk /'inet addr/ {print $4}'

# /sbin/ifconfig | awk /'HWaddr/ {print $4,$5}'
echo "---------------------------------------------------"
}
spin ()
{
echo -ne "${RED}-"
echo -ne "${WHITE}\b|"
echo -ne "${BLUE}\bx"
sleep .02
echo -ne "${RED}\b+${NC}"
}

scpsend ()
{
scp -P 22 "$@" root@francis.willeke.com:/var/www/html/pathtodirectoryonremoteserver/;
}
##########################################################
# NOTES
#######################################################
# To temporarily bypass an alias, we preceed the command with a \
# EG:  the ls command is aliased, but to use the normal ls command you would
# type \ls
# mount -o loop /home/crouse/NAMEOFISO.iso /home/crouse/ISOMOUNTDIR/
# umount /home/crouse/NAMEOFISO.iso
# Both commands done as root only.

###############################################################################
# WELCOME SCREEN
###############################################################################
# Set Terminal Title
echo -n -e $TITLEBAR
clear
# for i in `seq 1 15` ; do spin; done ;echo -ne "${WHITE} USA Linux Users Group ${NC}"; for i in `seq 1 15` ; do spin; done ;echo "";
echo -ne "Hello $USER today is "; date
echo -e ${CYAN}`cat /etc/SuSE-release` ;
echo -e "Kernel Information: " `uname -smr`;
echo -e ${GREEN} $EDIRECTORY
# echo -e ${CYAN}`bash --version`;echo ""
# echo -e "${WHITE}"; cal ; echo "";
echo -ne "${CYAN}";netinfo; mountedinfo
echo -ne "${CYAN}Uptime for this computer is ";uptime | awk /'up/{print $3,$4}'
#for i in `seq 1 15` ; do spin; done ;echo -ne "${WHITE} http://usalug.org ${NC}"; 
#for i in `seq 1 15` ; do spin; done ;echo "";
echo -e "${CYAN}End of bashrc ${RED}${T_VER}${CYAN} - DISPLAY on ${RED}$DISPLAY${NC}\n"
##########################################################
### END
##########################################################