#!/bin/bash

# Install the necessary files

mvn clean install
mvn liberty:start-server

# Copy Liberty War file and server.xml file into sample server

cp ../Liberty/server.xml target/liberty/wlp/usr/servers/sample
cp ../Liberty/mytruststore.jks target/liberty/wlp/usr/servers/sample
cp ../Liberty/apps/libertySample-1.0.0.war target/liberty/wlp/usr/servers/sample/apps 

# Run the OICD installer

./target/liberty/wlp/bin/installUtility install openidconnectclient-1.0 --acceptLicense 

# Delete existing key.jks file and create new key.jks file

rm target/liberty/wlp/usr/servers/sample/resources/security/key.p12
./target/liberty/wlp/bin/securityUtility createSSLCertificate --server=sample --password=myPassword

# Restart Liberty server

mvn liberty:stop-server
mvn liberty:start-server
