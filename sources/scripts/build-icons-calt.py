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


def keywordSubCode(keyword, glyphName):
	calt_subs = []
	sub_key = [f"{c} " for c in keyword]
	sub_str = "".join(sub_key)
	sub_str = sub_str.replace("-", "hyphen")
	calt_str = f"sub colon {sub_str}colon by {glyphName};"
	calt_subs += [calt_str]
	title_sub = f"sub colon {sub_str[0].upper() + sub_str[1:]}colon by {glyphName};"
	calt_subs += [title_sub]
	upper_str = sub_str.upper().replace("HYPHEN", "hyphen")
	upper_sub = f"sub colon {upper_str}colon by {glyphName};"
	calt_subs += [upper_sub]
	return calt_subs

calt_code = []
for k, val in icons_dict.items():
	calt_code += keywordSubCode(k, val)

print("\n".join(calt_code))
