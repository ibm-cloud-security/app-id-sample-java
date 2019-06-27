#!/bin/sh
export APPID_AUTH_SERVER=$(echo $APPID_SERVICE_BINDING | jq .oauthServerUrl -r)
echo APPID_AUTH_SERVER=$APPID_AUTH_SERVER >> defaultServer/bootstrap.properties
echo APPID_AUTH_SERVER_ISSUER=$(echo $APPID_AUTH_SERVER | awk -F 'https:\/\/|\/oauth' '{print $2}') >> defaultServer/bootstrap.properties
echo APPID_CLIENT_ID=$(echo $APPID_SERVICE_BINDING | jq .clientId -r) >> defaultServer/bootstrap.properties
echo APPID_CLIENT_SECRET=$(echo $APPID_SERVICE_BINDING | jq .secret -r) >> defaultServer/bootstrap.properties
echo APPID_TENANT_ID=$(echo $APPID_SERVICE_BINDING | jq .tenantId -r) >> defaultServer/bootstrap.properties

/opt/ibm/wlp/bin/server run defaultServer