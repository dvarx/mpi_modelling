function [B] = coil_field(r,z,coil)
%COIL FIELD:    
%   r:      r coordinate where field should be evaluated
%   z:      z coordinate where field should be evaluated
%   coil:   coil structure

%define the integrand for br
integrand_br=@(a_,z_) coil_int_br(r,z,a_,z_);
%define the integrand for bz
integrand_bz=@(a_,z_) coil_int_bz(r,z,a_,z_);

Bz=integral2(integrand_bz,coil.di/2,coil.do/2,-coil.h,0);

Br=integral2(integrand_br,coil.di/2,coil.do/2,-coil.h,0);

B=[Bz;Br];

end

