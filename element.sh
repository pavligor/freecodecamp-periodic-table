#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ $1 ]]
then
  GET_INFO=$($PSQL "select atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius from elements join properties using(atomic_number) join types using(type_id) where symbol='$1' or atomic_number::TEXT='$1' or name='$1'")
  if [[ -z $GET_INFO ]]
  then
    echo "I could not find that element in the database."
  else
    echo "$GET_INFO" | while read ATC_NUMBER BAR NAME BAR SYMBOL BAR TYPE BAR ATC_MASS BAR MELT BAR BOIL 
    do
      echo "The element with atomic number $ATC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATC_MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
    done
  fi
else
  echo "Please provide an element as an argument."
fi