import json
from pathlib import Path

for file in Path('.').glob('**/*.json'):
    print("Testing "+str(file))
    with open(file) as json_test:
      try:
        json_object = json.loads(json_test.read())
      except ValueError as e:
        print("Build failing as "+str(file)+" seems to have incorrect format")
        exit(1)
