function[b_Dmin,p_Dmin]=fractal_analysis(geom,boundary,n_b)

D_eq=geom(1);
perim=geom(2);

%number of boundary pixels
n=length(boundary(:,1));

%number of starting point = n
n_p=round(n);

%variables initialization
bacc=zeros(n_b,n_p-1);
b_D=zeros(size(bacc));
p_b=zeros(size(bacc));
p_D=zeros(size(bacc));

% LOOP 1 -> run over the differnt starting points            
for nn=1:n_p
    %sorting the boundary matrix accounting different starting point
    iniz=nn*round(n/n_p);
    bound=[boundary(iniz:end,:); boundary(1:iniz-1,:)];
    x=bound(:,1);
    y=bound(:,2);
         
    %vector of distances between the starting point and all the other point
    %of the boundary
    for i=1:n
        dist(i)=sqrt((bound(1,1)-bound(i,1))^2+(bound(1,2)-bound(i,2))^2);
    end
    
    %maximum distance
    [dist_max,~]=max(dist);
    
    %If the maximum distance is longer than D_eq, the characteristic
    %dimension id fixed to the maximum distance, else the D_Eq is
    %considered as the maximum distance.
    if D_eq>dist_max
        D=dist_max;
    else
        D=D_eq;
    end
    %stick length vector
    alpha=logspace(-3,0,n_b);
    bacc(1:n_b,nn)=alpha'.*D;
    
    % LOOP 2 -> Run over the stick length
    for m=1:n_b
        %value of stick length
        b=bacc(m,nn);
    
        %initialization of variables
        %initial boundary coordinates
        x0=bound(1,1); 
        y0=bound(1,2);
        seg=0;  %contour length
        k=1; %counter
        %initial intersection coordinates
        xi=x0;
        yi=y0;
        p(1,1)=xi;
        p(1,2)=yi;
    
 
        %LOOP 3 -> Detection of the intersection points
        j=1; %counter fixed to the starting point
    
        while j<n %it runs till the boundary ends
            j=j+1; %increasing the counter
            %distance between the starting point and the susequent point of the boundary
            dist=sqrt((xi-x(j))^2+(yi-y(j))^2);
 
            if dist>=b %Intersection detected!
                %Update of variables
                seg=seg+dist;
                xi=x(j);
                yi=y(j);
                k=k+1;
                %p contains the intersection coordinates on the k-th column 
                %relative to the m-th stick length
                p(k,1)=xi;
                p(k,2)=yi;
            end 
        end %LOOP 3

        disp([num2str(nn/n_p*100,'%.1f%%')])
        %particle perimeter
        p_b(m,nn)=(seg+sqrt((xi-x0)^2+(yi-y0)^2));

    end %LOOP 2 

    %Normalization of p and b
    p_D(:,nn)=p_b(:,nn)./D_eq;
    b_D(1:n_b,nn)=bacc(1:n_b,nn)./D_eq;


end %LOOP 1 


p_Dmin=zeros(n_b,1);
b_Dmin=zeros(n_b,1);
Ip_min=zeros(n_b,1);

%For each stick length, the minimum perimeter along the values correspoding
%to the differnt starting point is taken
for i=1:n_b
    [p_Dmin(i),Ip_min(i)]=min(p_D(i,:));
    b_Dmin(i)=b_D(i,Ip_min(i));
end

%Plotting results
figure()
loglog(b_Dmin,p_Dmin)
xlabel('b/D','FontSize',16)
ylabel('p/D','FontSize',16)

end

