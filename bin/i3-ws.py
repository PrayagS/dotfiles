#!/usr/bin/python

# from: https://github.com/benkaiser/i3-wm-config

import subprocess
import sys
import json
import math
import os
from os.path import expanduser
from tempfile import TemporaryFile


def get_workspace():
    handle = subprocess.Popen(
        ["i3-msg", "-t", "get_workspaces"], stdout=subprocess.PIPE)
    output = handle.communicate()[0]
    data = json.loads(output.decode())
    data = sorted(data, key=lambda k: k['name'])
    for i in data:
        if(i['focused']):
            print(i['name'])
            return i['name']


def get_workspaces():
    handle = subprocess.Popen(
        ["i3-msg", "-t", "get_workspaces"], stdout=subprocess.PIPE)
    output = handle.communicate()[0]
    data = json.loads(output.decode())
    data = sorted(data, key=lambda k: k['name'])
    arr = []
    for i in data:
        arr.append(i['name'])
    return arr


def move_to(num):
    print("move container to workspace", str(num))
    subprocess.Popen(
        ["i3-msg", "move container to workspace number "+str(num)], stdout=subprocess.PIPE)
    exit(0)


def go_to(num):
    print("goto workspace", str(num))
    subprocess.Popen(["i3-msg", "workspace "+str(num)], stdout=subprocess.PIPE)
    exit(0)


def dmenu_fetch(inputstr):
    t = TemporaryFile()
    t.write(bytes(inputstr, 'UTF-8'))
    t.seek(0)
    dmenu_run = subprocess.Popen(
        ["dmenu", "-b"], stdout=subprocess.PIPE, stdin=t)
    output = (dmenu_run.communicate()[0]).decode().strip()
    return output


def open_app(workspace):
    home = expanduser("~")
    cache = home+"/.cache/dmenu_run.mod"
    check_programs(home, cache)
    applications = open(cache, "r")
    dmenu_run = subprocess.Popen(
        ["dmenu", "-b"], stdout=subprocess.PIPE, stdin=applications)
    output = (dmenu_run.communicate()[0]).decode().strip()
    print("Running " + output + " on workspace " + workspace)
    subprocess.Popen(["i3-msg", "workspace " + workspace +
                      "; exec " + output], stdout=subprocess.PIPE)
    exit(0)


def check_programs(home, cache):
    os.system(
        "grep -ih ^exec= /usr/share/applications/*.desktop | tr -s = ' ' | awk '{print $2}' | sort -u > " + cache)


def print_usage():
    prog = os.path.basename(sys.argv[0])
    print(prog, "[up|down|next|prev] [go|move]")
    print(prog, "[go|move] number")
    print(prog, "open")
    print(prog, "dynamic [go|move]")
    print()
    print("'open' uses dmenu to prompt for an application to run")
    print("'dynamic' uses dmenu to prompt for a workspace number")


if len(sys.argv) < 2:
    print("Error not enough arguments")
    print_usage()
    exit(1)

command = sys.argv[1]
switch_number = 1  # default switch number
if len(sys.argv) == 3:
    # they passed in a number to move to
    try:
        switch_number = int(sys.argv[2])
    except ValueError:
        pass
# get the workspace number
workspace_name = get_workspace()
workspace_val = 1  # default value if name parsing fails
workspace_prefix = ''
try:
    match_set = '0123456789-'
    # only look for digits in the number
    workspace_val = int(
        ''.join(filter(lambda x: x in match_set, workspace_name)))
    # include '-' in the ignore list in case it is a negative number
    workspace_prefix = ''.join(
        filter(lambda x: x not in match_set, workspace_name))
except ValueError:
    pass
print(workspace_prefix)

if command == '-h' or command == '--help':
    print_usage()
    exit(0)

# handle the commands
print("command =", command)
if command == 'up':
    workspace_val += 10
elif command == 'down':
    workspace_val -= 10
elif command == 'next':
    workspace_val += 1
elif command == 'prev':
    workspace_val -= 1
elif command == 'go':
    # go to workspace in block
    workspace_rounded = int(math.floor(workspace_val/10))*10
    workspace_rounded += switch_number
    go_to(workspace_prefix + str(workspace_rounded))
elif command == 'move':
    # move the current container to the selected workspace
    workspace_rounded = int(math.floor(workspace_val/10))*10
    workspace_rounded += switch_number
    move_to(workspace_prefix + str(workspace_rounded))
elif command == 'open':
    open_app(workspace_name)
elif command == 'dynamic':
    # dynamic tagging
    command2 = sys.argv[2]
    print("command2 =", command2)
    workspaces = get_workspaces()
    inputstr = '\n'.join(workspaces)
    # use dmenu to prompt
    result = dmenu_fetch(inputstr)
    print("dmenu result = ", result)
    if command2 == 'go':
        go_to(result)
    elif command2 == 'move':
        move_to(result)

if len(sys.argv) == 3:
    # not a go or move, command2 is argv2
    command2 = sys.argv[2]
    print("command2 =", command2)
    if command == 'up' or command == 'down' or command == 'prev' or command == 'next':
        if command2 == 'go':
            go_to(workspace_prefix + str(workspace_val))
        elif command2 == 'move':
            if workspace_val is 0:
                workspace_val = 10
            if workspace_val is 11:
                workspace_val = 1
            move_to(str(workspace_val))

#  Local Variables:
#  eval: (add-hook (make-local-variable 'after-save-hook) 'bh:ensure-in-vc-or-check-in t))
#  End:
