
def octant(radius):
	result = [""] * radius
	y1 = 0
	x1 = radius
	residue = x1

	x2 = 0
	y2 = radius-1

	while y1 <= y2:
		result[y1] = "*" * x1
		residue -= y1
		y1 += 1
		residue -= y1
		x2 += 1

		if residue < 0:
			residue += x1
			x1 -= 1
			residue += x1
			result[y2] = "*" * x2
			y2 -= 1

	print(len(result), len(result[0]))
	for line in result:
		print(line)

octant(39)
