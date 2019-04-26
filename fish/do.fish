function do --argument when task
	switch $when
case today
set date (date +%Y%m%d)
case tomorrow
set date (date --date="tomorrow" +%Y%m%d)
case this-week
if [ (date +%a) = "Mon" ]
set date (date +W%Y%m%d)
else
set date (date --date="last monday" +W%Y%m%d)
end
case next-week
set date (date --date="next monday" +W%Y%m%d)
case asap
set date urgent
case '*'
echo Unknown time: $when
return
end
if [ (string sub -s 1 -l 1 $task) = '!' ]
set src (string sub -s 2 -l 8 $task)
set num (string sub -s 11 $task)
echo moving task $num from $src to $when \($date\)
awk "NR==$num" ~/.doing/$src >> ~/.doing/$date
sed -i "$test d" ~/.doing/$src
else
echo $task >> ~/.doing/$date
end
end
