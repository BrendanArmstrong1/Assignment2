
%% Assignment 2

%% Part a
% This part of the assignment fixes one side of the box at voltage Vo
% which is arbitrarily set to 3.

clear
clc
size = 200;
nx = 50;
ny = nx;
dx = size/nx;
dy = size/ny;
Vo = 3;

B = zeros(nx*ny,1);
G = sparse(nx*ny,nx*ny);
 

%% Setting the G matrix
% The matrix is set to fix the left and right side to a constant value
% and the top and bottom are floating.

for i=1:ny
    for j=1:nx
        n=j+(i-1)*ny;
        
        if j==1%-----------left side
            G(n,:) = 0;
            G(n,n) = 1;
        elseif j==ny %-----right side
            G(n,:) = 0;
            G(n,n) = 1;
        elseif i==1%-------top side
            G(n,n) = -2;           
            G(n,n-1) = 1;
            G(n,n+1) = 1;
        elseif i==ny%------bottom side
            G(n,n) = -2;           
            G(n,n-1) = 1;
            G(n,n+1) = 1;
        else        %------bulk mass
            G(n,n) = -4;           
            G(n,n-1) = 1;
            G(n,n+1) = 1;
            if n>=nx
               G(n,n-nx) = 1;
            end
            if n<=length(G)-ny
               G(n,n+ny) = 1; 
            end            
        end
    end
end

%% Setting Potentials
% The values for the fixed ends are calibrated in the B matrix

for i=1:nx:nx*ny %left side
    B(i) = Vo;
end

for i=nx:nx:nx*ny % right side
    B(i) = 0;
end

%% Running Calculations
% The calculation is done and then the calculation vector is transformed
% into a matrix that is representative of the potential values.
calc = G\B;
potential = ones(nx,ny);
for i=1:nx
    for j=1:nx
        potential(i,j) = calc((i-1)*nx+j);
    end
end
surf(potential)
view([45 45])

%% Part b
%
% In this section, both left and right sides are fixed to Vo. The top and
% bottom are fixed to zero

%% Setting the G matrix
% The matrix is set to fix the left and right side to a constant value
% and the top and bottom are also fixed.

for i=1:ny
    for j=1:nx
        n=j+(i-1)*ny;
        
        if j==1%-----------left side
            G(n,:) = 0;
            G(n,n) = 1;
        elseif j==ny %-----right side
            G(n,:) = 0;
            G(n,n) = 1;
        elseif i==1%-------top side
            G(n,:) = 0;
            G(n,n) = 1;
        elseif i==ny%------bottom side
            G(n,:) = 0;
            G(n,n) = 1;
        else        %------bulk mass
            G(n,n) = -4;           
            G(n,n-1) = 1;
            G(n,n+1) = 1;
            if n>=nx
               G(n,n-nx) = 1;
            end
            if n<=length(G)-ny
               G(n,n+ny) = 1; 
            end            
        end
    end
end

%% Setting Potentials
% The values for the fixed ends are calibrated in the B matrix

for i=1:nx:nx*ny %left side
    B(i) = Vo;
end

for i=nx:nx:nx*ny % right side
    B(i) = Vo;
end

%% Running Calculations
% The calculation is done and then the calculation vector is transformed
% into a matrix that is representative of the potential values.
calc = G\B;
potential = ones(nx,ny);
for i=1:nx
    for j=1:nx
        potential(i,j) = calc((i-1)*nx+j);
    end
end
surf(potential)
