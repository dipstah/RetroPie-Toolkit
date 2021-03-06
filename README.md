# RetroPie-Toolkit
Shell Script for configuring RetroPie 

I am new to the RetroPie community and have been downloading pre built images. This got me interested in building my own
image with what I wanted, some images had features I really like but not all of them had everything. I started this script in the
hopes I could start building my own and instead of taking notes I would add it to the script so that it is repeatable every
time I wanted to start over with a new image. 

feel free to use my script. I hope it is usefull for others.

Thanks to everyone who has put in hard work on developing and modding RetroPie and special thanks to the ones whom 
I am useing there work in my script. 

[@atar-axis](https://github.com/atar-axis/xpadneo) for xpadneo Xbox one Driver<br/>
[8bitjunkie](https://pie.8bitjunkie.net/retropie-shutdown-and-startup-switch-the-easy-way) for gpio shutdown<br/>
[@madmodder123](https://github.com/madmodder123/retropie_music_overlay) for BGM<br/>
[@thebezelproject](https://github.com/thebezelproject/BezelProject) for the awesome bezels<br/>
[@RetroHursty69](https://github.com/RetroHursty69/HurstyThemes) for all the Themes and work you have done<br/>
[@Shakz76](https://github.com/Shakz76/Eazy-Hax-RetroPie-Toolkit) for the Idea and Eazy-Hax-RetroPie-Toolkit<br/> 
[Patric Arteaga](https://patrickdearteaga.com/arcade-music/) for the Royalty Free Music<br/>

## What does the script do? 
- automates enabling/disabling boot text , Raspberry's <br/>
- set screen resolution 1024x600 for the 7" display from 52Pi  <br/>
- install Xbox One Driver xpadneo <br/>
- Install GPIO Shutdown script from 8bitjunkie <br/>
- Setup Adafruit's i2s Audio Amp Driver <br/>
- Install BGM  <br/>
- Add Bezel Project to RetroPie  <br/>
- Add Hursty Themes <br/>

![alt text](http://www.dippydawg.net/images/MainMenu.png)


## To Do
- New Name not a big fan of using RetroPie Toolkit
- configure RetroPie for OMXPlayer to play audio on bootup for splash screens
- ~~new Background Music menu and icon to replace the one provided by madmodder123 BGM install~~
- ~~menu item for GPIO Shutdown with icon~~
- Add Eazy-Hax-RetroPie-Toolkit
- ~~detect if Toolkit is running from retropie menu if not ask to install~~
- ~~Set Volume for BGM~~
- ~~Add Icon for Bezel Project in RetroPie config menu~~

## Known Issues ##
- ~~When installing BGM the original BGM_Install.sh replaces the gamelist.xml removeing any other custom menu adds.~~ 
- ~~When installing Hursty Themes gamelist.xml not updated because scripts folder already existed~~
- On occasion the RetroPie splash screen appears when loading one of the menues. 

## Change Log

**2/4/19**
- Added: Reboot Prompts after selections that need reboots
- Added: cleanup mess for some functions
- Added: txt to i2s notification informing the need of a keyboard
- Added: Set Volume for BGM to 0.20 after install default was 0.75
- Added: gpioShutdown.sh menu

**2/3/19**
- Added: Bezel install now updates gamelist.xml 
- Added: Install to RetroPie executing script outside of the retropiemenu folder
- Added: script header
- Change: BGM function dowlnload music if the ~/BGM folder doesn't exist
- Change: download music and icons so project doesn't have to be cloned
- Fixed: Hursty Themes original instal.sh crash due to scripts folder already existing, stopped using install.sh from            Hursty added to this script to check for the existence of folder. 

**2/2/19**
- Added: Hursty Themes Installer
    - https://github.com/RetroHursty69/HurstyThemes 
- Added: i2s Menu update conrim running script if detected in rc.local
- Added: BGM_Toggel.sh menu 
- Added: Volume Option to BGM_Toggle.sh menu
- Added: new icon for BGM_Toggle menu
- Fixed: BGM was installing with sudo 
- Fixed: GPIO Shutdown function
- Fixed: BGM font missing Pixel.otf

**2/1/19**
- Added: Bezel Project 
- Added: Royalty Free Arcade Music from 
  - https://patrickdearteaga.com/arcade-music/ 
- Added: AdaFruit i2S Sound Bonnet Driver
- Added: backup rc.local to ~/rpicfgbackup for GPIO Shutdown
- Added: Detection to see if Resolution was already set 
- Added: Detection for GPIO script installed
- Added: Detection for BGM already installed
- Added: Detections for i2s Audio amplifier bonnet 
- Change: Removed additional unused menu options that were just place holder
- Change: resize main menu 
- Change: moved the order of BGM and i2s menu items so driver was before BGM to imply install sound driver first 
- Change: Move Bezel Project down to last in menu 	
- Change: BGM.zip to BGM.tar.gz for royalty free music
- Fixed: Line detection for rc.local where the script would add the GPIO and BGM python scripts
- Fixed: Spelling in BGM function
- Fixed: Extraction of BGM archive for Royalty Free Musi

**1/31/19**
- Added: restore original for config.txt and cmdline.txt
- Added: Resolution 1024X600 for 7” display Kit (without Touch Screen) SKU:Z-0051
  - https://www.wiki.52pi.com/index.php?title=7-Inch-1024x600_Display_Kit_(without_Touch_Screen)_SKU:Z-0051
- Added: Xbox One Controller Driver Install
  - https://github.com/atar-axis/xpadneo 
- Added: GPIO shutdown script (8bitjunkie)
  - https://pie.8bitjunkie.net/retropie-shutdown-and-startup-switch-the-easy-way
- Added: Background music 
  - https://github.com/madmodder123/retropie_music_overlay
