#!/usr/bin/env python

import os, json, sys

paths = ['builds','devices.json']

indents = 3

def main():

	if len(sys.argv) > 1:
		formatter('builds/'+sys.argv[1]+".json")
		exit()

	for path in paths:
		if os.path.isdir(path):
			for file in os.listdir(path):
				formatter(path+'/'+file)
		elif os.path.isfile(path):
  			formatter(path)
  			
def formatter(path):
	if not path.endswith('.json'):
		return
	try:
		data = json.loads(open(path).read())
		outfile = open(path, 'w')
		json.dump(data, outfile, indent=indents, ensure_ascii=False)
		print(path,"...SUCCESS")
	except Exception as e:
		print(path,"...ERROR",e)

if __name__== "__main__":
  main()
