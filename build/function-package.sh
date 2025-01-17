#!/usr/bin/env bash
#     Copyright 2022 Dynatrace LLC
#
#     Licensed under the Apache License, Version 2.0 (the "License");
#     you may not use this file except in compliance with the License.
#     You may obtain a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#     Unless required by applicable law or agreed to in writing, software
#     distributed under the License is distributed on an "AS IS" BASIS,
#     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#     See the License for the specific language governing permissions and
#     limitations under the License.
set -e

mkdir -p artefacts
rm -f ./artefacts/function-deployment-package.zip
rm -f ./artefacts/dynatrace-gcp-function.zip
(cd ./src/; zip -r ../artefacts/dynatrace-gcp-function.zip ./ -x '*__pycache__*')
sed -i "s/^GCP_FUNCTION_RELEASE_VERSION=.*/GCP_FUNCTION_RELEASE_VERSION='$TRAVIS_TAG'/" scripts/setup.sh
zip -r ./artefacts/function-deployment-package.zip ./ext_tools/
zip -j ./artefacts/function-deployment-package.zip ./scripts/lib.sh ./scripts/setup.sh ./scripts/uninstall.sh ./activation-config.yaml ./src/version.txt
