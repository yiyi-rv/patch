#!/bin/bash
set -x 

json_out=`pwd`/errors.json
report_out=`pwd`/report
rm -rf $json_out
rm -rf $report_out

apt install -y automake autoconf gettext gzip m4 tar wget pkg-config bison

./bootstrap
./configure CC=kcc LD=kcc CFLAGS="-fissue-report=$json_out"
make
make check

touch $json_out && rv-html-report $json_out -o $report_out
rv-upload-report $report_out
