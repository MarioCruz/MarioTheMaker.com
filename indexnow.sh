#!/bin/bash
# Submit one or more mariothemaker.com URLs to IndexNow (Bing/Yandex/Seznam/Naver).
# Google does NOT participate in IndexNow — it picks up changes via sitemap.xml
# plus a manual "Request Indexing" in Search Console.
#
# Usage:
#   ./indexnow.sh posts/tomy-omnibot-restoration-part-5.html
#   ./indexnow.sh /                       # homepage
#   ./indexnow.sh https://mariothemaker.com/about.html posts/foo.html
#
# Accepts bare paths (with or without leading slash) or full https URLs.

set -euo pipefail

HOST="mariothemaker.com"
KEY="7ffadb6ae4bfb10a9cdedbe69b3af63d"
KEY_LOCATION="https://${HOST}/${KEY}.txt"
ENDPOINT="https://api.indexnow.org/indexnow"

if [ "$#" -eq 0 ]; then
  echo "Usage: ./indexnow.sh <url-or-path> [more...]" >&2
  echo "Example: ./indexnow.sh posts/tomy-omnibot-restoration-part-5.html" >&2
  exit 1
fi

# Normalize each argument into a full https://mariothemaker.com/... URL.
urls=()
for arg in "$@"; do
  case "$arg" in
    https://${HOST}/*) url="$arg" ;;
    http://${HOST}/*)  url="https://${arg#http://}" ;;
    /)                 url="https://${HOST}/" ;;
    /*)                url="https://${HOST}${arg}" ;;
    *)                 url="https://${HOST}/${arg}" ;;
  esac
  urls+=("$url")
done

# Build the JSON urlList.
url_json=""
for u in "${urls[@]}"; do
  [ -n "$url_json" ] && url_json+=","
  url_json+=$'\n    '"\"${u}\""
done

BODY=$(cat <<JSON
{
  "host": "${HOST}",
  "key": "${KEY}",
  "keyLocation": "${KEY_LOCATION}",
  "urlList": [${url_json}
  ]
}
JSON
)

echo "Submitting ${#urls[@]} URL(s) to IndexNow:"
printf '  %s\n' "${urls[@]}"

code=$(curl -s -o /tmp/indexnow_resp.txt -w "%{http_code}" -X POST "$ENDPOINT" \
  -H "Content-Type: application/json; charset=utf-8" \
  -d "$BODY")

echo "Response: HTTP ${code}"
case "$code" in
  200|202) echo "Accepted. Bing/Yandex/Seznam/Naver will crawl within ~24-48h." ;;
  *) echo "Problem — response body:"; cat /tmp/indexnow_resp.txt; echo; exit 1 ;;
esac

echo "Reminder: Google is not notified. For Google, the sitemap is automatic;"
echo "use GSC 'Request Indexing' for top pages if you want to accelerate."
