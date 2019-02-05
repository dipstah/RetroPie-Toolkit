#!/bin/bash
###################################################################
#Script Name	: gpioShutdown.sh
#Description    :Enable/Disable GPIO Shutdown script 
#                
#https://github.com/dipstah/RetroPie-Toolkit
#
#Author         :Mike White
#Email         	:dipstah@dippydawg.net
###################################################################

function mainmenu(){
    if [ -f ~/.DisableGPIO ]; then
        gpiostatus="GPIO Shutdown (Disabled)"
    else
        gpiostatus="GPIO Shutdown (Enabled)"
    fi
    local choice
    while true; do
        choice=$(dialog --backtitle "$BACKTITLE" --title "GPIO Shutdown Menu " \
            --ok-label OK --cancel-label Exit \
            --menu "What action would you like to perform?" 8 55 20 \
            1 "$gpiostatus" \
            2>&1 > /dev/tty)

        case "$choice" in
            1) gpio_sh ;;
            *) break ;;
        esac
    done
    gpiostatus=
}
function gpio_sh(){
    if [ -f ~/.DisableGPIO ]; then
        #Enabled
        dialog --infobox "Enabling GPIO Shutdown Script" 3 30 ; sleep 3
        sudo rm ~/.DisableGPIO &> /dev/null
        sudo sed -i "/#sudo python \/home\/pi\/scripts\/shutdown.py \&/c\sudo python \/home\/pi\/scripts\/shutdown.py \&" /etc/rc.local
        sudo python /home/pi/scripts/shutdown.py &
        gpiostatus="GPIO Shutdown (Enabled)"
    else
        #Disabled
        dialog --infobox "Disabling GPIO Shutdown Script" 3 30 ; sleep 3
        touch ~/.DisableGPIO
        sudo pkill -f shutdown.py &> /dev/null
        sudo sed -i "/sudo python \/home\/pi\/scripts\/shutdown.py \&/c\#sudo python \/home\/pi\/scripts\/shutdown.py \&" /etc/rc.local
        gpiostatus="GPIO Shutdown (Disabled)"
    fi

}
mainmenu    
