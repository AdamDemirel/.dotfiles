cat ./list.txt | while read line 
do
  wget $line --directory-prefix=/home/adam/Pictures/earthview/
done
