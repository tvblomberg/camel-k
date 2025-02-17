#!/bin/sh

# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -e

location=$(dirname $0)
rootdir=$location/..

GO111MODULE=on

echo "Generating Go client code for Strimzi addon..."

cd $rootdir

$(go env GOPATH)/bin/client-gen \
  -h script/headers/default.txt \
  --input duck/v1beta2 \
  --input-base=github.com/apache/camel-k/addons/strimzi \
  --output-base=. \
  --output-package=github.com/apache/camel-k/addons/strimzi/duck/client

rm -r ./addons/strimzi/duck/client || true

mv github.com/apache/camel-k/addons/strimzi/duck/client ./addons/strimzi/duck/

rm -r ./github.com
