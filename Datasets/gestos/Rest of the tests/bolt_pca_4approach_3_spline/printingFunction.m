function printingFunction(x_max_size,vector1,vector2,vector3,vector4,vector5,vector6,title_name,x_label,y_label,print_legend,g1,g2,g3,g4,g5,g6)



   
    
    [m,n]=size(vector1);
    T=n*100/10^3;
    t=0:100/10^3:T-100/10^3;
    
    h(1)=plot(t,vector1,'b-*');
    title(title_name);
    axis on;
    ylabel(x_label);
    xlabel(y_label);
    grid on;
    hold on;

    [m,n]=size(vector2);
    T=n*100/10^3;
    t=0:100/10^3:T-100/10^3;
    hold on
    h(2)=plot(t,vector2,'r-x');
    hold on;

    [m,n]=size(vector3);
    T=n*100/10^3;
    t=0:100/10^3:T-100/10^3;
    hold on
    h(3)=plot(t,vector3,'m-.');
    hold on;

    [m,n]=size(vector4);
    T=n*100/10^3;
    t=0:100/10^3:T-100/10^3;
    hold on

    h(4)=plot(t,vector4,'g-o');
    hold on;

    [m,n]=size(vector5);
    T=n*100/10^3;
    t=0:100/10^3:T-100/10^3;
    hold on

    h(5)=plot(t,vector5,'c-+');
    hold on;

    [m,n]=size(vector6);
    T=n*100/10^3;
    t=0:100/10^3:T-100/10^3;
    hold on

    h(6)=plot(t,vector6,'k-s');
    axis ([0 7 -2 2]);
    if(print_legend)
        legend(h, g1, g2, g3, g4, g5, g6);
    end
