%define the integrand

fun=@(rho,phi,z,rho0,z0,phi0) rho/(sqrt((z-z0).^2+(rho0^2+rho^2-2*rho*rho0*cos(phi-phi0))).^3)*...
    [z-z0;0;sign(rho-rho0)*sqrt(rho.^2+rho0.^2-2*rho*rho0*cos(phi-phi0))];

funx=@(rho,phi,z) fun(rho,phi,z,1,0,0);

di=20e-2;
do=35e-2;
h=30e-2;


zs=linspace(0,1,100);
Bs=zeros(size(zs));

for i=1:1:length(zs)
    integrand=@(rho,phi,z) fun(rho,phi,z,zs(i),0,0);
    B=integral3(integrand,di/2,do/2,0,2*pi,-h,0);
    Bs(i)=B
end