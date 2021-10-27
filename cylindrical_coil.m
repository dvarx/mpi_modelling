% compute the field of a cylindrical solenoid

mu0=4*pi*1e-7;

%coil structure describing the coil
coil.do=30e-2;
coil.di=20e-2;
coil.h=30e-2;
coil.i=1;
coil.ox=1e-3;
coil.oy=0;

r=30e-2;
z=20e-2;
%current density
N=25;
zs=linspace(-100e-2,100e-2,N);
rs=linspace(0,100e-2,N);
fields=zeros(length(zs),length(zs),2);
fields_control=zeros(length(zs),length(zs),2);

[zs_grid,rs_grid]=meshgrid(zs,rs);
% fields(i,j) field at position zs(i), rs(j)
for i=1:1:length(zs)
    for j=1:1:length(zs)
        r=rs_grid(i,j);
        z=zs_grid(i,j);
        %define the integrand for br
        integrand_br=@(a_,z_) coil_int_br(r,z,a_,z_);
        %define the integrand for bz
        integrand_bz=@(a_,z_) coil_int_bz(r,z,a_,z_);
        %integrate the integrands
        fields(i,j,1)=integral2(integrand_bz,coil.di/2,coil.do/2,-coil.h,0);
        fields(i,j,2)=integral2(integrand_br,coil.di/2,coil.do/2,-coil.h,0);
        
        %alternative way of computation
        fields_control(i,j,:)=coil_field(r,z,0,coil);
    end
end

figure(1);
quiver(zs_grid,rs_grid,fields(:,:,1),fields(:,:,2));
%alternative computation by directly calling coil_field function
figure(2);
quiver(zs_grid,rs_grid,fields_control(:,:,1),fields_control(:,:,2));