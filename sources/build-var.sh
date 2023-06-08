# build Playpen Sans variable font

set -e

varFontsPath="../fonts/variable"

rm -rf $varFontsPath
mkdir -p $varFontsPath

# pack source as .glyphspackage is not supported yet by fontmake
glyphspkg PlaypenSans.glyphspackage

# # Build VAR font
echo "
==========
 Build VF 
==========
 $(date "+ 📅 DATE: %Y-%m-%d%n  🕒 TIME: %H:%M:%S")"
echo

# fontmake -g ./PlaypenSans.glyphs -o variable --output-dir $varFontsPath
fontmake -g ./PlaypenSans.glyphs -o variable --output-path \
			$varFontsPath/PlaypenSans[wght].ttf \
			--filter DecomposeTransformedComponentsFilter

# Build WEB font
echo "
=================================
 Autohint, add STAT, make woff2 
=================================
"
ttfs=$(ls $varFontsPath/*.ttf)
for ttf in $ttfs
do
	echo $ttf
	ttfautohint $ttf "$ttf.fix";
	mv "$ttf.fix" $ttf;
	gftools fix-hinting $ttf;
	mv "$ttf.fix" $ttf;

	# add STAT
	gftools gen-stat --src config.yml --inplace $ttf
	echo "Done building STAT table"
	woff2_compress $ttf
done

# Clean up
rm -rf ./master_ufo/ ./instance_ufo/
