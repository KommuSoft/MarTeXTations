#!/bin/bash
cnt=$(cat)
sbf='\W*'
saf='\s*'
tom='\1'
dfp=':\s*(.*?)'
while test $# -gt 0; do
    case "$1" in
        -h|--help)
            man "./scrape.man"
            exit 0
            ;;
        -t|--title)
            frm='title'
            ;;
        -a|--author)
            frm='author'
            ;;
        -d|--date)
            frm='date'
            ;;
        -e|--email)
            frm='email'
            ;;
        -D|--description)
            frm='description'
            ;;
        -i|--institute)
            frm='institute'
            ;;
        --custom)
        	shift
        	from="$1"
        	;;
        *)
            break
            ;;
    esac
    echo "$cnt" | grep -P "$sbf$frm$saf" -m 1 | sed -E "s/^$sbf$frm$dfp$saf$/$tom/"
    shift
done
