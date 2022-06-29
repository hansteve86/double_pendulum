close all
clc
SimTime = 20;
FPS = 10;
TrailDuration = 10; %in frames

m1 = 2;
m2 = 2;
g = 9.8;
l1 = 3;
l2 = 6;

Theta1IC = 45;
Theta1DotIC = 5;
Theta2IC = 45;
Theta2DotIC = 5;
TitleString = sprintf("m1 = %dkg m2 = %dkg L1= %dm L2 = %dm\nInitial Conditions\nTheta = %d° Theta' = %d°/s Theta2 = %d° Theta2' = %d/s°",m1,m2,l1,l2,Theta1IC,Theta1DotIC,Theta2IC,Theta2DotIC);

[time, state_values] = ode45(@(t,x) double_pendulum_func(t,x,m1,m2,g,l1,l2),[0:1/FPS:SimTime],[deg2rad(Theta1IC),deg2rad(Theta1DotIC),deg2rad(Theta2IC),deg2rad(Theta2DotIC)]);

TotalLength = l1 + l2;
VideoDimensions = [-TotalLength*1.2,TotalLength*1.2]; %the 1.2 pads the figure by 20%

Video = VideoWriter("Animation");
Video.FrameRate = FPS;
open(Video);

% 
% figure(1)
% plot(time, state_values(:,1));
% xlabel('time');
% ylabel('position');
% legend('mass 1');
% 
% figure(2)
% plot(time, state_values(:,3));
% xlabel('time');
% ylabel('position');
% legend('mass 2');

Thetas1 = state_values(:,1);
Thetas2 = state_values(:,3);

Trail = length(time):2;


for n = 1:length(time)
    clf; %clear the plot
    %point format is [x1,x2],[y1,y2]
    Theta1 = Thetas1(n) - deg2rad(90); %align 0 degrees to the -y axis
    Theta2 = Thetas2(n) - deg2rad(90);
    
    
    xlabel('x-coordinates (m)');
    ylabel('y-coordinates (m)');
    title(TitleString);
    
    X1 = l1*cos(Theta1);
    Y1 = l1*sin(Theta1);
    
    X2 = X1 + l2*cos(Theta2);
    Y2 = Y1 + l2*sin(Theta2);
    Trail(n,1) = X2;%define trail points from the end of the pendulum
    Trail(n,2) = Y2;%^^^
    
    if n > 1 %Draw trails  
        PrevTrailX = Trail(n,1);
        PrevTrailY = Trail(n,2);
        for TrailNum = 1:min(max(n-1,1),TrailDuration) %draw trails before we reach the required amount of trtail frames
            hold on
            plot([Trail(n-TrailNum,1),PrevTrailX],[Trail(n-TrailNum,2),PrevTrailY],"LineWidth",2)
            hold off;
            PrevTrailX = Trail(n-TrailNum,1);
            PrevTrailY = Trail(n-TrailNum,2);
        end
    end
    
    hold on
    plot([0,X1],[0,Y1],"b","LineWidth",3); %Line 1 
    hold off;
    
    hold on
    plot([X1,X2],[Y1,Y2],"b","LineWidth",3); %Line 2 
    hold off;
    
    hold on
    plot(X1,Y1,"r","Marker","o","MarkerFaceColor","r"); %Point 1
    hold off;
    
    hold on
    plot(X2,Y2,"r","Marker","o","MarkerFaceColor","r"); %Point 2
    hold off;    
    
    hold on
    plot(0,0,"r","Marker","o","MarkerFaceColor","r"); %Hinge
    hold off;
    
    
    xlim(VideoDimensions);%keeps the figure from auto scaling
    ylim(VideoDimensions);%^^^
    CurrentFigure = gcf; %reference to the current figure
    
    Frame = getframe(CurrentFigure);%"capture" the current figure as a frame
    writeVideo(Video,Frame); %write the frame to our video
    
end