# hps-box

The Heavy Photon Search software stack in a containarized environment.

## Getting Started
### Dependencies
* [Docker](https://docs.docker.com/engine/install/)
* [distrobox](https://github.com/89luca89/distrobox/blob/main/docs/README.md#installation)

### Usage

Creating an environment using distrobox can be done as follows
```bash
distrobox create --image omarmoreno/hps-box:v0.3 --name hps-box --home /path/to/desired/home
```
Once created, the environment can be entered as follows
```bash
distrobox enter hps-box
```

### Docker Users
Create the image from the Docker file. Run the command in the folder containing the docker file
```bash
docker build -t "hps-box:v0.3" ./
```
For MacOs users:
1) Ensure the "Allow connections from network clients" option in XQuartz/Preferences/Security is turned on
2) Add localhost as an allowed source
```bash
xhost + 127.0.0.1
```
3) Run the docker container (In this command I'm mounting the host PWD into /sw)
```bash
docker run -e DISPLAY=host.docker.internal:0 -v /tmp/.X11-unix:/tmp/.X11-unix --volume=$PWD:/sw --interactive --tty af0a6d8bc93b /bin/bash
```

#### Visualization

To run the visualization, first enter the distrobox environment as above.  You might need to setup the environment:
```bash
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/
```

Then navigate to the directory containing the detector .lcdd and run slic as follows
```bash
slic -g detector.lcdd -n -m -m $PACKAGES/slic/macros/vis_qt.mac
```
This will bring up a QT window with the detector drawn.

