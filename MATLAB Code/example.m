clear
close all
url = 'http://blogs.mathworks.com/images/steve/2011/maze-51x51.png';

%% Drawing the maze
I = imread(url);
%thicken wall to decrease number of options
StartPoint = [1, 497];
EndPoint   = [533, 517];
walls = imdilate(I < 128, ones(9,9));
walls=not(walls);
MAP = double(walls);

%% Start Positions
StartX= 508;
StartY= 505;

%Generating goal nodes, which is represented by a matrix. Several goals can be speciefied, in which case the pathfinder will find the closest goal. 
%a cell with the value 1 represent a goal cell
GoalRegister=int8(zeros(533,533));
FinishX=27;
FinishY=24;
GoalRegister(FinishY,FinishX)=1;

%Number of Neighboors one wants to investigate from each cell. A larger
%number of nodes means that the path can be alligned in more directions. 
%Connecting_Distance=1-> Path can  be alligned along 8 different direction.
%Connecting_Distance=2-> Path can be alligned along 16 different direction.
%Connecting_Distance=3-> Path can be alligned along 32 different direction.
%Connecting_Distance=4-> Path can be alligned along 56 different direction.
%ETC......

Connecting_Distance=8; %Avoid to high values Connecting_Distances for reasonable runtimes. 

% Running PathFinder
OptimalPath=ASTARPATH(StartX,StartY,MAP,GoalRegister,Connecting_Distance)
% End. 

if size(OptimalPath,2)>1
figure(10)
imagesc((MAP))
    colormap(flipud(gray));

hold on
plot(OptimalPath(1,2),OptimalPath(1,1),'o','color','k')
plot(OptimalPath(end,2),OptimalPath(end,1),'o','color','b')
hold on
l=length(OptimalPath)
for i=1:l/100:l-l/100
    plot(OptimalPath(i:i+l/100,2),OptimalPath(i:i+l/100,1),'r', 'Linewidth', 2)
    pause(.1)
    hold on
end
legend('Goal','Start','Path')

else 
     pause(1);
 h=msgbox('Sorry, No path exists to the Target!','warn');
 uiwait(h,5);
 end









showNeighboors=0; %Set to 1 if you want to visualize how the possible directions of path. The code
%below are purley for illustrating purposes. 
if showNeighboors==1
%



%2
NeigboorCheck=[0 1 0 1 0;1 1 1 1 1;0 1 0 1 0;1 1 1 1 1;0 1 0 1 0]; %Heading has 16 possible allignments
[row col]=find(NeigboorCheck==1);
Neighboors=[row col]-(2+1);
figure(2)

for p=1:size(Neighboors,1)
  i=Neighboors(p,1);
       j=Neighboors(p,2);
      
     plot([0 i],[0 j],'k')
 hold on
 axis equal
 
grid on
title('Connecting distance=2')
end

%3
NeigboorCheck=[0 1 1 0 1 1 0;1 0 1 0 1 0 1;1 1 1 1 1 1 1;0 0 1 0 1 0 0;1 1 1 1 1 1 1;1 0 1 0 1 0 1;0 1 1 0 1 1 0]; %Heading has 32 possible allignments
figure(3)
[row col]=find(NeigboorCheck==1);
Neighboors=[row col]-(3+1);

for p=1:size(Neighboors,1)
  i=Neighboors(p,1);
       j=Neighboors(p,2);
      
     plot([0 i],[0 j],'k')
 hold on
 axis equal
 grid on
title('Connecting distance=3')

end
 
%4
NeigboorCheck=[0 1 1 1 0 1 1 1 0;1 0 1 1 0 1 1 0 1;1 1 0 1 0 1 0 1 1;1 1 1 1 1 1 1 1 1;0 0 0 1 0 1 0 0 0;1 1 1 1 1 1 1 1 1;1 1 0 1 0 1 0 1 1 ;1 0 1 1 0 1 1 0 1 ;0 1 1 1 0 1 1 1 0];  %Heading has 56 possible allignments
figure(4)
[row col]=find(NeigboorCheck==1);
Neighboors=[row col]-(4+1);

for p=1:size(Neighboors,1)
  i=Neighboors(p,1);
       j=Neighboors(p,2);
      
     plot([0 i],[0 j],'k')
 hold on
 axis equal
grid on
title('Connecting distance=4')

end
%1
NeigboorCheck=[1 1 1;1 0 1;1 1 1];
figure(1)
[row col]=find(NeigboorCheck==1);
Neighboors=[row col]-(1+1);

for p=1:size(Neighboors,1)
  i=Neighboors(p,1);
       j=Neighboors(p,2);
      
     plot([0 i],[0 j],'k')
 hold on
 axis equal
grid on
title('Connecting distance=1')

end
end


