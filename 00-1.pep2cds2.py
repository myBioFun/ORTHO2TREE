#!/usr/bin/env python
# -*- coding=utf-8 -*-

import os,sys,re


def read_fasta(input):
	with open(input,'r') as f:
		seq={}
		for line in f:
			if line.startswith('>'):
				name=line.replace('>','').split()[0]
				seq[name]=''
			else:
				seq[name]+=line.replace('\n','').strip()
	return seq

def read_file_list(dir):
	for root,dirs,files in os.walk(dir):
		name_list={}
		for file in files:
			if os.path.splitext(file)[1]=='.aln':
				filekey=file.split('.')[0]
				filename=os.path.join(root,file)
				with open(filename,'r') as f:
					name_list[filekey]=''
					list=[]
					for line in f:			
						if line.startswith('>'):
							list.append(line.replace('>','').split()[0])
					name_list[filekey]=list
	return name_list


AllCDS=sys.argv[1]
pepDir=sys.argv[2]
namelist=read_file_list(pepDir)
seq=read_fasta(AllCDS)

for key in namelist:
	fileout=key+".fa"
	with open(fileout,'w') as op:
		for ll in namelist[key]:
			lp=ll.replace('.p','')
			lt=ll.replace('PAN','TAN')
			if ll in seq.keys():
				op.write(">"+ll+"\n"+seq[ll]+"\n")
			elif lp in seq.keys():
				op.write(">"+ll+"\n"+seq[lp]+"\n")
			elif lt in seq.keys():
				op.write(">"+ll+"\n"+seq[lt]+"\n")
	
