S3_BUCKET="heroku.icecave"
S3_ACCESS_ID="AKIAIU2SXEXVSYVEYRDQ"

function s3-upload
{
    local source=$1
    local target=$2
    local password=$3

    local policy_source="
    {
        \"expiration\": \"2020-01-01T00:00:00.000Z\",
        \"conditions\": [
            {\"bucket\": \"${S3_BUCKET}\" },
            {\"acl\": \"public-read\" },
            {\"key\": \"$target\" }
        ]
    }
    "

    local policy="$(echo -n ${policy_source} | base64)"
    local signature="$(echo -n ${policy} | openssl dgst -sha1 -binary -hmac ${password} | base64)"

    curl "http://${S3_BUCKET}.s3.amazonaws.com" \
        -F "AWSAccessKeyId=${S3_ACCESS_ID}" \
        -F "policy=${policy}" \
        -F "signature=${signature}" \
        -F "acl=public-read" \
        -F "key=${target}" \
        -F "file=@${source}"
}

function s3-download
{
    local package=$1
    local version=$2
    local path=$3
    local url="http://${S3_BUCKET}.s3.amazonaws.com/${package}-${version}.tar.gz"

    url-download $url $path
}
