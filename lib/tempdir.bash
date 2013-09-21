function temp-dir-start
{
    dir=$(mktemp -t heroku-temp.XXX)
    rm -rf $dir
    mkdir -p $dir
    pushd $dir > /dev/null
}

function temp-dir-end
{
    dir=$(pwd)
    popd > /dev/null
    if [[ "${dir}" == *heroku-temp* ]]; then
        rm -rf $dir
    fi
}
