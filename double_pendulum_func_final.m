function xdot = double_pendulum_func_alan(~,x,m1,m2,g,l1,l2)

xdot = zeros(4,1);

xdot(1) = x(2);
xdot(2) = (-m2*l2*x(4)*x(4)*sin(x(1)-x(3))-g*(m1+m2)*sin(x(1))*m2*l2-m2*l2*cos(x(1)-x(3))*m2*l1*x(2)*x(2)*sin(x(1)-x(3))-m2*g*sin(x(3)))/((m1+m2)*l1*m2*l2-m2*l1*cos(x(1)-x(3))*m2*l2*cos(x(1)-x(3))) ;
xdot(3) = x(4) ;
xdot(4) = ((m1+m2)*l1*m2*l1*x(2)*x(2)*sin(x(1)-x(3))-m2*g*sin(x(3))-m2*l1*cos(x(1)-x(3))*-m2*l2*x(4)*x(4)*sin(x(1)-x(3))-g*(m1+m2)*sin(x(1)))/((m1+m2)*l1*m2*l2-m2*l1*cos(x(1)-x(3))*m2*l2*cos(x(1)-x(3))) ;
        
    
end