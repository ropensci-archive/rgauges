all: move pandoc rmd2md reducepdf

move:
		cp inst/vign/rgauges_vignette.md vignettes/
		cp -rf inst/vign/figure/* vignettes/figure/

pandoc:
		cd vignettes;\
		pandoc -H margins.sty rgauges_vignette.md -o rgauges_vignette.pdf --highlight-style=tango;\
		pandoc -H margins.sty rgauges_vignette.md -o rgauges_vignette.html --highlight-style=tango

rmd2md:
		cd vignettes;\
		cp rgauges_vignette.md rgauges_vignette.Rmd;\

reducepdf:
		Rscript -e 'tools::compactPDF("vignettes/rgauges_vignette.pdf", gs_quality = "ebook")'