#!/usr/bin/env bash
#make the directory to put the binaries
mkdir $HOME/public/package
#copy the binaries and flatten into the directory above
cp `find -L $HOME/../deps/0/ -type f | awk -F/ '{a[$NF]=$0}END{for(i in a)print a[i]}'` $HOME/public/package
#cd into directory so the structure of the zip is correct
cd $HOME/public/
zip -x "*.gz" -x "*.jar" -r ./package.zip package
#cd back to home dir for stager and delete the directory
cd
rm -r $HOME/public/package