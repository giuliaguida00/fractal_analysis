# 1 Introduction

This code has been developed in order to perform the fractal analysis of particle contour.
It characterises the morphology of soil particles over the range of experimentally accessible scales
through three new non-dimensional quantitative morphological descriptors characterising: (i) overall
particle shape at the macro-scale, (ii) particle regularity at the meso-scale, and (iii) particle texture at
the micro-scale. The characteristic size separating structural features and textural features emerges
directly from the results of the fractal analysis of the contour of the particle, and is a decreasing
fraction of particle dimension. 

## 1.1 The Method
Fractal analysis stems from the observation that the measured length of the contour of many natural
irregular closed shapes, $p$, is a function of the measurement scale, $b$ (Mandelbrot 1967), and that the
smaller the measurement scale, the longer the measured length becomes. The approximations with
segments of length b of strictly self-similar mathematical curves, such as $e.g.$, the Koch snow flake
(Von Koch 1906), have lengths: 

[1.1]   $p=b^{1-\alpha}$, 

where $\alpha$ is the Hausdorff dimension, assuming values between 1 and 2. 

The equation [1.1] implies that the length of the contour of any truly-fractal closed shape deiverges to infinity as the measurement scale tends to zero. When dealing with physical objects, indefinite subdivision
of space does not make sense, as the minimum measurement scale would be limited at least by
the distance at the atomic level, while in practice, well before this is achieved, it is limited by the
experimental resolution with which the contour of the particle is defined. However, the plot of the
length of the contour of a particle, p, versus measurement scale, $b$, still carries a signature of the
morphology of the particle over the range of experimentally accessible scales. At the upper end of
this range, the characteristic dimension of the particle can be conventionally defined as the diameter
of the circle having the same area as the particle:

[1.2]   $D=\sqrt{4A/\pi}$.

The input for the fractal analysis is a 2D image of the particle of any resolution, as obtained, $e.g.$, by
optical or scanning electron microscopy; it is evident that the higher the resolution of the image, the
more information can be extracted from the analysis.

In order to obtain quantitative information from images, they were processed by contrast enhancement, binarization and segmentation. Contrast enhancement increases image sharpness thus facilitating
subsequent binarization and segmentation. The method by Otsu 1979 was used to obtain the binary
version of the original greyscale image, by converting each pixel to either white (foreground) or black
(background), based on a threshold value. When the particles were not in contact in the binarized
image, they were identified simply by labelling areas composed by all connected foreground pixels.
In more complex situations, for instance when processing images containing grains in contact, a
watershed algorithm Beucher 1992 was used for segmentation purposes.

Figure 1.1a shows schematically a binarized particle image after segmentation, in which white pixels correspond to the particle while black pixels correspond to the background. The contour of the particle can be extracted by subtracting from the binarized image of the particle its 8th-connected eroded, to obtain the external line of 8th-connected pixels (Fig. 1.1b) in the form of a vector containing their coordinates ($x_i$; $y_i$).
The algorithm, coded in Matlab (2015), computes the length of the contour adopting segments of fixed length (Figure 1.1c-d). A point of the contour is chosen as the starting point for the calculation (Fig. 1.1c) and one end of a segment of length $b$ is fixed to it. A simple "while" loop, which stops when the distance between the starting point and a successive point on the boundary is greater than or equal to $b$, finds the intersection point between the other end of the segment and the boundary (Fig. 1.1c). In turn, this intersection point becomes the starting point for the second segment, until the whole contour is covered (Fig. 1.1d). Since a finite number of points discretize the outline, the exact distance between two subsequent intersection points is not strictly equal to the segment length $b$, but the maximum error is less than the pixel size. The loop ends when the distance between the
intersection point and the initial starting point is less than $b$ (Fig. 1.1e). The length of the contour is computed as the sum of the distances between all the intersection points. As this length depends on the chosen initial starting point (Stachowiak 1998), consistently with the definition of the Hausdorff dimension, the procedure is repeated using all the points of the boundary as starting points, and the perimeter of the particle, $p$, is defined as the minimum computed value of the length of the contour.
Finally, the normalised perimeter, $p=D$, is plotted versus the corresponding normalised stick length, $b=D$, in a bi-logarithmic plane.

