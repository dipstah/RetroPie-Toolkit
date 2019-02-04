#!/usr/bin/env bash

###################################################################
#Script Name	: BGM_Toggle.sh
#Description    :Script for enabling/disabling Background Music replaced 
#                @madmodder123 original BGM_Toggle.sh for BGM
#https://github.com/dipstah/RetroPie-Toolkit
#madmodder123 BGM https://github.com/madmodder123/retropie_music_overlay
#Author         :Mike White
#Email         	:dipstah@dippydawg.net
###################################################################
function mainmenu(){
    if [ -f ~/DisableMusic ]; then
        bgmstatus="Enable Music (Disabled)"
    else
        bgmstatus="Enable Music (Enabled)"
    fi
    
    local choice

    while true; do
        choice=$(dialog --backtitle "$BACKTITLE" --title "BGM Menu " \
            --ok-label OK --cancel-label Exit \
            --menu "What action would you like to perform?" 10 55 20 \
            1 "$bgmstatus" \
            2 "Set Volume" \
            2>&1 > /dev/tty)

        case "$choice" in
            1) bgm ;;
            2) setvolumemenu  ;;
            *) break ;;
        esac
    done
    bgmststus=
}

function bgm(){
    if [ -f ~/DisableMusic ]; then
	   # Enabled
        sudo rm ~/DisableMusic &> /dev/null
        python ~/BGM.py &
        bgmstatus="Enable Music (Enabled)"
        dialog --infobox "Enabling Background Music" 3 30 ; sleep 3
    else
        #Disabled
        dialog --infobox "Disabling Background Music" 3 30 ; sleep 3
        touch ~/DisableMusic
        sudo pkill -f BGM.py &> /dev/null
        sudo pkill -f pngview &> /dev/null
        bgmstatus="Enable Music (Disabled)"
    fi
}
function setvolumemenu(){
    currentvolume='cat BGM.py | grep "maxvolume ="'
    local choice

    while true; do
        choice=$(dialog --backtitle "$BACKTITLE" --title " Volume Menu " \
            --ok-label OK --cancel-label Back \
            --menu "Current Volume Level " 18 35 20 \
            1 "10%" \
            2 "20%" \
            3 "30%" \
            4 "40%" \
            5 "50%" \
            6 "60%" \
            7 "70%" \
            8 "80%" \
            9 "90%" \
            2>&1 > /dev/tty)

        case "$choice" in
            1) setvolume_sh 10 ;;
            2) setvolume_sh 20  ;;
            3) setvolume_sh 30 ;;
            4) setvolume_sh 40 ;;
            5) setvolume_sh 50 ;;
            6) setvolume_sh 60 ;;
            7) setvolume_sh 70 ;;
            8) setvolume_sh 80 ;;
            9) setvolume_sh 90 ;;
            *)  break ;;
        esac
    done
}
function setvolume_sh(){
    dialog --infobox "Setting Volume $1%" 3 30 ; sleep 1
    sed -i "/maxvolume = 0.*/c\maxvolume = 0.$1" ~/BGM.py
    sudo pkill -f BGM.py &> /dev/null
    sleep 2
    dialog --infobox "Setting Volume $1%" 3 30 ; sleep 1
    python ~/BGM.py &
}
mainmenu
