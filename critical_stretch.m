function [ sc ] = critical_stretch( Gc, Emod, poisson, delta )
%critical_stretch determines sc based on a materials critical energy
%release rate, Gc
% For 2D,(DIC is 2D)  sc is a function of Gc, bulk modulus, shear modulus,
% poisson's raio, horizon size and Young's modulus of elasticity

mu = Emod/(2*(1+poisson));       %shear modulus
kappa = Emod/(3*(1-2*poisson));

sc = sqrt(Gc/ (( 6/pi*mu + 16/(9*pi^2)*(kappa-2*mu))*delta));


end

