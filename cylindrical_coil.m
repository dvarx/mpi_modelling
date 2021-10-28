% compute the field of a cylindrical solenoid

mu0=4*pi*1e-7;

%coil structure describing the coil
coil.do=30e-2;
coil.di=20e-2;
coil.h=30e-2;
coil.i=1;
coil.ox=0;
coil.oy=0;

r=30e-2;
z=20e-2;
%current density
N=25;
zs=linspace(-100e-2,100e-2,N);
rs=linspace(0,100e-2,N);
phis=linspace(0,2*pi,N);

zs_plot=zeros(N*N*N,1);
rs_plot=zeros(N*N*N,1);
phis_plot=zeros(N*N*N,1);
xs_plot=zeros(N*N*N,1);
ys_plot=zeros(N*N*N,1);

fields=zeros(N*N*N,3);
fields_cartesian=zeros(N*N*N,3);

% fields(i,j) field at position zs(i), rs(j)
for i=1:1:N
    for j=1:1:N
        for k=1:1:N
            linidx=i+(j-1)*N+(k-1)*N*N;
            r=rs(i);
            z=zs(j);
            phi=phis(k);
            zs_plot(linidx)=z;
            rs_plot(linidx)=r;
            xs_plot(linidx)=r*cos(phi);
            ys_plot(linidx)=r*sin(phi);
            phis_plot(linidx)=phi;
            %alternative way of computation
            fields(linidx,:)=coil_field(r,z,phi,coil);
            fields_cartesian(linidx,3)=fields(linidx,3);
            fields_cartesian(linidx,1:2)=[cos(phi),-sin(phi);sin(phi),cos(phi)]*fields(linidx,1:2)';
        end
    end
end

quiver3(xs_plot,ys_plot,zs_plot,fields_cartesian(:,1),fields_cartesian(:,2),fields_cartesian(:,3));
xlabel("r=x");
ylabel("z");
axis equal
hold on;

r=coil.do/2;
[X,Y,Z] = cylinder(r);
Z=Z*coil.h;
Z=Z-ones(size(Z))*coil.h;
h=mesh(X,Y,Z,'facecolor',[0 0 1],'FaceAlpha','0.25');
hold on;

r=coil.di/2;
[X,Y,Z] = cylinder(r);
Z=Z*coil.h;
Z=Z-ones(size(Z))*coil.h;
h=mesh(X,Y,Z,'facecolor',[0 0 1],'FaceAlpha','0.25');