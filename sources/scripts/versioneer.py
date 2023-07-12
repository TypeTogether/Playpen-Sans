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
        up = round(float(current) + 0.001, 3)
        vf.close()
    font['name'].setName(f"Version {up}", 5, 3, 1, 1033)
    print(f"Version {up}")
    # # update version
    # with open(vpath, "w") as version:
    #     version.write(str(up))
    #     version.close()
ttfont = TTFont(fpath)
versionUp(ttfont, version_file)
ttfont.save(fpath)
ttfont.close()
