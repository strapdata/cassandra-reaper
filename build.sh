VERSION=$(mvn help:evaluate -Dexpression=project.version -q -DforceStdout)
mvn clean package -DskipTests
mvn -pl src/server/ docker:build -Ddocker.directory=src/server/src/main/docker
docker tag cassandra-reaper strapdata.azurecr.io/strapdata/cassandra-reaper:$VERSION

cp ~/.m2/repository/com/strapdata/strapkop/driver-addons/6.8.4.3/driver-addons-6.8.4.3.jar .
docker build --build-arg VERSION=$VERSION --tag strapdata.azurecr.io/strapdata/cassandra-reaper:$VERSION-strapdata .
docker push strapdata.azurecr.io/strapdata/cassandra-reaper:$VERSION-strapdata