#!/usr/bin/python3
#
import json

with open('stage.tfstate', 'r') as f:
  data = json.load(f)

# Output: {'name': 'Bob', 'languages': ['English', 'French']}
print(data)
