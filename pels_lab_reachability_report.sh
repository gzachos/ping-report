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

# "PELS" lab is equiped with 22 ULTRA20(SUN) workstations.
# Their hostnames are ultra20wsXX, with XX in [17,39].

################################# ULTRA20 #################################

echo "\n\n ${OR}*** ULTRA20 WORKSTATIONS ***${NC}\n"

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
		echo "${RD} ultra20ws$NUM is unreachable! ${NC}"
		UNREACHABLE=$((UNREACHABLE+1))
	else
		echo "${GN} ultra20ws$NUM ${NC}"
	fi
	NUM=$((NUM+1))
done

# The number of the unreachable ULTRA20 workstations is printed to console.
echo "\n ${OR}$UNREACHABLE ${CY}ULTRA20 workstations are unreachable! ${NC}"

################################# SUMMARY  #################################

# Finally, the total number of the unreachable workstations is printed to console.
echo "\n ${RD}$UNREACHABLE ${OR}out of the ${CY}23${OR} workstations in \"${CY}PELS${OR}\" lab are unreachable! ${NC}"

echo "\n ${GR}###################### END OF REPORT  ###################### ${NC}\n"
