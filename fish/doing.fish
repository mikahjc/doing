function doing --argument when
	if test -z "$when"
# No args provided, print summary of urgent, today, this week
if [ (date +%a) = "Mon" ]
set week (date +W%Y%m%d)
else
set week (date --date="last monday" +W%Y%m%d)
end
set today (date +%Y%m%d)
if test -e ~/.doing/urgent
echo Urgent:
cat -n ~/.doing/urgent | awk '$0 !~ /_DONE_/'
echo
end
if test -e ~/.doing/$week
echo This week:
cat -n ~/.doing/$week | awk '$0 !~ /_DONE_/'
echo
end
if test -e ~/.doing/$today
echo Today:
cat -n ~/.doing/$today | awk '$0 !~ /_DONE_/'
echo
end
return
end
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
# Print requested time
if [ $when != "asap" ]
if test -e ~/.doing/urgent
echo Urgent:
cat -n ~/.doing/urgent | awk '$0 !~ /_DONE_/'
end
end
if test -e ~/.doing/$date
echo Tasks to be completed $when:
cat -n ~/.doing/$date | awk '$0 !~ /_DONE_/'
echo
else
echo No tasks to be completed $when.
end
end
