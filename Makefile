%.htm : %.md custom.less *.css *.sh Makefile
	make install
	bash makehtm.sh <$< >$@

%.pdf : %.md custom.less *.css *.sh Makefile
	make install
#	temp := $(basename "$@" ".pdf")
	bash makepdf.sh <$< | pdflatex -jobname=`basename "$@" ".pdf"` || true
	bash makepdf.sh <$< | pdflatex -jobname=`basename "$@" ".pdf"` || true
	bash makepdf.sh <$< | pdflatex -jobname=`basename "$@" ".pdf"` || true
	rm -f *.aux *.log *.nav *.out *.snm *.toc
	bash makepdf.sh <$< > log.log || true

install : custom.less Makefile .gitmodules
#	wget "https://www.maths.nottingham.ac.uk/personal/drw/LaTeXMathML.js" -O "LaTeXMathML.js"
	git submodule update --init --recursive
	lessc custom.less > custom.css
