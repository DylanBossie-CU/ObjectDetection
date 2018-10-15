%% Author: Joshua Kirby
% Created: 10/10/2018
% Modified: 10/10/2018
%
% Purpose: Receives a three-dimensional position and velocity vector of 
% an object vectors of three-dimensional position and velocity uncertainty 
% (1sigma).  It will return the time and temporal uncertainty of when
% the object passed through the xy-plane.  Note that this code assumes that
% the object is truly moving only in the z direction, so components of R,
% dR, V, and dV in the xy-plane can be ignored when calculating launch
% time.
%
% Inputs (consistent units):
%   R   - 3D position vector
%   dR  - 3D position uncertainty vector (1sigma, always positive values)
%   V   - 3D velocity vector
%   dV  - 3D velocity uncertainty vector (1sigma, always positive values)
%
% Outputs (units consistent with input units):
%   ToL  - time of launch, i.e. time when object passed through xy-plane
%   dToL - uncertainty in time of launch (1sigma)
%
function [ToL,dToL] = TimeOfLaunch(R,dR,V,dV)
%% Extraction of relevant data
z = R;
dz = abs(dR);
zdot = V;
dzdot = abs(dV);

%% Calculation of ToL
ToL = abs(z/zdot);

%% Calculation of dToL
dToL = ToL*(dz/abs(z) + dzdot/abs(zdot));







end