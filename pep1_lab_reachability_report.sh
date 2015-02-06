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
echo "\n\n ${OR}Checking the reachability of all workstations in \"${CY}PEP-I${OR}\" lab ${NC}"

# "PEP-I" lab is equiped with 19 HP6000 and 9 HP6200 workstations.
# Their hostnames are hp6000wsXX, with XX in [11,29] and
# hp6200wsXX, with XX in [01,09]. 

################################# HP6000 #################################

echo "\n\n ${OR}*** HP6000 WORKSTATIONS ***${NC}\n"

HP6000_NUM=11
UNREACHABLE_HP6000=0

# For each hostname from hp6000ws11 to hp6000ws29
while [ $HP6000_NUM -le 29 ]
do
	# The STDOUT stream of the ping command is redirected to /dev/null,
	# while the STDERR stream is redirected to STDOUT. 
	# Consequently, nothing is printed to console.
	# Explaining '2>&1':
	# '1' is the file descriptor of STDOUT stream and '2' of the STDERR.
	# '&' indicates that what follows is a file descriptor and not a filename.
	ping -q -c 2 hp6000ws$HP6000_NUM > /dev/null 2>&1
	# if the exit code of the ping command differs from zero(0), the workstation
	# is unreachable and the appropriate feedback is printed to console.
	if [ $? -ne 0 ]
	then
		echo "${RD} hp6000ws$HP6000_NUM is unreachable! ${NC}"
		UNREACHABLE_HP6000=$((UNREACHABLE_HP6000+1))
	else
		echo "${GN} hp6000ws$HP6000_NUM ${NC}"
	fi
	HP6000_NUM=$((HP6000_NUM+1))
done

# The number of the unreachable HP6000 workstations is printed to console.
echo "\n ${OR}$UNREACHABLE_HP6000 ${CY}HP6000 workstations are unreachable! ${NC}"

################################# HP6200 #################################

echo "\n\n ${OR}*** HP6200 WORKSTATIONS ***${NC}\n"

HP6200_NUM=1
UNREACHABLE_HP6200=0

# For each hostname from hp6200ws01 to hp6200ws09
while [ $HP6200_NUM -le 9 ]
do
        ping -q -c 2 hp6200ws0$HP6200_NUM > /dev/null 2>&1
        # if the exit code of the ping command differs from zero(0), the workstation
        # is unreachable and the appropriate feedback is printed to console.
        if [ $? -ne 0 ]
        then
                echo "${RD} hp6200ws0$HP6200_NUM is unreachable! ${NC}"
                UNREACHABLE_HP6200=$((UNREACHABLE_HP6200+1))
        else
                echo "${GN} hp6200ws0$HP6200_NUM ${NC}"
        fi
        HP6200_NUM=$((HP6200_NUM+1))
done

# The number of the unreachable HP6200 workstations is printed to console.
echo "\n ${OR}$UNREACHABLE_HP6200 ${CY}HP6200 workstations are unreachable! ${NC}"

################################# SUMMARY  #################################

# $UNREACHABLE_SUM holds the total number of the unreachable workstations. 
UNREACHABLE_SUM=$((UNREACHABLE_HP6000+UNREACHABLE_HP6200))

# Finally, $UNREACHABLE_SUM is printed to console.
echo "\n ${RD}$UNREACHABLE_SUM ${OR}out of the ${CY}28${OR} workstations in \"${CY}PEP-I${OR}\" lab are unreachable! ${NC}"

echo "\n ${GR}###################### END OF REPORT  ###################### ${NC}\n"
