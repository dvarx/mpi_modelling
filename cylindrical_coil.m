% compute the field of a cylindrical solenoid

mu0=4*pi*1e-7;

%coil structure describing the coil
%coil 1 definition
coil_1.do=30e-2;
coil_1.di=20e-2;
coil_1.h=30e-2;
coil_1.i=1;
coil_1.ox=20e-2;
coil_1.oy=20e-2;
%coil 2 definition
coil_2.do=30e-2;
coil_2.di=20e-2;
coil_2.h=30e-2;
coil_2.i=1;
coil_2.ox=-20e-2;
coil_2.oy=-20e-2;

coil_config.coils=[coil_1,coil_2];

%current density
N=25;
xs=linspace(-1,1,N);
ys=linspace(-1,1,N);
zs=linspace(-1,1,N);

coil_config.zs_plot=zeros(N*N*N,1);
coil_config.xs_plot=zeros(N*N*N,1);
coil_config.ys_plot=zeros(N*N*N,1);

coil_1.fields=zeros(N*N*N,3);

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
        end
    end
end
toc

coil_config.coils(1).fields_cartesian=coil_1.fields_cartesian;
coil_config.coils(2).fields_cartesian=coil_2.fields_cartesian;

plot_coil_field(coil_config,1);
plot_coil(coil_1,1);
plot_coil(coil_2,1);