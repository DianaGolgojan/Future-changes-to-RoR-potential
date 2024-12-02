clearvars;

%% Constants

%Start and end dates for the baseline period (30 years)
Baseline_Start_time=datetime(1980,01,01);
Baseline_End_time=datetime(2009,12,31);

%Start and end dates for the 2040s future period (30 years)
Future_2040s_Start_time=datetime(2030,01,01);
Future_2040s_End_time=datetime(2059,12,30);

%Start and end dates for the 2060s future period (30 years)
Future_2060s_Start_time=datetime(2050,01,01);
Future_2060s_End_time=datetime(2079,12,30);

%Baseline and future months
Months_baseline=readtable('H:\01.PhD\004.Chapter4\Matlab Code\Months_Baseline.xlsx');
Months_baseline=table2array(Months_baseline);
Months_2040s=readtable('H:\01.PhD\004.Chapter4\Matlab Code\Months_2040s.xlsx');
Months_2040s=table2array(Months_2040s);
Months_2060s=readtable('H:\01.PhD\004.Chapter4\Matlab Code\Months_2060s.xlsx');
Months_2060s=table2array(Months_2060s);

%Baseline and future years
Years_baseline=readtable('H:\01.PhD\004.Chapter4\Matlab Code\Years_Baseline.xlsx');
Years_baseline=table2array(Years_baseline);
Years_2040s=readtable('H:\01.PhD\004.Chapter4\Matlab Code\Years_2040s.xlsx');
Years_2040s=table2array(Years_2040s);
Years_2060s=readtable('H:\01.PhD\004.Chapter4\Matlab Code\Years_2060s.xlsx');
Years_2060s=table2array(Years_2060s);

Months=["Jan";'Feb';'Mar';'Apr';'May';'Jun';'Jul';'Aug';'Sep';'Oct';'Nov';'Dec'];

%Read the gauges locations and time
location = "H:\01.PhD\004.Chapter4\Input_data_CEH\Supporting_Documentation\eFLaG_Station_Matlab.xlsx";
time_file="H:\01.PhD\004.Chapter4\Input_data_CEH\Observed Flows_eFlag\Time.xlsx";

%Read the gauge number
Gauges=readtable(location);
GaugesNo=Gauges(:,1);
Obs_percentile(:,1)=table2array(GaugesNo(:,1));
GaugesNo=table2array(GaugesNo);

for i=1:200
    no=num2str(GaugesNo(i,1));
    %These are excluded because there is no gauged data
    if i~=[2,56,120,128]

