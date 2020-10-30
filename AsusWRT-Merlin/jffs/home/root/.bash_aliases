color_is_on=
color_red=
color_green=
color_yellow=
color_blue=
color_white=
color_gray=
color_bg_red=
color_off=
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    color_is_on=true
    color_darkgray="\[$(/usr/bin/tput setaf 0)\]"
    color_red="\[$(/usr/bin/tput setaf 1)\]"
    color_green="\[$(/usr/bin/tput setaf 2)\]" #used
    color_yellow="\[$(/usr/bin/tput setaf 3)\]"
    color_blue="\[$(/usr/bin/tput setaf 4)\]"
    color_purple="\[$(/usr/bin/tput setaf 5)\]"
    color_cyan="\[$(/usr/bin/tput setaf 6)\]"
    color_gray="\[$(/usr/bin/tput setaf 7)\]"
    color_white="\[$(/usr/bin/tput setaf 8)\]"
    color_off="\[$(/usr/bin/tput sgr0)\]" #used
    color_error="$(/usr/bin/tput setab 1)$(/usr/bin/tput setaf 7)" #used
    color_error_off="$(/usr/bin/tput sgr0)" #used
fi


alias ls='/bin/ls'

# enable color support of ls and also add handy aliases
if [[ -x /usr/bin/dircolors ]]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias l='ls -l --group-directories-first'
alias lt='tree'
alias lss='echo "Ссылки скрыты (L), числа для человека (h), . .. папки/ (F) потом файлы"; l -FhLC'
alias lsa='echo "Ссылки скрыты (L), числа для человека (h), папки/ (F) без . и .. (A) потом все файлы (A)"; l -FhALC'
alias lsf='echo "Подробный вывод (l), числа для человека (h), папки/ (F) без . и .. (A) потом все файлы (A) и ссылки"; l -FhA'
alias lsl='echo "Подробный вывод (l), числа для человека (h), папки/ (F) без . и .. (A) потом все файлы (A), ссылки выделены"; lsf | cut -c 49-200 | grepbw ^\[^\.\].\*'

alias cd..='cd ..'
alias back='cd "$OLDPWD"'
alias mkdirf='mkdir -p -v'
alias dff='echo -e "ФC Размер Занято Доступно Занято% Cмонтирована\n" "`df -h`" | sed "2 d; :a; /^[^ ]*$/N; s/\n//; ta;" | column -t'
alias dff='echo -e "ФC\t\t\tРазмер\tЗанято\t Доступно Занято% Cмонтирована\n" "`df -h`"  | sed "2 d; :a; /^[^ ]*$/N; s/\n//; ta;"'
alias duf='du -hxc --max-depth=1'
alias cpf='rsync --progress'
alias rmf='rm -rf'
alias rmfv='rm -rfv'
alias wget='wget --content-disposition'
alias grepbw='grep --color=never'
alias tree='tree -N'
alias catgz='gzip -cd'

