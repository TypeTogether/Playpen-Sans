import os.path
from glyphsLib import GSFont

gpath = os.path.abspath(os.path.relpath("../sources/PlaypenSans.glyphspackage"))

font = GSFont(gpath)
font.versionMinor += 1
print(f"Bumped version: v{font.versionMajor}.{font.versionMinor}")

font.save(font.filepath)

