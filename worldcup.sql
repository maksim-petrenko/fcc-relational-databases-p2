-- https://www.freecodecamp.org/
-- Curriculum: Relational Databases Certification
-- Project: Build a World Cup Database
-- Copyright (C) 2026 Maksim Petrenko


-- SCHEMA ----------------------------------------------------------------------

DROP TABLE IF EXISTS games;
DROP TABLE IF EXISTS teams;

-- teams
CREATE TABLE teams (
    team_id INTEGER     NOT NULL,
    name    VARCHAR(20) NOT NULL,
    -- constraints
    PRIMARY KEY (team_id),
    UNIQUE (name)
);

-- games
CREATE TABLE games (
    game_id        INTEGER     NOT NULL,
    year           INTEGER     NOT NULL,
    round          VARCHAR(20) NOT NULL, -- name matches with "round" function
    winner_id      INTEGER     NOT NULL,
    opponent_id    INTEGER     NOT NULL,
    winner_goals   INTEGER     NOT NULL,
    opponent_goals INTEGER     NOT NULL,
    -- constraints
    PRIMARY KEY (game_id),
    FOREIGN KEY (winner_id) REFERENCES teams (team_id),
    FOREIGN KEY (opponent_id) REFERENCES teams (team_id)
);