alias aptitude="sudo aptitude -fV --with-recommends"
alias dpkg="sudo /usr/bin/dpkg"
alias apti="aptitude --no-gui"
alias aptupd="apti update"
alias aptsafe="apti safe-upgrade"
alias aptfull="apti full-upgrade"
alias aptupdsafe="aptupd; aptsafe"
alias aptupdfull="aptupd; aptfull"
alias aptinst="apti install"
alias aptfix="aptinst -f"
alias aptinstdeb="sudo dpkg -i"
alias aptinstdep="sudo apt-get build-dep"
alias aptreinst="apti reinstall"
alias aptreconf='sudo dpkg-reconfigure'
alias aptrem="apti remove"
alias aptremfull="apti purge"
alias aptremfullforce="dpkg --force-all -P"
alias aptremetc='aptremfull ~c'
alias aptshow="apti show"
alias aptshowfiles="dpkg -L"
alias aptshowdeb="dpkg -f"
alias aptshowdebfiles="dpkg -c"
alias aptshowver="sudo apt-cache policy"
alias aptshowdep="sudo apt-cache depends"
alias aptshowrdep="sudo apt-cache rdepends"
alias apthold="apti hold"
alias aptunhold="apti unhold"
alias aptclean="apti clean"
alias aptremkernels='aptremfull `for name in image-[0-9] headers-[0-9\.-]+$ headers-[0-9\.-]+generic; do aptsearch -F %p "~ilinux-$name" | sort -r | tail -n +2; done`'
alias aptsearch="apti search"
alias aptsearchsel2="dpkg --get-selections"
alias aptsearchmanually2="aptitude search '~i!~M'"
alias aptsearchfile="dpkg -S"
alias aptsearchupd="sudo apt-file update"
alias aptsearchfull="sudo apt-file search"
alias aptsearchupg2="aptsearch '?upgradable' --display-format '%p# %v# -> %V# %t'"
alias aptsearchupgexperimental="aptsearch '~U ~Aexperimental'"
alias aptsearchinst2="dpkg -l"
alias aptsearchnotwhy2='dpkg-query -W --showformat="\${Installed-Size} \${Package}\n" $(deborphan -a | awk "{print \$2}") | sort -rn'
alias aptsearchcache2="apt-cache dump"
alias aptsrc="sudo mcedit /etc/apt/sources.list"
alias aptrepo="sudo add-apt-repository"
alias aptremrepo='aptrepo -r'
alias aptfixver="sudo aptitude search ~i -F '%p' | while read STRING; do VER=\"\$(sudo apt-cache policy \$STRING)\"; LOCAL=\"\$(echo \"\$VER\" | grep '\*\*\*' -A1 | grep /var/lib/dpkg/status | wc -l)\"; if (( \"\$LOCAL\" != 1 )); then continue; fi; CHECK=\"\$(echo \"\$VER\" | grep http -B1 | head -n 1 | grep -v '\*\*\*')\"; if [ -n \"\$CHECK\" ] && (( \$(echo \"\$CHECK\" | wc -l) == 1 )); then NEW_VER=\$(echo \"\$CHECK\" | sed 's/^ \+\(.*\) \+[0-9]\+\$/\1/'); echo \"\$STRING=\$NEW_VER\" >> packages-versions.txt; fi; done;"

alias showdate='echo -e Here\\\t\\\t`/bin/date`\\\nGreenwich\\\t`/bin/date -u`'
alias showimage='geeqie'
alias showalias='cat ~/.bash_aliases'
alias editalias='mcedit ~/.bash_aliases; . ~/.bash_aliases'
alias showfunct='cat ~/.bash_functions'
alias editfunct='mcedit ~/.bash_functions; . ~/.bash_functions'
alias showbin='ls ~/bin/ | sort'
alias showcputemp='sensors | grepbw k10temp -A3 | tail -n 1'
alias showcpu='cat /proc/cpuinfo | grep name | sed s/^\[^:\]\*:\ //\;q; showcputemp; cat /proc/cpuinfo | grep "cpu MHz" | sort'
alias showirq='cat /proc/interrupts'
alias showmbtemp='sudo sensors | grepbw acpitz -A6 | tail -n 1'
alias showmb='sudo dmidecode | grepbw "System Information" -A 5; showmbtemp'
alias showbios='echo `sudo dmidecode --type baseboard | grep Product; echo "| Version: "; sudo dmidecode -s bios-version; echo "| Date: "; sudo dmidecode -s bios-release-date`'
alias showgputemp='sensors | grepbw amdgpu -A4 | tail -n 1'
alias showgpu='lspci | grepbw VGA; glxinfo | grepbw "direct rendering"; glxinfo | egrep "glx (vendor|version)" | grepbw glx; showgputemp'
alias showgpudrv='nvidia-settings -q all | grep NvidiaDriverVersion | head -n 1 | sed -n "s/^.* \([0-9\.]\+\).$/version \1/p"'
alias showgpumem='echo $(expr `nvidia-settings -q all | grep VideoRam | head -n 1 | sed -n "s/^.* \([0-9]\+\).$/\1/p"` / 1024) Mb'
alias showhdd="ls -l /dev/[h,s,m]d* 2> /dev/null; ls -l /dev/nvme* 2> /dev/null; sudo intelmas show -a -intelssd | grepbw 'ModelNumber\|DeviceStatus\|ProductFamily\|SerialNumber'; sudo intelmas show -a -sensor | grepbw Celsius"
alias showhddtop='sudo iotop -Pobka'
alias showhddparts='sudo fdisk -l'
alias showhdduuid='ls -l /dev/disk/by-uuid'
alias showhddtemp='sudo hddtemp /dev/sd{a,b,c} 2> /dev/null | column -t; sudo intelmas show -a -sensor | grepbw Celsius 2> /dev/null'
alias showhddsmart='sudo smartctl -A'
alias showhddmd='sudo mdadm --examine'
alias showcd='eject -T /dev/cdrom*'
alias showmd='cat /proc/mdstat'
alias showio='iotop'
alias shownet='sudo netstat -tupl'
alias showmemtotal='showmeminfo | grepbw Total'
alias showmeminfo='cat /proc/meminfo | grepbw "Mem\|Swap\|Cached"'
alias showmemstat='free -h | head -n2'
alias showmem='ps_mem.sh; showmemstat'
#alias showswp="echo -e 'Swap \t PID \tName'; ps -eo vsz,rss,pid,args | sed -r -n 's/([0-9]+) ([0-9]+) ([0-9]+) ([^ ]+).*$/\1 \2 \3 \4/p' | awk '{print \$1-\$2 \" \" \$3 \" \" \$4}' | sort -n | column -t"
alias showsnd='paplay --property=media.role=event /usr/share/psi-plus/sound/attention.wav'
#alias showsndp='ps -p $(fuser /dev/snd/pcm* 2> /dev/null | sed -n "s/ /\n/gp;" | sed "/^ *$/d" | uniq) -o args='
alias showsndpid='pidoff "`showsndp`"'
alias showsndcards="cat /proc/asound/cards"
alias showcam='mplayer tv:// -tv driver=v4l2:width=640:height=480'
alias editcam='v4l2ucp'
alias showcaminavi='avconv -f video4linux2 -r 8 -s 640x472 -i /dev/video0 -f alsa -ss 5 -ac 1 -i default -f avi -vcodec mpeg4 -r 25 -qmin 5 -qmax 50 -g 150 -vtag xvid -acodec ac3 -ab 128k -y ~/Images/Shots/output-$(date +"%F_%k-%M-%S").avi &> /dev/null'
alias showcaminjpg='avconv -f video4linux2 -r 8 -s 640x472 -i /dev/video0 -f image2 -ss 4 -vsync 1 -r 0.3 -vframes 5 -an -y ~/Images/Shots/output-$(date +"%F_%k-%M-%S")-%d4.jpg &> /dev/null'
alias showip='curl ipinfo.io'
alias showsched='cat /sys/block/sd*/queue/scheduler'
alias editsched='echo noop | sudo tee /sys/block/sd[e-z]/queue/scheduler'
alias editscheddef='echo deadline | sudo tee /sys/block/sd[a-d]/queue/scheduler'
alias editcron='crontab -e'
alias showups='upsc ups@localhost'

