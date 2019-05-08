#!/usr/bin/env bash
vslo_menu (){
vslo_ttle="What would you like to do?"
vslo_clas="$vslo_ttle"
vslo_wico="/usr/share/icons/void-trlogo.png"
vslo_main=$(yad --title="$vslo_ttle" --class="$vslo_clas" --window-icon="$vslo_wico" --width="800" --height="48" --center --fixed --on-top --buttons-layout=center  --button="Cancel!! Cancel:1" --button="Logout!$vslo_bute!Logout of VSIDO:2" --button="Lock Screen!$vslo_bute!Lock Screen:3" --button="Suspend!$vslo_buts!Suspend VSIDO:4" --button="Hibernate!$vslo_buts!Hibernate VSIDO:5" --button="Reboot!$vslo_butr!Reboot VSIDO:6" --button="Shutdown!$vslo_butq!Shutdown VSIDO:7")
vslo_main=$?
case "$vslo_main" in
1 | 252)
exit 1
;;
2)
id_of_session=$(loginctl session-status | head -n 1 | awk '{print $1}')
loginctl terminate-session "$id_of_session"
exit 0
;;
3)
slock
exit 0
;;
4)
systemctl suspend
exit 0
;;
5)
systemctl hibernate
exit 0
;;
6)
systemctl reboot
exit 0
;;
7)
systemctl poweroff
exit 0
;;
esac
}
while :
do
vslo_menu
done