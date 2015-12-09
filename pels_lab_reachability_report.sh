#!/bin/sh
# Created by George Z. Zachos

# Values for text coloration
OR="\033[1;33m" # Orange/Yellow
RD="\033[1;31m" # Red
GN="\033[32m"   # Green
CY="\033[1;36m" # Cyan
GR="\033[1;30m" # Grey
NC="\033[0m"    # No-color

# An initial message is printed to console.
echo "\n\n ${OR}Checking the reachability of all workstations in \"${CY}PELS${OR}\" lab ${NC}"

# "PELS" lab is equiped with 16 ULTRA20(SUN) workstations and 7 HP6000 worstations.
# Their hostnames are ultra20wsXX, with XX in [17,19]U[23,32]U[37,39] and
# hp6000wsXX, with XX in [01,07].

################################# ULTRA20 #################################

echo "\n\n ${OR}*** ULTRA20 WORKSTATIONS ***${NC}\n"

ULTRA20_NUM=17
UNREACHABLE_ULTRA20=0

# For each hostname from ultra20ws17 to ultra20ws39
while [ $ULTRA20_NUM -le 39 ]
do
	if [ $ULTRA20_NUM -ge 20 ] && [ $ULTRA20_NUM -le 22 ] || [ $ULTRA20_NUM -ge 33 ] && [ $ULTRA20_NUM -le 36 ]
	then
		ULTRA20_NUM=$((ULTRA20_NUM+1))
		continue
	fi
	# The STDOUT stream of the ping command is redirected to /dev/null,
	# while the STDERR stream is redirected to STDOUT.
	# Consequently, nothing is printed to console.
	# Explaining '2>&1':
	# '1' is the file descriptor of STDOUT stream and '2' of the STDERR.
	# '&' indicates that what follows is a file descriptor and not a filename.
	ping -q -c 2 ultra20ws$ULTRA20_NUM > /dev/null 2>&1
	# if the exit code of the ping command differs from zero(0), the workstation
	# is unreachable and the appropriate feedback is printed to console.
	if [ $? -ne 0 ]
	then
		echo "${RD} ultra20ws$ULTRA20_NUM is unreachable! ${NC}"
		UNREACHABLE_ULTRA20=$((UNREACHABLE_ULTRA20+1))
	else
		echo "${GN} ultra20ws$ULTRA20_NUM ${NC}"
	fi
	ULTRA20_NUM=$((ULTRA20_NUM+1))
done

# The number of the unreachable ULTRA20 workstations is printed to console.
echo "\n ${OR}$UNREACHABLE_ULTRA20 ${CY}ULTRA20 workstations are unreachable! ${NC}"

################################# HP6000 #################################

echo "\n\n ${OR}*** HP6000 WORKSTATIONS ***${NC}\n"

HP6000_NUM=1
UNREACHABLE_HP6000=0

# For each hostname from hp6000ws01 to hp6000ws07
while [ $HP6000_NUM -le 7 ]
do
	ping -q -c 2 hp6000ws0$HP6000_NUM > /dev/null 2>&1
	# if the exit code of the ping command differs from zero(0), the workstation
	# is unreachable and the appropriate feedback is printed to console.
	if [ $? -ne 0 ]
	then
		echo "${RD} hp6000ws0$HP6000_NUM is unreachable! ${NC}"
		UNREACHABLE_HP6000=$((UNREACHABLE_HP6000+1))
	else
		echo "${GN} hp6000ws0$HP6000_NUM ${NC}"
	fi
	HP6000_NUM=$((HP6000_NUM+1))
done

# The number of the unreachable HP6000 workstations is printed to console.
echo "\n ${OR}$UNREACHABLE_HP6000 ${CY}HP6000 workstations are unreachable! ${NC}"

################################# SUMMARY  #################################

# $UNREACHABLE_SUM holds the total number of the unreachable workstations.
UNREACHABLE_SUM=$((UNREACHABLE_ULTRA20+UNREACHABLE_HP6000))

# Finally, the total number of the unreachable workstations is printed to console.
echo "\n ${RD}$UNREACHABLE_SUM ${OR}out of the ${CY}23${OR} workstations in \"${CY}PELS${OR}\" lab are unreachable! ${NC}"

echo "\n ${GR}###################### END OF REPORT  ###################### ${NC}\n"
