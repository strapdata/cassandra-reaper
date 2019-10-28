#!/bin/bash
# Copyright 2017-2018 The Last Pickle Ltd
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

echo "Starting Before Deploy step..."

set -xe

mvn -pl src/server/ docker:build  -Ddocker.directory=src/server/src/main/docker
echo "Publish to strapdata registry"
docker tag cassandra-reaper:latest docker.repo.strapdata.com/strapdata/cassandra-reaper:latest
docker tag cassandra-reaper:latest docker.repo.strapdata.com/strapdata/cassandra-reaper:${TRAVIS_TAG}
docker push docker.repo.strapdata.com/strapdata/cassandra-reaper:latest
docker push docker.repo.strapdata.com/strapdata/cassandra-reaper:${TRAVIS_TAG}

echo "Publish to gcr.io registry"
docker tag cassandra-reaper:latest gcr.io/strapdata-gcp-partnership/cassandra-reaper:${TRAVIS_TAG}
docker push gcr.io/strapdata-gcp-partnership/cassandra-reaper:${TRAVIS_TAG}