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
            --menu "What action would you like to perform?" 15 55 20 \
            1 "Disable/Enable BootupTxt/Raspberrys" \
            2 "Screen Resolution" \
            3 "Xbox One Controller Drivers" \
            4 "GPIO Shutdown Powerbutton" \
            5 "Setup I2S Sound Bonnet" \
            6 "Install Background Music" \
            7 "Bezel Project" \
            2>&1 > /dev/tty)

        case "$choice" in
            1) boot_txt  ;;
            2) screen_resolution  ;;
            3) xbox_controller ;;
            4) gpio_shutdown ;;
            5) i2s ;;
            6) installbgm ;;
            7) bezelproject ;;
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
            --menu "What action would you like to perform?" 13 55 20 \
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
            --menu "What action would you like to perform?" 10 55 20 \
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
    
    if [ ! -d "~/rpicfgbackup" ]; then
        sudo mkdir -p ~/rpicfgbackup
    fi
    if [ ! -d "/boot/backup" ]; then
        sudo mkdir -p /boot/backup
    fi
    if [ "$1" == "restore" ]; then
        if [ ! -f "/boot/backup/config.txt" ]; then
            dialog --infobox "backup config.txt not found in /boot/backup/" 3 50 ; sleep 3
        else
            dialog --infobox "Restoring Original config.txt" 3 35 ; sleep 3
            sudo cp /boot/backup/config.txt /boot/config.txt
        fi
    fi
    if [ "$1" == "1024600" ]; then
        testresolution=`cat "/boot/config.txt"`
        if [[ "$testresolution" == *"hdmi_cvt=1024 600 60 3 0 0 0"* ]]; then
            dialog --infobox "Resolution already set" 3 30 ; sleep 3
        else
            sudo cp --backup=numbered -v /boot/config.txt /boot/backup
            sudo cp --backup=numbered -v /boot/config.txt ~/rpicfgbackup
            dialog --infobox "Setting Resolution 1024 X 600" 3 35 ; sleep 3
        
            sudo sed -i 's/.*hdmi_group=1.*/hdmi_cvt=1024 600 60 3 0 0 0\n&/' /boot/config.txt
            sudo sed -i 's/#hdmi_group=1/hdmi_group=2/g' /boot/config.txt
            sudo sed -i 's/#hdmi_mode=1/hdmi_mode=87/g' /boot/config.txt
        fi
    fi
}

function xbox_controller(){
    infoboxxbox= ""
    infoboxxbox="${infoboxxbox}__________________________________________________\n"
    infoboxxbox="${infoboxxbox}\n"
    infoboxxbox="${infoboxxbox}Install the Xbox One Controller Driver\n\n"
    infoboxxbox="${infoboxxbox}\n"
    infoboxxbox="${infoboxxbox}\n\n"

    dialog --backtitle "RetroPie Toolkit Xbox One Controller" \
    --title "RetroPie Toolkit Xbox One Controller" \
    --yesno "${infoboxxbox}" 8 55
    
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

function gpio_shutdown(){
    infoboxgpiosh= ""
    infoboxgpiosh="${infoboxgpiosh}__________________________________________________\n"
    infoboxgpiosh="${infoboxgpiosh}\n"
    infoboxgpiosh="${infoboxgpiosh}This script will install a python script to enable \n"
    infoboxgpiosh="${infoboxgpiosh}shutdown of Raspberry Pi upon PIN5/GPIO3 Logic LOW\n"
    infoboxgpiosh="${infoboxgpiosh}\n"
    infoboxgpiosh="${infoboxgpiosh}Visit http://pie.8bitjunkie.net for more information\n"
    infoboxgpiosh="${infoboxgpiosh}\n\n"

    dialog --backtitle "RetroPie Toolkit GPIO Shutdown" \
    --title "RetroPie Toolkit GPIO Shutdown" \
    --yesno "${infoboxgpiosh}" 10 60
    
    # Get exit status
    # 0 means user hit [yes] button.
    # 1 means user hit [no] button.
    # 255 means user hit [Esc] key.
    response=$?
    case $response in
        0) gpio_sh ;;
        1) dialog --infobox "Install GPIO shutdown script canceled" 3 45 ; sleep 3 ;;
        255) dialog --infobox "Install GPIO shutdown script canceled" 3 45 ; sleep 3 ;;
    esac
    
    infoboxgpiosh=
}
function gpio_sh(){
    if [ ! -d "~/rpicfgbackup" ]; then
        sudo mkdir -p ~/rpicfgbackup
    fi
    testgpio=`cat "/etc/rc.local"`
    if [[ "$testgpio" == *"shutdown.py"* ]]; then
        dialog --infobox "GPIO Shutdown script already installed" 3 50 ; sleep 3
    else    
        sudo cp --backup=numbered -v /etc/rc.local ~/rpicfgbackup
        curl https://pie.8bitjunkie.net/shutdown/setup-shutdown.sh --output ~/setup-shutdown.sh
        cd ~
        sudo chmod +x setup-shutdown.sh
        sudo ./setup-shutdown.sh
        sudo sed -i 's/^exit 0/#GPIO Shutdown script\n&/' /etc/rc.local 
        sudo sed -i 's/^exit 0/sudo python \/home\/pi\/scripts\/shutdown.py \&\n&/' /etc/rc.local 
        sudo sed -i 's/^exit 0/ \n&/' /etc/rc.local 
    fi
}

