<!--
 Copyright 2021 Google LLC

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

     https://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
-->
[![Java8](https://github.com/GoogleCloudPlatform/appengine-java-standard/actions/workflows/maven_java8.yml/badge.svg)](https://github.com/GoogleCloudPlatform/appengine-java-standard/actions/workflows/maven_java8.yml)
[![Java11](https://github.com/GoogleCloudPlatform/appengine-java-standard/actions/workflows/maven_java11.yml/badge.svg)](https://github.com/GoogleCloudPlatform/appengine-java-standard/actions/workflows/maven_java11.yml)
[![Java17](https://github.com/GoogleCloudPlatform/appengine-java-standard/actions/workflows/maven_java17.yml/badge.svg)](https://github.com/GoogleCloudPlatform/appengine-java-standard/actions/workflows/maven_java17.yml)
[![Maven][maven-version-image]][maven-version-link]

# Google App Engine Standard Environment Source Code for Java 8, Java 11 and Java 17.


This repository contains the Java Source Code for [Google App Engine
standard environment][ae-docs], the production runtime, the AppEngine APIs, and the local SDK.

[ae-docs]: https://cloud.google.com/appengine/docs/standard/java

## Prerequisites

### Download Maven

The source code use the [Apache Maven][maven] build system. Before getting
started, be sure to [download][maven-download] and [install][maven-install] it.
When you use Maven as described here, it will automatically download the needed
client libraries.

[maven]: https://maven.apache.org
[maven-download]: https://maven.apache.org/download.cgi
[maven-install]: https://maven.apache.org/install.html

### Use a JDK8 environment so it can build the Java8 GAE runtime.

[jdk8](https://adoptium.net/)

The shared code base is also used for Java11 and Jav17 build and test targets, using github actions:

- [Java8 Continuous Integration](https://github.com/GoogleCloudPlatform/appengine-java-standard/actions/workflows/maven_java8.yml)
- [Java11 Continuous Integration](https://github.com/GoogleCloudPlatform/appengine-java-standard/actions/workflows/maven_java11.yml)
- [Java17 Continuous Integration](https://github.com/GoogleCloudPlatform/appengine-java-standard/actions/workflows/maven_java17.yml)

## Modules

Orange items are public modules artifacts and yellow are internal ones.
Modules ending with * are only used on the production server side.

<img width="964" alt="pom_dependencies" src="https://github.com/GoogleCloudPlatform/appengine-java-standard/blob/main/pom%20dependencies.png">

### App Engine Java APIs

Source code for all public APIs for com.google.appengine.api.* packages.

- [Documentation][ae-docs]
- [Javadocs](https://cloud.google.com/appengine/docs/standard/java/javadoc)
- [Code](https://github.com/GoogleCloudPlatform/appengine-java-standard/tree/master/api)
- [Code for repackaged API jar](https://github.com/GoogleCloudPlatform/appengine-java-standard/tree/master/appengine-api-1.0-sdk)


#### User Visible Changes With Maven Builds
- Moved com.google.appengine.api.memcache.stdimpl and its dependancy
  javax.cache from appengine-api-1.0-sdk.jar to 
  appengine-api-legacy.jar. Users who depend on the
  moved classes will need to include appengine-api-legacy.jar when
  they build/deploy. Separating these classes allows
  appengine-api-1.0-sdk users to choose any version of javax.cache
  rather than being constrained by an obsolete included version.

### App Engine Java local development implementation of the APIs

Implementation of all the App Engine APIs for local environment (devappserver)
and local testing of an application before deployment.

- [Documentation][ae-docs]
- [Code](https://github.com/GoogleCloudPlatform/appengine-java-standard/tree/master/api_dev)
- [Code for repackaged APIs stubs jar](https://github.com/GoogleCloudPlatform/appengine-java-standard/tree/master/appengine-api-stubs)


### App Engine Java Remote APIs

Source code for remote APIs for App Engine.

- [Public Documentation](https://cloud.google.com/appengine/docs/standard/java/tools/remoteapi)
- [Code](https://github.com/GoogleCloudPlatform/appengine-java-standard/tree/master/remoteapi)

### App Engine Java various local development utilities and devappserver

Source code for the App Engine local dev application server and local utilities.

- [Public Documentation](https://cloud.google.com/appengine/docs/standard/java/tools/using-local-server)
- [Code for tools APIs (appcfg)](https://github.com/GoogleCloudPlatform/appengine-java-standard/tree/master/lib/tools_api)
- [Code for XML validator (appcfg)](https://github.com/GoogleCloudPlatform/appengine-java-standard/tree/master/lib/xml_validator)
- [Code for shared utilities (appcfg)](https://github.com/GoogleCloudPlatform/appengine-java-standard/tree/master/shared_sdk)
- [Code for shared utilities (config)](https://github.com/GoogleCloudPlatform/appengine-java-standard/tree/master/utils)
- [Code for local devappserver](https://github.com/GoogleCloudPlatform/appengine-java-standard/tree/master/runtime/local)

### App Engine Java production runtime execution environment

Source code for the App Engine production application server and utilities. It is based on the Jetty9.4 Web Server.

- [Documentation][ae-docs]
- [Code for the runtime implementation](https://github.com/GoogleCloudPlatform/appengine-java-standard/tree/master/runtime/impl)
- [Code for the Java Main](https://github.com/GoogleCloudPlatform/appengine-java-standard/tree/master/runtime/main)
- [End to End test Applications](https://github.com/GoogleCloudPlatform/appengine-java-standard/tree/master/runtime/testapps)
- [End to End tests](https://github.com/GoogleCloudPlatform/appengine-java-standard/tree/master/runtime/test)
- [Code for runtime utilities](https://github.com/GoogleCloudPlatform/appengine-java-standard/tree/master/runtime/util)

## Contributing

Check out the [contributing guide](CONTRIBUTING.md) to learn how you can report issues and help make changes.

Always be sure to follow the [Code of Conduct](CODE_OF_CONDUCT.md).

[maven-version-image]: https://img.shields.io/maven-central/v/com.google.appengine/appengine-api-1.0-sdk.svg
[maven-version-link]: https://search.maven.org/search?q=g:com.google.appengine%20AND%20a:appengine-api-1.0-sdk&core=gav

