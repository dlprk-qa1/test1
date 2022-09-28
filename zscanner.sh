#!/bin/bash
echo "token started"
platform="Darwin"
arch="x86_64"
token_url="https://z-cwp-int.us.auth0.com/oauth/token"
clientId="2DhqYXRxZHcyUvXvfweeaIk2W8zHmSO7"
clientSecret="SwxEsUE2bWDEx5mFntPE90gHoShXGUAC34mGpVhsaNf3zMC0ITmx9RajTEcWKN5b"
downloadurl="https://int.api.zscwp.io/iac/onboarding/v1/cli/download?version=e101670&platform=$platform&arch=$arch"
api_host="https://int.api.zscwp.io"
auth0_host="https://z-cwp-int.us.auth0.com"
clientConfigId="qdtlYwvGB6HPDj1l93KxfyHU331YDJMF"
abc=$(curl --location --request POST $token_url --header 'Content-Type: application/json'\
      --data-raw '{ "audience" : "https://api.zscwp.io/iac", \
                    "grant_type" : "client_credentials",\
                    "client_id" : clientId,\
                    "client_secret" : clientSecret}')
regex_hint=access_token
[[ $abc =~ $regex_hint\":\"(.+)\",\"expires_in\" ]]
token=${BASH_REMATCH[1]}
$(curl --location --request GET $downloadurl \
--header "Authorization: Bearer $token" \
--header 'Content-Type: application/json' \
--output zscanner_binary.tar.gz)
$(tar -xf zscanner_binary.tar.gz)
$(sudo install zscanner /usr/local/bin && rm zscanner)
zscanner version
zscanner config list -a
zscanner config add -k custom_region -v "{\"host\":\"$api_host\",\"auth\":{\"host\":\"\",\"clientId\":\"$clientConfigId\",\"scope\":\"offline_access profile\",\"audience\":\"https://api.zscwp.io/iac\"}}"
zscanner config list -a
zscanner logout
checkLogin=`zscanner login cc --client-id $clientId --client-secret $clientSecret -r CUSTOM`
loginString='Logged in as system'
if [ "$checkLogin" == "$loginString" ]
then
  echo "successfully login to system"
else
  echo "Failed to login to system"
fi
zscanner scan -d .
if [ $? == 0 ]
then
  echo "Scan passed and no violations"
else
  echo "Scan Violations reported"
  exit 1
fi
