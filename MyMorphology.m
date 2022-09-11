function[mhu,m,M,ind_mhu,ind_m,ind_M]=MyMorphology(p_Dmin,b_Dmin, tol)

%cutting off the plateaux
diff_p=p_Dmin(1:end-1)-p_Dmin(2:end);
ind_mhu=find(diff_p>0,1,'first');
p_Dmin=p_Dmin(ind_mhu:end);
b_Dmin=b_Dmin(ind_mhu:end);


figure(10)
loglog(b_Dmin,p_Dmin, 'k')
ylim([1,10])
xlabel('b/D','FontSize',16)
ylabel('p/D','FontSize',16)

pause(0.5)

%1st linear regression
X1=log10(b_Dmin);
Y1=log10(p_Dmin);
[ind_m,mhu,~]=regression(X1,Y1,tol);

%updating the plot with the end index of 1st regression
figure(10)
hold on
loglog(b_Dmin(ind_m),p_Dmin(ind_m),'*b')

disp(['b_Dm=',num2str(b_Dmin(ind_m))])

%2nd linear regression
X2=log10(b_Dmin(ind_m:end));
Y2=log10(p_Dmin(ind_m:end));
[ind_M,m,~]=regression(X2,Y2,tol);

%updating the plot with the end index of 2nd regression
figure(10)
loglog(b_Dmin(ind_M+ind_m-1),p_Dmin(ind_M+ind_m-1),'*r')

%M computing
M=1.14/(p_Dmin(ind_m)-p_Dmin(end));
if M>1
    M=1;
end

%indeces values
ind_m=ind_m+ind_mhu-1;
ind_M=ind_m+ind_M-1;

end
