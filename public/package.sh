#!/usr/bin/env bash

#get the package name for structure and zip name
PACKAGE=`tail -n1 $HOME/public/apt.yml | awk '{print $2}'`

#make the directory to put the binaries
mkdir $HOME/public/$PACKAGE

#copy the binaries
if [ ! "$FLATTEN" = false ]; then
  # default to flatten binaries into the packaging directory
  cp `find -L $HOME/../deps/0/ -type f | awk -F/ '{a[$NF]=$0}END{for(i in a)print a[i]}'` $HOME/public/$PACKAGE
else
  # package the binaries directory unmodified
  cp -R $HOME/../deps/0/ $HOME/public/$PACKAGE
fi

#cd into directory so the structure of the zip is correct
cd $HOME/public/
zip -x "*.gz" -x "*.jar" -r ./$PACKAGE.zip $PACKAGE

#replace link in html with correct file name
sed -i 's/package.zip/'$PACKAGE'.zip/g' index.html

#cd back to home dir for stager and delete the directory
cd
rm -r $HOME/public/$PACKAGE