%% Read the gauged flows and save the 1990s flows in an Excel file
    Current_station_location_baseline=strcat('H:\01.PhD\004.Chapter4\Input_data_CEH\Observed Flows_eFlag\GR6J\GR6J_simobs_',no,'.csv');
    Current_station_baseline=readtable(Current_station_location_baseline);
    Time_Obs_baseline=Current_station_baseline(:,1);
    Time_Obs_baseline=table2array(Time_Obs_baseline);
    [start_time_idx,~]=find(Time_Obs_baseline==Baseline_Start_time);
    [end_time_idx,~]=find(Time_Obs_baseline==Baseline_End_time);
    Current_station_baseline(end_time_idx+1:height(Current_station_baseline),:)=[];
    Current_station_baseline(1:start_time_idx-1,:)=[];

    Time_Obs_baseline=Current_station_baseline(:,1);
    Time_Obs_baseline=table2array(Time_Obs_baseline);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Change here for simulated/observed flows
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    Flow_Obs_baseline=Current_station_baseline(:,2);
    Flow_Obs_baseline=table2array(Flow_Obs_baseline);
    
    %Check if file exists, if yes delete it
    if exist(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR6J\Baseline\Baseline_station_',no,'.xls'), 'file')==2
        delete(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR6J\Baseline\Baseline_station_',no,'.xls'));
    end
    writetable(Current_station_baseline,strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR6J\Baseline\Baseline_station_',no,'.xls'));

%% Read the future flows and save the 2040s future flows in an Excel file
    Current_station_future_2040s_location=strcat('H:\01.PhD\004.Chapter4\Input_data_CEH\Future Flow_eFlag\GR6J\GR6J_simrcm_',no,'.csv');
    Current_station_future_2040s=readtable(Current_station_future_2040s_location);
    Time_Sim_future_2040s=Current_station_future_2040s(:,1);
    Time_Sim_future_2040s=table2array(Time_Sim_future_2040s);
    [start_time_idx,~]=find(Time_Sim_future_2040s==Future_2040s_Start_time);
    [end_time_idx,~]=find(Time_Sim_future_2040s==Future_2040s_End_time);
    Current_station_future_2040s(end_time_idx+1:height(Current_station_future_2040s),:)=[];
    Current_station_future_2040s(1:start_time_idx-1,:)=[];

    Time_Sim_future_2040s=Current_station_future_2040s(:,1);
    Time_Sim_future_2040s=table2array(Time_Sim_future_2040s);
    
    Flow_Sim_future_2040s=Current_station_future_2040s(:,2:13);
    Flow_Sim_future_2040s=table2array(Flow_Sim_future_2040s); 

    Flow_Sim_future_2040s_RCM01=Flow_Sim_future_2040s(:,1);
    Flow_Sim_future_2040s_RCM04=Flow_Sim_future_2040s(:,2);
    Flow_Sim_future_2040s_RCM05=Flow_Sim_future_2040s(:,3);
    Flow_Sim_future_2040s_RCM06=Flow_Sim_future_2040s(:,4);
    Flow_Sim_future_2040s_RCM07=Flow_Sim_future_2040s(:,5);
    Flow_Sim_future_2040s_RCM08=Flow_Sim_future_2040s(:,6);
    Flow_Sim_future_2040s_RCM09=Flow_Sim_future_2040s(:,7);
    Flow_Sim_future_2040s_RCM10=Flow_Sim_future_2040s(:,8);
    Flow_Sim_future_2040s_RCM11=Flow_Sim_future_2040s(:,9);
    Flow_Sim_future_2040s_RCM12=Flow_Sim_future_2040s(:,10);
    Flow_Sim_future_2040s_RCM13=Flow_Sim_future_2040s(:,11);
    Flow_Sim_future_2040s_RCM15=Flow_Sim_future_2040s(:,12);

    Check_index=[1:length(Flow_Sim_future_2040s_RCM01)];
    
    for j=1:length(Flow_Sim_future_2040s_RCM01)
        Flow_Sim_future_2040s_allRCM(j,1)=mean(Flow_Sim_future_2040s(j,:));
    end

    %Check if file exists, if yes delete it
    if exist(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR6J\Future_2040s\Future_2040s_station_',no,'.xls'), 'file')==2
        delete(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR6J\Future_2040s\Future_flow_inputs\Future_2040s_station_',no,'.xls'));
    end
    writetable(Current_station_future_2040s,strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR6J\Future_2040s\Future_2040s_station_',no,'.xls'));
    
%% Read the future flows and save the 2060s future flows in an Excel file
    Current_station_future_2060s_location=strcat('H:\01.PhD\004.Chapter4\Input_data_CEH\Future Flow_eFlag\GR6J\GR6J_simrcm_',no,'.csv');
    Current_station_future_2060s=readtable(Current_station_future_2060s_location);
    Time_Sim_future_2060s=Current_station_future_2060s(:,1);
    Time_Sim_future_2060s=table2array(Time_Sim_future_2060s);
    [start_time_idx,~]=find(Time_Sim_future_2060s==Future_2060s_Start_time);
    [end_time_idx,~]=find(Time_Sim_future_2060s==Future_2060s_End_time);
    Current_station_future_2060s(end_time_idx+1:height(Current_station_future_2060s),:)=[];
    Current_station_future_2060s(1:start_time_idx-1,:)=[];

    Time_Sim_future_2060s=Current_station_future_2060s(:,1);
    Time_Sim_future_2060s=table2array(Time_Sim_future_2060s);
    
    Flow_Sim_future_2060s=Current_station_future_2060s(:,2:13);
    Flow_Sim_future_2060s=table2array(Flow_Sim_future_2060s);

    Flow_Sim_future_2060s_RCM01=Flow_Sim_future_2060s(:,1);
    Flow_Sim_future_2060s_RCM04=Flow_Sim_future_2060s(:,2);
    Flow_Sim_future_2060s_RCM05=Flow_Sim_future_2060s(:,3);
    Flow_Sim_future_2060s_RCM06=Flow_Sim_future_2060s(:,4);
    Flow_Sim_future_2060s_RCM07=Flow_Sim_future_2060s(:,5);
    Flow_Sim_future_2060s_RCM08=Flow_Sim_future_2060s(:,6);
    Flow_Sim_future_2060s_RCM09=Flow_Sim_future_2060s(:,7);
    Flow_Sim_future_2060s_RCM10=Flow_Sim_future_2060s(:,8);
    Flow_Sim_future_2060s_RCM11=Flow_Sim_future_2060s(:,9);
    Flow_Sim_future_2060s_RCM12=Flow_Sim_future_2060s(:,10);
    Flow_Sim_future_2060s_RCM13=Flow_Sim_future_2060s(:,11);
    Flow_Sim_future_2060s_RCM15=Flow_Sim_future_2060s(:,12);

    for j=1:length(Flow_Sim_future_2060s_RCM01)
        Flow_Sim_future_2060s_allRCM(j,1)=mean(Flow_Sim_future_2060s(j,:));
    end

    %Check if file exists, if yes delete it
    if exist(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR6J\Future_2060s\Future_2060s_station_',no,'.xls'), 'file')==2
        delete(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR6J\Future_2060s\Future_2060s_station_',no,'.xls'));
    end
    writetable(Current_station_future_2060s,strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR6J\Future_2060s\Future_2060s_station_',no,'.xls'));

%% Claculate baseline flow duration curve (FDC)

for j=1:100
Flow_Obs_baseline_fdc(j,1)=prctile(Flow_Obs_baseline,(100-j));
end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Claculate future 2040s flow duration curve (FDC)
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% RCM01
for j=1:100
Flow_Sim_future_2040s_RCM01_fdc(j,1)=prctile(Flow_Sim_future_2040s_RCM01,(100-j));
end

%% RCM04
for j=1:100
Flow_Sim_future_2040s_RCM04_fdc(j,1)=prctile(Flow_Sim_future_2040s_RCM04,(100-j));
end

%% RCM05
for j=1:100
Flow_Sim_future_2040s_RCM05_fdc(j,1)=prctile(Flow_Sim_future_2040s_RCM05,(100-j));
end

%% RCM06
for j=1:100
Flow_Sim_future_2040s_RCM06_fdc(j,1)=prctile(Flow_Sim_future_2040s_RCM06,(100-j));
end

%% RCM07
for j=1:100
Flow_Sim_future_2040s_RCM07_fdc(j,1)=prctile(Flow_Sim_future_2040s_RCM07,(100-j));
end

%% RCM08
for j=1:100
Flow_Sim_future_2040s_RCM08_fdc(j,1)=prctile(Flow_Sim_future_2040s_RCM08,(100-j));
end

%% RCM09
for j=1:100
Flow_Sim_future_2040s_RCM09_fdc(j,1)=prctile(Flow_Sim_future_2040s_RCM09,(100-j));
end

%% RCM10
for j=1:100
Flow_Sim_future_2040s_RCM10_fdc(j,1)=prctile(Flow_Sim_future_2040s_RCM10,(100-j));
end

%% RCM11
for j=1:100
Flow_Sim_future_2040s_RCM11_fdc(j,1)=prctile(Flow_Sim_future_2040s_RCM11,(100-j));
end

%% RCM12
for j=1:100
Flow_Sim_future_2040s_RCM12_fdc(j,1)=prctile(Flow_Sim_future_2040s_RCM12,(100-j));
end

%% RCM13
for j=1:100
Flow_Sim_future_2040s_RCM13_fdc(j,1)=prctile(Flow_Sim_future_2040s_RCM13,(100-j));
end

%% RCM15
for j=1:100
Flow_Sim_future_2040s_RCM15_fdc(j,1)=prctile(Flow_Sim_future_2040s_RCM15,(100-j));
end

%% All RCMs
for j=1:100
    Flow_Sim_future_2040s_for_allRCM_fdc=[Flow_Sim_future_2040s_RCM01_fdc(j,1),Flow_Sim_future_2040s_RCM04_fdc(j,1),Flow_Sim_future_2040s_RCM05_fdc(j,1),Flow_Sim_future_2040s_RCM06_fdc(j,1),Flow_Sim_future_2040s_RCM07_fdc(j,1),Flow_Sim_future_2040s_RCM08_fdc(j,1),Flow_Sim_future_2040s_RCM09_fdc(j,1),Flow_Sim_future_2040s_RCM10_fdc(j,1),Flow_Sim_future_2040s_RCM11_fdc(j,1),Flow_Sim_future_2040s_RCM12_fdc(j,1),Flow_Sim_future_2040s_RCM13_fdc(j,1),Flow_Sim_future_2040s_RCM15_fdc(j,1)];
    Flow_Sim_future_2040s_allRCM_fdc(j,1)=mean(Flow_Sim_future_2040s_for_allRCM_fdc);
end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Claculate future 2060s flow duration curve (FDC)
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% RCM01
for j=1:100
Flow_Sim_future_2060s_RCM01_fdc(j,1)=prctile(Flow_Sim_future_2060s_RCM01,(100-j));
end

%% RCM04
for j=1:100
Flow_Sim_future_2060s_RCM04_fdc(j,1)=prctile(Flow_Sim_future_2060s_RCM04,(100-j));
end

%% RCM05
for j=1:100
Flow_Sim_future_2060s_RCM05_fdc(j,1)=prctile(Flow_Sim_future_2060s_RCM05,(100-j));
end

%% RCM06
for j=1:100
Flow_Sim_future_2060s_RCM06_fdc(j,1)=prctile(Flow_Sim_future_2060s_RCM06,(100-j));
end

%% RCM07
for j=1:100
Flow_Sim_future_2060s_RCM07_fdc(j,1)=prctile(Flow_Sim_future_2060s_RCM07,(100-j));
end

%% RCM08
for j=1:100
Flow_Sim_future_2060s_RCM08_fdc(j,1)=prctile(Flow_Sim_future_2060s_RCM08,(100-j));
end

%% RCM09
for j=1:100
Flow_Sim_future_2060s_RCM09_fdc(j,1)=prctile(Flow_Sim_future_2060s_RCM09,(100-j));
end

%% RCM10
for j=1:100
Flow_Sim_future_2060s_RCM10_fdc(j,1)=prctile(Flow_Sim_future_2060s_RCM10,(100-j));
end

%% RCM11
for j=1:100
Flow_Sim_future_2060s_RCM11_fdc(j,1)=prctile(Flow_Sim_future_2060s_RCM11,(100-j));
end

%% RCM12
for j=1:100
Flow_Sim_future_2060s_RCM12_fdc(j,1)=prctile(Flow_Sim_future_2060s_RCM12,(100-j));
end

%% RCM13
for j=1:100
Flow_Sim_future_2060s_RCM13_fdc(j,1)=prctile(Flow_Sim_future_2060s_RCM13,(100-j));
end

%% RCM15
for j=1:100
Flow_Sim_future_2060s_RCM15_fdc(j,1)=prctile(Flow_Sim_future_2060s_RCM15,(100-j));
end

%% All RCMs
for j=1:100
    Flow_Sim_future_2060s_for_allRCM_fdc=[Flow_Sim_future_2060s_RCM01_fdc(j,1),Flow_Sim_future_2060s_RCM04_fdc(j,1),Flow_Sim_future_2060s_RCM05_fdc(j,1),Flow_Sim_future_2060s_RCM06_fdc(j,1),Flow_Sim_future_2060s_RCM07_fdc(j,1),Flow_Sim_future_2060s_RCM08_fdc(j,1),Flow_Sim_future_2060s_RCM09_fdc(j,1),Flow_Sim_future_2060s_RCM10_fdc(j,1),Flow_Sim_future_2060s_RCM11_fdc(j,1),Flow_Sim_future_2060s_RCM12_fdc(j,1),Flow_Sim_future_2060s_RCM13_fdc(j,1),Flow_Sim_future_2060s_RCM15_fdc(j,1)];
    Flow_Sim_future_2060s_allRCM_fdc(j,1)=mean(Flow_Sim_future_2060s_for_allRCM_fdc);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Need to write the code to write the table with the results in excel
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
end