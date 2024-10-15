# bumps the version in 'name' id5 while development

import sys
import os
from fontTools.ttLib import TTFont

fpath = sys.argv[1]

version_file = "version-current.txt"


def versionUp(font, vpath):
	if os.path.isfile(vpath) is False:
		vpath = f"./scripts/{vpath}"
	with open(vpath, "r") as vf:
		current = vf.read()
		print(current)
		up = round(float(current) + 0.001, 3)
		print(f"Current: {current} | Up: {up}")
	with open(vpath, "w") as vf:
		vf.write(str(up))
		vf.close()
	font['head'].fontRevision = up
	font['name'].setName(f"{up};TT;Development-version", 3, 3, 1, 1033)
	font['name'].setName(f"Version {up}", 5, 3, 1, 1033)
	print(f"Version {up}")

ttfont = TTFont(fpath)
versionUp(ttfont, version_file)
ttfont.save(fpath)
ttfont.close()
