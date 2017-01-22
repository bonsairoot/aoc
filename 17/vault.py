#!/usr/bin/python3
import operator
import hashlib

paths = []


def main():
    start = (0, 0)
    passcode = "gdjjyniy"
    queue = [(start, passcode)]
    while queue:
        (x, y), code = queue.pop(0)
        next_posibilites = traverse(x, y, code)
        for walk in next_posibilites:
            queue.append(walk)

    max_path = max(paths, key=len)[len(passcode):]
    min_path = min(paths, key=len)[len(passcode):]
    print(min_path)
    print(len(max_path))


def computeMD5hash(code):
    m = hashlib.md5()
    m.update(code.encode('utf-8'))
    return m.hexdigest()[:4]


def traverse(x, y, code):
    possibles = []
    if (x == 3 and y == 3):
        global paths
        paths.append(code)
        return []

    for index, item in enumerate(computeMD5hash(code)):
        if not (item.isdigit() or item == "a"):
            if index == 0 and y > 0:
                possibles.append(((x, y-1), code + "U"))
            elif index == 1 and y < 3:
                possibles.append(((x, y+1), code + "D"))
            elif index == 2 and x > 0:
                possibles.append(((x-1, y), code + "L"))
            elif index == 3 and x < 3:
                possibles.append(((x+1, y), code + "R"))

    return possibles


if __name__ == "__main__":
    main()
