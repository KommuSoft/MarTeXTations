#!/bin/bash
cnt=$(cat)
sbf='\W*'
saf='\s*'
tom='\1'
while test $# -gt 0; do
    case "$1" in
        -h|--help)
            echo "Not much to help with"
            exit 0
            ;;
        -t|--title)
            frm='title:\W*(.*?)'
            ;;
        -a|--author)
            frm='author:\W*(.*?)'
            ;;
        -d|--date)
            frm='date:\W*(.*?)'
            ;;
        -e|--email)
            frm='email:\W*(.*?)'
            ;;
        -D|--description)
            frm='description:\W*(.*?)'
            ;;
        *)
            break
            ;;
    esac
    echo "$cnt" | grep -P "$sbf$frm$saf" -m 1 | sed -E "s/^$sbf$frm$saf$/$tom/"
    shift
done
