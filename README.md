# docker-lfc

## Docker container for the Sapienza LFC course

Docker is a container system. You could see it as a very light virtual machine.
To use it, firstly docwnload Docker Desktop from:

https://www.docker.com/products/docker-desktop/

### GUI

to use the GUI you need to allow X11 forwarding. In the following you will find the instruction for each operating system.

#### Linux
Add local connections to X11 access control list:

`xhost local:root`


#### Windows
If you don't have X11 already installed (it should be on the latest versions of Windows 11), download XMing from

https://sourceforge.net/projects/xming/


### Mac
Install XQuartz

https://www.xquartz.org/

start XQuartz:

`open -a XQuartz`

go to XQuartz->Settings and in the `Security` panel enable `Allow connections from network clients`

restart XQuartz:

Check where the XQuartz config file, or domain, is located with:

`quartz-wm --help`

which should output:
```
usage: quartz-wm OPTIONS
Aqua window manager for X11.

--version                 Print the version string
--prefs-domain <domain>   Change the domain used for reading preferences
                          (default: org.xquartz.X11
```
The last line shows the default domain, in this case `org.xquartz.X11`. Before XQuartz 2.8.0 the default domain was: `org.macosforge.xquartz.X11`.
You can check the default domain  with:
```
defaults read org.xquartz.X11
```
To have GLX acceleration you must enable it with:
```
defaults write org.xquartz.X11 enable_iglx -bool true
```
restart XQuartz again. You can check if GLX is now enabled again with:
```
defaults read org.xquartz.X11
```
Finally, you have to allow X11 forwarding to local containers:
```
xhost +localhost
```
the latter command has to be executed every time XQuartz is restarted.

## How to run the container

Download the docker-compse.yml file in the folder you want to use to work:
```
curl https://raw.githubusercontent.com/carlomt/docker-lfc/main/docker-compose.yml --output docker-compose.yml
```

in the same folder, download one of the following files accordingly to your operating system:

- linux
```
curl https://raw.githubusercontent.com/carlomt/docker-lfc/main/env_linux --output .env
```
- windows
```
curl https://raw.githubusercontent.com/carlomt/docker-lfc/main/env_windows --output .env
```
- mac
```
curl https://raw.githubusercontent.com/carlomt/docker-lfc/main/env_mac --output .env
```

finally, run the container:

```
docker compose run --rm lfc
```

it will create the subfolder `workdir` in which you will find anything to do in the home folder of the container.
All the files you will create outside of the home folder of the container will be deleted when you close the container and are not available on the host machine.

Remember that still you should enable the X11 forwarding every time you reboot (or restart the X11 server):
- `xhost local:root` on linux
- `xhost +localhost` on mac

to close the container type `exit` and press return.
