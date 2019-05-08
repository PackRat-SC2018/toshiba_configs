#!/usr/bin/env bash
vslo_menu (){
vslo_ttle="What would you like to do?"
vslo_clas="$vslo_ttle"
vslo_wico="/usr/share/icons/void-trlogo.png"
vslo_main=$(yad --title="$vslo_ttle" --class="$vslo_clas" --window-icon="$vslo_wico" --width="648" --height="48" --center --fixed --on-top --buttons-layout=center  --button="Cancel!! Cancel:1" --button="Logout!$vslo_bute!Logout of VSIDO:2" --button="Suspend!$vslo_buts!Suspend VSIDO:3" --button="Hibernate!$vslo_buts!Hibernate VSIDO:4" --button="Reboot!$vslo_butr!Reboot VSIDO:5" --button="Shutdown!$vslo_butq!Shutdown VSIDO:6")
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
systemctl suspend
exit 0
;;
4)
systemctl hibernate
exit 0
;;
5)
systemctl reboot
exit 0
;;
6)
systemctl poweroff
exit 0
;;
esac
}
while :
do
vslo_menu
done