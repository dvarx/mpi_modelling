function Bz = coil_int_bz(r,z,a_,z_)
%INTEGRAND This function computes the integrand of the Biot-Savart integral
%   The function computes the integrand for the Biot-Savart integral used
%   to compute the magnetic field of a circular current density

mu0=4*pi*1e-7;

k=sqrt(4*a_.*r./((a_+r).^2+(z-z_).^2));
[K,E]=ellipke(k);

% function handle for Bz integration
Bz=mu0./(2*pi*sqrt((a_+r).^2+(z-z_).^2))...
    .*(K+E.*((a_.^2-r.^2-(z-z_).^2)./((a_-r).^2+(z-z_).^2)));

end