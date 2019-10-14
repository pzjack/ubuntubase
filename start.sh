#!/bin/bash
  
mkdir -p "/root/.vnc"
PASSWD_PATH="/root/.vnc/passwd"
if [[ -f $PASSWD_PATH ]]; then
    rm -f $PASSWD_PATH
fi
echo "$VNC_PW" | vncpasswd -f >> $PASSWD_PATH
chmod 600 $PASSWD_PATH


echo -e "\n------------------ startup of Xfce4 window manager ------------------"
### disable screensaver and power management
xset -dpms &
xset s noblank &
xset s off &

/usr/bin/startxfce4 --replace > /xfce.log &

vncserver -kill $DISPLAY &> $STARTUPDIR/vnc_startup.log \
    || rm -rfv /tmp/.X*-lock /tmp/.X11-unix &> $STARTUPDIR/vnc_startup.log \
    || echo "no locks present"

vncserver $DISPLAY -depth $VNC_COL_DEPTH -geometry $VNC_RESOLUTION &> /vnc_startup.log
PID_SUB=$!
wait $PID_SUB
tail -f /vnc_startup.log
