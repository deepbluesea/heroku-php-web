function heroku-dir
{
    if [[ $1 == "" ]]; then
        echo /app/heroku
    else
        echo $1/heroku
    fi
}

function heroku-vendor-dir
{
    echo $(heroku-dir $2)/vendor/$1
}

function heroku-indent
{
  RE="s/^/       /"
  [ $(uname) == "Darwin" ] && sed -l "$RE" || sed -u "$RE"
}

function heroku-notice
{
  RE="s/^/-----> /"
  [ $(uname) == "Darwin" ] && sed -l "$RE" || sed -u "$RE"
}
