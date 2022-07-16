
# src/hps/__init__.py
__version__ = '0.1.0'

import docker
import os

client = docker.from_env()

def list(): 
    images = client.images.list(filters={'reference': 'hps-dev'})
    for image in images:
        print(image)


def execute(command : str, **kwargs):
    global client
    global image

    image = 'hps-dev:latest'
    if 'images' in kwargs: 
        image = kwargs['image']

    mount = ['%s:/current' % os.getcwd()]
    if 'mount' in kwargs:
        directory = kwargs['mount']
        if (not directory) & (directory not in mount): 
            mount.append(directory)

    print(client.containers.run(image, 
                                command, 
                                remove=True, 
                                volumes=mount).decode('UTF-8').strip('\n'), 
                                flush=True)



