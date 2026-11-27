-- Active: 1790189759050@@127.0.0.1@5432@steam
\set ON_ERROR_STOP on
\encoding UTF8

CREATE SCHEMA IF NOT EXISTS bronze;
DROP TABLE IF EXISTS bronze.games, bronze.users, bronze.recommendations CASCADE;

CREATE TABLE bronze.games (
    app_id text,
    title text, 
    date_release text, 
    win text,
    mac text, 
    linux text,
    rating text, 
    positive_ratio text, 
    user_reviews text, 
    price_final text,
    price_original text, 
    discount text, 
    steam_deck text
);

CREATE TABLE bronze.users (
    user_id text, 
    products text, 
    reviews text
);

CREATE TABLE bronze.recommendations (
    app_id text, 
    helpful text, 
    funny text, 
    date text,
    is_recommended text, 
    hours text, 
    user_id text, 
    review_id text
);

\copy bronze.games FROM 'ingestion/data/games_sample.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8')
\copy bronze.users FROM 'ingestion/data/users_sample.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8')
\copy bronze.recommendations FROM 'ingestion/data/recommendations_sample.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8') 