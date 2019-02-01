#!/bin/bash

#
#This Script will automate modifying cmdline.txt and config.txt. disable boot txt and Raspberrys
#set screen resolution to 1024 X 600 for 7" LCD
#Install Xbox One Controller Drivers and much more 
#
#I am in no way a developer/scripter if any of the scripting doesn't follow best practices please  
#be patient I am still learning and wanted a repeatable way to setup the RetroPie. 
#

infobox= ""
infobox="${infobox}___________________________________________________________________________\n\n"
infobox="${infobox}\n"
infobox="${infobox}RetroPie Toolbox\n\n"
infobox="${infobox}\n"
infobox="${infobox}This Toolbox is for enabling features on the RetroPie\n"
infobox="${infobox}I wrote this so that I could setup new SD cards easily\n"
infobox="${infobox}\n"
infobox="${infobox}\n"
infobox="${infobox}___________________________________________________________________________\n\n"

dialog --backtitle "RetroPie Toolkit" \
--title "RetroPie Toolkit" \
--msgbox "${infobox}" 15 80


function main_menu() {
    local choice

    while true; do
        choice=$(dialog --backtitle "$BACKTITLE" --title " MAIN MENU " \
            --ok-label OK --cancel-label Exit \
            --menu "What action would you like to perform?" 25 75 20 \
            1 "Disable/Enable BootupTxt/Raspberrys" \
            2 "Screen Resolution" \
            3 "Xbox One Controller Drivers" \
            4 "GPIO Shutdown Powerbutton" \
            5 "Install Background Music" \
            6 "Bezel Project" \
            7 "Setup I2S Sound Bonnet" \
            8 " " \
            9 " " \
            10 " " \
            11 " " \
            12 " " \
            13 " " \
            2>&1 > /dev/tty)

        case "$choice" in
            1) boot_txt  ;;
            2) screen_resolution  ;;
            3) xbox_controller ;;
            4) gpio_shutdown ;;
            5) installbgm ;;
            6) bezelproject ;;
            7) i2s ;;
            8) n ;;
            9) a ;;
            10) o ;;
            11) a ;;
            12) x ;;
            13) u ;;
            *)  break ;;
        esac
    done
}


function boot_txt(){
    infoboxboot= ""
    infoboxboot="${infoboxboot}_______________________________________________________\n\n"
    infoboxboot="${infoboxboot}\n"
    infoboxboot="${infoboxboot}This will modify the cmdline.txt of the RaspberryPie\n\n"
    infoboxboot="${infoboxboot}a Backup of the original files will be copied ~/rpicfgbackup folder\n"
    infoboxboot="${infoboxboot}and /boot/backup \n"
    infoboxboot="${infoboxboot}\n"
    infoboxboot="${infoboxboot}If something should go wrong you can restore the file from the boot partition on \n"
    infoboxboot="${infoboxboot}and PC or Mac\n"
    infoboxboot="${infoboxboot}\n"
    infoboxboot="${infoboxboot}\n\n"

    dialog --backtitle "RetroPie Toolkit boot txt" \
    --title "RetroPie Toolkit boot txt" \
    --msgbox "${infoboxboot}" 15 75
    local choice
    while true; do
        choice=$(dialog --backtitle "$BACKTITLE" --title " Boot Txt " \
            --ok-label OK --cancel-label Back \
            --menu "What action would you like to perform?" 25 55 20 \
            1 "Disable Boot txt" \
            2 "Enable Boot Txt" \
            3 "Disable Raspberrys" \
            4 "Enabele Raspberrys" \
            5 "Restore original cmdline.txt" \
            2>&1 > /dev/tty)

        case "$choice" in
            1) cmdlinetxt disable  ;;
            2) cmdlinetxt enable  ;;
            3) raspberry disable  ;;
            4) raspberry enable  ;;
            4) cmdlinetxt restore ;;
            *)  break ;;
        esac
    done
    infoboxboot=
}
function cmdlinetxt(){

    if [ ! -d "~/rpicfgbackup" ]; then
        sudo mkdir -p ~/rpicfgbackup
    fi
    if [ ! -d "/boot/backup" ]; then
        sudo mkdir -p /boot/backup
    fi
    
    if [ "$1" == "disable" ]; then
        testconsole=`cat "/boot/cmdline.txt"`
        if [[ "$testconsole" == *"tty3"* ]]; then
            dialog --infobox "boot txt already disabled" 3 30 ; sleep 3
        else    
            sudo cp --backup=numbered -v /boot/cmdline.txt /boot/backup
            sudo cp --backup=numbered -v /boot/cmdline.txt ~/rpicfgbackup
            sudo sed -i 's/console=tty1/console=tty3/g' /boot/cmdline.txt
            sudo sed -i 's/$/ vt.global_cursor_default=0/' /boot/cmdline.txt
        fi   
    fi
    
    if [ "$1" == "enable" ]; then
        testconsole=`cat "/boot/cmdline.txt"`
        if [[ "$testconsole" == *"tty1"* ]]; then
            dialog --infobox "boot txt already enabled" 3 30 ; sleep 3
        else
            sudo cp --backup=numbered -v /boot/cmdline.txt /boot/backup
            sudo cp --backup=numbered -v /boot/cmdline.txt ~/rpicfgbackup
            sudo sed -i 's/console=tty3/console=tty1/g' /boot/cmdline.txt 
            sudo sed -i 's/ vt.global_cursor_default=0//g' /boot/cmdline.txt            
        fi
    fi
    if [ "$1" == "restore" ]; then
        if [ ! -f "/boot/backup/cmdline.txt" ]; then
            dialog --infobox "backup cmdline.txt not found in /boot/backup/" 3 50 ; sleep 3
        else
            dialog --infobox "Restoring Original cmdline.txt" 3 35 ; sleep 3
            sudo cp /boot/backup/cmdline.txt /boot/cmdline.txt
        fi
    fi
}
function raspberry(){

    if [ ! -d "~/rpicfgbackup" ]; then
        sudo mkdir -p ~/rpicfgbackup
    fi
    if [ ! -d "/boot/backup" ]; then
        sudo mkdir -p /boot/backup
    fi
    
    if [ "$1" == "disable" ]; then
        testconsole=`cat "/boot/cmdline.txt"`
        if [[ "$testconsole" == *"logo.nologo"* ]]; then
            dialog --infobox "Rasberry's already disabled" 3 30 ; sleep 3
        else
            sudo cp --backup=numbered -v /boot/cmdline.txt /boot/backup
            sudo cp --backup=numbered -v /boot/cmdline.txt ~/rpicfgbackup
            sudo sed -i 's/$/ logo.nologo/' /boot/cmdline.txt
        fi
    fi
    
    if [ "$1" == "enable" ]; then
        testconsole=`cat "/boot/cmdline.txt"`
        if [[ "$testconsole" != *"logo.nologo"* ]]; then
            dialog --infobox "Rasberry's already enabled" 3 35 ; sleep 3
        else
            sudo cp --backup=numbered -v /boot/cmdline.txt /boot/backup
            sudo cp --backup=numbered -v /boot/cmdline.txt ~/rpicfgbackup
            sudo sed -i 's/ logo.nologo//g' /boot/cmdline.txt
        fi
    fi
}

