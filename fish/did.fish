function did --argument task
	if test (string length $task) -ge 10
set date (string sub -l 8 $task)
set num (string sub -s 10 $task)
awk -i inplace "NR==$num{print \$0 \"\t_DONE_\"}; NR!=$test" ~/.doing/$date
else if test (string sub -l 6 $task) = "urgent"
set num (string sub -s 8 $task)
if test -e ~/.doing/urgent
awk -i inplace "NR==$num{print \$0 \"\t_DONE_\"}; NR!=$test" ~/.doing/urgent
else
echo No urgent tasks to complete
end
else
echo Invalid task: $task
end
end
