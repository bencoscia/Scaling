#!/usr/bin/env python

import argparse
import numpy as np
import matplotlib.pyplot as plt

def initialize():

	parser = argparse.ArgumentParser(description='Plot scaling study results')

	parser.add_argument('-i', '--input', type=str, default='scaling.txt')
	parser.add_argument('-o', '--output', type=str, default='Scaling.png')
	parser.add_argument('--save', action="store_true")
	parser.add_argument('--noshow', action="store_true", help='Do not display plots')
	parser.add_argument('-dt', default=0.002, type=float, help='Time step (ps)')

	args = parser.parse_args()

	return args

if __name__ == "__main__":

	args = initialize()
	
	with open(args.input, 'r') as f:

		a = []

		for line in f:
			a.append(line)

	time = float(a[1].split()[3])

	names = []
	npts = []
	results = []
	for i in range(len(a)):
		if a[i].count('atoms') == 1:
			pt_count = 0
			names.append(str.strip(a[i]))
			line = i + 2
			while line != len(a) and a[line].count('atoms') == 0:
				results.append(a[line].split())
				line += 1
				pt_count += 1
			npts.append(pt_count)

	data = np.zeros([len(npts), max(npts), 2])

	for i in range(len(npts)):
		for j in range(npts[i]):
			data[i, j, :] = results[i*max(npts) + j]
			data[i, j, 1] *= (args.dt*60*24/(1000.0*time))  # convert steps to ns/day 

	data_sorted = np.zeros(data.shape)
	for i in range(data.shape[0]):
		data_sorted[i, :, 0] = np.sort(data[i, :, 0], axis=None)
		indices = np.argsort(data[i, :, 0], axis=None)
		for j in range(data.shape[1]):
			data_sorted[i, j, 1] = data[i, indices[j], 1]

	for i in range(len(names)):
		plt.plot(data_sorted[i, :, 0], data_sorted[i, :, 1], label='%s' % names[i])

	plt.xlabel('Number of Nodes')
	plt.ylabel('Performance (ns/day)')
	plt.legend()
	if args.save:
		plt.savefig(args.output)
	if not args.noshow:
		
		plt.show()	
