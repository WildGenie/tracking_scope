%% Comparing model errors

read_trajectory=readtable('x_trajectory.csv');
x_trajectory=read_trajectory.Var1/10;
xstar=x_trajectory(14000:17000-1);

load('output_read_position.mat')
model_direct_command=inScanDat;
load('output_MPC_T20_predicted.mat')
MPC_T20_know_future=output;
load('output_MPC_T50_predicted.mat')
MPC_T50_know_future=output;
load('output_MPC_T100_predicted.mat')
MPC_T100_know_future=output;
load('output_MPC_T20_naive_model.mat')
MPC_T20_naive_model=output;
load('output_MPC_T50_naive_model.mat')
MPC_T50_naive_model=output;
load('output_MPC_T100_naive_model.mat')
MPC_T100_naive_model=output;

%FULL TRAJECTORY
load('output_read_position_full.mat')
model_direct_command_full=inScanDat;
load('output_MPC_T170_predicted_full.mat')
MPC_T170_know_future=output;
load('output_MPC_T250_predicted_full.mat')
MPC_T250_know_future=output;
load('output_MPC_T170_naive_model_full.mat')
MPC_T170_naive_model=output;
load('output_MPC_T250_naive_model_full.mat')
MPC_T250_naive_model=output;
%

% 
% RMSE_direct_command= sqrt(mean((xstar-model_direct_command(2:end)).^2)); %root mean square error
% RMSE_MPC_T20_know_future= sqrt(mean((xstar(20:end)-MPC_T20_know_future).^2));
% RMSE_MPC_T50_know_future= sqrt(mean((xstar(50:end)-MPC_T50_know_future).^2));
% RMSE_MPC_T100_know_future= sqrt(mean((xstar(100:end)-MPC_T100_know_future).^2));
% RMSE_MPC_T20_naive_model= sqrt(mean((xstar-MPC_T20_naive_model(2:end)).^2));
% RMSE_MPC_T50_naive_model= sqrt(mean((xstar-MPC_T50_naive_model(2:end)).^2));
% RMSE_MPC_T100_naive_model= sqrt(mean((xstar-MPC_T100_naive_model(2:end)).^2));

RMSE_direct_command=RMSE_calculator(xstar,model_direct_command);
RMSE_MPC_T20_know_future=RMSE_calculator(xstar,MPC_T20_know_future);
RMSE_MPC_T50_know_future=RMSE_calculator(xstar,MPC_T50_know_future);
RMSE_MPC_T100_know_future=RMSE_calculator(xstar,MPC_T100_know_future);
RMSE_MPC_T20_naive_model=RMSE_calculator(xstar,MPC_T20_naive_model);
RMSE_MPC_T50_naive_model=RMSE_calculator(xstar,MPC_T50_naive_model);
RMSE_MPC_T100_naive_model=RMSE_calculator(xstar,MPC_T100_naive_model);

%FULL TRAJECTORY
error_direct_command_full=x_trajectory-model_direct_command_full(2:end);
error_MPC_T170_know_future=x_trajectory(1:end-(abs(length(x_trajectory)-length(MPC_T170_know_future))))-MPC_T170_know_future;
error_MPC_T250_know_future=x_trajectory(1:end-(abs(length(x_trajectory)-length(MPC_T250_know_future))))-MPC_T250_know_future;
error_MPC_T170_naive_model=x_trajectory-MPC_T170_naive_model(2:end);
error_MPC_T250_naive_model=x_trajectory-MPC_T250_naive_model(2:end);
%

error_direct_command=xstar-model_direct_command(2:end);
error_MPC_T20_know_future=xstar(1:end-19)-MPC_T20_know_future;
error_MPC_T50_know_future=xstar(1:end-49)-MPC_T50_know_future;
error_MPC_T100_know_future=xstar(1:end-99)-MPC_T100_know_future;
error_MPC_T20_naive_model=xstar-MPC_T20_naive_model(2:end);
error_MPC_T50_naive_model=xstar-MPC_T50_naive_model(2:end);
error_MPC_T100_naive_model=xstar-MPC_T100_naive_model(2:end);

