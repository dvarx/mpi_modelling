function [] = plot_coil(coil,n)
%PLOT_COIL Plots a cylindric representation of coil to figure n

figure(n);
hold on;

r=coil.do/2;
[X,Y,Z] = cylinder(r);
X=X+ones(size(X))*coil.ox;
Y=Y+ones(size(Y))*coil.oy;
Z=Z*coil.h;
Z=Z-ones(size(Z))*coil.h;
h=mesh(X,Y,Z,'facecolor',[1, 153/255, 51/255],'FaceAlpha','0.25');
hold on;

r=coil.di/2;
[X,Y,Z] = cylinder(r);
X=X+ones(size(X))*coil.ox;
Y=Y+ones(size(Y))*coil.oy;
Z=Z*coil.h;
Z=Z-ones(size(Z))*coil.h;
h=mesh(X,Y,Z,'facecolor',[1, 153/255, 51/255],'FaceAlpha','0.25');

end

