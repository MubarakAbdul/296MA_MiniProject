clear 
close all
%% plot all frames
% load('allMAP');
% load('allPath');
% for i = 400:length(allPath) 
%     curPath = allPath{i}; 
%     figure 
%     contour(allMAP{i});	
%     hold on 
%     grid on 
%     if(~isempty(curPath)) 
%         plot(curPath(:, 2), curPath(:, 1)) 
%     end
% end

%% run A*
xStart = 20;
yStart = 5;
xTarget = 90;
yTarget = 50;
M = -1*ones(100,100);
for i = 3:37
    for j = 1:100
        M(i,j) = 2;
    end
end
for i = 38:100
    for j = 30:60
        M(i,j) = 2;
    end
end
veh = -1*ones(1,20)
M(50,45:55) = veh(1:11);
M(50:69,45) = veh(1:20);
M(69,45:55) = veh(1:11);
M(50:69,55) = veh(1:20);
% M(20,20:22) = veh(1:3);
% M(20:22,20) = veh(1:3);
% M(51,51) = -1;
% M(52,52) = -1;
        
contour(M)
hold on;
plot(yStart,xStart,'ro');
hold on;
plot(yTarget,xTarget,'bo');
hold on;
% cost = zeros(100,100);
% list1 = [];
% for x = 1:100
%     for y = 1:100
%         if MF(x,y) == -1
%             list1 = [list1; x-1, y; x+1, y; x, y-1; x, y+1];
%         end
%     end
% end
% 
% for n = 1:numel(list1)/2
%     if list1(n,1)<=0 || list1(n,1)>100 || list1(n,2)<=0 || list1(n,2)>100 
%         continue;
%     end
%     MF(list1(n,1),list1(n,2)) = -1;
% end
% for x = 1:100
%     for y = 1:100
%         if MF(x,y) == -1
%             list1 = [list1; x-1, y; x+1, y; x, y-1; x, y+1];
%         end
%     end
% end
% for n = 1:numel(list1)/2
%     if list1(n,1)<=0 || list1(n,1)>100 || list1(n,2)<=0 || list1(n,2)>100 
%         continue;
%     end
%     MF(list1(n,1),list1(n,2)) = -1;
% end
contour(M)
Optimal_path = aStarFunc(M,xStart, yStart,xTarget,yTarget)
%contour(cost);





















