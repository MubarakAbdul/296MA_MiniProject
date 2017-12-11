clear 
close all

xmin = [-10, -10];
xmax = [10, 10];
xpts = 300;
x1 = linspace(xmin(1),xmax(1),xpts);
x2 = linspace(xmin(2),xmax(2),xpts);
radius = 6
roadRSquare = radius ^ 2;

xll = -10;
yll = -10;
r0 = 12;

xgoalref = 12;
ygoalref = 0;

[X, Y] = meshgrid(x1, x2);
Z = zeros(size(X));
Z2 = zeros(size(X));
% surf(X, Y, Z)

for i = 1 : length(x1)
	for j = 1 : length(x2)
		curX = x1(i);
		curY = x2(j);
		if  (((curX + 10) ^ 2 + (curY + 10) ^ 2) <= roadRSquare) || ...
			(((curX - 10) ^ 2 + (curY + 10) ^ 2) <= roadRSquare) || ...
			(((curX - 10) ^ 2 + (curY - 10) ^ 2) <= roadRSquare) || ...
			(((curX + 10) ^ 2 + (curY - 10) ^ 2) <= roadRSquare)
			Z(i, j) = nan;
			Z2(i, j) = nan;
		end
	end
end

for i = 1 : length(x1)
	for j = 1 : length(x2)
		if isnan(Z(i, j))
			continue;
		end
		xvec = x1(i) - xll;
		yvec = x2(j) - yll;
		theta = atan(yvec / xvec);
		xref = r0 * cos(theta);
		yref = r0 * sin(theta);
		Z(i, j) =(xvec - xref) ^ 2 + (yvec - yref) ^ 2;
		Z2(i, j) = (xvec - xref) ^ 2 + (yvec - yref) ^ 2 + ...
				   0.1 *( (xvec - xgoalref) ^ 2 + (yvec - ygoalref) ^ 2);
	end
end



figure
surf(X, Y, Z)
figure
surf(X, Y, Z2)
% view(0, 90)
% axis equal
