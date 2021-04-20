#!/bin/python
"""Brightness settings
usage: <path>/brightness.py <delta>
"""

import subprocess, re, sys

delta = float(sys.argv[1])

info = subprocess.check_output(["xrandr", "--verbose"]).decode("utf-8")

mon_names = re.findall("(\S+) connected", info)

current = float(re.findall("Brightness: ([0-9\.]+)", info)[0])

new = max(min(current + delta, 1), 0)

for mon_name in mon_names:
    subprocess.run(["xrandr", "--output", mon_name, "--brightness", str(new)])
