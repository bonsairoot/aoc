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


def traverse(x_i, y_i, code):
    possibles = []
    if (x_i == 3 and y_i == 3):
        global paths
        paths.append(code)
        return []

    for index, item in enumerate(computeMD5hash(code)):
        if not (item.isdigit() or item == "a"):
            x, y = (x_i, y_i)
            if index == 0 and y > 0:
                y -= 1
                possibles.append(((x, y), code + "U"))
            elif index == 1 and y < 3:
                y += 1
                possibles.append(((x, y), code + "D"))
            elif index == 2 and x > 0:
                x -= 1
                possibles.append(((x, y), code + "L"))
            elif index == 3 and x < 3:
                x += 1
                possibles.append(((x, y), code + "R"))

    return possibles


if __name__ == "__main__":
    main()
