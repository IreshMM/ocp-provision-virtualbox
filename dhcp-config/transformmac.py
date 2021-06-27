#!/usr/bin/python3
import sys

inputmac = sys.stdin.readline().strip()

length = len(inputmac)
result = []
for i in range(0, length, 2):
    result.append(inputmac[i:i+2].lower())


print(":".join(result), end="")