[error_count_direct_command,max_error_direct_command,min_error_direct_command]=error_calculator(error_direct_command);
[error_count_MPC_T20_know_future,max_error_MPC_T20_know_future,min_error_MPC_T20_know_future]=error_calculator(error_MPC_T20_know_future);
[error_count_MPC_T50_know_future,max_error_MPC_T50_know_future,min_error_MPC_T50_know_future]=error_calculator(error_MPC_T50_know_future);
[error_count_MPC_T100_know_future,max_error_MPC_T100_know_future, min_error_MPC_T100_know_future]=error_calculator(error_MPC_T100_know_future);
[error_count_MPC_T20_naive_model, max_error_MPC_T20_naive_model,min_error_MPC_T20_naive_model]=error_calculator(error_MPC_T20_naive_model);
[error_count_MPC_T50_naive_model,max_error_MPC_T50_naive_model,min_error_MPC_T50_naive_model]=error_calculator(error_MPC_T50_naive_model);
[error_count_MPC_T100_naive_model, max_error_MPC_T100_naive_model, min_error_MPC_T100_naive_model]=error_calculator(error_MPC_T100_naive_model);

max_errors=[max_error_direct_command, max_error_MPC_T50_naive_model, 0.0313, max_error_MPC_T50_know_future];

%FULL TRAJECTORY
max_error_direct_command_full=max(abs(error_direct_command_full));
max_error_170_know_future=max(abs(error_MPC_T170_know_future));
max_error_250_know_future=max(abs(error_MPC_T250_know_future));
max_error_170_naive_model=max(abs(error_MPC_T170_naive_model));
max_error_250_naive_model=max(abs(error_MPC_T250_naive_model));
max_errors_full=[max_error_direct_command_full,max_error_170_naive_model,max_error_250_naive_model ,0.0313, max_error_170_know_future, max_error_250_know_future];
%

figure(1)
hold on
plot(error_direct_command*10000);
%plot(error_MPC_T20_know_future);
plot(error_MPC_T50_naive_model*10000);
plot(error_MPC_T50_know_future*10000);
%plot(error_MPC_T100_know_future);
%plot(error_MPC_T20_naive_model);
%plot(error_MPC_T100_naive_model);
legend('Error direct command','Error MPC T50 naive model','Error MPC T50 know future');
xlabel('frame of 700Hz')
ylabel('um')
title('Error');
hold off

l = cell(1,3);
l{1}='<1/3'; l{2}='>1/3 & <2/3'; l{3}='>2/3' ;

figure(2)
subplot(2,4,1)
bar(error_count_direct_command);
title('direct command')
set(gca,'xticklabel', l) 
subplot(2,4,2)
bar(error_count_MPC_T20_know_future);
title('MPC T20 know future')
set(gca,'xticklabel', l) 
subplot(2,4,3)
bar(error_count_MPC_T50_know_future);
set(gca,'xticklabel', l)
title('MPC 520 know future')
subplot(2,4,4)
bar(error_count_MPC_T100_know_future);
set(gca,'xticklabel', l) 
title('MPC T100 know future')
subplot(2,4,5)
bar(error_count_MPC_T20_naive_model);
set(gca,'xticklabel', l) 
title('MPC T20 naive model')
subplot(2,4,6)
bar(error_count_MPC_T50_naive_model);
set(gca,'xticklabel', l) 
title('MPC T50 naive model')
subplot(2,4,7)
bar(error_count_MPC_T100_naive_model);
set(gca,'xticklabel', l) 
title('MPC T100 naive model')

figure(3)
hold on
plot(RMSE_direct_command);
plot(RMSE_MPC_T20_know_future);
plot(RMSE_MPC_T50_know_future);
plot(RMSE_MPC_T100_know_future);
plot(RMSE_MPC_T20_naive_model);
plot(RMSE_MPC_T50_naive_model);
plot(RMSE_MPC_T100_naive_model);
legend('error direct command','error MPC T20 know future','error MPC T50 know future','error MPC T100 know future','error MPC T20 naive model','error MPC T50 naive model','error MPC T100 naive model');
title('root mean square error')
hold off

l2 = cell(1,7);
l2{1}='Direct command'; l2{2}='MPC T50 naive model' ; l2{3}='?'; l2{4}='MPC T500 know future' ;l2{5}='MPC T20 naive model'; l2{6}='MPC T50 naive model' ;l2{7}='MPC T100 naive model';

figure(4)
bar(max_errors*10000);
set(gca,'xticklabel', l2); 
title('Maximum errors')
ylabel('um')

thres=0.01;
accuracy_direct_command=accuracy_calculator(RMSE_direct_command,thres);
accuracy_MPC_T20_know_future=accuracy_calculator(RMSE_MPC_T20_know_future,thres);
accuracy_MPC_T50_know_future=accuracy_calculator(RMSE_MPC_T50_know_future,thres);
accuracy_MPC_T100_know_future=accuracy_calculator(RMSE_MPC_T100_know_future,thres);
accuracy_MPC_T20_naive_model=accuracy_calculator(RMSE_MPC_T20_naive_model,thres);
accuracy_MPC_T50_naive_model=accuracy_calculator(RMSE_MPC_T50_naive_model,thres);
accuracy_MPC_T100_naive_model=accuracy_calculator(RMSE_MPC_T100_naive_model,thres);

