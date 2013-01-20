#!/bin/bash
date='2013-01-20';
id='43';
log_file='3.log';
plot_file='quantile.pdf';
sort  -k 8 -n "$log_file" |
awk  '
    BEGIN {
        a = 1;
        b = 1;
        sumA = 0;
        sumB = 0;
    }
    {
    if (($1 ~ /'"${date}"'/) && ($6 ~ /resume/) && ($2 ~ /12:/) && ($7 ~ /200/)){
        A[a] = substr($8,1,length($8)-2); 
        sumA += A[a];
        a++;
    }
    if (($1 ~ /'"${date}"'/) && ($6 ~ /resume\?id='"${id}"'/)){
        B[b] = substr($8,1,length($8)-2); 
        sumB += B[b];
        b++;
    }
    }
    END { 
	    print "'"${date}"' с 12:00 по 13:00 для страницы /resume?"
	    print "Общее время выполнения: " sumA " ms."; 
	    print "Медиана: " quantile(A,0.5,a) " ms."; 
	    print "Квантиль 0.95: " quantile(A,0.95,a) " ms.";
	    print "Квантиль 0.99: " quantile(A,0.99,a) " ms.";
	    print "";
	    print "'"${date}"' для страницы /resume?id='"${id}"'"
		print "Среднее: " sumB/b " ms."; 
		print "Медиана: " quantile(B,0.5,b) " ms."; 
	}
	function quantile(arr,f,n) {
		lf=(n-1)*f+1;	
		l=int(lf);	
		r=n-int(n-lf)
		ddl=lf-l
		return arr[l]+ddl*(arr[r]-arr[l])
	}'

echo;
sort "$log_file" |
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
tplot -if tplot.txt -or 1280x1080 -of pdf -o "$plot_file" -dk 'within[-] quantile 300 0.95'
rm tplot.txt
echo "График сгенерирован в файл ${plot_file}";
 
