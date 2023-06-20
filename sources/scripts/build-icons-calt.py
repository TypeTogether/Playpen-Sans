icons_dict = {
    "happy-sun": "sunFace",
    "happy": "sunFace",
    "shooting-star": "shootingStar",
    "star": "shootingStar",
    "birthday-cake": "birthdayCake",
    "cake": "birthdayCake",
    "paint": "artistPalette",
    "color-palette": "artistPalette",
    "attention-index": "whiteUpBackhandIndex",
    "point-up": "whiteUpBackhandIndex",
    "thumbs-up": "thumbsUpSign",
    "good": "thumbsUpSign",
    "thumbs-down": "thumbsDownSign",
    "bad": "thumbsDownSign",
    "read": "openBook",
    "open-book": "openBook",
    "announcement": "cheeringMegaphone",
    "attention": "cheeringMegaphone",
    "low-battery": "battery",
    "incomplete": "battery",
    "unicorn": "unicornFace",
    "magic": "unicornFace",
    "puzzle": "jigsawPuzzlePiece",
    "planet": "ringedPlanet",
    "pencil": "pencil",
    "check-mark": "checkmark",
    "correct": "checkmark",
    "cross-mark": "crossMark",
    "incorrect": "crossMark",
    "on-target": "roundTarget",
    "perfect": "roundTarget",
    "dinosaur": "dinosaur",
    "homework": "homework",
    "study": "homework",
    "paper-plane": "paperplane",
    "write": "pencilbook",
    "reward": "reward",
    "prize": "reward",
    "loving-sun": "suninlove",
    "love": "suninlove",
    "pirate-sun": "sunpirate",
    "pirate": "sunpirate",
    "sad-sun": "sunsad",
    "sad": "sunsad",
    "wink-sun": "sunwink",
    "wink": "sunwink",
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
