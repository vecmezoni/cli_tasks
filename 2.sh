#!/bin/bash
echo '<html><body>'
sed -e 's/&/\&amp;/g' \
    -e 's/</\&lt;/g' \
    -e 's/>/\&gt;/g' \
    -e 's/\"/\&quot;/g' \
    -e 's/^Part \(.*\)$/<h2>Part \1<\/h2>/' \
    -e '/<\/h2>$/! s/$/<br\/>/' $1 
echo '</body></html>'
