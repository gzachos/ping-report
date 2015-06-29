#!/bin/sh
# Created by George Z. Zachos

# Values for text coloration
OR="\033[1;33m" # Orange/Yellow
RD="\033[1;31m" # Red
GN="\033[32m"   # Green
CY="\033[1;36m" # Cyan
GR="\033[1;30m" # Grey
NC="\033[0m"    # No-color

#########################################################################
#                                PEP-I LAB                              #
#########################################################################

# An initial message is printed to console.
echo "\n\n ${OR}Checking the reachability of all workstations in \"${CY}PEP-I${OR}\" lab ${NC}"

# "PEP-I" lab is equiped with 19 HP6000 and 9 HP6200 workstations.
# Their hostnames are hp6000wsXX, with XX in [11,29] and
# hp6200wsXX, with XX in [01,09]. 

####################### HP6000 #######################

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

# The number of the unreachable HP6000 workstations in PEP-I lab is printed to console.
echo "\n ${OR}$UNREACHABLE_HP6000 ${CY}HP6000 workstations are unreachable! ${NC}"

####################### HP6200 #######################

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

# The number of the unreachable HP6200 workstations in PEP-I lab is printed to console.
echo "\n ${OR}$UNREACHABLE_HP6200 ${CY}HP6200 workstations are unreachable! ${NC}"

#################### SUMMARY for PEP-I Lab ####################

# $PEP1_UNREACHABLES holds the total number of the unreachable workstations in PEP-I lab. 
PEP1_UNREACHABLES=$((UNREACHABLE_HP6000+UNREACHABLE_HP6200))

# $PEP1_UNREACHABLES is printed to console.
echo "\n ${RD}$PEP1_UNREACHABLES ${OR}out of the ${CY}28${OR} workstations in \"${CY}PEP-I${OR}\" lab are unreachable! ${NC}"

echo "\n ${GR}###################### END OF PEP-I REPORT ###################### ${NC}\n"

#########################################################################
#                               PEP-II LAB                              #
#########################################################################

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

#################### SUMMARY for PEP-II Lab ####################

# $PEP2_UNREACHABLES holds the total number of the unreachable workstations in PEP-II lab. 
PEP2_UNREACHABLES=$((UNREACHABLE_OPTI7020+UNREACHABLE_OPTI7010))

# Finally, $PEP2_UNREACHABLES is printed to console.
echo "\n ${RD}$PEP2_UNREACHABLES ${OR}out of the ${CY}28${OR} workstations in \"${CY}PEP-II${OR}\" lab are unreachable! ${NC}"

echo "\n ${GR}###################### END OF PEP-II REPORT ###################### ${NC}\n"

#########################################################################
#                                PELS LAB                               #
#########################################################################

# An initial message is printed to console.
echo "\n\n ${OR}Checking the reachability of all workstations in \"${CY}PELS${OR}\" lab ${NC}"

# "PELS" lab is equiped with 22 ULTRA20(SUN) workstations.
# Their hostnames are ultra20wsXX, with XX in [17,39].

####################### ULTRA20 #######################

echo "\n\n ${OR}*** ULTRA20 WORKSTATIONS ***${NC}\n"

ULTRA20_NUM=17
UNREACHABLE_ULTRA20=0

# For each hostname from ultra20ws17 to ultra20ws39
while [ $ULTRA20_NUM -le 39 ]
do
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

# The number of the unreachable ULTRA20 workstations in PELS lab is printed to console.
echo "\n ${OR}$UNREACHABLE_ULTRA20 ${CY}ULTRA20 workstations are unreachable! ${NC}"

#################### SUMMARY for PELS Lab ####################

# $PELS_UNREACHABLES holds the total number of the unreachable workstations in PELS lab. 
PELS_UNREACHABLES=$UNREACHABLE_ULTRA20

# $PELS_UNREACHABLES is printed to console.
echo "\n ${RD}$PELS_UNREACHABLES ${OR}out of the ${CY}23${OR} workstations in \"${CY}PELS${OR}\" lab are unreachable! ${NC}"

echo "\n ${GR}####################### END OF PELS REPORT ####################### ${NC}\n"

#########################################################################
#                            GENERAL REPORT                             #
#########################################################################

# $UNREACHABLE_SUM holds the total number of the unreachable workstations in PEP-I, PEP-II and PELS lab.
UNREACHABLE_SUM=$((PEP1_UNREACHABLES+PEP2_UNREACHABLES+PELS_UNREACHABLES))

echo "\n ${RD}################################################################${NC}"
echo "${RD} #\t\t\t ${GR}*GENERAL REPORT* \t\t\t${RD}#"
echo "${RD} #\t\t\t\t\t\t\t\t#"
echo "${RD} #\t\t ${CY}Unreachable workstations:\t\t\t${RD}#"
echo "${RD} #\t\t\t ${OR}PEP-I Lab: ${RD}$PEP1_UNREACHABLES \t\t\t\t#"
echo "${RD} #\t\t\t ${OR}PEP-II Lab: ${RD}$PEP2_UNREACHABLES \t\t\t#"
echo "${RD} #\t\t\t ${OR}PELS Lab: ${RD}$PELS_UNREACHABLES \t\t\t\t#"
echo "${RD} #\t\t\t\t\t\t\t\t#"
echo "${RD} #\t $UNREACHABLE_SUM ${OR}out of the ${CY}79${OR} workstations are unreachable!\t\t${RD}#"
echo "${RD} ################################################################${NC}"

# Feedback is given to user, in order to show the end of the script execution.
echo "\n ${GR}########################## END OF REPORT ########################## ${NC}\n"
