cat ./list.txt | while read line 
do
    wget $line;
   # do something with $line here
done
