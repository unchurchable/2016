#!/bin/bash

# http://www.thegreenpapers.com/P16/D-PU.phtml

# Pledged Delegates Won
BS_PL_TOT=1437
HC_PL_TOT=1717
PL_WON_TOT=$(( $BS_PL_TOT + $HC_PL_TOT ))

# Unpledged Delegates "Won"
BS_UNPL_TOT=41
HC_UNPL_TOT=505
UNPL_WON_TOT=$(( $BS_UNPL_TOT + $HC_UNPL_TOT + 1 )) # O'Malley has 1 for some reason

# Combined Delegates Won
BS_DEL_TOT=$(( $BS_PL_TOT + $BS_UNPL_TOT ))
HC_DEL_TOT=$(( $HC_PL_TOT + $HC_UNPL_TOT ))
DEL_WON_TOT=$(( $BS_DEL_TOT + $HC_DEL_TOT ))

# Complete Delegate Totals
DEL_TOT=4765 # Pledged + Unpledged
PL_TOT=4051  # Pledged
UNPL_TOT=714 # Unpledged (THESE DON'T REALLY COUNT YET)

# Delegates Remaining
PL_REM=$(( $PL_TOT - $PL_WON_TOT ))
UNPL_REM=$(( $UNPL_TOT - $UNPL_WON_TOT ))
DEL_REM=$(( $PL_REM + $UNPL_REM ))
# Current Pledges Remaining
CUR_PL_REM="$PL_REM"

# Delegate Goals
C_C=1985 # 49%+ Pledged
MAJ=2026 # 50%+ Pledged
NOM=2383 # 50%+ Total Delegates
GOALS=($C_C $MAJ $NOM)

# All Goals are unmet by default
BS_GOAL=""
HC_GOAL=""

# functions
pledges_awarded() {
    calc -p "round("$1"*0."$2",0)"
}
precision_percent() {
    calc -p "round("$1"/"$2"*100,2)"
}

# Current totals
echo "2016 PRESIDENTIAL PRIMARY ELECTION DELEGATE COUNT AND PREDICTIONS
=================================================================

 CURRENT DELEGATE COUNT :
=========================================================================================
 AS OF MAY 14, 2016	| BERNIE SANDERS	| \$HILLARY CLINTON	| REMAINING	|
------------------------|-----------------------|-----------------------|---------------|
 PLEDGED DELEGATES      | 1437		35.47%	| 1717		42.38%	| 897	22.14%	|
 UNPLEDGED DELEGATES    | 41		5.74%	| 505		70.73%	| 167	23.39%	|
------------------------|-----------------------|-----------------------|---------------|
 TOTALS                 | 1478		31.02%	| 2222		46.63%	| 1064	22.33%	|
========================|=======================|=======================|================
 CONTESTED CONVENTION   | 548 - 61.1% PLEDGED	| 268 - 29.88% PLEDGED	|
 MAJORITY PLEDGED VOTES | 589 - 65.66% PLEDGED	| 309 - 34.45% PLEDGED	|
 NOMINATION             | 946 - 49+ UNPLEDGED	| 666 - 74.25% PLEDGED	|
=========================================================================
"

