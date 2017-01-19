#!/usr/bin/python3

ranges = []
with open("aoc20_input.txt") as f:
    for line in f:
        my_range = line.split("-")
        ranges.append(list(map(int, my_range)))

ranges.sort()
upper_bound = ranges[0][1]
max_upper = upper_bound
index = 0

while(True):
    found_entry = False
    while(ranges[index][0]<=upper_bound+1):
        found_entry = True
        max_upper = max(ranges[index][1],max_upper)
        index+=1
    if not found_entry:
        print ("%d" % (upper_bound+1))
        break
    upper_bound = max_upper

