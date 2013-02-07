function url-download
{
    local url=$1
    local path=$2

    mkdir -p $path > /dev/null
    pushd $path > /dev/null
    curl -s --max-time 90 --location $url | tar xz
    popd > /dev/null
}
