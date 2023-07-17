# build Playpen Sans variable font

set -e

varFontsPath="../fonts/variable"
scripts="./scripts"

rm -rf $varFontsPath
mkdir -p $varFontsPath

# pack source as .glyphspackage is not supported yet by fontmake
echo
echo "glyphspkg: Converting PlaypenSans.glyphspackage to PlaypenSans.glyphs"
glyphspkg PlaypenSans.glyphspackage

# # Build VAR font
echo "
==========
 Build VF 
==========
 $(date "+ 📅 DATE: %Y-%m-%d%n  🕒 TIME: %H:%M:%S")"
echo

fontmake -g ./PlaypenSans.glyphs -o variable --output-path \
			$varFontsPath/PlaypenSans[wght].ttf \
			--filter DecomposeTransformedComponentsFilter
			# --flatten-components


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
	gftools fix-nonhinting $ttf "$ttf.fix";
	mv "$ttf.fix" $ttf;
	rm $varFontsPath/*gasp*
	# version up while development
	python $scripts/versioneer.py $ttf

	# add STAT
	gftools gen-stat --src config.yml --inplace $ttf
	echo "Done building STAT table"
	echo "Compressing to .woff2:"
	fonttools ttLib.woff2 compress $ttf
	# woff2_compress $ttf
done

# update version
python $scripts/version-upgrade.py

# Clean up
rm -rf ./master_ufo/ ./instance_ufo/
