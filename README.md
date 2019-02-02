# RetroPie-Toolkit
Shell Scripts used for setting up RetroPie 


####Change Log

1/31/19

- Added: restore original for config.txt and codlin.txt
- Added: Resolution 1024X600 for 7” display Kit (without Touch Screen) SKU:Z-0051
  - https://www.wiki.52pi.com/index.php?title=7-Inch-1024x600_Display_Kit_(without_Touch_Screen)_SKU:Z-0051
- Added: Xbox One Controller Driver Install
  - https://github.com/atar-axis/xpadneo 
- Added: GPIO shutdown script (8bitjunkie)
  - https://pie.8bitjunkie.net/retropie-shutdown-and-startup-switch-the-easy-way
- Added: Background music 
  - https://github.com/madmodder123/retropie_music_overlay

2/1/19

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
- Fixed: Extraction of BGM archive for Royalty Free Music
