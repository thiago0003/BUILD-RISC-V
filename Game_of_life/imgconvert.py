import numpy as np


def read_mario8():
    with open('mario8.bin') as f:
        listing = []
        for line in f:
            listing.append(line.strip())  
    return listing


row, col  = 20, 15

l = read_mario8()
n_l = np.zeros((2*row, 2*col))
for i in range(row):
    for j in range(col):
        idx_y = 2 * i
        idx_x = 2 * j
        n_l[idx_y  ,   idx_x] = l[col * i + j]
        n_l[idx_y+1,   idx_x] = l[col * i + j]
        n_l[idx_y  ,1 +idx_x] = l[col * i + j]
        n_l[idx_y+1,1 +idx_x] = l[col * i + j]

n_l = n_l.reshape((300,4))


np.savetxt("mario8bit_exp.bin", n_l, fmt='%08i', delimiter="")

    