#!/bin/bash

# http://www.thegreenpapers.com/P16/D-PU.phtml
# as of May 7, 2016

# Pledged Delegates Won
BS_PL_TOT=1419
HC_PL_TOT=1706
PL_WON_TOT=$(calc -p "$BS_PL_TOT"+"$HC_PL_TOT")

# Unpledged Delegates "Won"
BS_UNPL_TOT=41
HC_UNPL_TOT=503
UNPL_WON_TOT=$(calc -p "$BS_UNPL_TOT"+"$HC_UNPL_TOT")

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

# Current totals
echo "2016 PRESIDENTIAL PRIMARY ELECTION DELEGATE COUNT AND PREDICTIONS

=================================================================================================
 AS OF MAY 9, 2016	| BERNIE SANDERS	| \$HILLARY CLINTON	| TOTAL	| REMAINING	|
------------------------|-----------------------|-----------------------|-------|---------------|
 PLEDGED DELEGATES      | 1419		35.03%	| 1706		42.11%	| 3125	| 926	22.86%	|
 UNPLEDGED DELEGATES    | 41		5.74%	| 503		70.45%	| 544	| 170	23.81%	|
------------------------|-----------------------|-----------------------|-----------------------|
 CONTESTED CONVENTION   | 566 - 61.12% PLEDGED	| 269 - 30.13% PLEDGED	|
 MAJORITY VOTE          | 607 - 65.55% PLEDGED	| 320 - 34.56% PLEDGED	|
 NOMINATION             | 964 - 38+ UNPLEDGED	| 667 - 73.11% PLEDGED	|
=========================================================================
"

