#!/bin/bash
function makeHeader () {
	echo '<!doctype html><html lang="en"><head><meta charset="utf-8" /><meta name="viewport" content="width=1024" /><meta name="apple-mobile-web-app-capable" content="yes" />';
	echo "<title>$titl</title><meta name=\"description\" content=\"$desc\"/><meta name=\"author\" content=\"$auth\"/>"
	echo ''; #<link href="http://fonts.googleapis.com/css?family=Open+Sans:regular,semibold,italic,italicsemibold|PT+Sans:400,700,400italic,700italic|PT+Serif:400,700,400italic,700italic" rel="stylesheet" />
	echo '<link href="presentation.css" rel="stylesheet"/><link href="d3plotter/d3plotter/public_html/d3plotter.css" rel="stylesheet"/><link href="custom.css" rel="stylesheet"/></head><body><div class="fallback-message"><p>Your browser <b>does not support the features required</b> by impress.js, so you are presented with a simplified version of this presentation.</p><p>For the best experience please use the latest <b>Chrome</b>, <b>Safari</b> or <b>Firefox</b> browser.</p></div><div id="impress">'
}

function makeFooter () {
	echo '</div><script src="jquery.min.js"></script><script src="impress.js/js/impress.js"></script><script language="JavaScript" src="LaTeXMathML.js"></script><script>impress().init();</script><script src="d3/d3.min.js"></script><script src="d3plotter/d3plotter/public_html/d3plotter.js"></script><script type="text/javascript" src="dagre-d3.min.js"></script>
<script type="text/javascript" src="graphlib-dot.min.js"></script></body></html>'
}

function makeTitle () {
	echo '			<div id="title" class="step" data-x="0" data-y="0" data-z="0" data-scale="5">';
	echo "					<h1 class=\"supertitle\"><center>$titl</center></h1>"
	echo "				<span class=\"date\"><center>$date</center></span>"
	echo "				<span class=\"author\"><div class=\"authorby\">by</div> $auth</span>"
	echo "				<span class=\"institute\">$inst</span>"
	echo '			</div>';
}

function makeToc () {
	echo '			<div id="toc" class="step" data-x="0" data-y="0" data-z="-1000" data-scale="1">';
	echo '					<h1 class="toctitle"><center>Overview</center></h1><div class="toctable">';
	echo "$cnt" | bash generatetoc.sh
	echo '			</div></div>';
}

function makeSlide () { #check if contains h1
	cntip=$(echo "$cnti" | pandoc -f markdown -t html5)
	if [ `echo "$cntip" | xmllint --html --xpath 'count(//h1)' -` -gt 0 ]
	then
		chpi=$(($chpi+1))
		thex=1200
		tmp=$chpic
		chpic=$((-$chpis))
		chpis=$tmp
	else
		thex=$(($thex+1200))
	fi
	drt=$(($chpr*$chpi))
	dxr=$(($chpic*$thex))
	dyr=$(($chpis*$thex))
	echo "			<div id=\"slide$slid\" class=\"step slide\" data-rotate=\"$drt\" data-x=\"$dxr\" data-y=\"$dyr\" data-z=\"-1000\">"
	echo "$cntu" | bash getbread.sh
	echo "$cntip" | xsltproc -html filterhead.xslt - | tail -n +1
	echo '			</div>';
	slid=$(($slid+1))
}

function makeConclusion () {
	echo '			<div id="conclusion" class="step concl" data-x="4000" data-y="4000" data-z="0" data-scale="5">'
	echo "$cnti" | pandoc -f markdown -t html5
	echo '			</div>'
}

cnt=$(cat)
chpr=$(echo "$cnt" | pandoc -s -f markdown -t html | xmllint --html --xpath 'count(//h1)-count(//h1[text()="Conclusion"])' -)
chpr=$((360/$chpr))
chpi=-1
chpic=0
chpis=-1
titl=$(echo "$cnt" | bash scrape.sh -t)
desc=$(echo "$cnt" | bash scrape.sh -D)
auth=$(echo "$cnt" | bash scrape.sh -a)
date=$(echo "$cnt" | bash scrape.sh -d)
inst=$(echo "$cnt" | bash scrape.sh -i)
slid=0;
cntu="";
makeHeader
makeTitle
makeToc
for slb in `echo "$cnt" | grep -n -e '----' | cut -f1 -d:`
do
	slb=$(($slb+1))
	cnti=$(echo "$cnt" | tail -n +$slb)
	sle=$(echo "$cnti" | grep -n -m 1 -e '----' | cut -f1 -d:)
	if [ -n "$sle" ]
	then
		sle=$(($sle-1))
		cnti=$(echo "$cnti" | head -n $sle)
		sle=$(($sle+$slb+1))
		cntu=$(echo "$cnt" | head -n $sle)
	else
		cntu=$cnt
	fi
	prcs=$(echo "$cnti" | pandoc -s -f markdown -t html | xmllint --html --xpath '//h1[text()="Conclusion"]' - 2> /dev/null)
	if [ ! -n "$prcs" ]
	then
		makeSlide
	else
		makeConclusion
	fi
done
makeFooter
