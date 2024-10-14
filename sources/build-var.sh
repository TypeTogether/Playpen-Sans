# build Playpen Sans variable font

set -e

varFontsPath="../fonts/variable"
scripts="./scripts"

# rm -rf $varFontsPath
# mkdir -p $varFontsPath

# # pack source as .glyphspackage is not supported yet by fontmake
# echo
# echo "glyphspkg: Converting PlaypenSans.glyphspackage to PlaypenSans.glyphs"
# glyphspkg PlaypenSans.glyphspackage

# Build VAR font
echo "
==========
 Build VF 
==========
 $(date "+ 📅 DATE: %Y-%m-%d%n  🕒 TIME: %H:%M:%S")"
echo

# python $scripts/bump-version-minor.py

fontmake -g ./PlaypenSans.glyphspackage -o variable --output-path \
			$varFontsPath/PlaypenSans[wght]-dev.ttf \
			--filter DecomposeTransformedComponentsFilter \
			--no-production-names
			# --flatten-components

echo "
=================================
 Autohint, add STAT, make woff2 
=================================
"
# do it only for PlaypenSans[wght]-dev.ttf
ttfs=$(ls $varFontsPath/*-dev.ttf)
for ttf in $ttfs
do
	echo $ttf
	gftools fix-nonhinting $ttf "$ttf.fix";
	mv "$ttf.fix" $ttf;
	rm $varFontsPath/*gasp*

	# add STAT
	gftools gen-stat --src config.yml --inplace $ttf
	echo "Done building STAT table"
	# echo "Compressing to .woff2:"
	# fonttools ttLib.woff2 compress $ttf
done
