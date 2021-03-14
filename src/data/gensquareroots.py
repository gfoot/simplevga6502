import math

radius = 97

with open("squareroots.dat", "wb") as fp:
	for x in range(radius):
		y = math.sqrt((radius-0.8) * (radius-0.8) - (x-0.2) * (x-0.2))
		fp.write(bytes([int(y)]))
	fp.close()

