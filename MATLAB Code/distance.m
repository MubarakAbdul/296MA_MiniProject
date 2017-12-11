function dist = distance(x1,y1,x2,y2)
%This function calculates the distance between any two cartesian 
%coordinates.
%   Copyright 2009-2010 The MathWorks, Inc.
xll = 70;
yll = 5;
r0 = 50;
xvec = x1 - xll;
yvec = y1 - yll;
theta = atan(yvec / xvec);
xref = r0 * cos(theta);
yref = r0 * sin(theta);
dist2 =(xvec + xref) ^ 2 + (yvec + yref) ^ 2;
%dist2 = (xvec - xref) ^ 2 + (yvec - yref) ^ 2 + ...
%    0.1 *( (xvec - xgoalref) ^ 2 + (yvec - ygoalref) ^ 2);
dist=sqrt((x1-x2)^2 + (y1-y2)^2) + 0.05*sqrt(dist2);
