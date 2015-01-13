pandoc -f markdown -t html5 | xsltproc -html breadcrums.xslt - | tail -n+1
