function [geom,shape]=descriptor(cc)

%COMPUTING shape descriptors
%defining pi-greco
pi=3.141519;

% 'regionprops' contain many properties of the image. look at the Matlab
% guide
graindata=regionprops(cc,'basic');

% area, mass centre, and corners of the opposite corners of the bounding
% box
A=[graindata.Area];
Centers=[graindata.Centroid];
BoundingBox=[graindata.BoundingBox];

% equivalent diameter
eqdiam=regionprops(cc,'EquivDiameter');
Deq=[eqdiam.EquivDiameter];

%perimeters
perim=regionprops(cc,'Perimeter');
P=[perim.Perimeter];


%convex area
conv=regionprops(cc,'Solidity');
CX=[conv.Solidity];

%feret min and feret max 
Lenght=regionprops(cc,'MajorAxisLength');
Width=regionprops(cc,'MinorAxisLength');

L=[Lenght.MajorAxisLength];
W=[Width.MinorAxisLength];
%Aspect Ratio
AR=W./L;
C=4*pi*A./(P).^2;
El=1-AR;


%output of vector
geom=[Deq,P,A];
shape=[C;AR;CX];


%PRINT THE INFORMATION

sprintf(' Equivalent Diameter [Pixel] %d\n Perimeter [Pixel] %d\n Area [Pixel] %d\n Circularity %d\n Aspect Ratio %d\n Convexity %d\n'...
    ,Deq,P,A,C,AR,CX)

end