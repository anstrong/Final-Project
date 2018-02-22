import cv2 as cv
import numpy as np
import matplotlib.pyplot as plt
from scipy.misc import imread, imsave
from PIL import Image

video_capture = cv.VideoCapture("Dancer.mp4")

#while True:
ret, img = video_capture.read()

#if not ret:
    #break

pixels = np.asarray(img)
#A=double(imread(img));

'''
for n in range(4):
    for m in range(4):
        pixels[n, m, :] = n + m
        if (n + m) == 4:
            print(n, m)

c = (0, 0, 0)
indices = np.where(np.all(pixels == c, axis=-1))
print(indices)
print(zip(indices[0], indices[1]))
'''

'''
indices = np.where(pixels == [255])
#print(indices)
coordinates = (indices[0], indices[1])
print(coordinates)
'''

c = cv.convertPointsFromHomogeneous(pixels)

print(c)
