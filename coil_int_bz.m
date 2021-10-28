function Bz = coil_int_bz(r,z,a_,z_)
%INTEGRAND This function computes the integrand of the Biot-Savart integral
%   r:  r coordinate where field should be computed wrto coil origin
%   z:  z coordinate where field should be computed wrto coil origin
%   a_: integration variable a (radius of circular wire loop)
%   z_: integration variable z (z position of circular wire loop)
%   return Bz: function handle for the integrand

mu0=4*pi*1e-7;

%k^2=M=4*a_.*r./((a_+r).^2+(z-z_).^2)
M=4*a_.*r./((a_+r).^2+(z-z_).^2);
[K,E]=ellipke(M);

% function handle for Bz integration
Bz=mu0./(2*pi*sqrt((a_+r).^2+(z-z_).^2))...
    .*(K+E.*((a_.^2-r.^2-(z-z_).^2)./((a_-r).^2+(z-z_).^2)));

end