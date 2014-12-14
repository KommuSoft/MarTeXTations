%.htm : %.md custom.less *.css *.sh Makefile
	make install
	bash makehtm.sh <$< >$@

%.pdf : %.md custom.less *.css *.sh Makefile
	make install
	bash makepdf.sh <$< | pdflatex -jobname=`basename $@ ".pdf"`

install : custom.less Makefile .gitmodules
	git submodule update --init --recursive
	lessc custom.less > custom.css
