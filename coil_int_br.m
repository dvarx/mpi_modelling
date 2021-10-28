function Br = coil_int_br(r,z,a_,z_,coil)
%INTEGRAND This function computes the integrand of the Biot-Savart integral
%   The function computes the integrand for the Biot-Savart integral used
%   to compute the magnetic field of a circular current density

mu0=4*pi*1e-7;

%k^2=M=4*a_.*r./((a_+r).^2+(z-z_).^2)
M=4*a_.*r./((a_+r).^2+(z-z_).^2);
[K,E]=ellipke(M);

%check if we are close to the axis r=0, if yes, use the formula for a field
%close to the inductor main axis
if r<1e-7
    Br=zeros(size(a_));
else
    % function handle for Br integration
    Br=mu0./(2*pi*sqrt((a_+r).^2+(z-z_).^2)).*(z-z_)./r...
        .*(-K+E.*((a_.^2+r.^2+(z-z_).^2)./((a_-r).^2+(z-z_).^2)));
end

end

