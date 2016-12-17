#!/bin/sh

if [ ! ${experiment_root} ]
then
    echo "experiment_root is unset in the shell"
    echo "please set experiment_root to point to your experiment directory"
    echo "see README for more information:"
    exit 2
fi

if test $# -lt 1
	then \
		echo Usage:
		echo install.sh comp_dir [variant]
		echo comp_dir: orig
                echo "variant: 1 or 2 (optional, default=1)"
		exit 0
fi

if test $# -eq 2
then
    variant=$2
else
    variant=1
fi

subject_dir=${experiment_root}/deadlock
echo removing old files
rm -f -r ${subject_dir}/source/*
rm -f ${subject_dir}/outputs/*

if test $1 = "orig"
then
     echo copying files for orig version d${variant}
     cp -r ${subject_dir}/versions.alt/orig/d${variant}/*.java ${subject_dir}/source 
else
    echo orig is the only option currently available
    exit 0
fi
cd ${subject_dir}/source

echo compiling application
echo "java home"
echo $JAVA_HOME
find . -name "*.java" | xargs javac -deprecation -source 1.4 > /dev/null