![image](https://user-images.githubusercontent.com/110109054/189543594-c7e91552-5d8d-4a60-8890-6d95ae15d29c.png)

## 1.2 Three scales of information

Figure 1.2 shows an example of the results of the fractal analysis applied to a natural grain of Toyoura
sand. A SEM photograph of the sand grain at a magnification factor of 300x (Fig. 1.2a) was taken from SEM images online database (http://web.utk.edu/~alshibli/research/MGM/archives.php).
Figure 1.2b shows the same grain after binarization and segmentation; in this case, careful contrast
enhancement was required to avoid altering the contour due to the presence of shadows and overlapping.
The characteristic dimension of the particle is $D = 185$ $\mu$m and the resolution of the image is 960
pixels/mm, or, in other words, one pixel corresponds to $b_{min} = 1.04$ $\mu$m. After boundary extraction,
the perimeter was computed using segments of decreasing length from $b = D$ to $b = 0:001D$, see
Figure 1.1c.

Figure 1.2d reports the results of the analysis in terms of $\log(b/D) vs \log(p/D)$. Starting from $b/D =
1$ and moving to the left, as $b/D$ decreases, $p/D$ increases rapidly and non-linearly from its minimum
value of 2, corresponding to point (1) in Figure 1.2d. For smaller values of $b/D$, two linear trends can
be identified, with slopes $-m$ and $-\mu$, until the computed perimeter saturates and the plot becomes
horizontal when the segment length reaches the pixel size, $b_{min}/D = 0.0056$. The larger segment
lengths, see $e.g.$, points (1) to (3) in Figure 1.1d, even if providing the least accurate estimate of the
actual perimeter of the particle, carry information about its overall proportions at the macro-scale.
Intermediate segment lengths, see $e.g.$, points (3) to (4), recognise the local features of the particle
contour at the meso-scale, while small segment lengths, see $e.g.$, point (5), convey the signature of
surface texture, because they can follow the asperities of the contour at the micro-scale, see Figure
1.1c.

![image](https://user-images.githubusercontent.com/110109054/189543738-364e5009-8d35-4dbe-85b6-e5a983be64ef.png)

The results in Figure 1.2 are typical of natural sand particles. They confirm the findings by Orford
and Whalley (1983) on the emergence of two distinct self-similar patterns describing structural and
textural features. Moreover, the characteristic scale separating the two, which may be regarded as
the maximum size of the micro-asperities, emerges directly from the results and corresponds to the
stick length at the point of intersection of the two linear portions of the plot, $b_m$ ($= 0.028D = 5.4
\mu m$) in Figure 1.2d.

The absolute values of the slopes of the two linear portions of the plot relate to the fractal dimension
in Eq. 1.1, and increase with the complexity of the profile (Vallejo, 1996). These can be obtained by
automatic linear regression in the $\log(b/D) : \log(p/D)$ plane, performing a check on the computed
value of the coefficient of determination, $R^2$. Starting from $b_{min}/D$, a linear regression is extended to
include an increasing number of points, corresponding to larger and larger values of $b=D$, until $R2$
remains approximately constant and equal to 1. When $R^2$ decreases by more than $0.02\%$, the process
stops, and starts again with another regression on the remaining data; any linear trend must contain
at least five data points.

Figure 1.3 illustrates this procedure for the contour of the Toyoura sand particle of Figure 1.2.
In this case, the first linear regression ends at a value of $b/D = b_m/D = 0.028$ and the second
linear regression at $b/D = 0.30$, no further linear portions are identified by the algorithm. The
computed absolute values of the slopes are $m = 0.042$ ($\alpha_m =1.042$) and $\mu = 0.137$ ($\ampha_\mu =1.137$). An
important feature of the plot in Figure 1.2d is the increase of the dimensionless perimeter above its
minimum value of 2 over the range of stick lengths connected to overall shape and structural features,
($bm/D < b/D < 1$):

[1.3] $\Delta = (p/D)_{b_m}-2$

For example in Figure 1.2, $D=1.55$.

![image](https://user-images.githubusercontent.com/110109054/189544134-4d25a5fb-8a98-4d06-8b9d-7ea277f70f05.png)

# 2 Inputs
## 2.1  Image

The matlab code 'main.m' takes as input a two-dimensional binarized image of a grain from the folder
'grains' and gives back fractal analysis results.
Binarized image means black and white coloured, bw, where whites represents the objects and blacks
the background. If user has not got a bw image of the grain, the Matlab code 'elab_I.m', processes
different type of image in order to obtain the right binarized input data.
The image type accepted by Matlab are list in the following link: https://it.mathworks.com/help/
matlab/import_export/supported-file-formats.html.

Figure 2.1 describes the step of elab_I.m code explained below:

1. ORIGINAL IMAGE - loading the input image from the folder named Grains;

2. CROPPED GRAYSCALE GRAIN - The grain of interest is manually selected by the command
imcrop and transformed into a gray scale image. [NOTE: It is easier to work on grayscale
images because they are two-dimensional matrix, while coloured are three-dimensional];

3. INVERTED - If the original image has the background brighter than the object it is necessary
to invert the image I=1-I; Else, just comment by using "%", %I=1-I;

4. NOISE REDUCTION - application of Gaussian filter = pixels values smoothing, in order to
attenuate noise;

5. CONTRAST ENHACEMENT - histograms stretching in order to make brighter the higher
value pixels and darker the lowest value pixels;

6. BINARIZED - imposing the Otsu threshold.

For each image it is necessary to make sure that the contour of the binarized footprint matches the
contour of the grain under examination.

![image](https://user-images.githubusercontent.com/110109054/189544393-d3127e1a-706c-4d07-8b9d-90bec58515e1.png)


## 2.2 Data

There are other properties that have to be set:

1. The entire name of the file, "filename", containing the input image, inside the folder Grains;

2. The number of sets of stick lengths "n_b";

3. The tolerance "tol" on linear regressions.

# 3 Particle Contour
## 3.1 Boundary extraction

The function "[boundary,cc]=boundary(bw)", takes as input the binarized image bw and gives back:

- the boundary, a matrix formed by two columns, x and y coordinates, and many rows as the
number of pixels of the grain contour;

- the image "cc", containing all the connected pixels of the input image.
Figure 3.1 reports an example of boundary extraction.

From the connected pixels image is possible to extract some geometric and shape properties, by the
use of function "[geom,shape] = descriptor(cc)", that gives as output two vectors:

- "geom" containing geometrical information such "Equivalent Diameter", $D$, or the diameter of a
circle with the same area of the grain, the perimeter, $P$, and the area, $A$, of the particle;

- "shape" containing morphological information such circularity, $C = 4\pi A/P^2$, that measures how
the object is similar to circle, aspect ratio, $AR = D_{Feret,min}/D_{Feret,max}$
where D_{Feret,min/max} is the minimum/maximum distance between two parallel tangent to the particle, that measures the
elongation, and convexity, $CX = A/A_{conv}$
where $A_{conv}$ is the area of the convex polygon tangent
the particle, that measures the objects concavities. All these shape descriptors assume values
ranging between 0 and 1, where 1 means the perfect circular shape.
Geometric and shape descriptors are printed in the command window during running the code.

![image](https://user-images.githubusercontent.com/110109054/189544612-c5cca9c8-b745-406f-abf0-8f56c55662a8.png)

# 4 Fractal Analysis

The "function[b_D,p_D]=fractal_analysis(geom,boundary,n_b)" computes the contour length of
the particle using set of sticks as units. It takes as input the geometrical information of the particle
"geom", the boundary coordinates "boundary", and the number of stick sizes "n_b". The outputs are two
vectors, "b_D" and "p_D", one containing the stick lengths, and the other the values of perimeters related
to the stick length adopted, both normalized by the equivalent perimeter, $D$.
The algorithm is divided in three loops one inside the other:

1. The first loop runs over the starting points, so all the indication described in that loop are
repeated for each starting point;

2. The second loop runs over the sticks lengths taking time by time the subsequent smaller one;

3. The third loop runs along the particle boundary using the stick as a unit.

This is the most time consuming part of the code, that anyway takes few minutes to run in a standard performance computer, with the default inputs. A percentage counter in the command window updates the status of the calculation. If it stays for too long, maybe your processor is not enough fast, therefore, try to
decrease the number of sticks "n_b", or the lower bound limit in the vector bacc (see Section 4.2) from
$10^{-3}$ to $10^{-2}$.

## 4.1 1st loop

The first loop runs the analysis over different starting points "nn", corresponding to each point of the
particle boundary. Everytime the loop restarts, the matrix of boundary coordinates is sorted into the
temporary "bound" matrix, placing at the first index the coordinates related to the starting point.
A first check consists to control that the first and biggest stick, equal to $b/D =1$ (where $D = D_{eq}$),
is no longer that the maximum distance between the starting point and the boundary. This could
happen if the particle has a different shape from the circular one. In that case $D =$ maximum distance
distances between the starting point and all the other point of the boundary.
The stick length vector $bacc$ (from the italian "bacchetta"=transaltion of stick) is log equally spaced
between $10^{-3}$ and $10^0$ times $D$.

## 4.2 2nd Loop

The second loop, inside the first, runs over the stick lengths taken from the vector "bacc".
Every time a new stick is used, the starting point coordinates are newly imposed. The starting
coordinates "x0" and "y0" are taken from the sorted boundary coordinates bound defined in the 1st Loop.

## 4.3 3rd Loop

The third loop detects the intersection point between the stick and particle boundary. In practice it
consists to fix one end of the stick in the starting point and to detect the intersection between the
other end of the stick and the boundary, following the pixels order. The new intersection becomes
the starting point for the next detection.
It is coded on a "while" loop that increases the counter "j", initially equal to the index related to the
starting point, till the particle contour ends, "j==n".
The loop detects intersection points following the condition: if "dist>=b" or if the distance dist
between the starting point and the increasing "j" point of the boundary becomes longer than the stick
length "b". In this case the new intersection point is found, and the relative "j", becomes the index of
the starting point for the next intersection detection. The intersection coordinates are stored in the
matrix "p(m x nn)" for each stick length "m" and for each starting point "nn".
The perimeters is computed summing the distances between each intersection point, normalized by
the equivalent diameter, and memorized inside the matrix, that has many rows as the number of stick
lengths and many column as the number of contour points.
The output vectors of perimeters "p_D", chooses the minimum value of contour length, related to the
associated stick length "b_D", along all the starting points adopted.

# 5 Morphology Descriptors

The fractal descriptors are evaluated by the function:

"[mhu,m,M,ind_mhu,ind_m,ind_M]=MyMorphology(p_D,b_D)", that takes as input the results of fractal analysis, "p_D" and "b_D", containing the value of minimum perimeter and the associated stick length respectively, giving back as outputs the fractal morphological descriptors: $\mu$, $m$, $M$, and the vector of
indices where they were computed.

## 5.1 Linear regression
The fractal analysis results are reported in a log-log space (Figure 5.1), "b_D" $versus$ "p_D", where it is
possible to appreciate the linear relations between the two variables (=contour's self similarities).

![image](https://user-images.githubusercontent.com/110109054/189544933-b24b69f9-e92c-4750-aca6-c701e682c7b0.png)

When the stick length is smaller than the pixel size, the log-log plot could present a $plateau$, for the
reasons exposed in the introduction. It, if present, is cutted off by the algorithm.
Linear regression are performed by the specific function:

"function[ind,m_fr,Q]=regression(X,Y,toll)" that takes as inputs "X" and "Y", equal to the logarithm
of the variable "b_D" and "p_D" respectively, and the tolerance "tol", imposed at the beginning as a data
input, and gives back the regression data: vector index of regression end ("ind"), its slope ("m_fr") and the intercept ("Q").
Starting from the smallest stick length the regression function performs a while loop in order to detect
automatically the two linear trends:

it looks for the maximum number of subsequent points in order that the correlation coefficient, $R^2$,
stays lower the tolerance, "tol". This procedure is repeated two times, because two linear subset are
expected.
It is IMPORTANT to check the success of the regressions, looking at the image , such as Fig. 5.1,
where it is possible to appreciate the end of the two regressions from the star symbols, blue for
the first regression and red for the second regression. They should correspond to the end of linear
subsets. In the case of Fig. 5.1 related to the grain of Fig. 2.1, they are good, even if the second
linear subset is not much meaningful because formed by few points. The absolute value of the slope
of the first linear regression is $\mu$ ("mhu"), the absolute value of the second linear regression is $m$ ("m"),
and the characteristic size of asperities $b_m=D$ corresponds to the end of the first regression, or the
beginning of the second (index "ind_m"). From the value of perimeter, $p_m/D$, corresponding to $b_m/D$,
the descriptor $M$ is evaluated, as described in the Introduction.
In the case of Fig. 5.1 the contour is mainly characterise by the complexity $\mu \approx 0$ till big stick length
because the blue star is much shifted to the right. This means that the grain contour is regular at all
the scales.

# 6 Data Saving

Data are saved in a file "results.xls", inside a sheet with the same name of the grain image. In this
way, all the analysis can be stored in a same file, but automatically on different sheets.
The data saved are the following:

1. The pixel coordinates $x$[px] and $y$[px] of the grain contour;

2. The stick length $b/D$ and the relative perimeter values $p/D$, results of fractal analysis;

3. The geometric properties of the grain: equivalent diameter [px], perimeter [px], and area [px$^2$];

4. The shape properties computed by Matlab: Circularity, $C$, Aspect Ratio, $AR$ and Convexity,
$CX$;

5. The fractal morphological descriptors: $M$, $m$ and $\mu$;

6. The initial, ($b/D|_{min}$; $p/D|_{min}$), intermediate, ($b/D|_m; p/D|_m$), and final coordinates, (b_D|_M; p/D|_M$),
of the regressions.

# References
Beucher, Serge et al. (1992). "The watershed transformation applied to image segmentation". In:
SCANNING MICROSCOPY-SUPPLEMENT-, pp. 299-299.

Mandelbrot, Benoit (1967). "How long is the coast of Britain? Statistical self-similarity and fractional
dimension". In: science 156.3775, pp. 636-638.

Orford, JD and WB Whalley (1983). "The use of the fractal dimension to quantify the morphology of
irregular-shaped particles". In: Sedimentology 30.5, pp. 655-668.

Otsu, Nobuyuki (1979). "A threshold selection method from gray-level histograms". In: IEEE
transactions on systems, man, and cybernetics 9.1, pp. 62-66.

Stachowiak, GW (1998). "Numerical characterization of wear particles morphology and angularity of
particles and surfaces". In: Tribology International 31.1-3, pp. 139-157.

Vallejo, L.E. (1996). "Fractal analysis of granular materials". In: Géotechnique 45.1, pp. 159-163.

Von Koch, Helge (1906). "Une méthode géométrique élémentaire pour l'étude de certaines questions
de la théorie des courbes planes". In: Acta mathematica 30.1, pp. 145-174.

