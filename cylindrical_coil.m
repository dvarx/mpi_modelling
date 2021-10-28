% compute the field of a cylindrical solenoid

mu0=4*pi*1e-7;

%coil structure describing the coil
coil.do=30e-2;
coil.di=20e-2;
coil.h=30e-2;
coil.i=1;
coil.ox=10e-2;
coil.oy=0;

r=30e-2;
z=20e-2;
%current density
N=25;
zs=linspace(-100e-2,100e-2,N);
rs=linspace(0,100e-2,N);

zs_plot=zeros(N*N,1);
rs_plot=zeros(N*N,1);

fields=zeros(N*N,3);

% fields(i,j) field at position zs(i), rs(j)
for i=1:1:length(zs)
    for j=1:1:length(zs)
        linidx=i+(j-1)*N;
        r=rs(i);
        z=zs(j);
        zs_plot(linidx)=z;
        rs_plot(linidx)=r;
        
        %alternative way of computation
        fields(linidx,:)=coil_field(r,z,0,coil);
    end
end

quiver(rs_plot,zs_plot,fields(:,1),fields(:,3));
xlabel("r=x");
ylabel("z");
axis equal