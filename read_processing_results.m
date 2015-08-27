function [y correct_class observed_class] = read_processing_results(fname)
% This function reads NuClass's processign results file. In case the format
% of this file changes in future version, or you have a different data
% source, modify this file to provide the correct return arguments.
% Author: Rohit Rawat (rohit.rawat@mavs.uta.edu)
% 06/19/2012
% http://www-ee.uta.edu/eeweb/ip/
% Image Processing and Neural Networks Lab, UT Arlington

x = dlmread(fname);

Nc = size(x,2) - 3;
y = x(:,2:2+Nc-1);
correct_class = x(:,Nc+2);
observed_class = x(:,Nc+3);
