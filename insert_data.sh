#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS

do
# primero busca y inserta winner
 if [[  $WINNER != "winner" ]]
 then
  WIN=$($PSQL"SELECT team_id FROM teams WHERE name='$WINNER'") 
  if [[ -z $WIN ]]
  then
    WIN_INSERT=$($PSQL"INSERT INTO teams(name) VALUES('$WINNER')")
  fi
 fi
#segundo busca y inserta opponen
 if  [[  $OPPONENT != "opponent" ]]
 then
  OPO=$($PSQL"SELECT team_id FROM teams WHERE name='$OPPONENT'")
  if [[ -z $OPO ]]
  then
    OPO_INSERT=$($PSQL"INSERT INTO teams(name) VALUES('$OPPONENT')")   
  fi  
 fi
#tercero meter los partidos 
 if [[ $YEAR != "year" ]]
 then
   echo $YEAR
   YEAR_INSERT=$YEAR
 fi  
 if [[ $ROUND != "round" ]]
 then
   echo $ROUND
   ROUND_INSERT=$ROUND
 fi  
 if [[ $WINNER_GOALS != "winner_goals" ]]
 then
   echo $WINNER_GOALS
   WINNER_GOALS_INSERT=$WINNER_GOALS
 fi  
 if [[ $OPPONENT_GOALS != "opponent_goals" ]]
 then
   echo $OPPONENT_GOALS
   OPPONENT_GOALS_INSERT=$OPPONENT_GOALS
 fi
 if [[  $WINNER != "winner" ]]
 then
    WIN_ID=$($PSQL"SELECT team_id FROM teams WHERE name='$WINNER'")
 fi
 if  [[  $OPPONENT != "opponent" ]]
 then
    OPO_ID=$($PSQL"SELECT team_id FROM teams WHERE name='$OPPONENT'")  
    INSERT_GAME=$($PSQL "INSERT INTO games(year,round,winner_id,opponent_id,winner_goals,opponent_goals)VALUES('$YEAR_INSERT','$ROUND_INSERT','$WIN_ID','$OPO_ID','$WINNER_GOALS_INSERT','$OPPONENT_GOALS_INSERT')") 

 fi 
done