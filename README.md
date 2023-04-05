# hps-box

The Heavy Photon Search software stack in a containarized environment.

## Getting Started
### Dependencies
* [Docker](https://docs.docker.com/engine/install/)
* [distrobox](https://github.com/89luca89/distrobox/blob/main/docs/README.md#installation)

### Usage

Creating an environment using distrobox can be done as follows
```bash
distrobox create --image omarmoreno/hps-box:v0.2 --name hps-box --home /path/to/desired/home
```
Once created, the environment can be entered as follows
```bash
distrobox enter hps-box
```

#### Visualization

To run the visualization, first enter the distrobox environment as above.  Then navigate to the directory containing the detector .lcdd and run slic as follows
```bash
slic -g detector.lcdd -n
```
This will bring up a QT window with an interactive promp that allows issuing Geant4 commands.  At this point, issuing the following commands will draw the detector
```
/vis/open OGLSQt
/vis/drawVolume
```

