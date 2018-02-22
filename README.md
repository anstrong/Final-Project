# Scribblr

## Orginial goal
The orginal idea was to have objects, created in a graphics simulator called VPython, gravitate towards and become a part of a moving shape.

<i> see "sim.py" in "Simulator" folder</i>

I wanted to use OpenCV to detect a sihouette in a video and use that information to determine when and where the objects should "stick"
to the object.
However, the graphic library I chose was tedious to use, so I switched over to Processing, which has an OpenCV library built for it.

##  Processing Part 1
To start with processing, I first chose to work in the Python branch of the language. However, I discovered that OpenCV doesn't have a module
for Processing.py, so I switched over to the Java branch. After playing around with some of the possible graphics (*Particle_Field*, *Particle_Processing*, *Flow_Field*, *Vector_Paticles*),
I began to test OpenCV for Processing. I was able to use sample code to find the edges of a shape, just as I'd hoped, but soon ran into the issue of reading the data.

<i> see "FindContours" in Test>Processing </i>

When I printed a string of the "contour" data, it returned an adress I couldn't make sense of. I looked through several layers of source code to
try to figure out what the function was actually returning, but had little luck. After searching for a while in vain (the OpenCV for Processing 
documentation is terrible at best), I decided to make a backup project in case I couldn't figure out how to process the data.

## Processing Part 2
Switching back to the more familliar Processing.py, I created a program that could "draw" an image. 

<i>see "Img_Drawing"</i>

However, the program, while it had taken a while to figure out, seemed too simplistic. Though a lot of my classmates suggested adding
color (which I did in several forms, only to find that the net result is brown because of all the overlapping) or a GUI, I really wanted 
to retry my original idea.

## Processing Part 3
I translated the code to Java (a language with which I have no experience) so it could be compatible with OpenCV, and began integrating
my movie testing code from before (*Test>Processing>Movie_Processing*) with the new graphics. The results, after hours of debugging, was a choppy video of the sihouette from the file, just as I'd originally hoped. I had originally considered adding a GUI to the image drawing program instead, but I thought the video would look cooler and I wanted to fufill my original vision.

<i>see final file: "Movie_Drawing"</i>
