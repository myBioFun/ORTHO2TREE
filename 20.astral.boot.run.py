#! /usr/bin/env python
# -*-coding=utf-8 -*-

import sys,os,re

astral="java -jar /data/00/user/user108/software/ASTRAL/astral.5.7.3.jar"
TreesDir=sys.argv[1]
os.system("mkdir bootstrapTree")
for root,dirs,files in os.walk(TreesDir):
	for ff in files:
		pattern=r"RAxML_bestTree.*.ml"
		if re.search(pattern,ff):
			MLtreeName=os.path.join(root,ff)
			#os.system("cat %s >>all_ML%s.trees"%(MLtreeName,os.path.basename(TreesDir)))
			os.system("cat %s >>all_ML.trees"%MLtreeName)
			BootstrapName=MLtreeName.replace("bestTree","bootstrap")
			os.system("cp %s bootstrapTree"%BootstrapName)
			

os.system("perl -p -i -e 's/\|.*?:/:/g' all_ML.trees")
os.system("ls bootstrapTree/* | awk -v d=\"'\" '{print \"perl -p -i -e \"d\"s/\\\|.*?([,\\\)])/$1/g\"d\" \" $1}' >seddperl.sh")
os.system("sh seddperl.sh")
os.system("ls bootstrapTree/* > all_boot.trees")

print(astral+" -i all_ML.trees -b all_boot.trees -g -r 100 -o astral_boot.out")





