#!/usr/bin/python

import json
import subprocess
import sys

output = subprocess.check_output(['i3-msg', '-t', 'get_workspaces'])
workspaces = json.loads(output)

next_num = next(i for i in range(1, 100) if not [
    ws for ws in workspaces if ws['num'] == i])

try:
    if(str(sys.argv[1]) == 'move'):
        subprocess.call(
            ['i3-msg', 'move container to workspace number '+str(next_num)])
except IndexError:
    subprocess.call(['i3-msg', 'workspace number %i' % next_num])
