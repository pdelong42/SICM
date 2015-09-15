#!/bin/sh

function errexit {
   echo 'please provide a valid path to scmutils in ".basedir"'
   exit 1
}

test -r .basedir || errexit

BASE=$(cat .basedir)

test -d $BASE || errexit

if ! command -v xdvi > /dev/null ; then
   echo 'WARNING: could not find "xdvi" - equation display will not function'
fi

if command -v rlwrap > /dev/null ; then
   READLINE="rlwrap -r -c -f scheme_completion.txt"
else
   READLINE=""
fi

exec $READLINE ${BASE}/mit-scheme/bin/scheme --library ${BASE}/mit-scheme/lib --heap 12000 --band edwin-mechanics.com $*
