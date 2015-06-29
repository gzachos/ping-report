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

# "PEP-II" lab is equiped with 25 Dell Optiplex 7020 and 3 Dell Optiplex 7010 workstations.
# Their hostnames are opti7020wsXX, with XX in [01,25] and opti7010wsXX, with XX in [01,03].

################################# OPTI7020 #################################

echo "\n\n ${OR}*** OPTI7020 WORKSTATIONS ***${NC}\n"

OPTI7020_NUM=1
UNREACHABLE_OPTI7020=0

# For each hostname from opti7020ws01 to opti7020ws09
while [ $OPTI7020_NUM -le 25 ]
do
	if [ $OPTI7020_NUM -le 9 ]
	then
		# The STDOUT stream of the ping command is redirected to /dev/null,
		# while the STDERR stream is redirected to STDOUT. 
		# Consequently, nothing is printed to console.
		# Explaining '2>&1':
		# '1' is the file descriptor of STDOUT stream and '2' of the STDERR.
		# '&' indicates that what follows is a file descriptor and not a filename.
		ping -q -c 2 opti7020ws0$OPTI7020_NUM > /dev/null 2>&1
		# if the exit code of the ping command differs from zero(0), the workstation
		# is unreachable and the appropriate feedback is printed to console.
		if [ $? -ne 0 ]
		then
			echo "${RD} opti7020ws0$OPTI7020_NUM is unreachable! ${NC}"
			UNREACHABLE_OPTI7020=$((UNREACHABLE_OPTI7020+1))
		else
			echo "${GN} opti7020ws0$OPTI7020_NUM ${NC}"
		fi
	else
		ping -q -c 2 opti7020ws$OPTI7020_NUM > /dev/null 2>&1
		if [ $? -ne 0 ]
		then
			echo "${RD} opti7020ws$OPTI7020_NUM is unreachable! ${NC}"
			UNREACHABLE_OPTI7020=$((UNREACHABLE_OPTI7020+1))
		else
			echo "${GN} opti7020ws$OPTI7020_NUM ${NC}"
		fi
	fi
	OPTI7020_NUM=$((OPTI7020_NUM+1))
done

# The number of the unreachable OPTI7020 workstations is printed to console.
echo "\n ${OR}$UNREACHABLE_OPTI7020 ${CY}OPTI7020 workstations are unreachable! ${NC}"

################################# OPTI7010 #################################

echo "\n\n ${OR}*** OPTI7010 WORKSTATIONS ***${NC}\n"

OPTI7010_NUM=1
UNREACHABLE_OPTI7010=0

# For each hostname from opti7010ws01 to opti7010ws03
# the reachability test is conducted in the same way as above.
while [ $OPTI7010_NUM -le 3 ]
do
	ping -q -c 2 opti7010ws0$OPTI7010_NUM > /dev/null 2>&1
	if [ $? -ne 0 ]
	then
                echo "${RD} opti7010ws0$OPTI7010_NUM is unreachable! ${NC}"
               	UNREACHABLE_OPTI7010=$((UNREACHABLE_OPTI7010+1))
	else
                echo "${GN} opti7010ws0$OPTI7010_NUM ${NC}"
        fi
	OPTI7010_NUM=$((OPTI7010_NUM+1))
done

# The number of the unreachable OPTI7010 workstations is printed to console.
echo "\n ${OR}$UNREACHABLE_OPTI7010 ${CY}OPTI7010 workstations are unreachable! ${NC}"

################################# SUMMARY  #################################

# $UNREACHABLE_SUM holds the total number of the unreachable workstations. 
UNREACHABLE_SUM=$((UNREACHABLE_OPTI7020+UNREACHABLE_OPTI7010))

# Finally, $UNREACHABLE_SUM is printed to console.
echo "\n ${RD}$UNREACHABLE_SUM ${OR}out of the ${CY}28${OR} workstations in \"${CY}PEP-II${OR}\" lab are unreachable! ${NC}"

echo "\n ${GR}###################### END OF REPORT  ###################### ${NC}\n"
