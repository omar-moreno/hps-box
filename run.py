#!/usr/bin/env python

import argparse
import docker

client = None

def list(): 
    images = client.images.list(filters={'reference': 'hps'})
    for image in images: print(image)

def run(): 
    global client

    parser = argparse.ArgumentParser(
            description='A set of utilities used to run HPS specific docker images.')
    parser.add_argument('command')
    parser.add_argument('-i', '--image', 
            help='The name of the image to run')
    parser.add_argument('-l', '--list',  action='store_true',
            help='List the available HPS images.')
    args = parser.parse_args()

    if not client: 
        client = docker.from_env()

    if args.list:
        list()

    image = 'hps:latest'
    if args.image:
        image = args.image

    if not args.command: 
        parser.error('A command needs to be specified.')

    print(client.containers.run(image, args.command).decode('UTF-8').strip('\n'), flush=True)

if __name__ == "__main__":
    run()