alias showmdconf='sudo mdadm -Db'
alias showmdstat='showmdconf /dev/md[0-9]; echo; cat /proc/mdstat'
alias showmdinfo='sudo mdadm --detail'
alias showlvmstat='sudo pvs'

alias showwellcome='echo -e `lsb_release -a 2> /dev/null | grep Description` "\nKernel: "`uname -r`'
alias showweather='lynx -dump http://weather.i.ua/ | grep Сейчас | sed "s/\, \[.*\]//i"'

alias showasciisource='for ((i = 41; i <= 176; i += 1)) ; do echo -e "$i - \0$i"; done;'
alias showascii='echo "`showasciisource`"'
alias showkeycodes="xev | grep -A2  --line-buffered '^KeyRelease' | sed -n '/keycode /s/^.*keycode\([0-9]*\).* (.*,\(.*\)).*$/\1 \2/p'"
alias showwindow='xprop | grep "WM_WINDOW_TYPE\|WM_COMMAND\|WM_CLASS\|WM_WINDOW_ROLE\|^WM_NAME" | sed "s/WM_\|WINDOW_\|NET_\|(STRING)\|(COMPOUND_TEXT)\|(ATOM)\|^_\|{ \|}//g;"'

alias edithello='sudo mcedit /etc/motd'
alias editgroupadduser="sudo usermod -a -G"
alias editfirewall="aptreconf arno-iptables-firewall"

alias findtext='sudo find -type f -print0 | sudo xargs -0 grep -l'
alias findname='sudo find -name'

alias resetnvset='nvidia-settings -l'
alias resetwine='kill -9 `ps ax | grep -i "c:\|wine\|playonlinux" | grep -v grep | cut -c 1-5` 2> /dev/null'

alias convertdate="/bin/date '+%Y.%m.%d %k:%M:%S' -d" # Enter like this "convertdate @1279690105"
alias convertencfile="enca -L ru -x utf-8"

