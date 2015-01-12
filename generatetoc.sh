#!/bin/bash
pandoc -f markdown -t html5 | xsltproc -html htmltoc.xslt - | tail -n +2
