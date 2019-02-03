# RetroPie-Toolkit
Shell Script for setting up RetroPie 

I am new to the RetroPie community and have been downloading pre built images. This got me interested in building my own
image with what I wanted, some images had features I really like but not all of them had everything. I started this script in the
hopes I could start building my own and instead of taking notes I would add it to the script so that it is repeatable every
time I wanted to start over with a new image. 

feel free to use my script. I hope it is usefull for others.

Thanks to everyone who has put in hard work on developing and modding RetroPie and special thanks to the ones whom 
I am useing there work in my script. 

@atar-axis for xpadneo Xbox one Driver
@8bitjunkie for gpio shutdown 
@madmodder123 for BGM 
@RetroHursty69 for all the Themes and work you have done
@Shakz76 for the Idea and Eazy-Hax-RetroPie-Toolkit. 
Patric Arteaga for the Royalty Free Music


## To DO
- New Name not a big fan of using RetroPie Toolkit
- configure RetroPie for OMXPlayer to play audio on bootup for splash screens
- new Background Music menu and icon to replace the one provided by madmodder123 BGM install
- menu item for GPIO Shutdown with icon
- Add Eazy-Hax-RetroPie-Toolkit
- detect if Toolkit is running from retropie menu if not ask to install

## Change Log

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
- Added: restore original for config.txt and codlin.txt
- Added: Resolution 1024X600 for 7” display Kit (without Touch Screen) SKU:Z-0051
  - https://www.wiki.52pi.com/index.php?title=7-Inch-1024x600_Display_Kit_(without_Touch_Screen)_SKU:Z-0051
- Added: Xbox One Controller Driver Install
  - https://github.com/atar-axis/xpadneo 
- Added: GPIO shutdown script (8bitjunkie)
  - https://pie.8bitjunkie.net/retropie-shutdown-and-startup-switch-the-easy-way
- Added: Background music 
  - https://github.com/madmodder123/retropie_music_overlay