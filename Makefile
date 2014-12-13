%.htm : %.md custom.less *.css *.sh Makefile
	make install
	bash generator.sh $<

install : custom.less Makefile .gitmodules
	git submodule update --init --recursive
	lessc custom.less > custom.css