# Remaining Primaries
STATES=(KY OR VI PR CA MT NJ NM ND SD DC)
echo "${#STATES[@]} REMAINING PRIMARIES :
"
for ST in ${STATES[@]}
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

    # % of remaining delegates (current $PL_REM total)
    ST_PL_PCT=$(precision_percent "$ST_PL" "$CUR_PL_REM")

    # Clinton voting %
    HC_VT=$(( 100 - $BS_VT ))

    # Total Delegates Won
    PL_WON_TOT=$(( $PL_WON_TOT + $ST_PL ))
    DEL_WON_TOT=$(( $DEL_WON_TOT + $ST_PL ))

    # Determine Delegate Totals
    BS_PL_WON=$(pledges_awarded "$ST_PL" "$BS_VT")
    BS_PL_TOT=$(( $BS_PL_TOT + $BS_PL_WON ))
    BS_PL_PCT=$(precision_percent "$BS_PL_TOT" "$PL_TOT")
    BS_UNPL_PCT=$(precision_percent "$BS_UNPL_TOT" "$UNPL_TOT")
    BS_DEL_TOT=$(( $BS_DEL_TOT + $BS_PL_WON ))
    BS_DEL_PCT=$(precision_percent "$BS_DEL_TOT" "$DEL_TOT")

    HC_PL_WON=$(( $ST_PL - $BS_PL_WON ))
    HC_PL_TOT=$(( $HC_PL_WON + $HC_PL_TOT ))
    HC_PL_PCT=$(precision_percent "$HC_PL_TOT" "$PL_TOT")
    HC_UNPL_PCT=$(precision_percent "$HC_UNPL_TOT" "$UNPL_TOT")
    HC_DEL_TOT=$(( $HC_DEL_TOT + $HC_PL_WON ))
    HC_DEL_PCT=$(precision_percent "$HC_DEL_TOT" "$DEL_TOT")

    # Total Delegates Remaining
    PL_REM=$(( $PL_REM - $ST_PL ))
    PL_REM_PCT=$(precision_percent "$PL_REM" "$PL_TOT")
    UNPL_REM_PCT=$(precision_percent "$UNPL_REM" "$UNPL_TOT")
    DEL_REM=$(( $DEL_REM - $ST_PL ))
    DEL_REM_PCT=$(precision_percent "$DEL_REM" "$DEL_TOT")

    echo "=========================================================================================
 $ST : $EL_DAY	| BERNIE SANDERS	| \$HILLARY CLINTON	| REMAINING	|
------------------------|-----------------------|-----------------------|---------------|
 PLEDGES ($ST_PL | $ST_PL_PCT%)	| $BS_PL_WON		$BS_VT%	| $HC_PL_WON		$HC_VT%	|		|
------------------------|-----------------------|-----------------------|---------------|
 PLEDGED DELEGATES      | $BS_PL_TOT		$BS_PL_PCT%	| $HC_PL_TOT		$HC_PL_PCT%	| $PL_REM	$PL_REM_PCT%	|
 UNPLEDGED DELEGATES    | $BS_UNPL_TOT            $BS_UNPL_PCT%   | $HC_UNPL_TOT           $HC_UNPL_PCT%  | $UNPL_REM   $UNPL_REM_PCT%  |
------------------------|-----------------------|-----------------------|---------------|
 TOTALS                 | $BS_DEL_TOT		$BS_DEL_PCT%	| $HC_DEL_TOT		$HC_DEL_PCT%	| $DEL_REM	$DEL_REM_PCT%	|
========================|=======================|=======================|================"

    # determine probability of brokered convention, majority, or nomination
    for XP in ${GOALS[@]}
    do
        [ "$XP" == 1985 ] && GOAL=" CONTESTED CONVENTION   |"
        [ "$XP" == 2026 ] && GOAL=" MAJORITY PLEDGED VOTES |"
        [ "$XP" == 2383 ] && GOAL=" NOMINATION             |"

        for C in 'BS' 'HC'
        do
            [ "$C" == "BS" ] && C_PL_TOT="$BS_PL_TOT"
            [ "$C" == "HC" ] && C_PL_TOT="$HC_PL_TOT"

            # assume all unpledged delegates can be flipped, because
            # neither candidate will win the nomination without them
            PL_REQ=$(( $XP - $C_PL_TOT ))
            DEL_MAX=$(( $C_PL_TOT + $PL_REM + $UNPL_TOT ))

            if [ "$C_PL_TOT" -ge "$XP" ]; then
                C_GOAL="ACHIEVED		|"
            elif [ "$PL_REQ" -ge "$PL_REM" ]; then
                if [ "$XP" == "$NOM" ] && [ "$DEL_MAX" -ge "$XP" ]; then
                    UNPL_MIN=$(( $PL_REQ - $PL_REM ))
                    C_GOAL="$PL_REQ - $UNPL_MIN+ UNPLEDGED	|"
                else
                    C_GOAL="IMPOSSIBLE		|"
                fi
            else
                PCT_REQ=$(precision_percent "$PL_REQ" "$PL_REM")
                C_GOAL="$PL_REQ - $PCT_REQ% PLEDGED	|"
            fi

            [ "$C" == "BS" ] && BS_GOAL="$C_GOAL"
            [ "$C" == "HC" ] && HC_GOAL="$C_GOAL"
        done

        echo "$GOAL $BS_GOAL $HC_GOAL"

        # Reset Goals
        BS_GOAL=""
        HC_GOAL=""
    done

    echo "=========================================================================
"
done

