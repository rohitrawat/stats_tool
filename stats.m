function class = stats(correct_class, calculated_class, Nc)
% Computes sensitivty and specificity. Nc is the number of classes, and is
% usually 2. Calculations are done for each class.
% Author: Rohit Rawat (rohit.rawat@mavs.uta.edu)
% 06/04/2012
% http://www-ee.uta.edu/eeweb/ip/
% Image Processing and Neural Networks Lab, UT Arlington

if(nargin < 3)
    fprintf('Assuming 2 classes.');
    Nc = 2;
end

for positive = 1:Nc
    tp = sum((calculated_class==positive) & (correct_class==positive));
    fp = sum((calculated_class==positive) & (correct_class~=positive));
    tn = sum((calculated_class~=positive) & (correct_class~=positive));
    fn = sum((calculated_class~=positive) & (correct_class==positive));
    class(positive).sensitivity = tp/(tp+fn);
    class(positive).specificity = tn/(fp+tn);
end
