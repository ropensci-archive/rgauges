all: move rmd2md

move:
		cp inst/vign/rgauges_vignette.md vignettes/
		cp -rf inst/vign/figure/* vignettes/figure/

rmd2md:
		cd vignettes;\
		cp rgauges_vignette.md rgauges_vignette.Rmd
