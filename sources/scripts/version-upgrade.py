# upgrades the version number in reference file

import os
from fontTools.ttLib import TTFont

version_file = "version-current.txt"


if os.path.isfile(version_file) is False:
    version_file = f"./scripts/{version_file}"
with open(version_file, "r") as vf:
    current = vf.read()
    up = round(float(current) + 0.001, 3)
    vf.close()
# update version
with open(version_file, "w") as vf:
    vf.write(str(up))
    vf.close()

print(f"\nSaved 'Version {up}' as current.\n")
