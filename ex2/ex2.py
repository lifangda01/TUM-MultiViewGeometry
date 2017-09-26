from pylab import *

def main():
	# Dx = 1
	# Generate D
	m = 20
	n = 4
	eps = 1e-5
	D = rand(m, n)
	D[:, -1] = dot(D[:, :3], array([4, -3, 2])) - 1
	D += eps * randn(20, 4)
	# SVD
	U, s, Vt = svd(D)
	print U.shape, s.shape, Vt.shape
	# Pseudo inverse
	Sd = zeros((n, m))
	Sd[:n, :n] = diag(1 / s)
	Dd = dot(Vt.T, dot(Sd, U.T))
	print Dd.shape
	# Solve for x
	x = dot(Dd, ones(m))
	print x
	print dot(D, x)

if __name__ == '__main__':
	main()