%.htm : %.md custom.less *.sh Makefile
	make install
	bash generator.sh $<

install : custom.less Makefile
	lessc custom.less > custom.css
