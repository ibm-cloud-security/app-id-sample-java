FROM websphere-liberty:webProfile7
USER root
WORKDIR /opt/ibm/wlp/usr/servers/
COPY Liberty defaultServer/
RUN installUtility install --acceptLicense defaultServer
ARG clusterEndpoint=localhost
ENV APPID_SAMPLE_HOST $clusterEndpoint
ENV APPID_SAMPLE_SSL_PORT=30081
RUN apt-get -qq update && apt-get -qq install jq -y
ARG binding_secret={}
ENV APPID_SERVICE_BINDING $binding_secret
ARG appid_auth_server=appid-oauth.ng.bluemix.net
ENV APPID_AUTH_SERVER $appid_auth_server
EXPOSE 9080
EXPOSE 9443
ENV LICENSE accept

COPY run_binded.sh defaultServer/
RUN chmod +x /opt/ibm/wlp/usr/servers/defaultServer/run_binded.sh
CMD ["/opt/ibm/wlp/usr/servers/defaultServer/run_binded.sh"]