function screen_resolution(){
    infoboxbootscrr= ""
    infoboxbootscrr="${infoboxbootscrr}______________________________________________________________________\n\n"
    infoboxbootscrr="${infoboxbootscrr}\n"
    infoboxbootscrr="${infoboxbootscrr}This Menu modifies /boot/config.txt file to help set the screen resolution\n\n"
    infoboxbootscrr="${infoboxbootscrr}\n"
    infoboxbootscrr="${infoboxbootscrr}a Backup of the original files will be copied ~/rpicfgbackup folder\n"
    infoboxbootscrr="${infoboxbootscrr}and /boot/backup \n"
    infoboxbootscrr="${infoboxbootscrr}\n"
    infoboxbootscrr="${infoboxbootscrr}\n"
    infoboxbootscrr="${infoboxbootscrr}\n"
    infoboxbootscrr="${infoboxbootscrr}\n\n"

    dialog --backtitle "RetroPie Toolkit Screen Resolution" \
    --title "RetroPie Toolkit Screen Resolution" \
    --msgbox "${infoboxbootscrr}" 15 75
    local choice
        while true; do
        choice=$(dialog --backtitle "$BACKTITLE" --title " Set Resolution " \
            --ok-label OK --cancel-label Back \
            --menu "What action would you like to perform?" 25 55 20 \
            1 "1024 X 600 (S2Pi Z-0051)" \
            2 "Restore Original config.txt" \
            2>&1 > /dev/tty)

        case "$choice" in
            1) resolution "1024600"  ;;
            2) resolution restore ;;
            *)  break ;;
        esac
    done
    infoboxbootscrr=
}
function resolution(){
    if [ "$1" == "restore" ]; then
        if [ ! -f "/boot/backup/config.txt" ]; then
            dialog --infobox "backup config.txt not found in /boot/backup/" 3 50 ; sleep 3
        else
            dialog --infobox "Restoring Original config.txt" 3 35 ; sleep 3
            sudo cp /boot/backup/config.txt /boot/config.txt
        fi
    fi
    if [ "$1" == "1024600" ]; then
        sudo cp --backup=numbered -v /boot/config.txt /boot/backup
        sudo cp --backup=numbered -v /boot/config.txt ~/rpicfgbackup
        dialog --infobox "Setting Resolution 1024 X 600" 3 35 ; sleep 3
        
        sudo sed -i 's/.*hdmi_group=1.*/hdmi_cvt=1024 600 60 3 0 0 0\n&/' /boot/config.txt
        sudo sed -i 's/#hdmi_group=1/hdmi_group=2/g' /boot/config.txt
        sudo sed -i 's/#hdmi_mode=1/hdmi_mode=87/g' /boot/config.txt
    fi

}

function xbox_controller(){
    infoboxxbox= ""
    infoboxxbox="${infoboxxbox}______________________________________________________________________\n\n"
    infoboxxbox="${infoboxxbox}\n"
    infoboxxbox="${infoboxxbox}Install the Xbox One Controller Driver\n\n"
    infoboxxbox="${infoboxxbox}\n"
    infoboxxbox="${infoboxxbox}\n\n"

    dialog --backtitle "RetroPie Toolkit Xbox One Controller" \
    --title "RetroPie Toolkit Xbox One Controller" \
    --yesno "${infoboxxbox}" 10 75
    
    # Get exit status
    # 0 means user hit [yes] button.
    # 1 means user hit [no] button.
    # 255 means user hit [Esc] key.
    response=$?
    case $response in
        0) xboxdriverinstall ;;
        1) dialog --infobox "Driver Installed Canceled" 3 35 ; sleep 3 ;;
        255) dialog --infobox "Driver Installed Canceled" 3 35 ; sleep 3 ;;
    esac
    
    infoboxxbox=
}
function xboxdriverinstall(){
    dialog --infobox "Installing xpadneo" 3 35 ; sleep 1
    cd ~
    git clone https://github.com/atar-axis/xpadneo.git
    cd xpadneo
    sudo ./install.sh
    dialog --infobox "Install complete" 3 35 ; sleep 1
}
main_menu

