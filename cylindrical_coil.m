% compute the field of a cylindrical solenoid

mu0=4*pi*1e-7;
Ncoil=1000;
di=50e-3;
do=90e-3;
Jcoil=10/((90e-3-50e-3)*85e-3);

%coil structure describing the coil
%coil 1 definition
coil_1.do=90e-3;
coil_1.di=50e-3;
coil_1.h=85e-3;
coil_1.i=1;
coil_1.ox=-49e-3;
coil_1.oy=28.29e-3;
coil_1.Jcoil=Jcoil;
%coil 2 definition
coil_2.do=90e-3;
coil_2.di=50e-3;
coil_2.h=85e-3;
coil_2.i=1;
coil_2.ox=49e-3;
coil_2.oy=28.29e-3;
coil_2.Jcoil=Jcoil;
%coil 3 definition
coil_3.do=90e-3;
coil_3.di=50e-3;
coil_3.h=85e-3;
coil_3.i=1;
coil_3.ox=0;
coil_3.oy=-56.58e-3;
coil_3.Jcoil=Jcoil;

coil_config.coils=[coil_1,coil_2,coil_3];

%current density
N=25;
xs=linspace(-0.2,0.2,N);
ys=linspace(-0.2,0.2,N);
zs=linspace(-0.3,0.3,N);

coil_config.zs_plot=zeros(N*N*N,1);
coil_config.xs_plot=zeros(N*N*N,1);
coil_config.ys_plot=zeros(N*N*N,1);

coil_1.fields=zeros(N*N*N,3);
coil_2.fields=zeros(N*N*N,3);
coil_3.fields=zeros(N*N*N,3);

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
            coil_config.zs_plot(linidx)=z;
            coil_config.xs_plot(linidx)=x;
            coil_config.ys_plot(linidx)=y;
            
            %fprintf("\nx:%f,y:%f,z:%f\n",x,y,z);
            
            %compute field of coil 1
            coil_1.fields(linidx,:)=coil_field(sqrt(x^2+y^2),z,phi,coil_1);
            coil_1.fields_cartesian(linidx,3)=coil_1.fields(linidx,3);
            coil_1.fields_cartesian(linidx,1:2)=coil_1.fields(linidx,1:2)';
            %compute field of coil 2
            coil_2.fields(linidx,:)=coil_field(sqrt(x^2+y^2),z,phi,coil_2);
            coil_2.fields_cartesian(linidx,3)=coil_2.fields(linidx,3);
            coil_2.fields_cartesian(linidx,1:2)=coil_2.fields(linidx,1:2)';
            %compute field of coil 3
            coil_3.fields(linidx,:)=coil_field(sqrt(x^2+y^2),z,phi,coil_3);
            coil_3.fields_cartesian(linidx,3)=coil_3.fields(linidx,3);
            coil_3.fields_cartesian(linidx,1:2)=coil_3.fields(linidx,1:2)';
        end
    end
end
toc

coil_config.coils(1).fields_cartesian=coil_1.fields_cartesian;
coil_config.coils(2).fields_cartesian=coil_2.fields_cartesian;
coil_config.coils(3).fields_cartesian=coil_3.fields_cartesian;

plot_coil_field(coil_config,1);
hold on;
quiver3(zeros(3,1),zeros(3,1),zeros(3,1),[0.25;0;0],[0;0.25;0],[0;0;0.25],'color','black');
plot_coil(coil_1,1);
plot_coil(coil_2,1);
plot_coil(coil_3,1);

axis equal;