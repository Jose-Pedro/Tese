x=[1,1,2,3,2,0];
y=[0,1,1,2,3,2,1,0,0];
m=size(y,2);
n=size(x,2);
distances=zeros(m,n);

for i= 1:m
    for j= 1:n
                distances(i,j)=( x(j)-y(i))^2;

    end
end
cost=zeros(m,n);
cost(1,1)=distances(1,1);
for j= 2:n
cost(1,j)=distances(1,j)+cost(1,j-1);
end

for i= 2:m
cost(i,1)=distances(i,1)+cost(i-1,1);
end

% 
for i= 2:m
    for j= 2:n
        h=[cost(i-1, j-1) cost(i-1, j) cost(i, j-1)];
        cost(i,j) = min(h) + distances(i,j);
    end
end