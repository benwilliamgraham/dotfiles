#!/bin/python
"""Split mode calculator
usage: <path>/splitmode.py <num splits per monitor (1 or 2)> <gap>
"""

import subprocess, re, sys

num_splits = 1 if sys.argv[1] == "1" else 2
gap = int(sys.argv[2])

mon_strs = [
    line
    for line in subprocess.check_output(["xrandr"]).decode("utf-8").split("\n")
    if " connected" in line
]

splits = []

for mon_str in mon_strs:
    width, height, x, y = [
        int(num_str)
        for num_str in re.findall("([0-9]+)x([0-9]+)\+([0-9]+)\+([0-9]+)", mon_str)[0]
    ]

    if num_splits == 1:
        splits.append(f"{width + gap * 2}x{height + gap * 2}+{x - gap}+{y - gap}")
    else:
        if width > height:
            splits.append(
                f"{width // 2 + gap}x{height + gap * 2}+{x + width // 2}+{y - gap}"
            )
            splits.append(f"{width // 2 + gap}x{height + gap * 2}+{x - gap}+{y - gap}")
        else:
            splits.append(
                f"{width + gap * 2}x{height // 2 + gap}+{x - gap}+{y + width // 2}"
            )
            splits.append(f"{width + gap * 2}x{height // 2 + gap}+{x - gap}+{y - gap}")

subprocess.run(["sosc", "set", "gap", str(gap)])
subprocess.run(["sosc", "split", "screen", *reversed(splits)])
