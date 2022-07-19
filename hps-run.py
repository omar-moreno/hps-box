#!/usr/bin/env python

import docker
import hps
import os
import sys

def get_value(args, var):
    index = args.index(var)
    val = args.pop(index + 1)
    del args[index]
    return val

def run():

    args = sys.argv[1:]
    if len(args) == 0:
        print('Please specify a command.')
        return

    if 'list' in args:
        hps.list()
        return

    image = 'hps-dev:latest'
    if 'image' in args:
        image = get_value(args, 'image')

    directory = '/current'
    if 'directory' in args: 
        directory = get_value(args, 'directory')

    mount = ''
    if 'mount' in args: 
        mount = get_value(args, 'mount')

    if len(args) == 0: 
        return

    command = '%s %s' % (directory, ' '.join(args))

    hps.execute(command, image=image, mount=mount)

if __name__ == "__main__":
    run()
