# Project 1

First project is to assemble RC car, and make software environment about RPI.

In SEA:ME we use ‘PiRacer Pro’.

@[https://www.waveshare.com/wiki/PiRacer_Pro_AI_Kit](https://www.waveshare.com/wiki/PiRacer_Pro_AI_Kit)

here is the official wiki, and you can get information about piracer<br><br><br>  

# Prepare Hardware

[Piracer_pro_ai_kit-en2.pdf](https://s3.us-west-2.amazonaws.com/secure.notion-static.com/dc39372a-09c4-4201-9800-3ec21513daae/Piracer_pro_ai_kit-en2.pdf?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20230202%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20230202T152911Z&X-Amz-Expires=86400&X-Amz-Signature=2973c2c3613f796b436fc0624e0c3e8905978d36dde8a856468eb7e86b56293a&X-Amz-SignedHeaders=host&response-content-disposition=filename%3D%22Piracer_pro_ai_kit-en2.pdf%22&x-id=GetObject)
<br><br><br>
# Prepare Software

Rpi will be a main computer of our project.

To run RPI, first you have to install OS in the RPI board.

Not all the versions are compatible. So you have to download this version 

@[https://downloads.raspberrypi.org/raspios_oldstable_lite_armhf/images/raspios_oldstable_lite_armhf-2021-12-02/2021-12-02-raspios-buster-armhf-lite.zip](https://downloads.raspberrypi.org/raspios_oldstable_lite_armhf/images/raspios_oldstable_lite_armhf-2021-12-02/2021-12-02-raspios-buster-armhf-lite.zip)

Also you need ‘Imager’ to install OS from .zip file

@[https://www.raspberrypi.com/software/](https://www.raspberrypi.com/software/) you can download it here.

1. operate Rasberry Pi Imager.
2. Choose operating system<br>

<img src="image/1.png" width="400" height="300">
    
3. select custom<br>

<img src="image/2.png" width="400" height="300">

    
4. upload [2021-12-02-raspios-buster-armhf-lite.zip]<br>

<img src="image/3.png" width="400" height="300">
    
    
5. select ‘setting’ and do like this
    <br>

<img src="image/4.png" width="400" height="600">
    

‘Host name’ represent your RPI user name

‘SSH’ enables you to connect RPI in other computer. It enables you use RPI without display monitor.

‘Wireless LAN’ To use RPI in your laptop, you have the same network with RPI, laptop.

1. Select your storage, and press ‘write’ to write down [2021-12-02-raspios-buster-armhf-lite.zip](https://downloads.raspberrypi.org/raspios_oldstable_lite_armhf/images/raspios_oldstable_lite_armhf-2021-12-02/2021-12-02-raspios-buster-armhf-lite.zip) in  your RPI OS.

<br>

<img src="image/5.png" width="400" height="300">

6. If all installation completed, put your sd card in raspberry pi.

7. coneect the power cable, and HDMI cable to check your RPI IP adress.

### Install Putty

To connect your raspberry pi with your computer, you have to install putty in your lap top.

@[https://www.putty.org/](https://www.putty.org/)

download putty in your laptop, and opertate putty.

Type your Rpi IP adress in ‘Host Name’

<br>

<img src="image/6.png" width="400" height="400">

## Install requirements for Donkey car.

Now, your RPI is connected with your laptop. You can type command in putty to send message to RPI.

Type thes to install requirements for Donkey car in your RPI 

`raspberry pi`

1. Update&Upgrade RP

```jsx
sudo apt-get update --allow-releaseinfo-change
sudo apt-get upgrade
```

2. Setting

```jsx
sudo raspi-config
```

<br>

<img src="image/7.png" width="400" height="300">

interfacing - camera

- 2. `interfacing` → `camera`  enable
- 2. `interfacing` → `ssh` enable
- 2. `interfacing` → `i2c` enable
- 6. `advanced options` → `expand filesystem` enable

3. Install requirements

```jsx
sudo apt-get install build-essential python3 python3-dev python3-pip python3-virtualenv python3-numpy python3-picamera python3-pandas python3-rpi.gpio i2c-tools avahi-utils joystick libopenjp2-7-dev libtiff5-dev gfortran libatlas-base-dev libopenblas-dev libhdf5-serial-dev libgeos-dev git ntp
```

```jsx
sudo apt-get install libilmbase-dev libopenexr-dev libgstreamer1.0-dev libjasper-dev libwebp-dev libatlas-base-dev libavcodec-dev libavformat-dev libswscale-dev libqtgui4 libqt4-testpython3 -m virtualenv -p python3 env --system-site-packages
echo "source ~/env/bin/activate" >> ~/.bashrc
source ~/.bashrc
```

```jsx
cd ~
mkdir projects
cd projects
```

```jsx
git clone https://github.com/autorope/donkeycar
cd donkeycar
git checkout main
pip install -e .[pi]
pip install https://github.com/lhelontra/tensorflow-on-arm/releases/download/v2.2.0/tensorflow-2.2.0-cp37-none-linux_armv7l.whl
```

```jsx
sudo apt install python3-opencv
```

```jsx
python -c "import cv2"
```

4. Install diplay

```jsx
cd ~
git clone https://github.com/waveshare/pi-display
cd pi-display
sudo ./install.sh
```

```jsx
sudo pip3 install flask
```

```jsx
cd pidisplay
sudo vi display_server.py
```
<br>


5. change line8  

**.utils** to **utils**
<details>
  <summary>displya_server.py</summary>
<div markdown="1">
    
    import threading
    import Adafruit_SSD1306
    import time
    import PIL.Image
    import PIL.ImageFont
    import PIL.ImageDraw
    from flask import Flask
    from utils import ip_address, cpu_usage, memory_usage, disk_usage, temp
    from pidisplay import ads1115
    from pidisplay import ina219
    import os
   
 </details>   

 <br>
6. reboot  

```jsx
sudo reboot
```

Now, you can see your IP through display.

7. Fix your Raspberrypi address

```jsx
cd ~
sudo vi /etc/dhcpcd.conf
```

add below line at the end of code.

```jsx
interface wlan0
static ip_address="your IP Address"
static routers="your IP address, but end is 1"
```


<details>
  <summary>dhcpcd.conf (in my case)</summary>
<div markdown="1">
    
    ~
    # A list of options to request from the DHCP server.
    option domain_name_servers, domain_name, domain_search, host_name
    option classless_static_routes
    # Respect the network MTU. This is applied to DHCP routes.
    option interface_mtu
    
    # Most distributions have NTP support.
    #option ntp_servers
    
    # A ServerID is required by RFC2131.
    require dhcp_server_identifier
    
    # Generate SLAAC address using the Hardware Address of the interface
    #slaac hwaddr
    # OR generate Stable Private IPv6 Addresses based from the DUID
    slaac private
    
    # Example static IP configuration:
    #interface eth0
    #static ip_address=192.168.0.10/24
    #static ip6_address=fd51:42f8:caae:d92e::ff/64
    #static routers=192.168.0.1
    #static domain_name_servers=192.168.0.1 8.8.8.8 fd51:42f8:caae:d92e::1
    
    # It is possible to fall back to a static IP if DHCP fails:
    # define static profile
    #profile static_eth0
    #static ip_address=192.168.1.23/24
    #static routers=192.168.1.1
    #static domain_name_servers=192.168.1.1
    
    # fallback to static profile on eth0
    #interface eth0
    #fallback static_eth0
    
    interface wlan0
    static ip_address="192.168.0.107"
    static routers="192.168.0.1"
    interface wlan0
    static ip_address="192.168.0.107"
    static routers="192.168.0.1"
  </details>
  <br><br>

type this to restart network

```jsx
sudo /etc/init.d/networking restart
```

## Install Donkey car

`raspberry pi`

1. create donkeycar path

```jsx
donkey createcar --path ~/mycar
```

2. Install I2C board.

```jsx
sudo apt-get install -y i2c-tools
```

type this to check If i2c board is connected with your RPI

```jsx
sudo i2cdetect -y 1
```
  <br>

<img src="image/8.jpg" width="400" height="300"><br>
If I2C board is connected like this,

you can see the output

```jsx
(env) joe@joe:~ $ sudo i2cdetect -y 1
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- 3c -- -- --
40: 40 -- 42 -- -- -- -- -- -- -- -- -- -- -- -- --
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: 70 -- -- -- -- -- -- --
```

※ If there’s no response like this, or more than 3 secodns to print this message, maybe your I2C board is broken. So replace your I2C board.

3. Time to operate Donkey car! 

`(Web Control)`

```jsx
source ~/env/bin/activate
cd ~/mycar
python manage.py drive
```

go to <your raspberry pi ip adress>:8887

In my case it was `192.168.0.107:8887`

`(Joypad Control)`

```jsx
source ~/eng/bin/activate
cd ~/mycar
python manage.py drive --js
```

Connect your USB dongle and joypad which was included in Pi-Racer Box.

If there’s an error, make sure your hardware setting.

(for example, you didn’t connect Camera wire with Raspberry pi / your I2C board is broken..)