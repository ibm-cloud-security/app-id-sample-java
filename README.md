# IBM Cloud App ID
Java Liberty Sample App Template for the IBM Cloud App ID service. The App ID Dashboard overwrites the Liberty/manifest.yml and Liberty/server.xml files with the user's information when they download a Java sample app. When downloaded, you can either run the application locally or in IBM Cloud.

[![IBM Cloud powered][img-ibmcloud-powered]][url-ibmcloud]
[![Java Badge][img-java-badge]][url-java-badge]
[![Travis][img-travis-master]][url-travis-master]
[![Coveralls][img-coveralls-master]][url-coveralls-master]
[![Codacy][img-codacy]][url-codacy]

[![GithubWatch][img-github-watchers]][url-github-watchers]
[![GithubStars][img-github-stars]][url-github-stars]
[![GithubForks][img-github-forks]][url-github-forks]

## Table of Contents
<!---
* [Contents](#contents)
-->
* [Requirements](#requirements)
* [Running Locally](#running-locally)
* [Running in IBM Cloud](#running-in-ibm-cloud)
* [License](#license)

<!---
## Contents
-->

## Requirements
* Java 8.x
* [Maven](https://maven.apache.org/download.cgi)

## Running Locally

Navigate to the WebApplication directory and run the following command:
```bash
./run_locally.sh
```
Use the link https://localhost:9443/appidSample to load the web application in browser. 

*Note:* You will get a warning that the connection is not secure, this happens because this sample application does not have a proper certificate. Click Proceed to localhost to continue.

## Running in Cloud Foundry

### Prerequisites
Before you begin, make sure that IBM Cloud CLI is installed.
For more information visit: https://cloud.ibm.com/docs/cli/reference/ibmcloud_cli?topic=cloud-cli-ibmcloud-cli.

### Deployment

**Important:** Before going live, remove https://localhost:9443/* from the list of web redirect URLs located in "Identity Providers" -> "Manage" page in the AppID dashboard.

1. Navigate to the WebApplication directory.

2. Generate your ‘war’ file and upload it using the following command:

    `mvn clean install`

3. Navigate to the Liberty directory.

4. Login to IBM Cloud.

    `ibmcloud login -a https://api.{{domain}}`

5. Target a Cloud Foundry organization and space in which you have at least Developer role access:

    Use `ibmcloud target --cf` to target Cloud Foundry org/space interactively.

6. Bind the sample app to the instance of App ID:

    `ibmcloud resource service-alias-create "appIDInstanceName-alias" --instance-name "appIDInstanceName" -s {{space}}`
    
7. Add the alias to the manifest.yml file in the sample app.

   ```
   applications:
        - name: [app-instance-name]
        memory: 256M
        services:
        - appIDInstanceName-alias
   ```

8. Deploy the sample application to IBM Cloud.

    `ibmcloud app push`
    
9. Now configure the OAuth redirect URL at the App ID dashboard so it will approve redirecting to your app. Go to your App ID instance at [IBM Cloud console](https://cloud.ibm.com/resources) and under Manage Authentication->Authentication Settings->Add web redirect URLs add the following URL:

   `https://{App Domain}/oidcclient/redirect/MyRP`
   
   You find your app's domain by visiting Cloud Foundry Apps at the IBM Cloud dashboard: https://cloud.ibm.com/resources.

10. Open your IBM Cloud app route in the browser. To access your app go to `https://{App Domain}/appidSample`.

## Running in Kubernetes

### Prerequisites
Before you begin make sure that IBM Cloud CLI, docker and kubectl installed and that you have a running kubernetes cluster.
You also need an IBM Cloud container registry namespace (see https://cloud.ibm.com/kubernetes/registry/main/start). You can find your registry domain and repository namespace using `ibmcloud cr namespaces`.

### Deployment

**Important:** Before going live, remove https://localhost:9443/* from the list of web redirect URLs located in "Identity Providers" -> "Manage" page in the AppID dashboard.

**Note:** Your App ID instance name must consist of lower case alphanumeric characters, '-' or '.', and must start and end with an alphanumeric character. You can visit the App ID dashboard to change your instance name. 
 
1. Navigate to the WebApplication directory, and do:

    `mvn clean install`

2. Login to IBM Cloud:

    `ibmcloud login`

3. Run the following command, it will output an export command.

    `ibmcloud cs cluster-config {CLUSTER_NAME}`
    
4. Set the KUBECONFIG environment variable. Copy the output from the previous command and paste it in your terminal. The command output looks similar to the following example:
   
    `export KUBECONFIG=/Users/$USER/.bluemix/plugins/container-service/clusters/mycluster/kube-config-hou02-mycluster.yml`

5. Bind the instance of App ID to your cluster.

    `ibmcloud cs cluster-service-bind {CLUSTER_NAME} default {APP_ID_INSTANCE_NAME}`

6. Find your cluster's public endpoint {CLUSTER_ENDPOINT}.
   
   Note: If you are using the free version of kubernetes (with only 1 worker node) you can use your node's public IP instead, which you can find using:

    `ibmcloud cs workers {CLUSTER_NAME}`

7. Edit the appid-liberty-sample.yml file. 
    1. Edit the image field of the deployment section to match your image name (the name of your image should be `{REGISTRY_DOMAIN}/{REPOSITORY_NAMESPACE}/appid-liberty:{APP_VERSION}`). 
    2. Edit the Binding name field to match yours (it should be `binding-{APP_ID_INSTANCE_NAME}`).
    3. Optional: Change the value of metadata.namespace from default to your cluster namespace if you’re using a different namespace.

9. Build your Docker image. In an IBM Cloud Container Service Lite Cluster, we have to create the services with Node ports that have non standard http and https ports in the 30000-32767 range. In this example we chose http to be exposed at port 30080 and https at port 30081.

    `docker build -t {REGISTRY_DOMAIN}/{REPOSITORY_NAMESPACE}/appid-liberty:{APP_VERSION} . --no-cache --build-arg clusterEndpoint={CLUSTER_ENDPOINT}`

10. Push the image.

    `docker push {REGISTRY_DOMAIN}/{REPOSITORY_NAMESPACE}/appid-liberty:{APP_VERSION}`

    `kubectl apply -f appid-liberty-sample.yml`

   Note: If you get an 'unauthorized' error during the push command, do `ibmcloud cr login` and try again.

11. Now configure the OAuth redirect URL at the App ID dashboard so it will approve redirecting to your cluster. Go to your App ID instance at [IBM Cloud console](https://cloud.ibm.com/resources) and under Manage Authentication->Authentication Settings->Add web redirect URLs add the following URL:

   `https://{CLUSTER_ENDPOINT}:30081/oidcclient/redirect/MyRP`

12. Give the server a minute to get up and running and then you’ll be able to see your sample running on Kubernetes in IBM Cloud.

    `open http://{CLUSTER_ENDPOINT}:30080/appidSample`
    
## See More
#### Protecting Liberty Java Web Applications with IBM Cloud App ID
https://www.youtube.com/watch?v=o_Er69YUsMQ&t=877s

## Got Questions?
Join us on [Slack](https://www.ibm.com/cloud/blog/announcements/get-help-with-ibm-cloud-app-id-related-questions-on-slack) and chat with our dev team.

## License

Copyright (c) 2019 IBM Corporation

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

[img-ibmcloud-powered]: https://img.shields.io/badge/ibm%20cloud-powered-blue.svg
[url-ibmcloud]: https://www.ibm.com/cloud/

[img-java-badge]: https://img.shields.io/badge/platform-java-lightgrey.svg?style=flat
[url-java-badge]: https://developer.java.com/index.html

[img-travis-master]: https://travis-ci.org/ibm-cloud-security/app-id-sample-java.svg?branch=master
[url-travis-master]: https://travis-ci.org/ibm-cloud-security/app-id-sample-java?branch=master

[img-coveralls-master]: https://coveralls.io/repos/github/ibm-cloud-security/app-id-sample-java/badge.svg
[url-coveralls-master]: https://coveralls.io/github/ibm-cloud-security/app-id-sample-java

[img-codacy]: https://api.codacy.com/project/badge/Grade/435ead3215584ffc9e530d504e240fca
[url-codacy]: https://www.codacy.com/app/ibm-cloud-security/app-id-sample-java

[img-github-watchers]: https://img.shields.io/github/watchers/ibm-cloud-security/app-id-sample-java.svg?style=social&label=Watch
[url-github-watchers]: https://github.com/ibm-cloud-security/app-id-sample-java/watchers
[img-github-stars]: https://img.shields.io/github/stars/ibm-cloud-security/app-id-sample-java.svg?style=social&label=Star
[url-github-stars]: https://github.com/ibm-cloud-security/app-id-sample-java/stargazers
[img-github-forks]: https://img.shields.io/github/forks/ibm-cloud-security/app-id-sample-java.svg?style=social&label=Fork
[url-github-forks]: https://github.com/ibm-cloud-security/app-id-sample-java/network
