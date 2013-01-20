#!/bin/bash
date='2013-01-20';
id='43';



sort  -k 8 -n 3.log |
awk  '($6 ~ /resume/) && ($1 ~ /'"${date}"'/) && ($2 ~ /12:/)' | 
awk  '{A[NR] = substr($8,1,length($8)-2); SUM += A[NR]} END { 
	print "'"${date}"' с 12:00 по 13:00 для страницы /resume?"
	print "Общее время выполнения: " SUM " ms."; 
	print "Медиана: " quantile(A,0.5,NR) " ms."; 
	print "Квантиль 0.95: " quantile(A,0.95,NR) " ms.";
	print "Квантиль 0.99: " quantile(A,0.99,NR) " ms.";}
	
	function quantile(arr,f,n) {
		lf=(n-1)*f+1;	
		l=int(lf);	
		r=n-int(n-lf)
		ddl=lf-l
		return arr[l]+ddl*(arr[r]-arr[l])
	}'

echo;
sort  -k 8 -n 3.log |
awk  '($6 ~ /resume\?id='"${id}"'/) && ($1 ~ /'"${date}"'/)' | 
awk  '{A[NR] = substr($8,1,length($8)-2); SUM += A[NR]} END { 
		print "'"${date}"' для страницы /resume?id='"${id}"'"
		print "Среднее: " SUM/NR " ms."; 
		print "Медиана: " quantile(A,0.5,NR) " ms."; 
		}
		function quantile(arr,f,n) {
			lf=(n-1)*f+1;	
			l=int(lf);	
			r=n-int(n-lf)
			ddl=lf-l
			return arr[l]+ddl*(arr[r]-arr[l])
		}'
		
echo;
sort 3.log |
awk  '($1 ~ /'"${date}"'/)' |
awk  '
{
	if ($6 ~ /resume/){
		name = "=resume";
	}
	else if ($6 ~ /vacancy/){
		name = "=vacancy";
	}
	else if ($6 ~ /user/){
		name = "=user";
	}
	print $1, $2, name, substr($8,1,length($8)-2) + 0.0; 
}
	' > tplot.txt
tplot -if tplot.txt -or 1280x1080 -of pdf -o arc.pdf -dk 'within[-] quantile 300 0.95'
echo "График сгенерирован: ./arc.pdf";
 
