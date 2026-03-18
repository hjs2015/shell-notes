#!/bin/bash

rm -rf /tmp/index/
mkdir /tmp/index/ -p

a=1
for i in `find /usr/share/doc/ -name "index.html"`
do
	cp $i /tmp/index/index.html.$a
	let a++
done
