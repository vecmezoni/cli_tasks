#!/bin/bash
echo '<html><body>'
sed 's/&/\&amp;/g' $1 |
sed 's/</\&lt;/g' |
sed 's/>/\&gt;/g' |
sed 's/\"/\&quot;/g' |
sed 's/^Part \(.*\)$/<h2>Part \1<\/h2>/' |
sed '/<\/h2>$/! s/$/<br\/>/' 
echo '</body></html>'

