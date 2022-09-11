function[ind,D_fr,Q]=regression(X,Y,toll)

dR2=zeros(size(X));
a=zeros(size(X));
b=0*a;
i=6;
R2=ones(size(X));
x=X(1:i);
y=Y(1:i);
x2=x.^2;
xy=x.*y;
N=i;
    
Sx=sum(x);
Sy=sum(y);
Sxy=sum(xy);
Sx2=sum(x2);
    
a (i) = ( N*Sxy - Sx*Sy )/( N*Sx2-Sx*Sx);
b (i) = ( Sx2*Sy - Sxy*Sx )/( N*Sx2-Sx*Sx);
    
y_fit = a(i).*x+b(i);
diff = (y-y_fit).^2;
R2(i)= 1 - sum(diff);


while dR2(i)<toll | i==length(X)
    i=i+1;
    x=X(1:i);
    y=Y(1:i);
    x2=x.^2;
    xy=x.*y;
    N=i;
    
    Sx=sum(x);
    Sy=sum(y);
    Sxy=sum(xy);
    Sx2=sum(x2);
    
    a (i) = ( N*Sxy - Sx*Sy )/( N*Sx2-Sx*Sx);
    b (i) = ( Sx2*Sy - Sxy*Sx )/( N*Sx2-Sx*Sx);
    
    y_fit = a(i).*x+b(i);
    diff = (y-y_fit).^2;
    R2(i)= 1 - sum(diff);
    dR2(i)=R2(i-1)-R2(i);
    
    if i==length(X)
        disp('ERROR')
    end
end

% figure()
% plot(10.^x,dR2(1:i))
% title('Linear Regression')

ind=i-1;
D_fr=-a(ind);
Q=b(ind);

end
% end