#!/bin/sh
# Created by George Z. Zachos

# Initial messages are printed to console.
echo "\n\n"

echo "\033[1;33m Checking the reachability of all workstations at lab \"PELS\" \033[0m \n\n"

echo "\033[1;33m *** ULTRA20 WORKSTATIONS *** \033[0m \n"

# "PELS" lab is equiped with 22 ULTRA20(SUN) workstations.
# Their hostnames are ultra20wsXX, with XX in [17,39].
NUM=17
UNREACHABLE=0

# For each hostname from ultra20ws17 to ultra20ws39
while [ $NUM -le 39 ]
do
	# The STDOUT stream of the ping command is redirected to /dev/null,
	# while the STDERR stream is redirected to STDOUT. 
	# Consequently, nothing is printed to console.
	# Explaining '2>&1':
	# '1' is the file descriptor of STDOUT stream and '2' of the STDERR.
	# '&' indicates that what follows is a file descriptor and not a filename.
	ping -q -c 2 ultra20ws$NUM > /dev/null 2>&1
	# if the exit code of the ping command differs from zero(0), the workstation
	# is unreachable and the appropriate feedback is printed to console.
	if [ $? -ne 0 ]
	then
		echo "\033[1;31m ultra20ws$NUM is unreachable!\033[0m"
		UNREACHABLE=$((UNREACHABLE+1))
	else
		echo "\033[32m ultra20ws$NUM \033[0m"
	fi
	NUM=$((NUM+1))
done

# The amount of the ULTRA20 unreachable workstations is printed to console.
echo "\033[1;33m \n $UNREACHABLE ULTRA20 workstations are unreachable! \033[0m \n"

# Finally, the total amount of the unreachable workstations is printed to console.
echo "\033[1;33m $UNREACHABLE out of the 23 workstations at lab \"PELS\" are unreachable! \033[0m \n"
