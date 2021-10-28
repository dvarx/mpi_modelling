% compute the field of a cylindrical solenoid

mu0=4*pi*1e-7;

%coil structure describing the coil
coil.do=30e-2;
coil.di=20e-2;
coil.h=30e-2;
coil.i=1;
coil.ox=20e-2;
coil.oy=20e-2;

%current density
N=25;
xs=linspace(coil.ox-coil.do,coil.ox+coil.do,N);
ys=linspace(coil.oy-coil.do,coil.oy+coil.do,N);
zs=linspace(-1,1,N);

zs_plot=zeros(N*N*N,1);
xs_plot=zeros(N*N*N,1);
ys_plot=zeros(N*N*N,1);

fields=zeros(N*N*N,3);
fields_cartesian=zeros(N*N*N,3);

% fields(i,j) field at position zs(i), rs(j)
tic
for i=1:1:N
    for j=1:1:N
        for k=1:1:N
            linidx=i+(j-1)*N+(k-1)*N*N;
            x=xs(i);
            y=ys(j);
            z=zs(k);
            phi=atan2(y,x);
            zs_plot(linidx)=z;
            xs_plot(linidx)=x;
            ys_plot(linidx)=y;
            
            fprintf("\nx:%f,y:%f,z:%f\n",x,y,z);
            
            %alternative way of computation
            fields(linidx,:)=coil_field(sqrt(x^2+y^2),z,phi,coil);
            fields_cartesian(linidx,3)=fields(linidx,3);
            fields_cartesian(linidx,1:2)=fields(linidx,1:2)';
        end
    end
end
toc

quiver3(xs_plot,ys_plot,zs_plot,fields_cartesian(:,1),fields_cartesian(:,2),fields_cartesian(:,3),3,'Color',[0.4660 0.6740 0.1880]);
xlabel("x");
ylabel("y");
axis equal
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