currentuser=$(whoami) # Check user and then stop the script if root
if [[ $currentuser == "root" ]]; then
	echo "DON'T RUN THIS SCRIPT AS ROOT! USE './BGM_Install.sh' !"
	exit
fi

sudo apt-get install imagemagick fbi # to generate overlays
sudo apt-get install python-pygame 

if [ -d "~/retropie_music_overlay" ]; then #delete folder if it is there
	sudo rm -r ~/retropie_music_overlay
fi

cd /tmp
git clone -b OGST-Beta https://github.com/madmodder123/retropie_music_overlay.git
cd /tmp/retropie_music_overlay

sudo chmod +x pngview
sudo cp pngview /usr/local/bin/

##### Add pixel font
sudo mkdir -p /usr/share/fonts/opentype
sudo cp Pixel.otf /usr/share/fonts/opentype/

sudo chmod +x BGM.py
sudo chown $currentuser:$currentuser BGM.py
sudo chmod 0777 BGM.py
if [ -f "~/BGM.py" ]; then #Remove old version if it is there
	rm -f ~/BGM.py
fi
cp BGM.py ~/
mkdir -p ~/BGM/