function installbgm(){
    infoboxbgm= ""
    infoboxbgm="${infoboxbgm}__________________________________________________\n"
    infoboxbgm="${infoboxbgm}\n"
    infoboxbgm="${infoboxbgm}Install Background Music\n\n"
    infoboxbgm="${infoboxbgm}\n"
    infoboxbgm="${infoboxbgm}\n\n"

    dialog --backtitle "RetroPie Toolkit BGM" \
    --title "RetroPie Toolkit BGM" \
    --yesno "${infoboxbgm}" 8 55
    
    # Get exit status
    # 0 means user hit [yes] button.
    # 1 means user hit [no] button.
    # 255 means user hit [Esc] key.
    response=$?
    case $response in
        0) bgm_sh ;;
        1) dialog --infobox "Install BGM canceled" 3 45 ; sleep 3 ;;
        255) dialog --infobox "Install BGM canceled" 3 45 ; sleep 3 ;;
    esac
    
    infoboxbgm=
}
function bgm_sh(){
    if [ ! -d "~/rpicfgbackup" ]; then
        sudo mkdir -p ~/rpicfgbackup
    fi
    testbgm=`cat "/etc/rc.local"`
    if [[ "$testbgm" == *"BGM.py"* ]]; then
        dialog --infobox "BGM already installed" 3 30 ; sleep 3
    else
        tar -zxvf ./BGM.tar.gz -C ../
        sudo cp --backup=numbered -v /etc/rc.local ~/rpicfgbackup
        cd ~
        git clone https://github.com/madmodder123/retropie_music_overlay.git
        cd retropie_music_overlay/
        sudo chmod +x BGM_Install.sh 
        sudo ./BGM_Install.sh 
        cp BGM.py ../
        cd ../
        sudo chmod +x ./BGM.py
   
        sudo sed -i 's/^exit 0/#BackGround Music\n&/' /etc/rc.local 
        sudo sed -i 's/^exit 0/su pi -c '\''python \/home\/pi\/BGM.py \&'\''\n&/' /etc/rc.local
        sudo sed -i 's/^exit 0/ \n&/' /etc/rc.local
    fi
}

function i2s(){
    infoboxi2s= ""
    infoboxi2s="${infoboxi2s}__________________________________________________\n"
    infoboxi2s="${infoboxi2s}\n"
    infoboxi2s="${infoboxi2s}Install Adafruit i2s Bonnet Sound Driver\n\n"
    infoboxi2s="${infoboxi2s}\n"
    infoboxi2s="${infoboxi2s}\n\n"

    dialog --backtitle "RetroPie Toolkit i2s" \
    --title "RetroPie Toolkit i2s" \
    --yesno "${infoboxi2s}" 8 55
    
    # Get exit status
    # 0 means user hit [yes] button.
    # 1 means user hit [no] button.
    # 255 means user hit [Esc] key.
    response=$?
    case $response in
        0) i2s_sh ;;
        1) dialog --infobox "Install i2s driver canceled" 3 45 ; sleep 3 ;;
        255) dialog --infobox "Install i2s driver canceled" 3 45 ; sleep 3 ;;
    esac
    
    infoboxi2s=
}
function i2s_sh(){
    if [ ! -d "~/rpicfgbackup" ]; then
        sudo mkdir -p ~/rpicfgbackup
    fi
    if [ ! -d "/boot/backup" ]; then
        sudo mkdir -p /boot/backup
    fi

    testi2s=`cat "/boot/config.txt"`
    if [[ "$testi2s" == *"dtoverlay=i2s-mmap"* ]]; then
        dialog --infobox "i2s ampliphier already installed" 3 50 ; sleep 3
    else    
        curl -sS https://raw.githubusercontent.com/adafruit/Raspberry-Pi-Installer-Scripts/master/i2samp.sh | bash
    fi
}

function bezelproject(){
    infoboxbezel= ""
    infoboxbezel="${infoboxbezel}_______________________________________________________\n\n"
    infoboxbezel="${infoboxbezel}\n"
    infoboxbezel="${infoboxbezel}This will add the Bezel Project to RetroPie and can be accessed\n\n"
    infoboxbezel="${infoboxbezel}from the configuration menu in RestroPie\n"
    infoboxbezel="${infoboxbezel}\n"
    infoboxbezel="${infoboxbezel}\n"
    infoboxbezel="${infoboxbezel}\n"
    infoboxbezel="${infoboxbezel}\n"
    infoboxbezel="${infoboxbezel}\n"
    infoboxbezel="${infoboxbezel}\n\n"

    dialog --backtitle "RetroPie Toolkit Bezel Project" \
    --title "RetroPie Toolkit Bezel Project" \
    --msgbox "${infoboxbezel}" 15 75
    
    cd /home/pi/RetroPie/retropiemenu/
	wget https://raw.githubusercontent.com/thebezelproject/BezelProject/master/bezelproject.sh
	chmod +x "bezelproject.sh"
    infoboxbezel=
}
main_menu 

