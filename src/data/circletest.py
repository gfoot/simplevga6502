
def octant(radius):
	result = [""] * radius
	y = 0
	ysq = 0
	x = radius
	residue = x

	k = []
	n = 0
	m = radius-1

	while y <= m:
		result[y] = "*" * x
		ysq += y
		residue -= y
		y += 1
		ysq += y
		residue -= y
		n += 1

		if residue < 0:
			residue += x
			x -= 1
			residue += x
			result[m] = "*" * n
			m -= 1

	print(len(result), len(result[0]))
	for line in result:
		print(line)

octant(39)
