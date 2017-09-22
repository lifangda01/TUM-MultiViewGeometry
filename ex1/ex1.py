from pylab import *
import cv2
import primefac as pf
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('task', metavar='task', type=int)
args = parser.parse_args()

def task1():
	img = imread("lena.png")
	gry = cv2.cvtColor(img, cv2.COLOR_RGB2GRAY)
	gau = cv2.GaussianBlur(gry, (5,5), 3)
	subplot(1,3,1)
	imshow(img)
	subplot(1,3,2)
	imshow(gry, cmap='gray')
	subplot(1,3,3)
	imshow(gau, cmap='gray')
	show()

def task2():
	A = array([[2, 2, 0], [0, 8, 3]])
	b = array([5, 15])
	# x is the solution in the least-square sense
	x = lstsq(A, b)
	print "x =", x[0] 
	B = array(A)
	A[0, 1] = 4
	c = 0
	for i in [-4, 0, 4]:
		c = c + i * dot(A.T, b)
	print "c =", c
	print multiply(A, B)
	print dot(A.T, B)

def approxequal(x, y, eps):
	return all(x - y < eps, axis=0)

def task3():
	eps = 1e-10
	print approxequal(arange(9), arange(9), eps)
	X = arange(6).reshape(2,3)
	Y = arange(6).reshape(2,3)
	Y[1, 2] = -1
	print approxequal(X, Y, eps)

def addprimes(s, e):
	psum = 0
	s = pf.nextprime(s)
	while s < e:
		psum += s
		s = pf.nextprime(s)
	return psum

def task4():
	print addprimes(2, 5)
	print addprimes(2, 20)

def main():
	if args.task == 1:
		task1()
	elif args.task == 2:
		task2()
	elif args.task == 3:
		task3()
	elif args.task == 4:
		task4()
	else:
		print "Invalid task!"

if __name__ == '__main__':
	main()