#!/bin/sh
# build script for fluxbox spin void linux - www.voidlinux.eu
# based on https://github.com/ferviron/void-mklive/blob/master/icabian.sh
#
#

DATE=$(date +%F_%s)
ARCH=$(uname -m)

GRUB="grub-i386-efi grub-x86_64-efi grub-utils efibootmgr";

BASE="dialog cryptsetup lvm2 mdadm gtkdialog base-devel";

XAPPS="xorg-minimal xorg-apps xinit xauth setxkbmap xbacklight gptfdisk xdotool wmctrl xlsfonts \
       xterm xf86-video-intel xf86-video-ati xf86-video-nouveau xf86-video-vesa xf86-video-fbdev";
       
FONTS="font-misc-misc terminus-font dejavu-fonts-ttf font-fira-otf font-hack-otf \
       noto-fonts-ttf cantarell-fonts font-fantasque-sans-ttf font-sourcecodepro \
       source-sans-pro ttf-material-icons ttf-ubuntu-font-family wqy-microhei";

GUIAPPS="fluxbox spectrwm geany rxvt-unicode sakura tmux pcmanfm gvfs gvfs-mtp gvfs-gphoto2 udisks2 \
         fuse qpdfview gparted dunst geeqie ImageMagick lxappearance colord lxdm greybird-themes \
         blackbird-themes hicolor-icon-theme adwaita-icon-theme gdk-pixbuf gtk2-engines gtk-engine-murrine";

INTNET="firefox hexchat transmission transmission-gtk connman connman-gtk connman-ncurses ntp";

SYSUTILS="xfsprogs btrfs-progs ntfs-3g p7zip xarchiver xz unzip zip lz4 rsync nfs-utils \
          yad htop wget curl gphoto2 cdrtools dvd+rw-tools scrot hsetroot dzen2 jgmenu \
          dmenu rofi slock less dbus dbus-x11 perl python python-dbus pygtk python-cairo vim mc";

MEDIA="alsa-lib alsa-utils alsa-tools alsa-plugins-ffmpeg alsa-plugins-jack alsa-plugins-speex alsa-plugins-samplerate \
       sox gst-plugins-base gst-plugins-ugly1 gst-plugins-bad1 gst-plugins-good1 mpg123 youtube-dl libdvdcss \
       audacious audacious-plugins ffmpegthumbnailer mpv";

SYSOPTS="git subversion inetutils iptables strace sysstat dstat slurm traceroute acpi acpid";

USROPTS="tint2 i3status zsh conky polybar lm_sensors neofetch inxi w3m w3m-img \
         geany-plugins geany-plugins-extra xfburn guvcview numlockx mate-power-manager";

BLOAT="thunderbird gimp filezilla cups cups-filters hplip libreoffice";

exec /mnt/public/void-mklive/mklive.sh -a x86_64 -p "$GRUB $BASE $XAPPS $FONTS $GUIAPPS $INTNET $SYSUTILS $MEDIA $SYSOPTS $USROPTS $BLOAT" -I ./ROOT/ -o void-live-full-${ARCH}-${DATE}-fluxbox.iso

exit 0
