import numpy as np
import re


grid = np.zeros((6,50))

def printGrid():
    for row in grid:
        print(' '.join(['X' if i else ' 'for i in row]))

def createRect(x,y):
    grid[:y,:x]=np.ones((y,x))

def shift(axis,index,shiftValue):
    if(axis=='y'):
        grid[index,:]=np.roll(grid[index,:],shiftValue)
    else:
        grid[:,index]=np.roll(grid[:,index],shiftValue)

with open("test.txt") as f:
    for line in f:
        if(line.startswith('rect')):
            dimensions = line.split()[-1].split("x")
            createRect(int(dimensions[0]),int(dimensions[1]))
        else:
            axis,index,shiftValue = re.findall('rotate.*(\w)=(\d+) by (\d+)',line)[0]
            shift(axis,int(index),int(shiftValue))

print(np.sum(grid))
printGrid()
