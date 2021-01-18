#!/bin/python
"""Brightness settings
usage: <path>/brightness.py <delta>
"""

import subprocess, re, sys

delta = float(sys.argv[1])

mon_strs = (
    subprocess.check_output(["xrandr", "--listactivemonitors"])
    .decode("utf-8")
    .split("\n")[1:-1]
)

current = float(
    re.findall(
        "Brightness: [0-9\.]+",
        subprocess.check_output(["xrandr", "--verbose"]).decode("utf-8"),
    )[0].split()[1]
)

new = max(min(current + delta, 1), 0)

for mon_str in mon_strs:
    name = mon_str.split()[3]
    subprocess.run(["xrandr", "--output", name, "--brightness", str(new)])
