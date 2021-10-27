function [B] = coil_field(r_wrto,z_wrto,phi_wrto,coil)
%COIL FIELD:    
%   r_wrto:      r coordinate where field should be evaluated wrt main
%   origin
%   z_wrto:      z coordinate where field should be evaluated wrt main
%   origin
%   phi_wrto:    phi coordintae where field should be evaluated wrt main
%   origin
%   coil:       coil structure
%   B:          B(1): z component B(2): r component

%check if the coil center axis is offset wrt to the main coordinate system
%z axis. If it is, compute coordinate locations in this coils coordinate
%system (r,phi)
coil_offset=(coil.ox>1e-9)|(coil.oy>1e-9);
if(coil_offset)
    r=sqrt((cos(phi_wrto)*r_wrto-coil.ox)^2+(sin(phi_wrto)*r_wrto^2));
else
    r=r_wrto;
end

%we compute the magnetic field first in the coordinate system of the coil
%define the integrand for br
integrand_br=@(a_,z_) coil_int_br(r,z_wrto,a_,z_);
%define the integrand for bz
integrand_bz=@(a_,z_) coil_int_bz(r,z_wrto,a_,z_);

Bz=integral2(integrand_bz,coil.di/2,coil.do/2,-coil.h,0);
Br=integral2(integrand_br,coil.di/2,coil.do/2,-coil.h,0);

%if necessary, we transform the solution back into the main coordinate
%system
if(coil_offset)
    x=r_wrto*cos(phi_wrto);
    y=r_wrto*sin(phi_wrto);
    %compute solution in cartesian coordinates wrt main origin
    B=(Br*[x-coil.ox;y-coil.oy]+Bz*[-(y-coil.oy);x-coil.oy])...
        /(sqrt((x-coil.ox)^2+(y-coil.oy)^2));
    %convert solution to cylindrical coordinates wrt main origin
    B=[x,-y;y,x]/(sqrt(x^2+y^2))*B;
else
    B=[Bz;Br];
end

