import sys
from fontTools.ttLib import TTFont

# Bumps version to the built font
# ugly but apparently working

fpath = sys.argv[1]

# font['head'].fontRevision = new_version

ttfont = TTFont(fpath)

current_version = round(ttfont['head'].fontRevision, 3)
new_version = round(current_version, 3) + .001
new_version = round(new_version, 3)

ttfont['head'].fontRevision = new_version
ttfont['name'].setName(f"{new_version};TT;Development", 3, 3, 1, 1033)
ttfont['name'].setName(f"Version {new_version}", 5, 3, 1, 1033)

print(f"Updated version: {current_version:.3f} → {new_version:.3f}")

ttfont.save(fpath)
ttfont.close()

