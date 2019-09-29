import json
import glob, os

os.chdir("builds")
for file in glob.glob("*.json"):
    print("Testing "+file)
    with open(file) as json_test:
      try:
        json_object = json.loads(json_test.read())
      except ValueError as e:
        print("Build failing as "+file+" seems to have incorrect format")
        exit(1)
exit(0)
