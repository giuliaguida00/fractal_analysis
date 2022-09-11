tic

clc
clear all
close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FRACTAL ANALYSIS OF PARTICLE CONTOUR 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Developer:     Giulia Guida          
%  Last Update:   2018-09-17            
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Note_ Before using the code, read the 'instruction_guide.pdf' attached


% INPUTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%name of the image file to anlayse
filename='Grain1-bw.jpg';

%number of stick lengths
n_b=50;
%tolerance for the linear regression
tol=0.0001;

% LOADING THE IMAGE & BOUNDARY EXTRACTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%name of the folder containing binarized images of single grains
folder='grains';
%input path
path_in=sprintf('%s/%s',folder,filename);

%loading image
bw=imread(path_in);
%boundary extraction
[boundary,cc]=boundary(bw);
x=boundary(:,1);
y=boundary(:,2);

figure()
subplot(2,1,1), imshow(bw),title('Binarized Image')
subplot(2,1,2), plot(y,-x,'k'),title('Particle Contour'), axis off, axis equal
pause(0.5)

% Evaluation of geometrical and morphological descriptors
[geom,shape] = descriptor(cc);


%% FRACTAL ANALYSIS

[b_D , p_D] = fractal_analysis(geom,boundary,n_b);

%% FRACTAL MORPHOLOGY DESCRIPTORS

[mhu,m,M,ind_mhu,ind_m,ind_M]=MyMorphology(p_D,b_D, tol);
disp(['mhu = ',num2str(mhu)])
disp(['m = ',num2str(m)])
disp(['M = ',num2str(M)])

%% SAVING DATA
%All the data are sved in a excel file

%excel sheet name
sheet=filename;

row_header1  = {'x','y','-',...
    'b/D','p/D',' ',...
    'geom',' ','shape',' ',...
     'fractal_shape',' ',...
     'p_b'
};

column1={'diameter';'perimeter';'area'};
column2={'C';'AR';'CX'};
column3={'M';'m';char(956)};
column4={'b/D|micro';'p/D|micro';'b/D|meso';'p/D|meso';'b/D|macro';'p/D|macro'};


xlswrite('results.xls' , row_header1, sheet, 'A1');
xlswrite('results.xls' , x, sheet, 'A3');
xlswrite('results.xls' , y, sheet, 'B3');
xlswrite('results.xls' , b_D, sheet, 'D3');
xlswrite('results.xls' , p_D, sheet, 'E3');
xlswrite('results.xls' , column1, sheet, 'F3');
xlswrite('results.xls' , geom', sheet, 'G3');
xlswrite('results.xls' , column2, sheet, 'H3');
xlswrite('results.xls' , shape, sheet, 'I3');
xlswrite('results.xls' , column3, sheet, 'j3');
xlswrite('results.xls' , M, sheet, 'k3');
xlswrite('results.xls' , m, sheet, 'k4');
xlswrite('results.xls' , mhu, sheet, 'k5');
xlswrite('results.xls' , column4, sheet, 'l3');
xlswrite('results.xls' , b_D(ind_mhu), sheet, 'm3');
xlswrite('results.xls' , p_D(ind_mhu), sheet, 'm4');
xlswrite('results.xls' , b_D(ind_m), sheet, 'm5');
xlswrite('results.xls' , p_D(ind_m), sheet, 'm6');
xlswrite('results.xls' , b_D(ind_M), sheet, 'm7');
xlswrite('results.xls' , p_D(ind_M), sheet, 'm8');

toc
