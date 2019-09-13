#!/bin/sh

set -ex

DIR=golang_org_x_tools
REPO=https://go.googlesource.com/tools
COMMIT=gopls/v0.1.5

rm -rf $DIR
git clone $REPO
(
	cd tools
	git checkout $COMMIT
)

mkdir $DIR
mv tools/LICENSE $DIR/LICENSE
mv tools/internal/jsonrpc2 $DIR/jsonrpc2

(
	cd tools
	echo "Packages in this directory is copied from golang.org/x/tools/internal (commit $COMMIT)."
	#git show -s --format='(commit %h on %ci).'
) > $DIR/README.txt

find $DIR -name '*.go' | xargs sed -i 's!golang.org/x/tools/internal!github.com/fhs/acme-lsp/internal/golang_org_x_tools!'

rm -rf tools