alias phonescan='hcitool scan'
alias phonebrowse='sdptool browse'
alias phonemount='obexfs -b 00:0F:DE:79:A1:93 -B 7 /media/bluetooth'
alias phoneumount='sudo umount /media/bluetooth'

alias iphonebackup='cp /media/iPhone/var/mobile/Library/xBackup/Backups/backup.bk.zip /media/iPhone/var/mobile/Library/Preferences/libactivator.exported.plist /home/aslok/Devices/iPhone\ 4/Backup/'
alias iphonemount='ifuse /media/iPhone --root'
alias iphoneumount='sudo umount /media/iPhone'

alias getrenamephotos='renrot *.jpg'
alias getrenamephotos2='for filename in *.jpg ; do touch -c -d "`LANG=C exiv2 "$filename" | grep timestamp | sed '"'"'s/[^0-9 :]//g; s/://; s/:/-/; s/:/-/;'"'"'`" "$filename"; done'
alias getrenamephotos3='for filename in *.jpg ; do exiv=`LANG=C exiv2 "$filename" | grep timestamp | sed '"'"'s/[^0-9 :]//g; s/://'"'"' | wc -m`; if (( $exiv < 15)) ; then ls -FAlh "$filename"; fi; done'
alias getrenamephotos4='for filename in *.jpg ; do exiv=`LANG=C exiv2 "$filename" | grep timestamp | sed '"'"'s/[^0-9 :]//g; s/://'"'"' | wc -m`; if (( $exiv < 15)) ; then touch -c -d "`echo "$filename" | sed '"'"'s/\..*//; s/\(.\{4\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)/\1-\2-\3 \4:\5:\6/'"'"'`" "$filename"; fi; done'

alias getsorthdd='sudo fatsort -c'
alias getshortlink='pastebinit -b http://paste.kde.org'
alias getcd2wav='cdparanoia -vzl -O +48 [::]- disk.wav; cdrdao read-toc disk.toc; cueconvert -i toc disk.toc disk.cue'

alias getstartvncserver='x11vnc -ncache 10 -usepw -display :0 -forever' # To connect please enter "vncviewer localhost:0"

alias gituntrack='git update-index --assume-unchanged'
alias gitgraph='git log --graph --pretty=format:"%h - %ar - %an          %s"'

alias sshkey='ssh-keygen'
alias sshkeycopy="ssh-copy-id '-p 32 -i /home/aslok/.ssh/id_rsa aslok@192.168.0.5'"

#alias skype-clear="kill -HUP `ps -eo 'pid:1,args:1' | grep -E '\-\-type=renderer.*skypeforlinux' | cut -d' ' -f1`"

# Сброс
Color_Off='\e[0m'       # Text Reset

# Обычные цвета
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Жирные
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Подчёркнутые
UBlack='\e[4;30m'       # Black
URed='\e[4;31m'         # Red
UGreen='\e[4;32m'       # Green
UYellow='\e[4;33m'      # Yellow
UBlue='\e[4;34m'        # Blue
UPurple='\e[4;35m'      # Purple
UCyan='\e[4;36m'        # Cyan
UWhite='\e[4;37m'       # White

# Фоновые
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

# Высоко Интенсивные
IBlack='\e[0;90m'       # Black
IRed='\e[0;91m'         # Red
IGreen='\e[0;92m'       # Green
IYellow='\e[0;93m'      # Yellow
IBlue='\e[0;94m'        # Blue
IPurple='\e[0;95m'      # Purple
ICyan='\e[0;96m'        # Cyan
IWhite='\e[0;97m'       # White

# Жирные Высоко Интенсивные
BIBlack='\e[1;90m'      # Black
BIRed='\e[1;91m'        # Red
BIGreen='\e[1;92m'      # Green
BIYellow='\e[1;93m'     # Yellow
BIBlue='\e[1;94m'       # Blue
BIPurple='\e[1;95m'     # Purple
BICyan='\e[1;96m'       # Cyan
BIWhite='\e[1;97m'      # White

# Высоко Интенсивные фоновые
On_IBlack='\e[0;100m'   # Black
On_IRed='\e[0;101m'     # Red
On_IGreen='\e[0;102m'   # Green
On_IYellow='\e[0;103m'  # Yellow
On_IBlue='\e[0;104m'    # Blue
On_IPurple='\e[0;105m'  # Purple
On_ICyan='\e[0;106m'    # Cyan
On_IWhite='\e[0;107m'   # White