# Remaining Primaries
STATES='WV KY OR VI PR CA MT NJ NM ND SD DC'
for ST in $STATES
do
    # State pledged delegate counts, primary dates, and voting %
    # Adjust BS_VT to calculate different possible outcomes
    [ "$ST" == "WV" ] && EL_DAY="MAY 10, TUESDAY"  && ST_PL=29  && ST_UNPL=8  && BS_VT=65
    [ "$ST" == "KY" ] && EL_DAY="MAY 17, TUESDAY"  && ST_PL=55  && ST_UNPL=5  && BS_VT=57
    [ "$ST" == "OR" ] && EL_DAY="MAY 17, TUESDAY"  && ST_PL=61  && ST_UNPL=13 && BS_VT=77
    [ "$ST" == "VI" ] && EL_DAY="JUNE 4, SATURDAY" && ST_PL=7   && ST_UNPL=5  && BS_VT=40
    [ "$ST" == "PR" ] && EL_DAY="JUNE 5, SUNDAY"   && ST_PL=60  && ST_UNPL=7  && BS_VT=48
    [ "$ST" == "CA" ] && EL_DAY="JUNE 7, TUESDAY"  && ST_PL=475 && ST_UNPL=73 && BS_VT=63
    [ "$ST" == "MT" ] && EL_DAY="JUNE 7, TUESDAY"  && ST_PL=21  && ST_UNPL=6  && BS_VT=68
    [ "$ST" == "NJ" ] && EL_DAY="JUNE 7, TUESDAY"  && ST_PL=126 && ST_UNPL=16 && BS_VT=58
    [ "$ST" == "NM" ] && EL_DAY="JUNE 7, TUESDAY"  && ST_PL=34  && ST_UNPL=9  && BS_VT=62
    [ "$ST" == "ND" ] && EL_DAY="JUNE 7, TUESDAY"  && ST_PL=18  && ST_UNPL=5  && BS_VT=62
    [ "$ST" == "SD" ] && EL_DAY="JUNE 7, TUESDAY"  && ST_PL=20  && ST_UNPL=5  && BS_VT=62
    [ "$ST" == "DC" ] && EL_DAY="JUNE 14, TUESDAY" && ST_PL=20  && ST_UNPL=26 && BS_VT=44

    # Clinton voting %
    HC_VT=$(calc -p 100-"$BS_VT")

    # Total Delegates Won
    PL_WON_TOT=$(calc -p "$PL_WON_TOT"+"$ST_PL")
    #UNPL_WON_TOT=$(calc -p "$UNPL_WON_TOT"+"$ST_UNPL"
    DEL_WON_TOT=$(calc -p "$DEL_WON_TOT"+"$ST_PL")

    # Determine Delegate Totals
    BS_PL_WON=$(calc -p "round("$ST_PL"*0."$BS_VT",0)")
    BS_PL_TOT=$(calc -p "$BS_PL_TOT"+"$BS_PL_WON")
    BS_PL_PCT=$(calc -p "round("$BS_PL_TOT"/"$PL_TOT"*100,2)")
    #BS_UNPL_WON=$(calc -p "round("$ST_UNPL"*0."$BS_VT",0)")
    #BS_UNPL_TOT=$(calc -p "$BS_UNPL_TOT"+"$BS_UNPL_WON")
    BS_UNPL_PCT=$(calc -p "round("$BS_UNPL_TOT"/"$UNPL_TOT"*100,2)")
    BS_DEL_TOT=$(calc -p "$BS_PL_TOT"+"$BS_UNPL_TOT")

    HC_PL_WON=$(calc -p "$ST_PL"-"$BS_PL_WON")
    HC_PL_TOT=$(calc -p "$HC_PL_WON"+"$HC_PL_TOT")
    HC_PL_PCT=$(calc -p "round("$HC_PL_TOT"/"$PL_TOT"*100,2)")
    #HC_UNPL_WON=$(calc -p "$ST_UNPL"-"$BS_UNPL_WON")
    #HC_UNPL_TOT=$(calc -p "$HC_UNPL_TOT"+"$HC_UNPL_WON")
    HC_UNPL_PCT=$(calc -p "round("$HC_UNPL_TOT"/"$UNPL_TOT"*100,2)")
    HC_DEL_TOT=$(calc -p "$HC_PL_TOT"+"$HC_UNPL_TOT")

    # Total Delegates Remaining
    PL_REM=$(calc -p "$PL_REM"-"$ST_PL")
    PL_REM_PCT=$(calc -p "round("$PL_REM"/"$PL_TOT"*100,2)")
    #UNPL_REM=$(calc -p "$UNPL_REM"-"$ST_UNPL")
    UNPL_REM_PCT=$(calc -p "round("$UNPL_REM"/"$UNPL_TOT"*100,2)")
    DEL_REM=$(calc -p "$DEL_REM"-"$ST_PL")
    DEL_REM_PCT=$(calc -p "round("$DEL_WON_TOT"/"$DEL_TOT"*100,2)")

    echo "================================================================================================="
    echo " $ST : $EL_DAY	| BERNIE SANDERS	| \$HILLARY CLINTON	| TOTAL	| REMAINING	|"
    echo "------------------------|-----------------------|-----------------------|-------|---------------|"
    echo " DELEGATES WON          | $BS_PL_WON		$BS_VT%	| $HC_PL_WON		$HC_VT%	| $ST_PL	|		|"
    echo "------------------------|-----------------------|-----------------------|-------|---------------|"
    echo " PLEDGED DELEGATES      | $BS_PL_TOT		$BS_PL_PCT%	| $HC_PL_TOT		$HC_PL_PCT%	| $PL_WON_TOT	| $PL_REM	$PL_REM_PCT%	|"
    echo " UNPLEDGED DELEGATES    | $BS_UNPL_TOT            $BS_UNPL_PCT%   | $HC_UNPL_TOT           $HC_UNPL_PCT%  | $UNPL_WON_TOT   | $UNPL_REM   $UNPL_REM_PCT%  |"
    echo "------------------------|-----------------------|-----------------------|-----------------------|"

    # determine probability of brokered convention, majority, or nomination
    for XP in "$C_C" "$MAJ" "$NOM"
    do
        [ "$XP" == 1985 ] && GOAL=" CONTESTED CONVENTION   |"
        [ "$XP" == 2026 ] && GOAL=" MAJORITY VOTE          |"
        [ "$XP" == 2383 ] && GOAL=" NOMINATION             |"

        for C in 'BS' 'HC'
        do
            [ "$C" == "BS" ] && C_PL_TOT="$BS_PL_TOT" && C_DEL_TOT="$BS_DEL_TOT"
            [ "$C" == "HC" ] && C_PL_TOT="$HC_PL_TOT" && C_DEL_TOT="$HC_DEL_TOT"

            if [ "$1" == "" ]; then
                # assumes every unpledged can be flipped
                PL_REQ=$(calc -p "$XP"-"$C_PL_TOT")
                DEL_MAX=$(calc -p "$C_PL_TOT"+"$PL_REM"+"$UNPL_TOT")

                if [ "$C_PL_TOT" -ge "$XP" ]; then
                    C_GOAL="ACHIEVED		|"
                elif [ "$DEL_MAX" -lt "$XP" ]; then
                    C_GOAL="IMPOSSIBLE		|"
                elif [ "$PL_REQ" -gt "$PL_REM" ]; then
                    UNPL_MIN=$(calc -p "$PL_REQ"-"$PL_REM")
                    C_GOAL="$PL_REQ - $UNPL_MIN+ UNPLEDGED	|"
                else
                    PCT_REQ=$(calc -p "round("$PL_REQ"/"$PL_REM"*100,2)")
                    C_GOAL="$PL_REQ - $PCT_REQ% PLEDGED	|"
                fi
            else
                # include unpledged counts
                [ "$XP" == 1985 ] && XP=2335
                [ "$XP" == 2026 ] && XP=2383
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
 
