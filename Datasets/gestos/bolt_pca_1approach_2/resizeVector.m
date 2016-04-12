function [ out ] = resizeVector( vector2D , size )
% vector2D - is a two line vector (each line is a dimension, each column is a pair of values)
% size - is the new size for the vector

x=vector2D(1,:);
y=vector2D(2,:);

fn1=cscvn([x;y]);
t=linspace(fn1.breaks(1),fn1.breaks(end),size);
out=fnval(fn1,t);

end

