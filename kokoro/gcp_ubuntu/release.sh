#!/bin/bash
# Copyright 2021 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Fail on any error.
set -e
shopt -s globstar


if [[ -z "${CREDENTIALS}" ]]; then
  CREDENTIALS=${KOKORO_KEYSTORE_DIR}/73713_docuploader_service_account
fi

if [[ -z "${STAGING_BUCKET_V2}" ]]; then
  echo "Need to set STAGING_BUCKET_V2 environment variable"
  STAGING_BUCKET_V=
  # exit 1
fi

src_dir="${KOKORO_ARTIFACTS_DIR}/git/appengine-java-standard"
cd $src_dir

# Make sure `JAVA_HOME` is set.
echo "JAVA_HOME = $JAVA_HOME"
curl -fsSL --retry 10 -o /tmp/jar1.jar https://github.com/googleapis/java-docfx-doclet/releases/download/1.5.0/java-docfx-doclet-1.5.0-jar-with-dependencies.jar
curl -fsSL --retry 10 -o /tmp/jar2.jar https://github.com/googleapis/java-docfx-doclet/releases/download/1.5.0/java-docfx-doclet-1.5.0.jar
# install docuploader package
python3 -m pip install gcp-docuploader

# compile all packages
./mvnw clean install -B -q -DskipTests=true

export NAME={{ metadata['repo']['distribution_name'].split(':')|last }}
export VERSION=$(grep ${NAME}: versions.txt | cut -d: -f3)

# cloud RAD generation
cd api
../mwnw javadoc:aggregate -B -q -P docFX -DdocletPath=/tmp/jar1.jar:/tmp/jar2.jar

# include CHANGELOG
#cp CHANGELOG.md target/docfx-yml/history.md

pushd target/docfx-yml

# create metadata
python3 -m docuploader create-metadata \
 --name ${NAME} \
 --version ${VERSION} \
 --language java

# upload yml to production bucket
python3 -m docuploader upload . \
 --credentials ${CREDENTIALS} \
 --staging-bucket ${STAGING_BUCKET_V2} \
 --destination-prefix docfx
 
echo "Done doing a release."

