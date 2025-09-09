for sound settings

```
sudo echo "options snd-hda-intel model=generic" | sudo tee -a

sudo echo "options snd-hda-intel dmic_detect=0" | sudo tee -a /etc/modprobe.d/alsa-base.conf

sudo echo "blacklist snd_soc_skl" | sudo tee -a /etc/modprobe.d/blacklist.conf 
```
