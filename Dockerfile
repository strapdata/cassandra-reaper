ARG VERSION
FROM strapdata.azurecr.io/strapdata/cassandra-reaper:$VERSION
COPY driver-addons-6.8.4.3.jar /usr/local/lib/