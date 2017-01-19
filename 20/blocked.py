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
counter = 0
first = True

while (True):
    found_entry = False
    while (index < len(ranges) and ranges[index][0] <= upper_bound + 1):
        found_entry = True
        max_upper = max(ranges[index][1], max_upper)
        index += 1
    if not found_entry:
        if first:
            print("Part 1: %d" % (upper_bound + 1))
            first = False
        if index >= len(ranges):
            break
        counter += 1
        max_upper = ranges[index][1]
    upper_bound = max_upper

print("Part 2: %d" % counter)
