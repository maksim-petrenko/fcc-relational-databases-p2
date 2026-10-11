#!/bin/sh
# https://www.freecodecamp.org/
# Curriculum: Relational Databases Certification
# Project: Build a World Cup Database
# Copyright (C) 2026 Maksim Petrenko


# Options
if [ $1 = "test" ]
then
    db_user="postgres"
    db_name="worldcuptest"
    schema="../worldcup.sql"
else
    db_user="freecodecamp"
    db_name="worldcup"
    schema="./worldcup.sql"
fi

# Data directory
if [ ! -d ./data ]
then
    mkdir ./data
fi

# Teams table
echo "team_id,name" > ./data/teams.csv
tail -n +2 games.csv | cut -s -d "," -f 3,4 | tr "," "\n" | sort | uniq | awk '{ printf "%d,%s\n", NR, $0 }' >> ./data/teams.csv

# Games table
echo "game_id,year,round,winner_id,opponent_id,winner_goals,opponent_goals" > ./data/games.csv
awk -F "," 'FILENAME == "./data/teams.csv" && FNR > 1 { teams[$2] = $1 } FILENAME == "games.csv" && FNR > 1 && length() > 0 { printf "%d,%d,%s,%d,%d,%d,%d\n", FNR-1, $1, $2, teams[$3], teams[$4], $5, $6 }' ./data/teams.csv games.csv >> ./data/games.csv

# Create the database and import tables
# PostgreSQL
#dropdb --if-exists -U "$db_user" "$db_name"
#createdb -U "$db_user" "$db_name"
psql -U "$db_user" "$db_name" < "$schema"
psql -U "$db_user" "$db_name" -c "\copy teams from './data/teams.csv' (format csv, delimiter ',', quote '\"', header true)"
psql -U "$db_user" "$db_name" -c "\copy games from './data/games.csv' (format csv, delimiter ',', quote '\"', header true)"

