
curl -G 'https://api.api4com.com/api/v1/calls'   --data-urlencode 'filter={"where":{"from":"1003","duration":{"gt":60},"started_at":{"between":["2025-12-05T00:00:00.000Z","2025-12-06T23:59:59.999Z"]}}}'   --data-urlencode 'page=1'   -H "Content-Type: application/json"   -H "Authorization: $token" | jq

curl -X POST $url -H 'Content-Type: application/json' -H "Authorization: $token" -d "${data}"