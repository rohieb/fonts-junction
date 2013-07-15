#!/bin/sh

set -e

UPSTREAM_REPO=https://github.com/theleagueof/junction.git
PACKAGE=$(dpkg-parsechangelog | sed -n 's/^Source: //p')

rm -rf orig-source

git clone "$UPSTREAM_REPO" orig-source
cd orig-source

date=$(date --utc --date="$(git log -1 --pretty=format:%cD HEAD)" "+%Y%m%d")
rev=$(git log -1 --pretty=format:"%h")
upstream_version="$date.$rev"

git archive HEAD |
	xz -c >../$PACKAGE\_$upstream_version.orig.tar.xz

cd ..
rm -rf orig-source
