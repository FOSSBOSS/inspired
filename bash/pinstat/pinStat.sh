#!/bin/bash
#raspbery pi project
echo "<!DOCTYPE HTML><html><body>"
#get temp too and show in images
sensor=`/opt/vc/bin/vcgencmd measure_temp | sed "s/[^0-9]//g"`
#sensor is 10 times higher than actual Cor temp. I decided I dont care about the regex
ctemp=$((sensor/10))

echo "Core Temp: " $ctemp

if [ "$ctemp" -le "38" ] ;then   
    echo "<img src=\"cool.png\" alt=\"cool\">"
elif [ "$ctemp" -ge "38" ] && [ "$ctemp" -le "50" ] ;then
     echo "<img src=\"mid.png\" alt=\"Normal Operational Temprature\"><br>"

elif [ "$ctemp" -gt "50" ] ;then
     echo "<img src=\"hot.png\" alt=\"Hot\">"
else
     echo "<br>I have no clue what temprature it is<br>"
fi

echo "<br>GPIO PIN____STAUS<br>"
for i in `seq 0 30`
do

x=`gpio read $i`
if [ "$x" = "1" ] 
then 
		echo "<br> "$i  " <img src=\"on.png\"><br>" 
else
		echo "<br> "$i  " <img src=\"off.png\"><br>"
fi


done

echo "</body></html>"
