#!/bin/bash

sed -e 's/</\&lt;/g' -e 's/>/\&gt;/g' -e 's/^Part \(.*\)$/<h2>Part \1<\/h2>/' -e '/<\/h2>$/! s/$/<br\/>/' -e '1 s/^/<html><body>\
/g' -e '$ s/$/\
<\/body><\/html>/' 2.txt

