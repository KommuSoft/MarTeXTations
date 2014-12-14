%.htm : %.md custom.less *.css *.sh Makefile
	make install
	bash makehtm.sh <$< >$@

%.pdf : %.md custom.less *.css *.sh Makefile
	make install
#	temp := $(basename "$@" ".pdf")
	bash makepdf.sh <$< | pdflatex -jobname=`basename "$@" ".pdf"`
	#rm -f "$b.aux $b.log $b.nav $b.out $thef.snm ${TFL}.toc"

install : custom.less Makefile .gitmodules
	git submodule update --init --recursive
	lessc custom.less > custom.css
