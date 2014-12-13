%.htm : %.md custom.less *.sh Makefile
	make install
	bash makepresentation.sh $<

install : custom.less Makefile
	lessc custom.less > custom.css
