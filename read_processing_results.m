function [y correct_class observed_class] = read_processing_results(fname)
% This function reads NuClass's processign results file. In case the format
% of this file changes in future version, or you have a different data
% source, modify this file to provide the correct return arguments.
% Author: Rohit Rawat (rohit.rawat@mavs.uta.edu)
% 06/19/2012
% http://www-ee.uta.edu/eeweb/ip/
% Image Processing and Neural Networks Lab, UT Arlington

try
    % Read NuClass style processing results
    x = dlmread(fname);
catch e
    % Read other formats, ignores all lines that don't start with a number
    x = [];
    fid = fopen(fname);
    while(~feof(fid))
        tline = fgetl(fid);
        if(numel(tline)>0 && tline(1)>='0' && tline(1)<='9')
            fprintf('%s\n', tline);
            x = [x; sscanf(tline, '%f')'];
        end
    end
    fclose(fid);
end

Nc = size(x,2) - 3;
y = x(:,2:2+Nc-1);
correct_class = x(:,Nc+2);
observed_class = x(:,Nc+3);
