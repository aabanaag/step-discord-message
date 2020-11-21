#!/bin/bash

# exit if a command fails
set -e


# CHECK PARAMETERS
if [ -z "${webhook_url}" ]; then
	echo "[!] Webhook URL is required"
	exit 1
fi

echo "$build_message"

# Send payload
res=$(curl -is -X  POST "${webhook_url}" \
--header 'Content-Type: application/json' \
--header 'Cookie: __cfduid=d0c96288565ab2538b52f8165a3fcb68b1605946859' \
--data-raw '{
		"content": "New build available",
    "embeds": [
        {
						"title": "MYCare",
						"url": "https://test.com",
						"description": "'"${build_message}"'",
            "thumbnail": {
                "url": "'"${thumbnail}"'"		
						}
				}
    ]
}')


echo "----- RESULT -----"
echo "$res"
echo "------------------"

http_code=$(echo "$res" | grep HTTP/ | awk {'print $2'} | tail -1)
echo " [i] http_code: $http_code"

if [ "$http_code" == "204" ]; then
  exit 0
else
  exit 1
fi

