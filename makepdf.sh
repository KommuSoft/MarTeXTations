#!/bin/bash
function makeHeader () {
	echo '\documentclass{beamer}';
	echo "\\title{$titl}"
	echo "\\author{$auth}"
	echo "\\date{$date}"
	echo '\begin{document}\AtBeginSection[] {\begin{frame}[plain]\frametitle{Overview}\tableofcontents[currentsection]\end{frame}}'
}

function makeFooter () {
	echo '\end{document}'
}

function makeTitle () {
	echo '	\begin{frame}\maketitle{}\end{frame}\begin{frame}\tableofcontents{}\end{frame}'
}

function slide () {
	fisc=$(echo "$cnti" | grep -P '#+ (.*)')
	ftip=$(echo "$fisc" | tail -n 1 | sed -r 's/#+ +//g')
	ftit="$ftip"
	echo "$fisc" | pandoc -f markdown -t latex -S --normalize
	frmi=$(echo "$cnti" | pandoc -f markdown -t latex -S --normalize)
	echo "\\begin{frame}[allowframebreak]{$ftit}"
	echo "$frmi" | grep -v -P '\\section\{.*|\\label{.*'
	echo '\end{frame}'
}

cnt=$(cat)
titl=$(echo "$cnt" | bash scrape.sh -t)
desc=$(echo "$cnt" | bash scrape.sh -D)
auth=$(echo "$cnt" | bash scrape.sh -a)
date=$(echo "$cnt" | bash scrape.sh -d)
slid=0;
makeHeader
makeTitle
for slb in `echo "$cnt" | grep -n -e '----' | cut -f1 -d:`
do
	slb=$(($slb+1))
	cnti=$(echo "$cnt" | tail -n +$slb)
	sle=$(echo "$cnti" | grep -n -m 1 -e '----' | cut -f1 -d:)
	if [ -n "$sle" ]
	then
		sle=$(($sle-1))
		cnti=$(echo "$cnti" | head -n $sle)
	fi
	slide
done
makeFooter
