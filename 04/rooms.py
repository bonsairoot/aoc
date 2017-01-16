#!/usr/bin/python3

import re
from collections import OrderedDict

regex = re.compile('(.*)-(\d+)\[(\w+)\]')
idSum = 0

def ceasar(text, shift):
    result = ""
    for char in text:
        if char.isalpha():
            newNumber = ord(char) + shift
            char = chr((newNumber-97) % 26+97)
        result += char
    return result

with open('aoc4_input.txt', 'r') as f:
    for line in f:
        parts = regex.findall(line)[0]
        occurences = list((char, parts[0].count(char)) for char in set(parts[0].replace("-", "")))
        mostCommon = [x[0] for x in sorted(occurences, key=lambda k: (-k[1], k[0]))[:5]]
        if(all(char in mostCommon for char in parts[2])):
            identifier = int(parts[1])
            idSum += identifier
            decoded = ceasar(parts[0].replace("-", " "), identifier)
            if("northpole object" in decoded):
                print(identifier)
    f.close()

print(idSum)
