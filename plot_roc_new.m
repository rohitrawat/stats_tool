function plot_roc_new(AUC_curves, save_as_jpeg)
% This script averages the supplied AUC curves and displays the averaged
% plot with errorbars showing the standard deviation. Plots are vertically
% averaged, and standard deviation shown in red.
% See below for settings for an alternative plot.
% Author: Rohit Rawat (rohit.rawat@mavs.uta.edu)
% 06/04/2012
% http://www-ee.uta.edu/eeweb/ip/
% Image Processing and Neural Networks Lab, UT Arlington

N_fold = length(AUC_curves.X);

allX = [];
allY = [];

% iX = [0; 0.25; 0.5; 0.75; 1];
for i = 1:N_fold
    X = AUC_curves.X{i};
    Y = AUC_curves.Y{i};

    allX = [allX; X];
    allY = [allY; Y];

end

dx = 0.001;
uX = [0:dx:1]';

% Use the following to get the curve at only a few points connected by
% lines. Looks better, but not accurate in between the points.
% uX = unique(allX);

mY = zeros(size(uX));
sY = mY;
for i = 1:N_fold

    X = AUC_curves.X{i};
    Y = AUC_curves.Y{i};
    uY = [];
    for k=1:length(uX)
        a = Y(X == uX(k));
        if(isempty(a))
            for j=1:length(X)
                if(X(j)<uX(k) && X(j+1)>uX(k))  % locate
                    uY(k) = (Y(j+1) - Y(j))/(X(j+1) - X(j)) + Y(j);
                end
            end
        else
            uY(k) = max(a);
        end
    end

    mY = mY + uY';
    sY = sY + (uY').^2;
end
mY = mY/N_fold;
sY = sY/N_fold;
sY = sY - mY.^2;

figure;
h = plot(uX, mY);
hold on;
hE = errorbar(uX, mY,sY);
axis([0 1 0 1]);
xlabel('False positive rate'); ylabel('True positive rate'); 
title('ROC for classification');
set(hE                            , ...
  'LineStyle'       , 'none'           , ...
  'Color' , [0.9 .2 .2]    , ...
  'LineWidth'       , 3           , ...
  'Marker'          , 'o'         , ...
  'MarkerSize'      , 2           , ...
  'MarkerEdgeColor' , [.2 .2 .2]  , ...
  'MarkerFaceColor' , [.7 .7 .7]  );

if(save_as_jpeg)
    saveas(h, 'averaged_ROC_plot.jpg');
end