pie_direct_command=[accuracy_direct_command  length(RMSE_direct_command)-accuracy_direct_command];
pie_MPC_T20_know_future=[accuracy_MPC_T20_know_future  length(RMSE_direct_command)-accuracy_MPC_T20_know_future];
pie_MPC_T50_know_future=[accuracy_MPC_T50_know_future  length(RMSE_direct_command)-accuracy_MPC_T50_know_future];
pie_MPC_T100_know_future=[accuracy_MPC_T100_know_future  length(RMSE_direct_command)-accuracy_MPC_T100_know_future];
pie_MPC_T20_naive_model=[accuracy_MPC_T20_naive_model  length(RMSE_direct_command)-accuracy_MPC_T20_naive_model];
pie_MPC_T50_naive_model=[accuracy_MPC_T50_naive_model  length(RMSE_direct_command)-accuracy_MPC_T50_naive_model];
pie_MPC_T100_naive_model=[accuracy_MPC_T100_naive_model  length(RMSE_direct_command)-accuracy_MPC_T100_naive_model];


figure(5)
subplot(2,4,1)
labels = {'<100micro','>100micro'};
pie(pie_direct_command);
legend(labels)
subplot(2,4,2)
labels = {'<100micro','>100micro'};
pie(pie_MPC_T20_know_future)
legend(labels)
subplot(2,4,3)
labels = {'<100micro','>100micro'};
pie(pie_MPC_T50_know_future);
legend(labels)
subplot(2,4,4)
labels = {'<100micro','>100micro'};
pie(pie_MPC_T100_know_future)
legend(labels)
subplot(2,4,5)
labels = {'<100micro','>100micro'};
pie(pie_MPC_T20_naive_model)
legend(labels)
subplot(2,4,6)
labels = {'<100micro','>100micro'};
pie(pie_MPC_T50_naive_model);
legend(labels)
subplot(2,4,7)
labels = {'<100micro','>100micro'};
pie(pie_MPC_T100_naive_model)
legend(labels)


figure(6)
subplot(2,4,1)
boxplot(RMSE_direct_command);
ylabel('cm')
title('error direct command')%'error MPC T20 know future','error MPC T50 know future','error MPC T100 know future','error MPC T20 naive model','error MPC T50 naive model','error MPC T100 naive model');
subplot(2,4,2)
boxplot(RMSE_MPC_T20_know_future);
title('error MPC T20 know future')
ylabel('cm')
subplot(2,4,3)
boxplot(RMSE_MPC_T50_know_future);
ylabel('cm')
title('error MPC T50 know future')
subplot(2,4,4)
boxplot(RMSE_MPC_T100_know_future);
ylabel('cm')
title('error MPC T100 know future')
subplot(2,4,5)
boxplot(RMSE_MPC_T20_naive_model);
ylabel('cm')
title('error MPC T20 naive model')
subplot(2,4,6)
boxplot(RMSE_MPC_T50_naive_model);
ylabel('cm')
title('error MPC T50 naive model')
subplot(2,4,7)
boxplot(RMSE_MPC_T100_naive_model);
ylabel('cm')
title('error MPC T100 naive model')


%% Full trajectory plots

figure(1)
hold on
plot(error_direct_command_full*10000);
plot(error_MPC_T170_know_future*10000);
plot(error_MPC_T250_know_future*10000);
plot(error_MPC_T170_naive_model*10000);
plot(error_MPC_T250_naive_model*10000);
legend('Error direct command','Error MPC T170 know future','Error MPC T250 know future','Error MPC T170 naive model','Error MPC T250 naive model');
xlabel('frame of 700Hz')
ylabel('um')
title('Error');
hold off

label_full = cell(1,6);
label_full{1}='Direct command'; label_full{2}='MPC T170 naive model'; label_full{3}='MPC T250 naive model' ; label_full{4}='?'; label_full{5}='MPC T170 know future' ;label_full{6}='MPC T250 naive model';  

figure(2)
bar(max_errors_full*10000);
set(gca,'xticklabel', label_full); 
title('Maximum errors')
ylabel('um')

%% input vs output direct command or lab meeting

figure(1)
plot(x_trajectory)
hold on
plot(model_direct_command_full(2:end))
hold off
title ('input vs output')
xlabel ('frame of 700Hz')
ylabel('cm')

%zoom in
figure(2)
plot(x_trajectory)
hold on
plot(model_direct_command_full(2:end))
hold off
title ('input vs output')
xlabel ('frame of 700Hz')
axis([1.5e4 2.3e4 0.6 1.6])
ylabel('cm')
