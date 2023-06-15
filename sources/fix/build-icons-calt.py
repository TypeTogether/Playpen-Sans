icons_dict = {"shooting-star": "shootingStar",
              "birthday-cake": "birthdayCake",
              "paint": "artistPalette",
              "attention-index": "whiteUpBackhandIndex",
              "thumbs-up": "thumbsUpSign",
              "thumbs-down": "thumbsDownSign",
              "read": "openBook",
              "announcement": "cheeringMegaphone",
              "battery": "battery",
              "unicorn": "unicornFace",
              "dinosaur": "dinosaur",
              "puzzle": "jigsawPuzzlePiece",
              "planet": "ringedPlanet",
              "pencil": "pencil",
              "check-mark": "checkmark",
              "cross-mark": "crossMark",
              "target": "roundTarget",
              "happy-sun": "sunFace",
              "loving-sun": "suninlove",
              "pirate-sun": "sunpirate",
              "sad-sun": "sunsad",
              "wink-sun": "sunwink",
              "homework": "homework",
              "paper-plane": "paperplane",
              "write": "pencilbook",
              "accomplishment": "reward",
              }

def splitKeyword(keyword, glyphName):
	sub_key = [f"{c} " for c in keyword]
	sub_str = "".join(sub_key)
	sub_str = sub_str.replace("-", "hyphen")
	calt_str = f"sub colon {sub_str}colon by {glyphName};"
	return calt_str

calt_code = []
for k, val in icons_dict.items():
	calt_code.append(splitKeyword(k, val))

print("\n".join(calt_code))
