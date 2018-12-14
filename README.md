# IBM Cloud App ID
Java Liberty Sample App for the IBM Cloud App ID service. You can either run the application locally or in IBM Cloud.

[![](https://img.shields.io/badge/ibm%20cloud-powered-blue.svg)](https://www.ibm.com/cloud/)
[![](https://img.shields.io/badge/platform-java-lightgrey.svg?style=flat)](https://developer.java.com/index.html)
[![Codacy][img-codacy]][url-codacy]
[![Version][img-version]][url-repo]
[![DownloadsMonthly][img-downloads-monthly]][url-repo]
[![DownloadsTotal][img-downloads-total]][url-repo]
[![License][img-license]][url-repo]

[![GithubWatch][img-github-watchers]][url-github-watchers]
[![GithubStars][img-github-stars]][url-github-stars]
[![GithubForks][img-github-forks]][url-github-forks]

## Table of Contents
* [Contents](#contents)
* [Requirements](#requirements)
* [Running Locally](#running-locally)
* [Running in IBM Cloud](#running-in-ibm-cloud)
* [Clarification](#clarification)
* [License](#license)

## Contents



## Requirements
* Java 8.x
* [Maven](https://maven.apache.org/download.cgi)

## Running Locally

Navigate to the WebApplication directory and run the following command:
```bash
./finalize.sh
```
Use the link http://localhost:9080/appidSample to load the web application in browser.

## Running in IBM Cloud

### Prerequisites
Before you begin, make sure that IBM Cloud CLI is installed.
For more information visit: https://console.bluemix.net/docs/cli/reference/bluemix_cli/get_started.html#getting-started.

### Deployment

**Important:** Before going live, remove https://localhost:9443/* from the list of web redirect URLs located in "Identity Providers" -> "Manage" page in the AppID dashboard.

1. Navigate to the WebApplication directory.

2. Generate your ‘war’ file and upload it using the following command:

  `mvn clean install`

3. Navigate to the Liberty directory.

4. Login to IBM Cloud.

  `bx login https://api.{{domain}}`

5. Target a Cloud Foundry organization and space in which you have at least Developer role access:

  Use `bx target --cf` to target Cloud Foundry org/space interactively.

6. Bind the sample app to the instance of App ID:

  `bx resource service-alias-create "appIDInstanceName-alias" --instance-name "appIDInstanceName" -s {{space}}`

7. Deploy the sample application to IBM Cloud.

  `bx app push`

8. Open your IBM Cloud app route in the browser.

## Clarification
This sample runs on one instance and uses the session to store the authorization data.
In order to run it in production mode, use services such as Redis to store the relevant data.

## License

Copyright (c) 2018 IBM Corporation

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
