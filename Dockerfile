FROM neo4j:latest

# ENV NEO4J_HOME="/var/lib/neo4j"
# ENV NEO4J_AUTH=neo4j/neo4jtestdb

# COPY ./database.cypher /var/lib/neo4j/db_init/database.cypher
# COPY ./apoc.conf /var/lib/neo4j/conf/apoc.conf
COPY import/neo4j-db1.dump /var/lib/neo4j/import/neo4j-db1.dump
COPY data/netflix_titles/netflix_titles.csv /var/lib/neo4j/import/netflix_titles.csv
COPY start.sh /var/lib/neo4j/bin/start.sh

CMD bash /var/lib/neo4j/bin/start.sh
