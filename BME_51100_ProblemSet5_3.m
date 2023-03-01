%% Read and save the diabetes dataset into a table
T = readtable("diabetes.txt");
%disp(size(T));
Ttrain = T(1:354, :);
Ttest = T(355:end, :);

%% Plot the predictor and response variable of interest
plot3(Ttrain.BMI, Ttrain.S6, Ttrain.Y, '.');
xlabel('BMI', 'fontsize', 16);
ylabel('S6', 'fontsize', 16);
zlabel('Y', 'fontsize', 16);
grid on

%% Fit a linear model, taking into account the third variable BP
A = [Ttrain.BMI, Ttrain.S6, Ttrain.BP, ones(size(Ttrain.BMI))];
P = inv(A'*A)*A';
beta_hat = P*Ttrain.Y;  %Model Coefficients
disp(beta_hat);

%% Testing the fitted model with an independent dataset
y_hat = [Ttest.BMI, Ttest.S6, Ttest.BP, ones(size(Ttest.BMI))]*beta_hat;
figure;
plot(y_hat, Ttest.Y, 'o', 'markersize', 8);
hold on;
plot(0:350); %45 degree line
ylabel('Measured diabetes progression', 'fontsize', 16);
xlabel('Predicted diabetes progression', 'fontsize', 16);
