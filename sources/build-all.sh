# Build all formats

set -e

otfFontsPath="../fonts/static/otf"
ttfFontsPath="../fonts/static/ttf"
varFontsPath="../fonts/variable"
webFontsPath="../fonts/static/web"
sourcePath="./source-glyphs"
scripts="./scripts"

rm -rf $otfFontsPath $ttfFontsPath $webFontsPath $varFontsPath
mkdir -p $otfFontsPath $ttfFontsPath $webFontsPath $varFontsPath

# pack source as .glyphspackage is not supported yet by fontmake
echo
echo "glyphspkg: Converting PlaypenSans.glyphspackage to PlaypenSans.glyphs"
glyphspkg PlaypenSans.glyphspackage

echo "
=========================
 Generating STATIC fonts
=========================
 $(date "+ 📅 DATE: %Y-%m-%d%n  🕒 TIME: %H:%M:%S")"
echo

# Build OTF fonts
fontmake -g ./PlaypenSans.glyphs -i -o otf --output-dir $otfFontsPath
# Build TTF fonts
fontmake -g ./PlaypenSans.glyphs -i -o ttf --output-dir $ttfFontsPath \
			--filter DecomposeTransformedComponentsFilter \
			--flatten-components

echo "
======================
 Post processing OTFs 
======================
"
otfs=$(ls $otfFontsPath/*.otf)
for otf in $otfs
do
	echo $otf
	python $scripts/fix-usWeightClass-otf.py $otf
	psautohint --no-zones-stems -a $otf
	# version up while development
	python $scripts/versioneer.py $otf
done

echo "
======================
 Post processing TTFs 
======================
"
ttfs=$(ls $ttfFontsPath/*.ttf)
for ttf in $ttfs
do
	ttfautohint $ttf "$ttf.hint"
	mv "$ttf.hint" $ttf
	gftools fix-hinting $ttf;
	mv "$ttf.fix" $ttf;
	echo $ttf
	# version up while development
	python $scripts/versioneer.py $ttf

	sfnt2woff $ttf
	# woff2_compress $ttf
	echo "Compressing to .woff2:"
	fonttools ttLib.woff2 compress $ttf
	lenght=${#ttf}
	mv ${ttf:0:$lenght-4}.woff $webFontsPath
	mv ${ttf:0:$lenght-4}.woff2 $webFontsPath
done

# ============================================================

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
	# woff2_compress $ttf
	fonttools ttLib.woff2 compress $ttf
done

# update version
python $scripts/version-upgrade.py

# Clean up
rm -rf ./master_ufo/ ./instance_ufo/
# rm ./PlaypenSans.glyphs
