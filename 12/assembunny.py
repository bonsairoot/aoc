#!/usr/bin/python3
register = {"a": 0, "b": 0, "c": 1, "d": 0}


def getValue(criteria):
    if (criteria.isdigit()):
        return int(criteria)
    else:
        return register[criteria]


with open('aoc12_input.txt', 'r') as f:
    lines = f.readlines()
    i = 0
    while (i < len(lines)):
        instructions = lines[i].split()
        if (instructions[0] == "jnz" and getValue(instructions[1]) != 0):
            i += int(instructions[2])
            continue
        elif (instructions[0] == "inc"):
            register[instructions[1]] += 1
        elif (instructions[0] == "dec"):
            register[instructions[1]] -= 1
        elif (instructions[0] == "cpy"):
            register[instructions[2]] = getValue(instructions[1])
        i += 1

print(register)
