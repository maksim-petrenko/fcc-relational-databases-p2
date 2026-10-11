#!/bin/sh
# https://www.freecodecamp.org/
# Curriculum: Relational Databases Certification
# Project: Build a World Cup Database
# Copyright (C) 2026 Maksim Petrenko


# Constants
DB_USER="freecodecamp"
DB_NAME="worldcup"


# 01
printf "\nTotal number of goals in all games from winning teams:\n"
psql -U "$DB_USER" -d "$DB_NAME" -At -c "
SELECT sum(winner_goals)
FROM games;"

# 02
printf "\nTotal number of goals in all games from both teams combined:\n"
psql -U "$DB_USER" -d "$DB_NAME" -At -c "
SELECT (sum(winner_goals) + sum(opponent_goals))
FROM games;"

# 03
printf "\nAverage number of goals in all games from the winning teams:\n"
psql -U "$DB_USER" -d "$DB_NAME" -At -c "
SELECT CAST(avg(winner_goals) AS DECIMAL(17, 16))
FROM games;"

# 04
printf "\nAverage number of goals in all games from the winning teams rounded to two decimal places:\n"
psql -U "$DB_USER" -d "$DB_NAME" -At -c "
SELECT round(avg(winner_goals), 2)
FROM games;"

# 05
printf "\nAverage number of goals in all games from both teams:\n"
psql -U "$DB_USER" -d "$DB_NAME" -At -c "
SELECT CAST(avg(winner_goals) + avg(opponent_goals) AS DECIMAL(17, 16))
FROM games;"

# 06
printf "\nMost goals scored in a single game by one team:\n"
psql -U "$DB_USER" -d "$DB_NAME" -At -c "
SELECT max(winner_goals)
FROM games;"

# 07
printf "\nNumber of games where the winning team scored more than two goals:\n"
psql -U "$DB_USER" -d "$DB_NAME" -At -c "
SELECT count(*)
FROM games
WHERE winner_goals > 2;"

# 08
printf "\nWinner of the 2018 tournament team name:\n"
psql -U "$DB_USER" -d "$DB_NAME" -At -c "
SELECT teams.name
FROM games JOIN teams ON games.winner_id = teams.team_id
WHERE games.year = 2018 AND games.round = 'Final';"

# 09
printf "\nList of teams who played in the 2014 'Eighth-Final' round:\n"
psql -U "$DB_USER" -d "$DB_NAME" -At -c "
WITH eighth_final (team_id) AS (
    SELECT winner_id
    FROM games
    WHERE year = 2014 AND round = 'Eighth-Final'
    UNION
    SELECT opponent_id
    FROM games
    WHERE year = 2014 AND round = 'Eighth-Final'
)
SELECT teams.name
FROM eighth_final JOIN teams USING (team_id)
ORDER BY teams.name ASC;"

# 10
printf "\nList of unique winning team names in the whole data set:\n"
psql -U "$DB_USER" -d "$DB_NAME" -At -c "
SELECT DISTINCT teams.name
FROM games JOIN teams ON games.winner_id = teams.team_id
ORDER BY teams.name ASC;"

# 11
printf "\nYear and team name of all the champions:\n"
psql -U "$DB_USER" -d "$DB_NAME" -At -c "
SELECT games.year, teams.name
FROM games JOIN teams ON games.winner_id = teams.team_id
WHERE games.round = 'Final'
ORDER BY games.year ASC;"

# 12
printf "\nList of teams that start with 'Co':\n"
psql -U "$DB_USER" -d "$DB_NAME" -At -c "
SELECT name
FROM teams
WHERE name LIKE 'Co%';"

