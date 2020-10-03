
######################################## ФУНКЦИИ РАБОТЫ С АРХИВАМИ ########################################

extract () {
    if [ -f "$1" ] ; then
        case "$1" in
            *.tar.bz2)          tar xjf "$1"              ;;
            *.tar.gz)           tar xzf "$1"              ;;
            *.bz2)              bunzip2 "$1"              ;;
            *.rar)              unrar x -r -ad "$1"       ;;
            *.gz)               gunzip "$1"               ;;
            *.tar)              tar xf "$1"               ;;
            *.tbz2)             tar xjf "$1"              ;;
            *.tgz)              tar xzf "$1"              ;;
            *.zip)              unzip "$1"                ;;
            *.7z)               7z e "$1"                 ;;
            *.Z)                uncompress "$1"           ;;
            *.exe)              mkdir ico; for i in `wrestool -l "$1" | grep group_icon | awk '{ print $2}' | cut -f2 -d=` ; do wrestool -x -n "$i" "$1" > "ico/$i.ico"; done ;;
            *.dll)              mkdir ico; for i in `wrestool -l "$1" | grep group_icon | awk '{ print $2}' | cut -f2 -d=` ; do wrestool -x -n "$i" "$1" > "ico/$i.ico"; done ;;
            *)                  echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

putinbz2 () {
  echo "Будет создан (перезаписан) архив bzip `basename "$1"`.tar.bz2"
  tar -jcvf - "$1" 2> /dev/null | pv -cs "`du "$1" -sb | grep -o '[0-9]*'`" > "`basename "$1"`.tar.bz2"
}

putingz () {
  echo "Будет создан (перезаписан) архив gzip `basename "$1"`.tar.gz"
  tar -zcvf - "$1" 2> /dev/null | pv -cs "`du "$1" -sb | grep -o '[0-9]*'`" > "`basename "$1"`.tar.gz"
}

dir2bz2 () {
  BACK="`pwd`"
  cd "${1:-.}"
  CURRENT="`pwd`"
  echo "Будет создан (перезаписан) архив bzip `basename "$CURRENT"`.tar.bz2"
  SIZE="`du "$CURRENT" -sb | grep -o '[0-9]*' | head -n 1`"
  echo "Размер папки $SIZE"
  tar -jcf - . | pv -cs $SIZE > "$BACK/`basename "$CURRENT"`.tar.bz2"
  cd "$BACK"
}

dir2gz () {
  BACK="`pwd`"
  cd "${1:-.}"
  CURRENT="`pwd`"
  echo "Будет создан (перезаписан) архив gzip `basename $CURRENT`.tar.gz"
  SIZE="`du "$CURRENT" -sb | grep -o '[0-9]*' | head -n 1`"
  echo "Размер папки $SIZE"
  tar -zcf - . | pv -cs $SIZE > "$BACK/`basename "$CURRENT"`.tar.gz"
  cd "$BACK"
}

######################################## ФУНКЦИИ ДЛЯ РАБОТЫ С ФАЙЛАМИ ########################################

lsln () {
    lsf "${1:-.}" | grep ' \-> '
}

grab() {
    # chmod -R a-rwx,a+rX,u+rwX ./dirname

    sudo chown -R ${USER}:${USER} "${1:-.}"
    sudo find "${1:-.}" -type d | xargs -i chmod 755 "{}" &> /dev/null
    sudo find "${1:-.}" -type f | xargs -i chmod 644 "{}" &> /dev/null
}

# backup
bu () {
    pv "$1" > ~/.backup/`basename "$1"`-`date +%Y%m%d%H%M`.backup
}

# search driver
search_driver_by_vendor_id ()
{
	STRING=''; FILES=/sys/bus/usb/devices/*/idVendor; for FILE in $FILES; do STRING=$(cat "$FILE" | grep "$1"); if [[ $STRING != '' ]]; then echo $FILE; break; fi; done;
}

get_short_link ()
{
	lynx --dump "http://tinyurl.com/api-create.php?url=$1"
}


#get_screenshot_last_link ()
#{
#	get_short_link "http://aslok.no-ip.org/aslok/Скриншоты/$(ls ~/Картинки/Скриншоты/ | grep ^20 | tail -n 1)"
#}

search_iphone_app ()
{
	app=$1
	ssh root@192.168.0.41 'dir=/private/var/mobile/Applications; for filename in $dir/* ; do if [ -n "`ls \"$filename\" | grep \"$app\"`" ] ; then echo $filename; fi; done;'
}

######################################## ФУНКЦИИ ДЛЯ РАБОТЫ С ВЕБ-РЕСУРСАМИ ########################################

geo () {
    GEO=`wget -qO- 'http://xml.utrace.de/?query='$1 | \
      sed -e '/^<\/\?result\|^<?xml\|^<queries/d;s/<\/.\+>$//g;s/^<//g;s/>/\t\t: /g;s/\(^countrycode\|^latitude\|^longitude\)\t/\1/g'`

    echo "$GEO" | tr ':' ' '

    REG=`echo "$GEO" | awk -F':' '/^region/ {print $2}'`
    LAT=`echo "$GEO" | awk -F':' '/^latitude/ {print $2}'`
    LONG=`echo "$GEO" | awk -F':' '/^longitude/ {print $2}'`

    whois $1 | sed 's/\ \+//g;s/^\(org:\)/\1/' | \
      awk -F':' '/^nserver|^org:|^registar|^created|^paid|^inetnum|^netname|^descr|^organisation|^org-name|^address|^e-mail|^person|^route/ {print $1"\t\t  "$2}' | \
      sed 's/\(^organisation\|^org-name\|^paid-till\)\t/\1/'

    echo -ne "google map\t  "
    echo 'http://maps.google.com/maps?f=q&source=s_q&hl=ru&ie=UTF8&hq=&t=h&z=11&sll='$LAT','$LONG'&q='$REG | sed 's/\ \+//g'
    echo -ne "url\t\t  http://en.utrace.de/?query=$1\n"
}

######################################## ФУНКЦИИ ДЛЯ РАЗРАБОТКИ ПО #################################################

colors() {
    local fgc bgc vals seq0

    printf "Color escapes are %s\n" '\e[${value};...;${value}m'
    printf "Values 30..37 are \e[33mforeground colors\e[m\n"
    printf "Values 40..47 are \e[43mbackground colors\e[m\n"
    printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

    # foreground colors
    for fgc in {30..37}; do
    # background colors
    for bgc in {40..47}; do
        fgc=${fgc#37} # white
        bgc=${bgc#40} # black

        vals="${fgc:+$fgc;}${bgc}"
        vals=${vals%%;}

        seq0="${vals:+\e[${vals}m}"
        printf "  %-9s" "${seq0:-(default)}"
        printf " ${seq0}TEXT\e[m"
        printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
    done
    echo; echo
    done
}
