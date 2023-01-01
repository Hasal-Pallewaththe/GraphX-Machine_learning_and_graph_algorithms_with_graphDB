// neo4j graph database for Audit procedure
// using Cypher Query Language

//...................... remove previous data .........................................................................
MATCH (n) DETACH DELETE n;


//.................... Data Loading from CSV ............................................................................

LOAD CSV WITH HEADERS FROM 'file:///netflix_titles_restruct.csv' AS csvLine
WITH csvLine WHERE csvLine.type = 'Movie'
MERGE (M: Movie {title: csvLine.title, description: csvLine.description});

LOAD CSV WITH HEADERS FROM 'file:///netflix_titles_restruct.csv' AS csvLine
WITH csvLine WHERE csvLine.type = 'TV Show'
MERGE (T: TVShow {title: csvLine.title, description: csvLine.description});

LOAD CSV WITH HEADERS FROM 'file:///netflix_titles_restruct.csv' AS csvLine
MERGE (R: Rating {rating: csvLine.rating});

LOAD CSV WITH HEADERS FROM 'file:///netflix_titles_restruct.csv' AS csvLine
WITH csvLine WHERE csvLine.type = 'Movie'
MATCH (M: Movie {title: csvLine.title})
MATCH (R: Rating {rating: csvLine.rating})
MERGE (M)-[:HAS_RATING]->(R)
MERGE (R)-[:HAS_MOVIE]->(M);


LOAD CSV WITH HEADERS FROM 'file:///netflix_titles_restruct.csv' AS csvLine
WITH csvLine WHERE csvLine.type = 'TV Show'
MATCH (T: TVShow {title: csvLine.title})
MATCH (R: Rating {rating: csvLine.rating})
MERGE (T)-[:HAS_RATING]->(R)
MERGE (R)-[:HAS_SERIES]->(T);

LOAD CSV WITH HEADERS FROM 'file:///netflix_titles_restruct.csv' AS csvLine
MERGE (LS: Listed {listed_in: csvLine.listed_in});

LOAD CSV WITH HEADERS FROM 'file:///netflix_titles_restruct.csv' AS csvLine
MERGE (DIR: Director {listed_in: csvLine.director});


LOAD CSV WITH HEADERS FROM 'file:///netflix_titles_restruct.csv' AS csvLine
WITH csvLine WHERE csvLine.type = 'Movie'
MATCH (M: Movie {title: csvLine.title})
MATCH (LS: Listed {listed_in: csvLine.listed_in})
MERGE (M)-[:HAS_LISTED]->(LS)
MERGE (LS)-[:HAS_MOVIE]->(M);


LOAD CSV WITH HEADERS FROM 'file:///netflix_titles_restruct.csv' AS csvLine
WITH csvLine WHERE csvLine.type = 'TV Show'
MATCH (T: TVShow {title: csvLine.title})
MATCH (LS: Listed {listed_in: csvLine.listed_in})
MERGE (T)-[:HAS_LISTED]->(LS)
MERGE (LS)-[:HAS_SERIES]->(T);
