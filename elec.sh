#!/bin/bash

# http://www.thegreenpapers.com/P16/D-PU.phtml
# as of May 11, 2016

# Pledged Delegates Won
BS_PL_TOT=1437
HC_PL_TOT=1717
PL_WON_TOT=$(calc -p "$BS_PL_TOT"+"$HC_PL_TOT")

# Unpledged Delegates "Won"
BS_UNPL_TOT=41
HC_UNPL_TOT=503
UNPL_WON_TOT=$(calc -p "$BS_UNPL_TOT"+"$HC_UNPL_TOT"+1) # O'Malley has 1 for some reason

# Combined Delegates Won
BS_DEL_TOT=$(calc -p "$BS_PL_TOT"+"$BS_UNPL_TOT")
HC_DEL_TOT=$(calc -p "$HC_PL_TOT"+"$HC_UNPL_TOT")
DEL_WON_TOT=$(calc -p "$BS_DEL_TOT"+"$HC_DEL_TOT")

# Complete Delegate Totals
DEL_TOT=4765 # Pledged + Unpledged
PL_TOT=4051  # Pledged
UNPL_TOT=714 # Unpledged (THESE DON'T REALLY COUNT YET)

# Delegates Remaining
PL_REM=$(calc -p "$PL_TOT"-"$PL_WON_TOT")
UNPL_REM=$(calc -p "$UNPL_TOT"-"$UNPL_WON_TOT")
DEL_REM=$(calc -p "$PL_REM"+"$UNPL_REM")

# Delegate Goals
C_C=1985 # 49%+ Pledged
MAJ=2026 # 50%+ Pledged
NOM=2383 # 50%+ Total Delegates

# All Goals are unmet by default
BS_GOAL=""
HC_GOAL=""

# Include unpledged total and only check possibility for nomination?
if [ "$1" != "" ]; then # any args
    UNPL_HARD=true
    GOALS="$NOM"
else
    GOALS="$C_C $MAJ $NOM"
fi

# Current totals
echo "2016 PRESIDENTIAL PRIMARY ELECTION DELEGATE COUNT AND PREDICTIONS

=================================================================================================
 AS OF MAY 11, 2016	| BERNIE SANDERS	| \$HILLARY CLINTON	| TOTAL	| REMAINING	|
------------------------|-----------------------|-----------------------|-------|---------------|
 PLEDGED DELEGATES      | 1437		35.47%	| 1717		42.38%	| 3154	| 897	22.14%	|
 UNPLEDGED DELEGATES    | 41		5.74%	| 503		70.45%	| 544	| 169	23.67%	|
------------------------|-----------------------|-----------------------|-----------------------|
 CONTESTED CONVENTION   | 548 - 61.1% PLEDGED	| 268 - 29.88% PLEDGED	|
 MAJORITY VOTE          | 589 - 65.66% PLEDGED	| 309 - 34.45% PLEDGED	|
 NOMINATION             | 946 - 49+ UNPLEDGED	| 666 - 74.25% PLEDGED	|
=========================================================================
"

