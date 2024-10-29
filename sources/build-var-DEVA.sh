# build Playpen Sans variable font

set -e

varFontsPath="../fonts/variable"
scripts="./scripts"

# Build VAR font
echo "
==========
 Build VF 
==========
 $(date "+ 📅 DATE: %Y-%m-%d%n  🕒 TIME: %H:%M:%S")"
echo

fontmake -g ./PlaypenSansDEVA.glyphspackage -o variable --output-path \
			$varFontsPath/PlaypenSansDEVA[wght]-dev.ttf \
			--filter DecomposeTransformedComponentsFilter \
			--flatten-components \
			--no-production-names \
			--debug-feature-file debug-deva-fea.fea
			# --flatten-components

# python $scripts/bump-version.py $varFontsPath/PlaypenSans[wght]-dev.ttf


echo "
=================================
 Autohint, add STAT, make woff2 
=================================
"
# do it only for PlaypenSansDEVA[wght]-dev.ttf
ttfs=$(ls $varFontsPath/PlaypenSansDEVA*)
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
