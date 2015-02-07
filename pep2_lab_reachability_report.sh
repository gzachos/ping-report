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
echo "\n\n ${OR}Checking the reachability of all workstations in \"${CY}PEP-II${OR}\" lab ${NC}"

# "PEP-II" lab is equiped with 10 HP6000 and 18 ULTRA20(SUN) workstations.
# Their hostnames are hp6000wsXX, with XX in [01,10] and
# ultra20wsXX, with XX in [01,16]U{40,41}. 

################################# HP6000 #################################

echo "\n\n ${OR}*** HP6000 WORKSTATIONS ***${NC}\n"

HP6000_NUM=1
UNREACHABLE_HP6000=0

# For each hostname from hp6000ws01 to hp6000ws09
while [ $HP6000_NUM -le 9 ]
do
	# The STDOUT stream of the ping command is redirected to /dev/null,
	# while the STDERR stream is redirected to STDOUT. 
	# Consequently, nothing is printed to console.
	# Explaining '2>&1':
	# '1' is the file descriptor of STDOUT stream and '2' of the STDERR.
	# '&' indicates that what follows is a file descriptor and not a filename.
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

# Similarly, the reachability test of hp6000ws10 is conducted.
ping -q -c 2 hp6000ws10 > /dev/null 2>&1
if [ $? -ne 0 ] 
then    
	echo "${RD} hp6000ws10 is unreachable! ${NC}"
	UNREACHABLE_HP6000=$((UNREACHABLE_HP6000+1))
else    
	echo "${GN} hp6000ws10 ${NC}"
fi      

# The number of the unreachable HP6000 workstations is printed to console.
echo "\n ${OR}$UNREACHABLE_HP6000 ${CY}HP6000 workstations are unreachable! ${NC}"

################################# ULTRA20 #################################

echo "\n\n ${OR}*** ULTRA20 WORKSTATIONS ***${NC}\n"

ULTRA20_NUM=1
UNREACHABLE_ULTRA20=0

# For each hostname from ultra20ws01 to ultra20ws16 and for ultra20ws40 & ultra20ws41,
# the reachability test is conducted in the same way as above.
while [ $ULTRA20_NUM -le 41 ]
do
	if [ $ULTRA20_NUM -le 9 ]
	then
		ping -q -c 2 ultra20ws0$ULTRA20_NUM > /dev/null 2>&1
		if [ $? -ne 0 ]
	        then
        	        echo "${RD} ultra20ws0$ULTRA20_NUM is unreachable! ${NC}"
                	UNREACHABLE_ULTRA20=$((UNREACHABLE_ULTRA20+1))
	        else
        	        echo "${GN} ultra20ws0$ULTRA20_NUM ${NC}"
        	fi
	else
		if [ $ULTRA20_NUM -le 16 ] || [ $ULTRA20_NUM -eq 40 ] || [ $ULTRA20_NUM -eq 41 ]
		then
			ping -q -c 2 ultra20ws$ULTRA20_NUM > /dev/null 2>&1
			if [ $? -ne 0 ]
                	then
                        	echo "${RD} ultra20ws$ULTRA20_NUM is unreachable! ${NC}"
                        	UNREACHABLE_ULTRA20=$((UNREACHABLE_ULTRA20+1))
                	else
                        	echo "${GN} ultra20ws$ULTRA20_NUM ${NC}"
                	fi
		fi
	fi
	ULTRA20_NUM=$((ULTRA20_NUM+1))
done

# The number of the unreachable ULTRA20 workstations is printed to console.
echo "\n ${OR}$UNREACHABLE_ULTRA20 ${CY}ULTRA20 workstations are unreachable! ${NC}"

################################# SUMMARY  #################################

# $UNREACHABLE_SUM holds the total number of the unreachable workstations. 
UNREACHABLE_SUM=$((UNREACHABLE_HP6000+UNREACHABLE_ULTRA20))

# Finally, $UNREACHABLE_SUM is printed to console.
echo "\n ${RD}$UNREACHABLE_SUM ${OR}out of the ${CY}28${OR} workstations in \"${CY}PEP-II${OR}\" lab are unreachable! ${NC}"

echo "\n ${GR}###################### END OF REPORT  ###################### ${NC}\n"
