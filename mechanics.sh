#!/bin/sh

function errexit {
   echo please provide a valid path to scmutils in \".basedir\"
   exit 1
}

test -r .basedir || errexit

BASE=$(cat .basedir)

test -d $BASE || errexit

exec ${BASE}/mit-scheme/bin/scheme --library ${BASE}/mit-scheme/lib --heap 10000 --band edwin-mechanics.com $*
