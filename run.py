#!/usr/bin/env python

import docker
import os
import sys

client = None


def list():
    images = client.images.list(filters={'reference': 'hps'})
    for image in images:
        print(image)


def get_value(args, var):
    index = args.index(var)
    val = args.pop(index + 1)
    del args[index]
    return val


def run():
    global client

    args = sys.argv[1:]
    if len(args) == 0:
        print('Please specify a command.')
        return

    if not client:
        client = docker.from_env()

    image = 'hps:latest'
    if 'list' in args:
        list()
        return

    if 'image' in args:
        image = get_value(args, 'image')

    directory = os.getcwd()
    mount = ['%s:%s' % (directory, directory)]
    if 'mount' in args:
        directory = get_value(args, 'mount').split(',')
        if directory not in mount:
            mound.append(directory)

    if 'directory' in args:
        directory = get_value(args, 'directory')
        if directory not in mount:
            mount.append(directory)

    if len(args) == 0:
        return

    command = '%s %s' % (directory, ' '.join(args))

    user = os.getuid()
    print(client.containers.run(image,
                                command,
                                remove=True,
                                volumes=mount,
                                user=user).decode('UTF-8').strip('\n'),
          flush=True)


if __name__ == "__main__":
    run()