# Remaining Primaries
STATES='KY OR VI PR CA MT NJ NM ND SD DC'
for ST in $STATES
do
    # State pledged delegate counts, primary dates, and voting %
    # Adjust BS_VT to calculate different possible outcomes
    [ "$ST" == "KY" ] && EL_DAY="MAY 17, TUESDAY"  && ST_PL=55  && BS_VT=57
    [ "$ST" == "OR" ] && EL_DAY="MAY 17, TUESDAY"  && ST_PL=61  && BS_VT=77
    [ "$ST" == "VI" ] && EL_DAY="JUNE 4, SATURDAY" && ST_PL=7   && BS_VT=40
    [ "$ST" == "PR" ] && EL_DAY="JUNE 5, SUNDAY"   && ST_PL=60  && BS_VT=48
    [ "$ST" == "CA" ] && EL_DAY="JUNE 7, TUESDAY"  && ST_PL=475 && BS_VT=63
    [ "$ST" == "MT" ] && EL_DAY="JUNE 7, TUESDAY"  && ST_PL=21  && BS_VT=68
    [ "$ST" == "NJ" ] && EL_DAY="JUNE 7, TUESDAY"  && ST_PL=126 && BS_VT=58
    [ "$ST" == "NM" ] && EL_DAY="JUNE 7, TUESDAY"  && ST_PL=34  && BS_VT=62
    [ "$ST" == "ND" ] && EL_DAY="JUNE 7, TUESDAY"  && ST_PL=18  && BS_VT=62
    [ "$ST" == "SD" ] && EL_DAY="JUNE 7, TUESDAY"  && ST_PL=20  && BS_VT=62
    [ "$ST" == "DC" ] && EL_DAY="JUNE 14, TUESDAY" && ST_PL=20  && BS_VT=44

    # Clinton voting %
    HC_VT=$(calc -p 100-"$BS_VT")

    # Total Delegates Won
    PL_WON_TOT=$(calc -p "$PL_WON_TOT"+"$ST_PL")
    DEL_WON_TOT=$(calc -p "$DEL_WON_TOT"+"$ST_PL")

    # Determine Delegate Totals
    BS_PL_WON=$(calc -p "round("$ST_PL"*0."$BS_VT",0)")
    BS_PL_TOT=$(calc -p "$BS_PL_TOT"+"$BS_PL_WON")
    BS_PL_PCT=$(calc -p "round("$BS_PL_TOT"/"$PL_TOT"*100,2)")
    BS_UNPL_PCT=$(calc -p "round("$BS_UNPL_TOT"/"$UNPL_TOT"*100,2)")
    BS_DEL_TOT=$(calc -p "$BS_DEL_TOT"+"$BS_PL_WON")
    BS_DEL_PCT=$(calc -p "round("$BS_DEL_TOT"/"$DEL_TOT"*100,2)")

    HC_PL_WON=$(calc -p "$ST_PL"-"$BS_PL_WON")
    HC_PL_TOT=$(calc -p "$HC_PL_WON"+"$HC_PL_TOT")
    HC_PL_PCT=$(calc -p "round("$HC_PL_TOT"/"$PL_TOT"*100,2)")
    HC_UNPL_PCT=$(calc -p "round("$HC_UNPL_TOT"/"$UNPL_TOT"*100,2)")
    HC_DEL_TOT=$(calc -p "$HC_DEL_TOT"+"$HC_PL_WON")
    HC_DEL_PCT=$(calc -p "round("$HC_DEL_TOT"/"$DEL_TOT"*100,2)")

    # Total Delegates Remaining
    PL_REM=$(calc -p "$PL_REM"-"$ST_PL")
    PL_REM_PCT=$(calc -p "round("$PL_REM"/"$PL_TOT"*100,2)")
    UNPL_REM_PCT=$(calc -p "round("$UNPL_REM"/"$UNPL_TOT"*100,2)")
    DEL_REM=$(calc -p "$DEL_REM"-"$ST_PL")
    DEL_REM_PCT=$(calc -p "round("$DEL_REM"/"$DEL_TOT"*100,2)")

    echo "========================================================================================="
    echo " $ST : $EL_DAY	| BERNIE SANDERS	| \$HILLARY CLINTON	| REMAINING	|"
    echo "------------------------|-----------------------|-----------------------|---------------|"
    echo " PLEDGES ($ST_PL TOTAL)	| $BS_PL_WON		$BS_VT%	| $HC_PL_WON		$HC_VT%	|		|"
    echo "------------------------|-----------------------|-----------------------|---------------|"
    echo " PLEDGED DELEGATES      | $BS_PL_TOT		$BS_PL_PCT%	| $HC_PL_TOT		$HC_PL_PCT%	| $PL_REM	$PL_REM_PCT%	|"
    echo " UNPLEDGED DELEGATES    | $BS_UNPL_TOT            $BS_UNPL_PCT%   | $HC_UNPL_TOT           $HC_UNPL_PCT%  | $UNPL_REM   $UNPL_REM_PCT%  |"
    echo "------------------------|-----------------------|-----------------------|---------------|"
    echo " TOTALS                 | $BS_DEL_TOT		$BS_DEL_PCT%	| $HC_DEL_TOT		$HC_DEL_PCT%	| $DEL_REM	$DEL_REM_PCT%	|"
    echo "========================|=======================|=======================|================"

    # determine probability of brokered convention, majority, or nomination
    for XP in $GOALS
    do
        [ "$XP" == 1985 ] && GOAL=" CONTESTED CONVENTION   |"
        [ "$XP" == 2026 ] && GOAL=" MAJORITY PLEDGED VOTES |"
        [ "$XP" == 2383 ] && GOAL=" NOMINATION             |"

        for C in 'BS' 'HC'
        do
            [ "$C" == "BS" ] && C_PL_TOT="$BS_PL_TOT" && C_DEL_TOT="$BS_DEL_TOT"
            [ "$C" == "HC" ] && C_PL_TOT="$HC_PL_TOT" && C_DEL_TOT="$HC_DEL_TOT"

            if [ ! "$UNPL_HARD" ]; then
                # assumes every unpledged can be flipped
                PL_REQ=$(calc -p "$XP"-"$C_PL_TOT")
                DEL_MAX=$(calc -p "$C_PL_TOT"+"$PL_REM"+"$UNPL_TOT")

                if [ "$C_PL_TOT" -ge "$XP" ]; then
                    C_GOAL="ACHIEVED		|"
                elif [ "$DEL_MAX" -lt "$XP" ]; then
                    C_GOAL="IMPOSSIBLE		|"
                elif [ "$PL_REQ" -ge "$PL_REM" ]; then
                    if [ "$XP" == "$NOM" ]; then
                        UNPL_MIN=$(calc -p "$PL_REQ"-"$PL_REM")
                        C_GOAL="$PL_REQ - $UNPL_MIN+ UNPLEDGED	|"
                    else
                        C_GOAL="IMPOSSIBLE		|"
                    fi
                else
                    PCT_REQ=$(calc -p "round("$PL_REQ"/"$PL_REM"*100,2)")
                    C_GOAL="$PL_REQ - $PCT_REQ% PLEDGED	|"
                fi
            else
                # include unpledged counts, only calculate possibility for nomination
                PL_REQ=$(calc -p "$XP"-"$C_PL_TOT")
                DEL_MAX=$(calc -p "$C_DEL_TOT"+"$DEL_REM")

                if [ "$C_DEL_TOT" -ge "$XP" ]; then
                    C_GOAL="ACHIEVED		|"
                elif [ "$DEL_MAX" -lt "$XP" ]; then
                    C_GOAL="IMPOSSIBLE		|"
                elif [ "$PL_REQ" -gt "$PL_REM" ]; then
                    DEL_MIN=$(calc -p "$XP"-"$C_DEL_TOT")
                    UNPL_MIN=$(calc -p "$PL_REQ"-"$PL_REM")
                    C_GOAL="$DEL_MIN - $UNPL_MIN+ UNPLEDGED	|"
                else
                    PCT_REQ=$(calc -p "round("$PL_REQ"/"$PL_REM"*100,2)")
                    C_GOAL="$PL_REQ - $PCT_REQ% PLEDGED	|"
                fi
            fi

            [ "$C" == "BS" ] && BS_GOAL="$C_GOAL"
            [ "$C" == "HC" ] && HC_GOAL="$C_GOAL"
        done

        echo "$GOAL $BS_GOAL $HC_GOAL"

        # Reset Goals
        BS_GOAL=""
        HC_GOAL=""
    done

    echo "========================================================================="
    echo
done
 
