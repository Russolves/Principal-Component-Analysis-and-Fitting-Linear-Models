clear;

%% Load the gene expression data using import data
load('HW_geneExpressionData.mat');
% disp(size(X))

[eigvecs, PCs, ~, ~, varExplained] = pca(X);

%% Plotting the top two or three principal components using scatter
if size(eigvecs,2) == 2   %Checks if there are two principal components
    scatter(PCs(:,1),PCs(:,2));
    xlabel('PC1', 'fontsize', 16);
    ylabel('PC2', 'fontsize', 16);
elseif size(eigvecs,2) >= 3 %Checks if there are 3 principal components
        plot3(PCs(:,1),PCs(:, 2), PCs(:,3), 'o');
        xlabel('PC1', 'fontsize', 16);
        ylabel('PC3', 'fontsize', 16);
        zlabel('PC2', 'fontsize', 16);
        grid on;
end



