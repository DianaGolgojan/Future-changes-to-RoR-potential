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

%Read the gauge numbe
Gauges=readtable(location);
GaugesNo=Gauges(:,1);
Obs_percentile(:,1)=table2array(GaugesNo(:,1));
GaugesNo=table2array(GaugesNo);

for i=1:191
    no=num2str(GaugesNo(i,1));
    %These are excluded because there is no gauged data
    if i~=27 && i~=28 && i~=42 && i~=62 && i~=66 && i~=67 && i~=68 && i~=69 && i~=70 && i~=71 && i~=78 && i~=102 && i~=115 && i~=123 && i~=124 && i~=125 && i~=126 && i~=127 && i~=128 &&i~=129 && i~=130 && i~=131 && i~=132 && i~=133 && i~=134 && i~=135 && i~=136 && i~=137 && i~=138 && i~=139 && i~=154
%% Read the baseline flows and save the 1990s flows in an Excel file
    Current_station_location_baseline=strcat('H:\01.PhD\004.Chapter4\Input_data_CEH\Observed Flows_eFlag\G2G\G2G_simobs_',no,'.csv');
    Current_station_baseline=readtable(Current_station_location_baseline);
    Time_Obs_baseline=Current_station_baseline(:,1);
    Time_Obs_baseline=table2array(Time_Obs_baseline);
    [start_time_idx,~]=find(Time_Obs_baseline==Baseline_Start_time);
    [end_time_idx,~]=find(Time_Obs_baseline==Baseline_End_time);
    Current_station_baseline(end_time_idx+1:height(Current_station_baseline),:)=[];
    Current_station_baseline(1:start_time_idx-1,:)=[];

    Time_Obs_baseline=Current_station_baseline(:,1);
    Time_Obs_baseline=table2array(Time_Obs_baseline);
    
    Flow_Obs_baseline=Current_station_baseline(:,2);
    Flow_Obs_baseline=table2array(Flow_Obs_baseline);
    
    %Check if file exists, if yes delete it
    if exist(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Baseline\Baseline_station_',no,'.xls'), 'file')==2
        delete(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Baseline\Baseline_station_',no,'.xls'));
    end
    writetable(Current_station_baseline,strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Baseline\Baseline_station_',no,'.xls'));

%% Read the future flows and save the 2040s future flows in an Excel file
    Current_station_future_2040s_location=strcat('H:\01.PhD\004.Chapter4\Input_data_CEH\Future Flow_eFlag\G2G\G2G_simrcm_',no,'.csv');
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
    if exist(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Future_2040s\Future_2040s_station_',no,'.xls'), 'file')==2
        delete(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Future_2040s\Future_flow_inputs\Future_2040s_station_',no,'.xls'));
    end
    writetable(Current_station_future_2040s,strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Future_2040s\Future_2040s_station_',no,'.xls'));
    
%% Read the future flows and save the 2060s future flows in an Excel file
    Current_station_future_2060s_location=strcat('H:\01.PhD\004.Chapter4\Input_data_CEH\Future Flow_eFlag\G2G\G2G_simrcm_',no,'.csv');
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
    if exist(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Future_2060s\Future_2060s_station_',no,'.xls'), 'file')==2
        delete(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Future_2060s\Future_2060s_station_',no,'.xls'));
    end
    writetable(Current_station_future_2060s,strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Future_2060s\Future_2060s_station_',no,'.xls'));
%% Calculate the medium flows: Q40, Q50 and Q60
 
%% Baseline
Flow_Obs_baseline_Q40(i,1)=prctile(Flow_Obs_baseline,60);
Flow_Obs_baseline_Q50(i,1)=prctile(Flow_Obs_baseline,50);
Flow_Obs_baseline_Q60(i,1)=prctile(Flow_Obs_baseline,40);
 
%% Future 2040s
 
%% RCM01
Flow_Sim_future_2040s_RCM01_Q40(i,1)=prctile(Flow_Sim_future_2040s_RCM01,60);
Flow_Sim_future_2040s_RCM01_Q50(i,1)=prctile(Flow_Sim_future_2040s_RCM01,50);
Flow_Sim_future_2040s_RCM01_Q60(i,1)=prctile(Flow_Sim_future_2040s_RCM01,40);
 
%% RCM04
Flow_Sim_future_2040s_RCM04_Q40(i,1)=prctile(Flow_Sim_future_2040s_RCM04,60);
Flow_Sim_future_2040s_RCM04_Q50(i,1)=prctile(Flow_Sim_future_2040s_RCM04,50);
Flow_Sim_future_2040s_RCM04_Q60(i,1)=prctile(Flow_Sim_future_2040s_RCM04,40);
 
%% RCM05
Flow_Sim_future_2040s_RCM05_Q40(i,1)=prctile(Flow_Sim_future_2040s_RCM05,60);
Flow_Sim_future_2040s_RCM05_Q50(i,1)=prctile(Flow_Sim_future_2040s_RCM05,50);
Flow_Sim_future_2040s_RCM05_Q60(i,1)=prctile(Flow_Sim_future_2040s_RCM05,40);
 
%% RCM06
Flow_Sim_future_2040s_RCM06_Q40(i,1)=prctile(Flow_Sim_future_2040s_RCM06,60);
Flow_Sim_future_2040s_RCM06_Q50(i,1)=prctile(Flow_Sim_future_2040s_RCM06,50);
Flow_Sim_future_2040s_RCM06_Q60(i,1)=prctile(Flow_Sim_future_2040s_RCM06,40);
 
%% RCM07
Flow_Sim_future_2040s_RCM07_Q40(i,1)=prctile(Flow_Sim_future_2040s_RCM07,60);
Flow_Sim_future_2040s_RCM07_Q50(i,1)=prctile(Flow_Sim_future_2040s_RCM07,50);
Flow_Sim_future_2040s_RCM07_Q60(i,1)=prctile(Flow_Sim_future_2040s_RCM07,40);
 
%% RCM08
Flow_Sim_future_2040s_RCM08_Q40(i,1)=prctile(Flow_Sim_future_2040s_RCM08,60);
Flow_Sim_future_2040s_RCM08_Q50(i,1)=prctile(Flow_Sim_future_2040s_RCM08,50);
Flow_Sim_future_2040s_RCM08_Q60(i,1)=prctile(Flow_Sim_future_2040s_RCM08,40);
 
%% RCM09
Flow_Sim_future_2040s_RCM09_Q40(i,1)=prctile(Flow_Sim_future_2040s_RCM09,60);
Flow_Sim_future_2040s_RCM09_Q50(i,1)=prctile(Flow_Sim_future_2040s_RCM09,50);
Flow_Sim_future_2040s_RCM09_Q60(i,1)=prctile(Flow_Sim_future_2040s_RCM09,40);
 
%% RCM10
Flow_Sim_future_2040s_RCM10_Q40(i,1)=prctile(Flow_Sim_future_2040s_RCM10,60);
Flow_Sim_future_2040s_RCM10_Q50(i,1)=prctile(Flow_Sim_future_2040s_RCM10,50);
Flow_Sim_future_2040s_RCM10_Q60(i,1)=prctile(Flow_Sim_future_2040s_RCM10,40);
 
%% RCM11
Flow_Sim_future_2040s_RCM11_Q40(i,1)=prctile(Flow_Sim_future_2040s_RCM11,60);
Flow_Sim_future_2040s_RCM11_Q50(i,1)=prctile(Flow_Sim_future_2040s_RCM11,50);
Flow_Sim_future_2040s_RCM11_Q60(i,1)=prctile(Flow_Sim_future_2040s_RCM11,40);
 
%% RCM12
Flow_Sim_future_2040s_RCM12_Q40(i,1)=prctile(Flow_Sim_future_2040s_RCM12,60);
Flow_Sim_future_2040s_RCM12_Q50(i,1)=prctile(Flow_Sim_future_2040s_RCM12,50);
Flow_Sim_future_2040s_RCM12_Q60(i,1)=prctile(Flow_Sim_future_2040s_RCM12,40);
 
%% RCM13
Flow_Sim_future_2040s_RCM13_Q40(i,1)=prctile(Flow_Sim_future_2040s_RCM13,60);
Flow_Sim_future_2040s_RCM13_Q50(i,1)=prctile(Flow_Sim_future_2040s_RCM13,50);
Flow_Sim_future_2040s_RCM13_Q60(i,1)=prctile(Flow_Sim_future_2040s_RCM13,40);
 
%% RCM15
Flow_Sim_future_2040s_RCM15_Q40(i,1)=prctile(Flow_Sim_future_2040s_RCM15,60);
Flow_Sim_future_2040s_RCM15_Q50(i,1)=prctile(Flow_Sim_future_2040s_RCM15,50);
Flow_Sim_future_2040s_RCM15_Q60(i,1)=prctile(Flow_Sim_future_2040s_RCM15,40);
 
%% All RCMs
 
Flow_Sim_future_2040s_for_allRCM_Q40=[Flow_Sim_future_2040s_RCM01_Q40(i,1),Flow_Sim_future_2040s_RCM04_Q40(i,1),Flow_Sim_future_2040s_RCM05_Q40(i,1),Flow_Sim_future_2040s_RCM06_Q40(i,1),Flow_Sim_future_2040s_RCM07_Q40(i,1),Flow_Sim_future_2040s_RCM08_Q40(i,1),Flow_Sim_future_2040s_RCM09_Q40(i,1),Flow_Sim_future_2040s_RCM10_Q40(i,1),Flow_Sim_future_2040s_RCM11_Q40(i,1),Flow_Sim_future_2040s_RCM12_Q40(i,1),Flow_Sim_future_2040s_RCM13_Q40(i,1),Flow_Sim_future_2040s_RCM15_Q40(i,1)];
Flow_Sim_future_2040s_allRCM_Q40(i,1)=mean(Flow_Sim_future_2040s_for_allRCM_Q40);
 
Flow_Sim_future_2040s_for_allRCM_Q50=[Flow_Sim_future_2040s_RCM01_Q50(i,1),Flow_Sim_future_2040s_RCM04_Q50(i,1),Flow_Sim_future_2040s_RCM05_Q50(i,1),Flow_Sim_future_2040s_RCM06_Q50(i,1),Flow_Sim_future_2040s_RCM07_Q50(i,1),Flow_Sim_future_2040s_RCM08_Q50(i,1),Flow_Sim_future_2040s_RCM09_Q50(i,1),Flow_Sim_future_2040s_RCM10_Q50(i,1),Flow_Sim_future_2040s_RCM11_Q50(i,1),Flow_Sim_future_2040s_RCM12_Q50(i,1),Flow_Sim_future_2040s_RCM13_Q50(i,1),Flow_Sim_future_2040s_RCM15_Q50(i,1)];
Flow_Sim_future_2040s_allRCM_Q50(i,1)=mean(Flow_Sim_future_2040s_for_allRCM_Q50);
 
Flow_Sim_future_2040s_for_allRCM_Q60=[Flow_Sim_future_2040s_RCM01_Q60(i,1),Flow_Sim_future_2040s_RCM04_Q60(i,1),Flow_Sim_future_2040s_RCM05_Q60(i,1),Flow_Sim_future_2040s_RCM06_Q60(i,1),Flow_Sim_future_2040s_RCM07_Q60(i,1),Flow_Sim_future_2040s_RCM08_Q60(i,1),Flow_Sim_future_2040s_RCM09_Q60(i,1),Flow_Sim_future_2040s_RCM10_Q60(i,1),Flow_Sim_future_2040s_RCM11_Q60(i,1),Flow_Sim_future_2040s_RCM12_Q60(i,1),Flow_Sim_future_2040s_RCM13_Q60(i,1),Flow_Sim_future_2040s_RCM15_Q60(i,1)];
Flow_Sim_future_2040s_allRCM_Q60(i,1)=mean(Flow_Sim_future_2040s_for_allRCM_Q60);
 
%% Future 2060s
 
%% RCM01
Flow_Sim_future_2060s_RCM01_Q40(i,1)=prctile(Flow_Sim_future_2060s_RCM01,60);
Flow_Sim_future_2060s_RCM01_Q50(i,1)=prctile(Flow_Sim_future_2060s_RCM01,50);
Flow_Sim_future_2060s_RCM01_Q60(i,1)=prctile(Flow_Sim_future_2060s_RCM01,40);
 
%% RCM04
Flow_Sim_future_2060s_RCM04_Q40(i,1)=prctile(Flow_Sim_future_2060s_RCM04,60);
Flow_Sim_future_2060s_RCM04_Q50(i,1)=prctile(Flow_Sim_future_2060s_RCM04,50);
Flow_Sim_future_2060s_RCM04_Q60(i,1)=prctile(Flow_Sim_future_2060s_RCM04,40);
 
%% RCM05
Flow_Sim_future_2060s_RCM05_Q40(i,1)=prctile(Flow_Sim_future_2060s_RCM05,60);
Flow_Sim_future_2060s_RCM05_Q50(i,1)=prctile(Flow_Sim_future_2060s_RCM05,50);
Flow_Sim_future_2060s_RCM05_Q60(i,1)=prctile(Flow_Sim_future_2060s_RCM05,40);
 
%% RCM06
Flow_Sim_future_2060s_RCM06_Q40(i,1)=prctile(Flow_Sim_future_2060s_RCM06,60);
Flow_Sim_future_2060s_RCM06_Q50(i,1)=prctile(Flow_Sim_future_2060s_RCM06,50);
Flow_Sim_future_2060s_RCM06_Q60(i,1)=prctile(Flow_Sim_future_2060s_RCM06,40);
 
%% RCM07
Flow_Sim_future_2060s_RCM07_Q40(i,1)=prctile(Flow_Sim_future_2060s_RCM07,60);
Flow_Sim_future_2060s_RCM07_Q50(i,1)=prctile(Flow_Sim_future_2060s_RCM07,50);
Flow_Sim_future_2060s_RCM07_Q60(i,1)=prctile(Flow_Sim_future_2060s_RCM07,40);
 
%% RCM08
Flow_Sim_future_2060s_RCM08_Q40(i,1)=prctile(Flow_Sim_future_2060s_RCM08,60);
Flow_Sim_future_2060s_RCM08_Q50(i,1)=prctile(Flow_Sim_future_2060s_RCM08,50);
Flow_Sim_future_2060s_RCM08_Q60(i,1)=prctile(Flow_Sim_future_2060s_RCM08,40);
 
%% RCM09
Flow_Sim_future_2060s_RCM09_Q40(i,1)=prctile(Flow_Sim_future_2060s_RCM09,60);
Flow_Sim_future_2060s_RCM09_Q50(i,1)=prctile(Flow_Sim_future_2060s_RCM09,50);
Flow_Sim_future_2060s_RCM09_Q60(i,1)=prctile(Flow_Sim_future_2060s_RCM09,40);
 
%% RCM10
Flow_Sim_future_2060s_RCM10_Q40(i,1)=prctile(Flow_Sim_future_2060s_RCM10,60);
Flow_Sim_future_2060s_RCM10_Q50(i,1)=prctile(Flow_Sim_future_2060s_RCM10,50);
Flow_Sim_future_2060s_RCM10_Q60(i,1)=prctile(Flow_Sim_future_2060s_RCM10,40);
 
%% RCM11
Flow_Sim_future_2060s_RCM11_Q40(i,1)=prctile(Flow_Sim_future_2060s_RCM11,60);
Flow_Sim_future_2060s_RCM11_Q50(i,1)=prctile(Flow_Sim_future_2060s_RCM11,50);
Flow_Sim_future_2060s_RCM11_Q60(i,1)=prctile(Flow_Sim_future_2060s_RCM11,40);
 
%% RCM12
Flow_Sim_future_2060s_RCM12_Q40(i,1)=prctile(Flow_Sim_future_2060s_RCM12,60);
Flow_Sim_future_2060s_RCM12_Q50(i,1)=prctile(Flow_Sim_future_2060s_RCM12,50);
Flow_Sim_future_2060s_RCM12_Q60(i,1)=prctile(Flow_Sim_future_2060s_RCM12,40);
 
%% RCM13
Flow_Sim_future_2060s_RCM13_Q40(i,1)=prctile(Flow_Sim_future_2060s_RCM13,60);
Flow_Sim_future_2060s_RCM13_Q50(i,1)=prctile(Flow_Sim_future_2060s_RCM13,50);
Flow_Sim_future_2060s_RCM13_Q60(i,1)=prctile(Flow_Sim_future_2060s_RCM13,40);
 
%% RCM15
Flow_Sim_future_2060s_RCM15_Q40(i,1)=prctile(Flow_Sim_future_2060s_RCM15,60);
Flow_Sim_future_2060s_RCM15_Q50(i,1)=prctile(Flow_Sim_future_2060s_RCM15,50);
Flow_Sim_future_2060s_RCM15_Q60(i,1)=prctile(Flow_Sim_future_2060s_RCM15,40);
 
%% All RCMs
 
Flow_Sim_future_2060s_for_allRCM_Q40=[Flow_Sim_future_2060s_RCM01_Q40(i,1),Flow_Sim_future_2060s_RCM04_Q40(i,1),Flow_Sim_future_2060s_RCM05_Q40(i,1),Flow_Sim_future_2060s_RCM06_Q40(i,1),Flow_Sim_future_2060s_RCM07_Q40(i,1),Flow_Sim_future_2060s_RCM08_Q40(i,1),Flow_Sim_future_2060s_RCM09_Q40(i,1),Flow_Sim_future_2060s_RCM10_Q40(i,1),Flow_Sim_future_2060s_RCM11_Q40(i,1),Flow_Sim_future_2060s_RCM12_Q40(i,1),Flow_Sim_future_2060s_RCM13_Q40(i,1),Flow_Sim_future_2060s_RCM15_Q40(i,1)];
Flow_Sim_future_2060s_allRCM_Q40(i,1)=mean(Flow_Sim_future_2060s_for_allRCM_Q40);
 
Flow_Sim_future_2060s_for_allRCM_Q50=[Flow_Sim_future_2060s_RCM01_Q50(i,1),Flow_Sim_future_2060s_RCM04_Q50(i,1),Flow_Sim_future_2060s_RCM05_Q50(i,1),Flow_Sim_future_2060s_RCM06_Q50(i,1),Flow_Sim_future_2060s_RCM07_Q50(i,1),Flow_Sim_future_2060s_RCM08_Q50(i,1),Flow_Sim_future_2060s_RCM09_Q50(i,1),Flow_Sim_future_2060s_RCM10_Q50(i,1),Flow_Sim_future_2060s_RCM11_Q50(i,1),Flow_Sim_future_2060s_RCM12_Q50(i,1),Flow_Sim_future_2060s_RCM13_Q50(i,1),Flow_Sim_future_2060s_RCM15_Q50(i,1)];
Flow_Sim_future_2060s_allRCM_Q50(i,1)=mean(Flow_Sim_future_2060s_for_allRCM_Q50);
 
Flow_Sim_future_2060s_for_allRCM_Q60=[Flow_Sim_future_2060s_RCM01_Q60(i,1),Flow_Sim_future_2060s_RCM04_Q60(i,1),Flow_Sim_future_2060s_RCM05_Q60(i,1),Flow_Sim_future_2060s_RCM06_Q60(i,1),Flow_Sim_future_2060s_RCM07_Q60(i,1),Flow_Sim_future_2060s_RCM08_Q60(i,1),Flow_Sim_future_2060s_RCM09_Q60(i,1),Flow_Sim_future_2060s_RCM10_Q60(i,1),Flow_Sim_future_2060s_RCM11_Q60(i,1),Flow_Sim_future_2060s_RCM12_Q60(i,1),Flow_Sim_future_2060s_RCM13_Q60(i,1),Flow_Sim_future_2060s_RCM15_Q60(i,1)];
Flow_Sim_future_2060s_allRCM_Q60(i,1)=mean(Flow_Sim_future_2060s_for_allRCM_Q60);
 
%% Calculate the environmental flows: Q95
 
%% Baseline
Flow_Obs_baseline_Q95(i,1)=prctile(Flow_Obs_baseline,5);
 
%% Future 2040s
 
%% RCM01
Flow_Sim_future_2040s_RCM01_Q95(i,1)=prctile(Flow_Sim_future_2040s_RCM01,5);
 
%% RCM04
Flow_Sim_future_2040s_RCM04_Q95(i,1)=prctile(Flow_Sim_future_2040s_RCM04,5);
 
%% RCM05
Flow_Sim_future_2040s_RCM05_Q95(i,1)=prctile(Flow_Sim_future_2040s_RCM05,5);
 
%% RCM06
Flow_Sim_future_2040s_RCM06_Q95(i,1)=prctile(Flow_Sim_future_2040s_RCM06,5);
 
%% RCM07
Flow_Sim_future_2040s_RCM07_Q95(i,1)=prctile(Flow_Sim_future_2040s_RCM07,5);
 
%% RCM08
Flow_Sim_future_2040s_RCM08_Q95(i,1)=prctile(Flow_Sim_future_2040s_RCM08,5);
 
%% RCM09
Flow_Sim_future_2040s_RCM09_Q95(i,1)=prctile(Flow_Sim_future_2040s_RCM09,5);
 
%% RCM10
Flow_Sim_future_2040s_RCM10_Q95(i,1)=prctile(Flow_Sim_future_2040s_RCM10,5);
 
%% RCM11
Flow_Sim_future_2040s_RCM11_Q95(i,1)=prctile(Flow_Sim_future_2040s_RCM11,5);
 
%% RCM12
Flow_Sim_future_2040s_RCM12_Q95(i,1)=prctile(Flow_Sim_future_2040s_RCM12,5);
 
%% RCM13
Flow_Sim_future_2040s_RCM13_Q95(i,1)=prctile(Flow_Sim_future_2040s_RCM13,5);
 
%% RCM15
Flow_Sim_future_2040s_RCM15_Q95(i,1)=prctile(Flow_Sim_future_2040s_RCM15,5);
 
%% All RCMs
Flow_Sim_future_2040s_for_allRCM_Q95=[Flow_Sim_future_2040s_RCM01_Q95(i,1),Flow_Sim_future_2040s_RCM04_Q95(i,1),Flow_Sim_future_2040s_RCM05_Q95(i,1),Flow_Sim_future_2040s_RCM06_Q95(i,1),Flow_Sim_future_2040s_RCM07_Q95(i,1),Flow_Sim_future_2040s_RCM08_Q95(i,1),Flow_Sim_future_2040s_RCM09_Q95(i,1),Flow_Sim_future_2040s_RCM10_Q95(i,1),Flow_Sim_future_2040s_RCM11_Q95(i,1),Flow_Sim_future_2040s_RCM12_Q95(i,1),Flow_Sim_future_2040s_RCM13_Q95(i,1),Flow_Sim_future_2040s_RCM15_Q95(i,1)];
Flow_Sim_future_2040s_allRCM_Q95(i,1)=mean(Flow_Sim_future_2040s_for_allRCM_Q95);
 
%% Future 2060s
 
%% RCM01
Flow_Sim_future_2060s_RCM01_Q95(i,1)=prctile(Flow_Sim_future_2060s_RCM01,5);
 
%% RCM04
Flow_Sim_future_2060s_RCM04_Q95(i,1)=prctile(Flow_Sim_future_2060s_RCM04,5);
 
%% RCM05
Flow_Sim_future_2060s_RCM05_Q95(i,1)=prctile(Flow_Sim_future_2060s_RCM05,5);
 
%% RCM06
Flow_Sim_future_2060s_RCM06_Q95(i,1)=prctile(Flow_Sim_future_2060s_RCM06,5);
 
%% RCM07
Flow_Sim_future_2060s_RCM07_Q95(i,1)=prctile(Flow_Sim_future_2060s_RCM07,5);
 
%% RCM08
Flow_Sim_future_2060s_RCM08_Q95(i,1)=prctile(Flow_Sim_future_2060s_RCM08,5);
 
%% RCM09
Flow_Sim_future_2060s_RCM09_Q95(i,1)=prctile(Flow_Sim_future_2060s_RCM09,5);
 
%% RCM10
Flow_Sim_future_2060s_RCM10_Q95(i,1)=prctile(Flow_Sim_future_2060s_RCM10,5);
 
%% RCM11
Flow_Sim_future_2060s_RCM11_Q95(i,1)=prctile(Flow_Sim_future_2060s_RCM11,5);
 
%% RCM12
Flow_Sim_future_2060s_RCM12_Q95(i,1)=prctile(Flow_Sim_future_2060s_RCM12,5);
 
%% RCM13
Flow_Sim_future_2060s_RCM13_Q95(i,1)=prctile(Flow_Sim_future_2060s_RCM13,5);
 
%% RCM15
Flow_Sim_future_2060s_RCM15_Q95(i,1)=prctile(Flow_Sim_future_2060s_RCM15,5);
 
%% All RCMs
Flow_Sim_future_2060s_for_allRCM_Q95=[Flow_Sim_future_2060s_RCM01_Q95(i,1),Flow_Sim_future_2060s_RCM04_Q95(i,1),Flow_Sim_future_2060s_RCM05_Q95(i,1),Flow_Sim_future_2060s_RCM06_Q95(i,1),Flow_Sim_future_2060s_RCM07_Q95(i,1),Flow_Sim_future_2060s_RCM08_Q95(i,1),Flow_Sim_future_2060s_RCM09_Q95(i,1),Flow_Sim_future_2060s_RCM10_Q95(i,1),Flow_Sim_future_2060s_RCM11_Q95(i,1),Flow_Sim_future_2060s_RCM12_Q95(i,1),Flow_Sim_future_2060s_RCM13_Q95(i,1),Flow_Sim_future_2060s_RCM15_Q95(i,1)];
Flow_Sim_future_2060s_allRCM_Q95(i,1)=mean(Flow_Sim_future_2060s_for_allRCM_Q95);
 
%% Tables of difference in medium flows
 
%% 2040s
 
%% Q40
Table_medium_diff_Q40_2040s{i,1}=GaugesNo(i,1);
 
Table_medium_diff_Q40_2040s{i,2}=Flow_Obs_baseline_Q40(i,1);
 
Table_medium_diff_Q40_2040s{i,3}=Flow_Sim_future_2040s_RCM01_Q40(i,1);
Table_medium_diff_Q40_2040s{i,4}=Flow_Sim_future_2040s_RCM04_Q40(i,1);
Table_medium_diff_Q40_2040s{i,5}=Flow_Sim_future_2040s_RCM05_Q40(i,1);
Table_medium_diff_Q40_2040s{i,6}=Flow_Sim_future_2040s_RCM06_Q40(i,1);
Table_medium_diff_Q40_2040s{i,7}=Flow_Sim_future_2040s_RCM07_Q40(i,1);
Table_medium_diff_Q40_2040s{i,8}=Flow_Sim_future_2040s_RCM08_Q40(i,1);
Table_medium_diff_Q40_2040s{i,9}=Flow_Sim_future_2040s_RCM09_Q40(i,1);
Table_medium_diff_Q40_2040s{i,10}=Flow_Sim_future_2040s_RCM10_Q40(i,1);
Table_medium_diff_Q40_2040s{i,11}=Flow_Sim_future_2040s_RCM11_Q40(i,1);
Table_medium_diff_Q40_2040s{i,12}=Flow_Sim_future_2040s_RCM12_Q40(i,1);
Table_medium_diff_Q40_2040s{i,13}=Flow_Sim_future_2040s_RCM13_Q40(i,1);
Table_medium_diff_Q40_2040s{i,14}=Flow_Sim_future_2040s_RCM15_Q40(i,1);
 
Table_medium_diff_Q40_2040s{i,15}=Flow_Sim_future_2040s_allRCM_Q40(i,1);
 
Table_medium_diff_Q40_2040s{i,16}=(Flow_Obs_baseline_Q40(i,1)-Flow_Sim_future_2040s_RCM01_Q40(i,1))/Flow_Obs_baseline_Q40(i,1)*100;
Table_medium_diff_Q40_2040s{i,17}=(Flow_Obs_baseline_Q40(i,1)-Flow_Sim_future_2040s_RCM04_Q40(i,1))/Flow_Obs_baseline_Q40(i,1)*100;
Table_medium_diff_Q40_2040s{i,18}=(Flow_Obs_baseline_Q40(i,1)-Flow_Sim_future_2040s_RCM05_Q40(i,1))/Flow_Obs_baseline_Q40(i,1)*100;
Table_medium_diff_Q40_2040s{i,19}=(Flow_Obs_baseline_Q40(i,1)-Flow_Sim_future_2040s_RCM06_Q40(i,1))/Flow_Obs_baseline_Q40(i,1)*100;
Table_medium_diff_Q40_2040s{i,20}=(Flow_Obs_baseline_Q40(i,1)-Flow_Sim_future_2040s_RCM07_Q40(i,1))/Flow_Obs_baseline_Q40(i,1)*100;
Table_medium_diff_Q40_2040s{i,21}=(Flow_Obs_baseline_Q40(i,1)-Flow_Sim_future_2040s_RCM08_Q40(i,1))/Flow_Obs_baseline_Q40(i,1)*100;
Table_medium_diff_Q40_2040s{i,22}=(Flow_Obs_baseline_Q40(i,1)-Flow_Sim_future_2040s_RCM09_Q40(i,1))/Flow_Obs_baseline_Q40(i,1)*100;
Table_medium_diff_Q40_2040s{i,23}=(Flow_Obs_baseline_Q40(i,1)-Flow_Sim_future_2040s_RCM10_Q40(i,1))/Flow_Obs_baseline_Q40(i,1)*100;
Table_medium_diff_Q40_2040s{i,24}=(Flow_Obs_baseline_Q40(i,1)-Flow_Sim_future_2040s_RCM11_Q40(i,1))/Flow_Obs_baseline_Q40(i,1)*100;
Table_medium_diff_Q40_2040s{i,25}=(Flow_Obs_baseline_Q40(i,1)-Flow_Sim_future_2040s_RCM12_Q40(i,1))/Flow_Obs_baseline_Q40(i,1)*100;
Table_medium_diff_Q40_2040s{i,26}=(Flow_Obs_baseline_Q40(i,1)-Flow_Sim_future_2040s_RCM13_Q40(i,1))/Flow_Obs_baseline_Q40(i,1)*100;
Table_medium_diff_Q40_2040s{i,27}=(Flow_Obs_baseline_Q40(i,1)-Flow_Sim_future_2040s_RCM15_Q40(i,1))/Flow_Obs_baseline_Q40(i,1)*100;
 
Table_medium_diff_Q40_2040s{i,28}=(Flow_Obs_baseline_Q40(i,1)-Flow_Sim_future_2040s_allRCM_Q40(i,1))/Flow_Obs_baseline_Q40(i,1)*100;
 
Table_medium_diff_Q40_2040s_header={'ID','Baseline Q40 [m^3/s]','RCM01 2040s Q40 [m^3/s]','RCM04 2040s Q40 [m^3/s]','RCM05 2040s Q40 [m^3/s]','RCM06 2040s Q40 [m^3/s]','RCM07 2040s Q40 [m^3/s]','RCM08 2040s Q40 [m^3/s]','RCM09 2040s Q40 [m^3/s]','RCM10 2040s Q40 [m^3/s]','RCM11 2040s Q40 [m^3/s]','RCM12 2040s Q40 [m^3/s]','RCM13 2040s Q40 [m^3/s]','RCM15 2040s Q40 [m^3/s]','All RCM 2040s Q40 [m^3/s]','Baseline-RCM01 2040s Q40 [%]','Baseline-RCM04 [%]','Baseline-RCM05 [%]','Baseline-RCM06 [%]','Baseline-RCM07 [%]','Baseline-RCM08 [%]','Baseline-RCM09 [%]','Baseline-RCM10 [%]' ,'Baseline-RCM11 [%]','Baseline-RCM12 [%]','Baseline-RCM13 [%]','Baseline-RCM15 [%]','Baseline Q40-Future 2040s Q40 [%]'};
 
%Write the table into an excel file
 
if exist(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Station_',no,'_flows_2040s_Q40.xls'), 'file')==2
   delete(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Station_',no,'_flows_2040s_Q40.xls'));
end
 
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Station_',no,'_flows_2040s_Q40.xls'),Table_medium_diff_Q40_2040s,'Sheet1','A2');
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Station_',no,'_flows_2040s_Q40.xls'),Table_medium_diff_Q40_2040s_header,'Sheet1','A1');
 
%% Q50
 
Table_medium_diff_Q50_2040s{i,1}=GaugesNo(i,1);
 
Table_medium_diff_Q50_2040s{i,2}=Flow_Obs_baseline_Q50(i,1);
 
Table_medium_diff_Q50_2040s{i,3}=Flow_Sim_future_2040s_RCM01_Q50(i,1);
Table_medium_diff_Q50_2040s{i,4}=Flow_Sim_future_2040s_RCM04_Q50(i,1);
Table_medium_diff_Q50_2040s{i,5}=Flow_Sim_future_2040s_RCM05_Q50(i,1);
Table_medium_diff_Q50_2040s{i,6}=Flow_Sim_future_2040s_RCM06_Q50(i,1);
Table_medium_diff_Q50_2040s{i,7}=Flow_Sim_future_2040s_RCM07_Q50(i,1);
Table_medium_diff_Q50_2040s{i,8}=Flow_Sim_future_2040s_RCM08_Q50(i,1);
Table_medium_diff_Q50_2040s{i,9}=Flow_Sim_future_2040s_RCM09_Q50(i,1);
Table_medium_diff_Q50_2040s{i,10}=Flow_Sim_future_2040s_RCM10_Q50(i,1);
Table_medium_diff_Q50_2040s{i,11}=Flow_Sim_future_2040s_RCM11_Q50(i,1);
Table_medium_diff_Q50_2040s{i,12}=Flow_Sim_future_2040s_RCM12_Q50(i,1);
Table_medium_diff_Q50_2040s{i,13}=Flow_Sim_future_2040s_RCM13_Q50(i,1);
Table_medium_diff_Q50_2040s{i,14}=Flow_Sim_future_2040s_RCM15_Q50(i,1);
 
Table_medium_diff_Q50_2040s{i,15}=Flow_Sim_future_2040s_allRCM_Q50(i,1);
 
Table_medium_diff_Q50_2040s{i,16}=(Flow_Obs_baseline_Q50(i,1)-Flow_Sim_future_2040s_RCM01_Q50(i,1))/Flow_Obs_baseline_Q50(i,1)*100;
Table_medium_diff_Q50_2040s{i,17}=(Flow_Obs_baseline_Q50(i,1)-Flow_Sim_future_2040s_RCM04_Q50(i,1))/Flow_Obs_baseline_Q50(i,1)*100;
Table_medium_diff_Q50_2040s{i,18}=(Flow_Obs_baseline_Q50(i,1)-Flow_Sim_future_2040s_RCM05_Q50(i,1))/Flow_Obs_baseline_Q50(i,1)*100;
Table_medium_diff_Q50_2040s{i,19}=(Flow_Obs_baseline_Q50(i,1)-Flow_Sim_future_2040s_RCM06_Q50(i,1))/Flow_Obs_baseline_Q50(i,1)*100;
Table_medium_diff_Q50_2040s{i,20}=(Flow_Obs_baseline_Q50(i,1)-Flow_Sim_future_2040s_RCM07_Q50(i,1))/Flow_Obs_baseline_Q50(i,1)*100;
Table_medium_diff_Q50_2040s{i,21}=(Flow_Obs_baseline_Q50(i,1)-Flow_Sim_future_2040s_RCM08_Q50(i,1))/Flow_Obs_baseline_Q50(i,1)*100;
Table_medium_diff_Q50_2040s{i,22}=(Flow_Obs_baseline_Q50(i,1)-Flow_Sim_future_2040s_RCM09_Q50(i,1))/Flow_Obs_baseline_Q50(i,1)*100;
Table_medium_diff_Q50_2040s{i,23}=(Flow_Obs_baseline_Q50(i,1)-Flow_Sim_future_2040s_RCM10_Q50(i,1))/Flow_Obs_baseline_Q50(i,1)*100;
Table_medium_diff_Q50_2040s{i,24}=(Flow_Obs_baseline_Q50(i,1)-Flow_Sim_future_2040s_RCM11_Q50(i,1))/Flow_Obs_baseline_Q50(i,1)*100;
Table_medium_diff_Q50_2040s{i,25}=(Flow_Obs_baseline_Q50(i,1)-Flow_Sim_future_2040s_RCM12_Q50(i,1))/Flow_Obs_baseline_Q50(i,1)*100;
Table_medium_diff_Q50_2040s{i,26}=(Flow_Obs_baseline_Q50(i,1)-Flow_Sim_future_2040s_RCM13_Q50(i,1))/Flow_Obs_baseline_Q50(i,1)*100;
Table_medium_diff_Q50_2040s{i,27}=(Flow_Obs_baseline_Q50(i,1)-Flow_Sim_future_2040s_RCM15_Q50(i,1))/Flow_Obs_baseline_Q50(i,1)*100;
 
Table_medium_diff_Q50_2040s{i,28}=(Flow_Obs_baseline_Q50(i,1)-Flow_Sim_future_2040s_allRCM_Q50(i,1))/Flow_Obs_baseline_Q50(i,1)*100;
 
Table_medium_diff_Q50_2040s_header={'ID','Baseline Q50 [m^3/s]','RCM01 2040s Q50 [m^3/s]','RCM04 2040s Q50 [m^3/s]','RCM05 2040s Q50 [m^3/s]','RCM06 2040s Q50 [m^3/s]','RCM07 2040s Q50 [m^3/s]','RCM08 2040s Q50 [m^3/s]','RCM09 2040s Q50 [m^3/s]','RCM10 2040s Q50 [m^3/s]','RCM11 2040s Q50 [m^3/s]','RCM12 2040s Q50 [m^3/s]','RCM13 2040s Q50 [m^3/s]','RCM15 2040s Q50 [m^3/s]','All RCM 2040s Q50 [m^3/s]','Baseline-RCM01 2040s Q50 [%]','Baseline-RCM04 [%]','Baseline-RCM05 [%]','Baseline-RCM06 [%]','Baseline-RCM07 [%]','Baseline-RCM08 [%]','Baseline-RCM09 [%]','Baseline-RCM10 [%]' ,'Baseline-RCM11 [%]','Baseline-RCM12 [%]','Baseline-RCM13 [%]','Baseline-RCM15 [%]','Baseline Q50-Future 2040s Q50 [%]'};
 
%Write the table into an excel file
 
if exist(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Station_',no,'_flows_2040s_Q50.xls'), 'file')==2
   delete(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Station_',no,'_flows_2040s_Q50.xls'));
end
 
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Station_',no,'_flows_2040s_Q50.xls'),Table_medium_diff_Q50_2040s,'Sheet1','A2');
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Station_',no,'_flows_2040s_Q50.xls'),Table_medium_diff_Q50_2040s_header,'Sheet1','A1');
 
%% Q60
Table_medium_diff_Q60_2040s{i,1}=GaugesNo(i,1);
 
Table_medium_diff_Q60_2040s{i,2}=Flow_Obs_baseline_Q60(i,1);
 
Table_medium_diff_Q60_2040s{i,3}=Flow_Sim_future_2040s_RCM01_Q60(i,1);
Table_medium_diff_Q60_2040s{i,4}=Flow_Sim_future_2040s_RCM04_Q60(i,1);
Table_medium_diff_Q60_2040s{i,5}=Flow_Sim_future_2040s_RCM05_Q60(i,1);
Table_medium_diff_Q60_2040s{i,6}=Flow_Sim_future_2040s_RCM06_Q60(i,1);
Table_medium_diff_Q60_2040s{i,7}=Flow_Sim_future_2040s_RCM07_Q60(i,1);
Table_medium_diff_Q60_2040s{i,8}=Flow_Sim_future_2040s_RCM08_Q60(i,1);
Table_medium_diff_Q60_2040s{i,9}=Flow_Sim_future_2040s_RCM09_Q60(i,1);
Table_medium_diff_Q60_2040s{i,10}=Flow_Sim_future_2040s_RCM10_Q60(i,1);
Table_medium_diff_Q60_2040s{i,11}=Flow_Sim_future_2040s_RCM11_Q60(i,1);
Table_medium_diff_Q60_2040s{i,12}=Flow_Sim_future_2040s_RCM12_Q60(i,1);
Table_medium_diff_Q60_2040s{i,13}=Flow_Sim_future_2040s_RCM13_Q60(i,1);
Table_medium_diff_Q60_2040s{i,14}=Flow_Sim_future_2040s_RCM15_Q60(i,1);
 
Table_medium_diff_Q60_2040s{i,15}=Flow_Sim_future_2040s_allRCM_Q60(i,1);
 
Table_medium_diff_Q60_2040s{i,16}=(Flow_Obs_baseline_Q60(i,1)-Flow_Sim_future_2040s_RCM01_Q60(i,1))/Flow_Obs_baseline_Q60(i,1)*100;
Table_medium_diff_Q60_2040s{i,17}=(Flow_Obs_baseline_Q60(i,1)-Flow_Sim_future_2040s_RCM04_Q60(i,1))/Flow_Obs_baseline_Q60(i,1)*100;
Table_medium_diff_Q60_2040s{i,18}=(Flow_Obs_baseline_Q60(i,1)-Flow_Sim_future_2040s_RCM05_Q60(i,1))/Flow_Obs_baseline_Q60(i,1)*100;
Table_medium_diff_Q60_2040s{i,19}=(Flow_Obs_baseline_Q60(i,1)-Flow_Sim_future_2040s_RCM06_Q60(i,1))/Flow_Obs_baseline_Q60(i,1)*100;
Table_medium_diff_Q60_2040s{i,20}=(Flow_Obs_baseline_Q60(i,1)-Flow_Sim_future_2040s_RCM07_Q60(i,1))/Flow_Obs_baseline_Q60(i,1)*100;
Table_medium_diff_Q60_2040s{i,21}=(Flow_Obs_baseline_Q60(i,1)-Flow_Sim_future_2040s_RCM08_Q60(i,1))/Flow_Obs_baseline_Q60(i,1)*100;
Table_medium_diff_Q60_2040s{i,22}=(Flow_Obs_baseline_Q60(i,1)-Flow_Sim_future_2040s_RCM09_Q60(i,1))/Flow_Obs_baseline_Q60(i,1)*100;
Table_medium_diff_Q60_2040s{i,23}=(Flow_Obs_baseline_Q60(i,1)-Flow_Sim_future_2040s_RCM10_Q60(i,1))/Flow_Obs_baseline_Q60(i,1)*100;
Table_medium_diff_Q60_2040s{i,24}=(Flow_Obs_baseline_Q60(i,1)-Flow_Sim_future_2040s_RCM11_Q60(i,1))/Flow_Obs_baseline_Q60(i,1)*100;
Table_medium_diff_Q60_2040s{i,25}=(Flow_Obs_baseline_Q60(i,1)-Flow_Sim_future_2040s_RCM12_Q60(i,1))/Flow_Obs_baseline_Q60(i,1)*100;
Table_medium_diff_Q60_2040s{i,26}=(Flow_Obs_baseline_Q60(i,1)-Flow_Sim_future_2040s_RCM13_Q60(i,1))/Flow_Obs_baseline_Q60(i,1)*100;
Table_medium_diff_Q60_2040s{i,27}=(Flow_Obs_baseline_Q60(i,1)-Flow_Sim_future_2040s_RCM15_Q60(i,1))/Flow_Obs_baseline_Q60(i,1)*100;
 
Table_medium_diff_Q60_2040s{i,28}=(Flow_Obs_baseline_Q60(i,1)-Flow_Sim_future_2040s_allRCM_Q60(i,1))/Flow_Obs_baseline_Q60(i,1)*100;
 
Table_medium_diff_Q60_2040s_header={'ID','Baseline Q60 [m^3/s]','RCM01 2040s Q60 [m^3/s]','RCM04 2040s Q60 [m^3/s]','RCM05 2040s Q60 [m^3/s]','RCM06 2040s Q60 [m^3/s]','RCM07 2040s Q60 [m^3/s]','RCM08 2040s Q60 [m^3/s]','RCM09 2040s Q60 [m^3/s]','RCM10 2040s Q60 [m^3/s]','RCM11 2040s Q60 [m^3/s]','RCM12 2040s Q60 [m^3/s]','RCM13 2040s Q60 [m^3/s]','RCM15 2040s Q60 [m^3/s]','All RCM 2040s Q60 [m^3/s]','Baseline-RCM01 2040s Q60 [%]','Baseline-RCM04 [%]','Baseline-RCM05 [%]','Baseline-RCM06 [%]','Baseline-RCM07 [%]','Baseline-RCM08 [%]','Baseline-RCM09 [%]','Baseline-RCM10 [%]' ,'Baseline-RCM11 [%]','Baseline-RCM12 [%]','Baseline-RCM13 [%]','Baseline-RCM15 [%]','Baseline Q60-Future 2040s Q60 [%]'};
 
%Write the table into an excel file
 
if exist(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Station_',no,'_flows_2040s_Q60.xls'), 'file')==2
   delete(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Station_',no,'_flows_2040s_Q60.xls'));
end
 
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Station_',no,'_flows_2040s_Q60.xls'),Table_medium_diff_Q60_2040s,'Sheet1','A2');
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Station_',no,'_flows_2040s_Q60.xls'),Table_medium_diff_Q60_2040s_header,'Sheet1','A1');
 
%% 2060s
 
%% Q40
 
Table_medium_diff_Q40_2060s{i,1}=GaugesNo(i,1);
 
Table_medium_diff_Q40_2060s{i,2}=Flow_Obs_baseline_Q40(i,1);
 
Table_medium_diff_Q40_2060s{i,3}=Flow_Sim_future_2060s_RCM01_Q40(i,1);
Table_medium_diff_Q40_2060s{i,4}=Flow_Sim_future_2060s_RCM04_Q40(i,1);
Table_medium_diff_Q40_2060s{i,5}=Flow_Sim_future_2060s_RCM05_Q40(i,1);
Table_medium_diff_Q40_2060s{i,6}=Flow_Sim_future_2060s_RCM06_Q40(i,1);
Table_medium_diff_Q40_2060s{i,7}=Flow_Sim_future_2060s_RCM07_Q40(i,1);
Table_medium_diff_Q40_2060s{i,8}=Flow_Sim_future_2060s_RCM08_Q40(i,1);
Table_medium_diff_Q40_2060s{i,9}=Flow_Sim_future_2060s_RCM09_Q40(i,1);
Table_medium_diff_Q40_2060s{i,10}=Flow_Sim_future_2060s_RCM10_Q40(i,1);
Table_medium_diff_Q40_2060s{i,11}=Flow_Sim_future_2060s_RCM11_Q40(i,1);
Table_medium_diff_Q40_2060s{i,12}=Flow_Sim_future_2060s_RCM12_Q40(i,1);
Table_medium_diff_Q40_2060s{i,13}=Flow_Sim_future_2060s_RCM13_Q40(i,1);
Table_medium_diff_Q40_2060s{i,14}=Flow_Sim_future_2060s_RCM15_Q40(i,1);
 
Table_medium_diff_Q40_2060s{i,15}=Flow_Sim_future_2060s_allRCM_Q40(i,1);
 
Table_medium_diff_Q40_2060s{i,16}=(Flow_Obs_baseline_Q40(i,1)-Flow_Sim_future_2060s_RCM01_Q40(i,1))/Flow_Obs_baseline_Q40(i,1)*100;
Table_medium_diff_Q40_2060s{i,17}=(Flow_Obs_baseline_Q40(i,1)-Flow_Sim_future_2060s_RCM04_Q40(i,1))/Flow_Obs_baseline_Q40(i,1)*100;
Table_medium_diff_Q40_2060s{i,18}=(Flow_Obs_baseline_Q40(i,1)-Flow_Sim_future_2060s_RCM05_Q40(i,1))/Flow_Obs_baseline_Q40(i,1)*100;
Table_medium_diff_Q40_2060s{i,19}=(Flow_Obs_baseline_Q40(i,1)-Flow_Sim_future_2060s_RCM06_Q40(i,1))/Flow_Obs_baseline_Q40(i,1)*100;
Table_medium_diff_Q40_2060s{i,20}=(Flow_Obs_baseline_Q40(i,1)-Flow_Sim_future_2060s_RCM07_Q40(i,1))/Flow_Obs_baseline_Q40(i,1)*100;
Table_medium_diff_Q40_2060s{i,21}=(Flow_Obs_baseline_Q40(i,1)-Flow_Sim_future_2060s_RCM08_Q40(i,1))/Flow_Obs_baseline_Q40(i,1)*100;
Table_medium_diff_Q40_2060s{i,22}=(Flow_Obs_baseline_Q40(i,1)-Flow_Sim_future_2060s_RCM09_Q40(i,1))/Flow_Obs_baseline_Q40(i,1)*100;
Table_medium_diff_Q40_2060s{i,23}=(Flow_Obs_baseline_Q40(i,1)-Flow_Sim_future_2060s_RCM10_Q40(i,1))/Flow_Obs_baseline_Q40(i,1)*100;
Table_medium_diff_Q40_2060s{i,24}=(Flow_Obs_baseline_Q40(i,1)-Flow_Sim_future_2060s_RCM11_Q40(i,1))/Flow_Obs_baseline_Q40(i,1)*100;
Table_medium_diff_Q40_2060s{i,25}=(Flow_Obs_baseline_Q40(i,1)-Flow_Sim_future_2060s_RCM12_Q40(i,1))/Flow_Obs_baseline_Q40(i,1)*100;
Table_medium_diff_Q40_2060s{i,26}=(Flow_Obs_baseline_Q40(i,1)-Flow_Sim_future_2060s_RCM13_Q40(i,1))/Flow_Obs_baseline_Q40(i,1)*100;
Table_medium_diff_Q40_2060s{i,27}=(Flow_Obs_baseline_Q40(i,1)-Flow_Sim_future_2060s_RCM15_Q40(i,1))/Flow_Obs_baseline_Q40(i,1)*100;
 
Table_medium_diff_Q40_2060s{i,28}=(Flow_Obs_baseline_Q40(i,1)-Flow_Sim_future_2060s_allRCM_Q40(i,1))/Flow_Obs_baseline_Q40(i,1)*100;
 
Table_medium_diff_Q40_2060s_header={'ID','Baseline Q40 [m^3/s]','RCM01 2060s Q40 [m^3/s]','RCM04 2060s Q40 [m^3/s]','RCM05 2060s Q40 [m^3/s]','RCM06 2060s Q40 [m^3/s]','RCM07 2060s Q40 [m^3/s]','RCM08 2060s Q40 [m^3/s]','RCM09 2060s Q40 [m^3/s]','RCM10 2060s Q40 [m^3/s]','RCM11 2060s Q40 [m^3/s]','RCM12 2060s Q40 [m^3/s]','RCM13 2060s Q40 [m^3/s]','RCM15 2060s Q40 [m^3/s]','All RCM 2060s Q40 [m^3/s]','Baseline-RCM01 2060s Q40 [%]','Baseline-RCM04 [%]','Baseline-RCM05 [%]','Baseline-RCM06 [%]','Baseline-RCM07 [%]','Baseline-RCM08 [%]','Baseline-RCM09 [%]','Baseline-RCM10 [%]' ,'Baseline-RCM11 [%]','Baseline-RCM12 [%]','Baseline-RCM13 [%]','Baseline-RCM15 [%]','Baseline Q40-Future 2060s Q40 [%]'};
 
%Write the table into an excel file
 
if exist(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Station_',no,'_flows_2060s_Q40.xls'), 'file')==2
   delete(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Station_',no,'_flows_2060s_Q40.xls'));
end
 
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Station_',no,'_flows_2060s_Q40.xls'),Table_medium_diff_Q40_2060s,'Sheet1','A2');
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Station_',no,'_flows_2060s_Q40.xls'),Table_medium_diff_Q40_2060s_header,'Sheet1','A1');
 
%% Q50
 
Table_medium_diff_Q50_2060s{i,1}=GaugesNo(i,1);
 
Table_medium_diff_Q50_2060s{i,2}=Flow_Obs_baseline_Q50(i,1);
 
Table_medium_diff_Q50_2060s{i,3}=Flow_Sim_future_2060s_RCM01_Q50(i,1);
Table_medium_diff_Q50_2060s{i,4}=Flow_Sim_future_2060s_RCM04_Q50(i,1);
Table_medium_diff_Q50_2060s{i,5}=Flow_Sim_future_2060s_RCM05_Q50(i,1);
Table_medium_diff_Q50_2060s{i,6}=Flow_Sim_future_2060s_RCM06_Q50(i,1);
Table_medium_diff_Q50_2060s{i,7}=Flow_Sim_future_2060s_RCM07_Q50(i,1);
Table_medium_diff_Q50_2060s{i,8}=Flow_Sim_future_2060s_RCM08_Q50(i,1);
Table_medium_diff_Q50_2060s{i,9}=Flow_Sim_future_2060s_RCM09_Q50(i,1);
Table_medium_diff_Q50_2060s{i,10}=Flow_Sim_future_2060s_RCM10_Q50(i,1);
Table_medium_diff_Q50_2060s{i,11}=Flow_Sim_future_2060s_RCM11_Q50(i,1);
Table_medium_diff_Q50_2060s{i,12}=Flow_Sim_future_2060s_RCM12_Q50(i,1);
Table_medium_diff_Q50_2060s{i,13}=Flow_Sim_future_2060s_RCM13_Q50(i,1);
Table_medium_diff_Q50_2060s{i,14}=Flow_Sim_future_2060s_RCM15_Q50(i,1);
 
Table_medium_diff_Q50_2060s{i,15}=Flow_Sim_future_2060s_allRCM_Q50(i,1);
 
Table_medium_diff_Q50_2060s{i,16}=(Flow_Obs_baseline_Q50(i,1)-Flow_Sim_future_2060s_RCM01_Q50(i,1))/Flow_Obs_baseline_Q50(i,1)*100;
Table_medium_diff_Q50_2060s{i,17}=(Flow_Obs_baseline_Q50(i,1)-Flow_Sim_future_2060s_RCM04_Q50(i,1))/Flow_Obs_baseline_Q50(i,1)*100;
Table_medium_diff_Q50_2060s{i,18}=(Flow_Obs_baseline_Q50(i,1)-Flow_Sim_future_2060s_RCM05_Q50(i,1))/Flow_Obs_baseline_Q50(i,1)*100;
Table_medium_diff_Q50_2060s{i,19}=(Flow_Obs_baseline_Q50(i,1)-Flow_Sim_future_2060s_RCM06_Q50(i,1))/Flow_Obs_baseline_Q50(i,1)*100;
Table_medium_diff_Q50_2060s{i,20}=(Flow_Obs_baseline_Q50(i,1)-Flow_Sim_future_2060s_RCM07_Q50(i,1))/Flow_Obs_baseline_Q50(i,1)*100;
Table_medium_diff_Q50_2060s{i,21}=(Flow_Obs_baseline_Q50(i,1)-Flow_Sim_future_2060s_RCM08_Q50(i,1))/Flow_Obs_baseline_Q50(i,1)*100;
Table_medium_diff_Q50_2060s{i,22}=(Flow_Obs_baseline_Q50(i,1)-Flow_Sim_future_2060s_RCM09_Q50(i,1))/Flow_Obs_baseline_Q50(i,1)*100;
Table_medium_diff_Q50_2060s{i,23}=(Flow_Obs_baseline_Q50(i,1)-Flow_Sim_future_2060s_RCM10_Q50(i,1))/Flow_Obs_baseline_Q50(i,1)*100;
Table_medium_diff_Q50_2060s{i,24}=(Flow_Obs_baseline_Q50(i,1)-Flow_Sim_future_2060s_RCM11_Q50(i,1))/Flow_Obs_baseline_Q50(i,1)*100;
Table_medium_diff_Q50_2060s{i,25}=(Flow_Obs_baseline_Q50(i,1)-Flow_Sim_future_2060s_RCM12_Q50(i,1))/Flow_Obs_baseline_Q50(i,1)*100;
Table_medium_diff_Q50_2060s{i,26}=(Flow_Obs_baseline_Q50(i,1)-Flow_Sim_future_2060s_RCM13_Q50(i,1))/Flow_Obs_baseline_Q50(i,1)*100;
Table_medium_diff_Q50_2060s{i,27}=(Flow_Obs_baseline_Q50(i,1)-Flow_Sim_future_2060s_RCM15_Q50(i,1))/Flow_Obs_baseline_Q50(i,1)*100;
 
Table_medium_diff_Q50_2060s{i,28}=(Flow_Obs_baseline_Q50(i,1)-Flow_Sim_future_2060s_allRCM_Q50(i,1))/Flow_Obs_baseline_Q50(i,1)*100;
 
Table_medium_diff_Q50_2060s_header={'ID','Baseline Q50 [m^3/s]','RCM01 2060s Q50 [m^3/s]','RCM04 2060s Q50 [m^3/s]','RCM05 2060s Q50 [m^3/s]','RCM06 2060s Q50 [m^3/s]','RCM07 2060s Q50 [m^3/s]','RCM08 2060s Q50 [m^3/s]','RCM09 2060s Q50 [m^3/s]','RCM10 2060s Q50 [m^3/s]','RCM11 2060s Q50 [m^3/s]','RCM12 2060s Q50 [m^3/s]','RCM13 2060s Q50 [m^3/s]','RCM15 2060s Q50 [m^3/s]','All RCM 2060s Q50 [m^3/s]','Baseline-RCM01 2060s Q50 [%]','Baseline-RCM04 [%]','Baseline-RCM05 [%]','Baseline-RCM06 [%]','Baseline-RCM07 [%]','Baseline-RCM08 [%]','Baseline-RCM09 [%]','Baseline-RCM10 [%]' ,'Baseline-RCM11 [%]','Baseline-RCM12 [%]','Baseline-RCM13 [%]','Baseline-RCM15 [%]','Baseline Q50-Future 2060s Q50 [%]'};
 
%Write the table into an excel file
 
if exist(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Station_',no,'_flows_2060s_Q50.xls'), 'file')==2
   delete(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Station_',no,'_flows_2060s_Q50.xls'));
end
 
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Station_',no,'_flows_2060s_Q50.xls'),Table_medium_diff_Q50_2060s,'Sheet1','A2');
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Station_',no,'_flows_2060s_Q50.xls'),Table_medium_diff_Q50_2060s_header,'Sheet1','A1');
 
%% Q60
 
Table_medium_diff_Q60_2060s{i,1}=GaugesNo(i,1);
 
Table_medium_diff_Q60_2060s{i,2}=Flow_Obs_baseline_Q60(i,1);
 
Table_medium_diff_Q60_2060s{i,3}=Flow_Sim_future_2060s_RCM01_Q60(i,1);
Table_medium_diff_Q60_2060s{i,4}=Flow_Sim_future_2060s_RCM04_Q60(i,1);
Table_medium_diff_Q60_2060s{i,5}=Flow_Sim_future_2060s_RCM05_Q60(i,1);
Table_medium_diff_Q60_2060s{i,6}=Flow_Sim_future_2060s_RCM06_Q60(i,1);
Table_medium_diff_Q60_2060s{i,7}=Flow_Sim_future_2060s_RCM07_Q60(i,1);
Table_medium_diff_Q60_2060s{i,8}=Flow_Sim_future_2060s_RCM08_Q60(i,1);
Table_medium_diff_Q60_2060s{i,9}=Flow_Sim_future_2060s_RCM09_Q60(i,1);
Table_medium_diff_Q60_2060s{i,10}=Flow_Sim_future_2060s_RCM10_Q60(i,1);
Table_medium_diff_Q60_2060s{i,11}=Flow_Sim_future_2060s_RCM11_Q60(i,1);
Table_medium_diff_Q60_2060s{i,12}=Flow_Sim_future_2060s_RCM12_Q60(i,1);
Table_medium_diff_Q60_2060s{i,13}=Flow_Sim_future_2060s_RCM13_Q60(i,1);
Table_medium_diff_Q60_2060s{i,14}=Flow_Sim_future_2060s_RCM15_Q60(i,1);
 
Table_medium_diff_Q60_2060s{i,15}=Flow_Sim_future_2060s_allRCM_Q60(i,1);
 
Table_medium_diff_Q60_2060s{i,16}=(Flow_Obs_baseline_Q60(i,1)-Flow_Sim_future_2060s_RCM01_Q60(i,1))/Flow_Obs_baseline_Q60(i,1)*100;
Table_medium_diff_Q60_2060s{i,17}=(Flow_Obs_baseline_Q60(i,1)-Flow_Sim_future_2060s_RCM04_Q60(i,1))/Flow_Obs_baseline_Q60(i,1)*100;
Table_medium_diff_Q60_2060s{i,18}=(Flow_Obs_baseline_Q60(i,1)-Flow_Sim_future_2060s_RCM05_Q60(i,1))/Flow_Obs_baseline_Q60(i,1)*100;
Table_medium_diff_Q60_2060s{i,19}=(Flow_Obs_baseline_Q60(i,1)-Flow_Sim_future_2060s_RCM06_Q60(i,1))/Flow_Obs_baseline_Q60(i,1)*100;
Table_medium_diff_Q60_2060s{i,20}=(Flow_Obs_baseline_Q60(i,1)-Flow_Sim_future_2060s_RCM07_Q60(i,1))/Flow_Obs_baseline_Q60(i,1)*100;
Table_medium_diff_Q60_2060s{i,21}=(Flow_Obs_baseline_Q60(i,1)-Flow_Sim_future_2060s_RCM08_Q60(i,1))/Flow_Obs_baseline_Q60(i,1)*100;
Table_medium_diff_Q60_2060s{i,22}=(Flow_Obs_baseline_Q60(i,1)-Flow_Sim_future_2060s_RCM09_Q60(i,1))/Flow_Obs_baseline_Q60(i,1)*100;
Table_medium_diff_Q60_2060s{i,23}=(Flow_Obs_baseline_Q60(i,1)-Flow_Sim_future_2060s_RCM10_Q60(i,1))/Flow_Obs_baseline_Q60(i,1)*100;
Table_medium_diff_Q60_2060s{i,24}=(Flow_Obs_baseline_Q60(i,1)-Flow_Sim_future_2060s_RCM11_Q60(i,1))/Flow_Obs_baseline_Q60(i,1)*100;
Table_medium_diff_Q60_2060s{i,25}=(Flow_Obs_baseline_Q60(i,1)-Flow_Sim_future_2060s_RCM12_Q60(i,1))/Flow_Obs_baseline_Q60(i,1)*100;
Table_medium_diff_Q60_2060s{i,26}=(Flow_Obs_baseline_Q60(i,1)-Flow_Sim_future_2060s_RCM13_Q60(i,1))/Flow_Obs_baseline_Q60(i,1)*100;
Table_medium_diff_Q60_2060s{i,27}=(Flow_Obs_baseline_Q60(i,1)-Flow_Sim_future_2060s_RCM15_Q60(i,1))/Flow_Obs_baseline_Q60(i,1)*100;
 
Table_medium_diff_Q60_2060s{i,28}=(Flow_Obs_baseline_Q60(i,1)-Flow_Sim_future_2060s_allRCM_Q60(i,1))/Flow_Obs_baseline_Q60(i,1)*100;
 
Table_medium_diff_Q60_2060s_header={'ID','Baseline Q60 [m^3/s]','RCM01 2060s Q60 [m^3/s]','RCM04 2060s Q60 [m^3/s]','RCM05 2060s Q60 [m^3/s]','RCM06 2060s Q60 [m^3/s]','RCM07 2060s Q60 [m^3/s]','RCM08 2060s Q60 [m^3/s]','RCM09 2060s Q60 [m^3/s]','RCM10 2060s Q60 [m^3/s]','RCM11 2060s Q60 [m^3/s]','RCM12 2060s Q60 [m^3/s]','RCM13 2060s Q60 [m^3/s]','RCM15 2060s Q60 [m^3/s]','All RCM 2060s Q60 [m^3/s]','Baseline-RCM01 2060s Q60 [%]','Baseline-RCM04 [%]','Baseline-RCM05 [%]','Baseline-RCM06 [%]','Baseline-RCM07 [%]','Baseline-RCM08 [%]','Baseline-RCM09 [%]','Baseline-RCM10 [%]' ,'Baseline-RCM11 [%]','Baseline-RCM12 [%]','Baseline-RCM13 [%]','Baseline-RCM15 [%]','Baseline Q60-Future 2060s Q60 [%]'};
 
%Write the table into an excel file
 
if exist(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Station_',no,'_flows_2060s_Q60.xls'), 'file')==2
   delete(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Station_',no,'_flows_2060s_Q60.xls'));
end
 
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Station_',no,'_flows_2060s_Q60.xls'),Table_medium_diff_Q60_2060s,'Sheet1','A2');
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Station_',no,'_flows_2060s_Q60.xls'),Table_medium_diff_Q60_2060s_header,'Sheet1','A1');
 
%% Tables of differences in environmental flows
 
%% 2040s
 
%% Q95
Table_medium_diff_Q95_2040s{i,1}=GaugesNo(i,1);
 
Table_medium_diff_Q95_2040s{i,2}=Flow_Obs_baseline_Q95(i,1);
 
Table_medium_diff_Q95_2040s{i,3}=Flow_Sim_future_2040s_RCM01_Q95(i,1);
Table_medium_diff_Q95_2040s{i,4}=Flow_Sim_future_2040s_RCM04_Q95(i,1);
Table_medium_diff_Q95_2040s{i,5}=Flow_Sim_future_2040s_RCM05_Q95(i,1);
Table_medium_diff_Q95_2040s{i,6}=Flow_Sim_future_2040s_RCM06_Q95(i,1);
Table_medium_diff_Q95_2040s{i,7}=Flow_Sim_future_2040s_RCM07_Q95(i,1);
Table_medium_diff_Q95_2040s{i,8}=Flow_Sim_future_2040s_RCM08_Q95(i,1);
Table_medium_diff_Q95_2040s{i,9}=Flow_Sim_future_2040s_RCM09_Q95(i,1);
Table_medium_diff_Q95_2040s{i,10}=Flow_Sim_future_2040s_RCM10_Q95(i,1);
Table_medium_diff_Q95_2040s{i,11}=Flow_Sim_future_2040s_RCM11_Q95(i,1);
Table_medium_diff_Q95_2040s{i,12}=Flow_Sim_future_2040s_RCM12_Q95(i,1);
Table_medium_diff_Q95_2040s{i,13}=Flow_Sim_future_2040s_RCM13_Q95(i,1);
Table_medium_diff_Q95_2040s{i,14}=Flow_Sim_future_2040s_RCM15_Q95(i,1);
 
Table_medium_diff_Q95_2040s{i,15}=Flow_Sim_future_2040s_allRCM_Q95(i,1);
 
Table_medium_diff_Q95_2040s{i,16}=(Flow_Obs_baseline_Q95(i,1)-Flow_Sim_future_2040s_RCM01_Q95(i,1))/Flow_Obs_baseline_Q95(i,1)*100;
Table_medium_diff_Q95_2040s{i,17}=(Flow_Obs_baseline_Q95(i,1)-Flow_Sim_future_2040s_RCM04_Q95(i,1))/Flow_Obs_baseline_Q95(i,1)*100;
Table_medium_diff_Q95_2040s{i,18}=(Flow_Obs_baseline_Q95(i,1)-Flow_Sim_future_2040s_RCM05_Q95(i,1))/Flow_Obs_baseline_Q95(i,1)*100;
Table_medium_diff_Q95_2040s{i,19}=(Flow_Obs_baseline_Q95(i,1)-Flow_Sim_future_2040s_RCM06_Q95(i,1))/Flow_Obs_baseline_Q95(i,1)*100;
Table_medium_diff_Q95_2040s{i,20}=(Flow_Obs_baseline_Q95(i,1)-Flow_Sim_future_2040s_RCM07_Q95(i,1))/Flow_Obs_baseline_Q95(i,1)*100;
Table_medium_diff_Q95_2040s{i,21}=(Flow_Obs_baseline_Q95(i,1)-Flow_Sim_future_2040s_RCM08_Q95(i,1))/Flow_Obs_baseline_Q95(i,1)*100;
Table_medium_diff_Q95_2040s{i,22}=(Flow_Obs_baseline_Q95(i,1)-Flow_Sim_future_2040s_RCM09_Q95(i,1))/Flow_Obs_baseline_Q95(i,1)*100;
Table_medium_diff_Q95_2040s{i,23}=(Flow_Obs_baseline_Q95(i,1)-Flow_Sim_future_2040s_RCM10_Q95(i,1))/Flow_Obs_baseline_Q95(i,1)*100;
Table_medium_diff_Q95_2040s{i,24}=(Flow_Obs_baseline_Q95(i,1)-Flow_Sim_future_2040s_RCM11_Q95(i,1))/Flow_Obs_baseline_Q95(i,1)*100;
Table_medium_diff_Q95_2040s{i,25}=(Flow_Obs_baseline_Q95(i,1)-Flow_Sim_future_2040s_RCM12_Q95(i,1))/Flow_Obs_baseline_Q95(i,1)*100;
Table_medium_diff_Q95_2040s{i,26}=(Flow_Obs_baseline_Q95(i,1)-Flow_Sim_future_2040s_RCM13_Q95(i,1))/Flow_Obs_baseline_Q95(i,1)*100;
Table_medium_diff_Q95_2040s{i,27}=(Flow_Obs_baseline_Q95(i,1)-Flow_Sim_future_2040s_RCM15_Q95(i,1))/Flow_Obs_baseline_Q95(i,1)*100;
 
Table_medium_diff_Q95_2040s{i,28}=(Flow_Obs_baseline_Q95(i,1)-Flow_Sim_future_2040s_allRCM_Q95(i,1))/Flow_Obs_baseline_Q95(i,1)*100;
 
Table_medium_diff_Q95_2040s_header={'ID','Baseline Q95 [m^3/s]','RCM01 2040s Q95 [m^3/s]','RCM04 2040s Q95 [m^3/s]','RCM05 2040s Q95 [m^3/s]','RCM06 2040s Q95 [m^3/s]','RCM07 2040s Q95 [m^3/s]','RCM08 2040s Q95 [m^3/s]','RCM09 2040s Q95 [m^3/s]','RCM10 2040s Q95 [m^3/s]','RCM11 2040s Q95 [m^3/s]','RCM12 2040s Q95 [m^3/s]','RCM13 2040s Q95 [m^3/s]','RCM15 2040s Q95 [m^3/s]','All RCM 2040s Q95 [m^3/s]','Baseline-RCM01 2040s Q95 [%]','Baseline-RCM04 [%]','Baseline-RCM05 [%]','Baseline-RCM06 [%]','Baseline-RCM07 [%]','Baseline-RCM08 [%]','Baseline-RCM09 [%]','Baseline-RCM10 [%]' ,'Baseline-RCM11 [%]','Baseline-RCM12 [%]','Baseline-RCM13 [%]','Baseline-RCM15 [%]','Baseline Q95-Future 2040s Q95 [%]'};
 
%Write the table into an excel file
 
if exist(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Station_',no,'_flows_2040s_Q95.xls'), 'file')==2
   delete(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Station_',no,'_flows_2040s_Q95.xls'));
end
 
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Station_',no,'_flows_2040s_Q95.xls'),Table_medium_diff_Q95_2040s,'Sheet1','A2');
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Station_',no,'_flows_2040s_Q95.xls'),Table_medium_diff_Q95_2040s_header,'Sheet1','A1');
 
%% 2060s
 
%% Q95
 
Table_medium_diff_Q95_2060s{i,1}=GaugesNo(i,1);
 
Table_medium_diff_Q95_2060s{i,2}=Flow_Obs_baseline_Q95(i,1);
 
Table_medium_diff_Q95_2060s{i,3}=Flow_Sim_future_2060s_RCM01_Q95(i,1);
Table_medium_diff_Q95_2060s{i,4}=Flow_Sim_future_2060s_RCM04_Q95(i,1);
Table_medium_diff_Q95_2060s{i,5}=Flow_Sim_future_2060s_RCM05_Q95(i,1);
Table_medium_diff_Q95_2060s{i,6}=Flow_Sim_future_2060s_RCM06_Q95(i,1);
Table_medium_diff_Q95_2060s{i,7}=Flow_Sim_future_2060s_RCM07_Q95(i,1);
Table_medium_diff_Q95_2060s{i,8}=Flow_Sim_future_2060s_RCM08_Q95(i,1);
Table_medium_diff_Q95_2060s{i,9}=Flow_Sim_future_2060s_RCM09_Q95(i,1);
Table_medium_diff_Q95_2060s{i,10}=Flow_Sim_future_2060s_RCM10_Q95(i,1);
Table_medium_diff_Q95_2060s{i,11}=Flow_Sim_future_2060s_RCM11_Q95(i,1);
Table_medium_diff_Q95_2060s{i,12}=Flow_Sim_future_2060s_RCM12_Q95(i,1);
Table_medium_diff_Q95_2060s{i,13}=Flow_Sim_future_2060s_RCM13_Q95(i,1);
Table_medium_diff_Q95_2060s{i,14}=Flow_Sim_future_2060s_RCM15_Q95(i,1);
 
Table_medium_diff_Q95_2060s{i,15}=Flow_Sim_future_2060s_allRCM_Q95(i,1);
 
Table_medium_diff_Q95_2060s{i,16}=(Flow_Obs_baseline_Q95(i,1)-Flow_Sim_future_2060s_RCM01_Q95(i,1))/Flow_Obs_baseline_Q95(i,1)*100;
Table_medium_diff_Q95_2060s{i,17}=(Flow_Obs_baseline_Q95(i,1)-Flow_Sim_future_2060s_RCM04_Q95(i,1))/Flow_Obs_baseline_Q95(i,1)*100;
Table_medium_diff_Q95_2060s{i,18}=(Flow_Obs_baseline_Q95(i,1)-Flow_Sim_future_2060s_RCM05_Q95(i,1))/Flow_Obs_baseline_Q95(i,1)*100;
Table_medium_diff_Q95_2060s{i,19}=(Flow_Obs_baseline_Q95(i,1)-Flow_Sim_future_2060s_RCM06_Q95(i,1))/Flow_Obs_baseline_Q95(i,1)*100;
Table_medium_diff_Q95_2060s{i,20}=(Flow_Obs_baseline_Q95(i,1)-Flow_Sim_future_2060s_RCM07_Q95(i,1))/Flow_Obs_baseline_Q95(i,1)*100;
Table_medium_diff_Q95_2060s{i,21}=(Flow_Obs_baseline_Q95(i,1)-Flow_Sim_future_2060s_RCM08_Q95(i,1))/Flow_Obs_baseline_Q95(i,1)*100;
Table_medium_diff_Q95_2060s{i,22}=(Flow_Obs_baseline_Q95(i,1)-Flow_Sim_future_2060s_RCM09_Q95(i,1))/Flow_Obs_baseline_Q95(i,1)*100;
Table_medium_diff_Q95_2060s{i,23}=(Flow_Obs_baseline_Q95(i,1)-Flow_Sim_future_2060s_RCM10_Q95(i,1))/Flow_Obs_baseline_Q95(i,1)*100;
Table_medium_diff_Q95_2060s{i,24}=(Flow_Obs_baseline_Q95(i,1)-Flow_Sim_future_2060s_RCM11_Q95(i,1))/Flow_Obs_baseline_Q95(i,1)*100;
Table_medium_diff_Q95_2060s{i,25}=(Flow_Obs_baseline_Q95(i,1)-Flow_Sim_future_2060s_RCM12_Q95(i,1))/Flow_Obs_baseline_Q95(i,1)*100;
Table_medium_diff_Q95_2060s{i,26}=(Flow_Obs_baseline_Q95(i,1)-Flow_Sim_future_2060s_RCM13_Q95(i,1))/Flow_Obs_baseline_Q95(i,1)*100;
Table_medium_diff_Q95_2060s{i,27}=(Flow_Obs_baseline_Q95(i,1)-Flow_Sim_future_2060s_RCM15_Q95(i,1))/Flow_Obs_baseline_Q95(i,1)*100;
 
Table_medium_diff_Q95_2060s{i,28}=(Flow_Obs_baseline_Q95(i,1)-Flow_Sim_future_2060s_allRCM_Q95(i,1))/Flow_Obs_baseline_Q95(i,1)*100;
 
Table_medium_diff_Q95_2060s_header={'ID','Baseline Q95 [m^3/s]','RCM01 2060s Q95 [m^3/s]','RCM04 2060s Q95 [m^3/s]','RCM05 2060s Q95 [m^3/s]','RCM06 2060s Q95 [m^3/s]','RCM07 2060s Q95 [m^3/s]','RCM08 2060s Q95 [m^3/s]','RCM09 2060s Q95 [m^3/s]','RCM10 2060s Q95 [m^3/s]','RCM11 2060s Q95 [m^3/s]','RCM12 2060s Q95 [m^3/s]','RCM13 2060s Q95 [m^3/s]','RCM15 2060s Q95 [m^3/s]','All RCM 2060s Q95 [m^3/s]','Baseline-RCM01 2060s Q95 [%]','Baseline-RCM04 [%]','Baseline-RCM05 [%]','Baseline-RCM06 [%]','Baseline-RCM07 [%]','Baseline-RCM08 [%]','Baseline-RCM09 [%]','Baseline-RCM10 [%]' ,'Baseline-RCM11 [%]','Baseline-RCM12 [%]','Baseline-RCM13 [%]','Baseline-RCM15 [%]','Baseline Q95-Future 2060s Q95 [%]'};
 
%Write the table into an excel file
 
if exist(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Station_',no,'_flows_2060s_Q95.xls'), 'file')==2
   delete(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Station_',no,'_flows_2060s_Q95.xls'));
end
 
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Station_',no,'_flows_2060s_Q95.xls'),Table_medium_diff_Q95_2060s,'Sheet1','A2');
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Station_',no,'_flows_2060s_Q95.xls'),Table_medium_diff_Q95_2060s_header,'Sheet1','A1');
 
%% Days with flow below baseline Q95
 
%% Baseline
Days_baseline_flow_below_Q95(i,1)=0;
 
for j =1:length(Flow_Obs_baseline)
    if Flow_Obs_baseline(j,1)<Flow_Obs_baseline_Q95(i,1)
        Days_baseline_flow_below_Q95(i,1)=Days_baseline_flow_below_Q95(i,1)+1;
    end
end
    Days_baseline_flow_below_Q95_perc(i,1)=Days_baseline_flow_below_Q95(i,1)/length(Flow_Obs_baseline)*100;
 
%% 2040s
 
%% RCM01
Days_future_2040s_RCM01_flow_below_Q95(i,1)=0;
 
for j =1:length(Flow_Sim_future_2040s_RCM01)
    if Flow_Sim_future_2040s_RCM01(j,1)<Flow_Obs_baseline_Q95(i,1)
        Days_future_2040s_RCM01_flow_below_Q95(i,1)=Days_future_2040s_RCM01_flow_below_Q95(i,1)+1;
    end
end
    Days_future_2040s_RCM01_flow_below_Q95_perc(i,1)=Days_future_2040s_RCM01_flow_below_Q95(i,1)/length(Flow_Sim_future_2040s_RCM01)*100;
 
%% RCM04
Days_future_2040s_RCM04_flow_below_Q95(i,1)=0;
 
for j =1:length(Flow_Sim_future_2040s_RCM04)
    if Flow_Sim_future_2040s_RCM04(j,1)<Flow_Obs_baseline_Q95(i,1)
        Days_future_2040s_RCM04_flow_below_Q95(i,1)=Days_future_2040s_RCM04_flow_below_Q95(i,1)+1;
    end
end
    Days_future_2040s_RCM04_flow_below_Q95_perc(i,1)=Days_future_2040s_RCM04_flow_below_Q95(i,1)/length(Flow_Sim_future_2040s_RCM04)*100;
 
%% RCM05
Days_future_2040s_RCM05_flow_below_Q95(i,1)=0;
 
for j =1:length(Flow_Sim_future_2040s_RCM05)
    if Flow_Sim_future_2040s_RCM05(j,1)<Flow_Obs_baseline_Q95(i,1)
        Days_future_2040s_RCM05_flow_below_Q95(i,1)=Days_future_2040s_RCM05_flow_below_Q95(i,1)+1;
    end
end
    Days_future_2040s_RCM05_flow_below_Q95_perc(i,1)=Days_future_2040s_RCM05_flow_below_Q95(i,1)/length(Flow_Sim_future_2040s_RCM05)*100;
 
%% RCM06
Days_future_2040s_RCM06_flow_below_Q95(i,1)=0;
 
for j =1:length(Flow_Sim_future_2040s_RCM06)
    if Flow_Sim_future_2040s_RCM06(j,1)<Flow_Obs_baseline_Q95(i,1)
        Days_future_2040s_RCM06_flow_below_Q95(i,1)=Days_future_2040s_RCM06_flow_below_Q95(i,1)+1;
    end
end
    Days_future_2040s_RCM06_flow_below_Q95_perc(i,1)=Days_future_2040s_RCM06_flow_below_Q95(i,1)/length(Flow_Sim_future_2040s_RCM06)*100;
 
%% RCM07
Days_future_2040s_RCM07_flow_below_Q95(i,1)=0;
 
for j =1:length(Flow_Sim_future_2040s_RCM07)
    if Flow_Sim_future_2040s_RCM07(j,1)<Flow_Obs_baseline_Q95(i,1)
        Days_future_2040s_RCM07_flow_below_Q95(i,1)=Days_future_2040s_RCM07_flow_below_Q95(i,1)+1;
    end
end
    Days_future_2040s_RCM07_flow_below_Q95_perc(i,1)=Days_future_2040s_RCM07_flow_below_Q95(i,1)/length(Flow_Sim_future_2040s_RCM07)*100;
 
%% RCM08
Days_future_2040s_RCM08_flow_below_Q95(i,1)=0;
 
for j =1:length(Flow_Sim_future_2040s_RCM08)
    if Flow_Sim_future_2040s_RCM08(j,1)<Flow_Obs_baseline_Q95(i,1)
        Days_future_2040s_RCM08_flow_below_Q95(i,1)=Days_future_2040s_RCM08_flow_below_Q95(i,1)+1;
    end
end
    Days_future_2040s_RCM08_flow_below_Q95_perc(i,1)=Days_future_2040s_RCM08_flow_below_Q95(i,1)/length(Flow_Sim_future_2040s_RCM08)*100;
 
%% RCM09
Days_future_2040s_RCM09_flow_below_Q95(i,1)=0;
 
for j =1:length(Flow_Sim_future_2040s_RCM09)
    if Flow_Sim_future_2040s_RCM09(j,1)<Flow_Obs_baseline_Q95(i,1)
        Days_future_2040s_RCM09_flow_below_Q95(i,1)=Days_future_2040s_RCM09_flow_below_Q95(i,1)+1;
    end
end
    Days_future_2040s_RCM09_flow_below_Q95_perc(i,1)=Days_future_2040s_RCM09_flow_below_Q95(i,1)/length(Flow_Sim_future_2040s_RCM09)*100;
 
%% RCM10
Days_future_2040s_RCM10_flow_below_Q95(i,1)=0;
 
for j =1:length(Flow_Sim_future_2040s_RCM10)
    if Flow_Sim_future_2040s_RCM10(j,1)<Flow_Obs_baseline_Q95(i,1)
        Days_future_2040s_RCM10_flow_below_Q95(i,1)=Days_future_2040s_RCM10_flow_below_Q95(i,1)+1;
    end
end
    Days_future_2040s_RCM10_flow_below_Q95_perc(i,1)=Days_future_2040s_RCM10_flow_below_Q95(i,1)/length(Flow_Sim_future_2040s_RCM10)*100;
 
%% RCM11
Days_future_2040s_RCM11_flow_below_Q95(i,1)=0;
 
for j =1:length(Flow_Sim_future_2040s_RCM11)
    if Flow_Sim_future_2040s_RCM11(j,1)<Flow_Obs_baseline_Q95(i,1)
        Days_future_2040s_RCM11_flow_below_Q95(i,1)=Days_future_2040s_RCM11_flow_below_Q95(i,1)+1;
    end
end
    Days_future_2040s_RCM11_flow_below_Q95_perc(i,1)=Days_future_2040s_RCM11_flow_below_Q95(i,1)/length(Flow_Sim_future_2040s_RCM11)*100;
 
%% RCM12
Days_future_2040s_RCM12_flow_below_Q95(i,1)=0;
 
for j =1:length(Flow_Sim_future_2040s_RCM12)
    if Flow_Sim_future_2040s_RCM12(j,1)<Flow_Obs_baseline_Q95(i,1)
        Days_future_2040s_RCM12_flow_below_Q95(i,1)=Days_future_2040s_RCM12_flow_below_Q95(i,1)+1;
    end
end
    Days_future_2040s_RCM12_flow_below_Q95_perc(i,1)=Days_future_2040s_RCM12_flow_below_Q95(i,1)/length(Flow_Sim_future_2040s_RCM12)*100;
 
%% RCM13
Days_future_2040s_RCM13_flow_below_Q95(i,1)=0;
 
for j =1:length(Flow_Sim_future_2040s_RCM13)
    if Flow_Sim_future_2040s_RCM13(j,1)<Flow_Obs_baseline_Q95(i,1)
        Days_future_2040s_RCM13_flow_below_Q95(i,1)=Days_future_2040s_RCM13_flow_below_Q95(i,1)+1;
    end
end
    Days_future_2040s_RCM13_flow_below_Q95_perc(i,1)=Days_future_2040s_RCM13_flow_below_Q95(i,1)/length(Flow_Sim_future_2040s_RCM13)*100;
 
%% RCM15
Days_future_2040s_RCM15_flow_below_Q95(i,1)=0;
 
for j =1:length(Flow_Sim_future_2040s_RCM15)
    if Flow_Sim_future_2040s_RCM15(j,1)<Flow_Obs_baseline_Q95(i,1)
        Days_future_2040s_RCM15_flow_below_Q95(i,1)=Days_future_2040s_RCM15_flow_below_Q95(i,1)+1;
    end
end
    Days_future_2040s_RCM15_flow_below_Q95_perc(i,1)=Days_future_2040s_RCM15_flow_below_Q95(i,1)/length(Flow_Sim_future_2040s_RCM15)*100;
 
%% All RCM
Days_future_2040s_allRCM_flow_below_Q95(i,1)=0;
 
for j =1:length(Flow_Sim_future_2040s_allRCM)
    if Flow_Sim_future_2040s_allRCM(j,1)<Flow_Obs_baseline_Q95(i,1)
        Days_future_2040s_allRCM_flow_below_Q95(i,1)=Days_future_2040s_allRCM_flow_below_Q95(i,1)+1;
    end
end
    Days_future_2040s_allRCM_flow_below_Q95_perc(i,1)=Days_future_2040s_allRCM_flow_below_Q95(i,1)/length(Flow_Sim_future_2040s_allRCM)*100;
    
 
%% 2060s
 
%% RCM01
Days_future_2060s_RCM01_flow_below_Q95(i,1)=0;
 
for j =1:length(Flow_Sim_future_2060s_RCM01)
    if Flow_Sim_future_2060s_RCM01(j,1)<Flow_Obs_baseline_Q95(i,1)
        Days_future_2060s_RCM01_flow_below_Q95(i,1)=Days_future_2060s_RCM01_flow_below_Q95(i,1)+1;
    end
end
    Days_future_2060s_RCM01_flow_below_Q95_perc(i,1)=Days_future_2060s_RCM01_flow_below_Q95(i,1)/length(Flow_Sim_future_2060s_RCM01)*100;
 
%% RCM04
Days_future_2060s_RCM04_flow_below_Q95(i,1)=0;
 
for j =1:length(Flow_Sim_future_2060s_RCM04)
    if Flow_Sim_future_2060s_RCM04(j,1)<Flow_Obs_baseline_Q95(i,1)
        Days_future_2060s_RCM04_flow_below_Q95(i,1)=Days_future_2060s_RCM04_flow_below_Q95(i,1)+1;
    end
end
    Days_future_2060s_RCM04_flow_below_Q95_perc(i,1)=Days_future_2060s_RCM04_flow_below_Q95(i,1)/length(Flow_Sim_future_2060s_RCM04)*100;
 
%% RCM05
Days_future_2060s_RCM05_flow_below_Q95(i,1)=0;
 
for j =1:length(Flow_Sim_future_2060s_RCM05)
    if Flow_Sim_future_2060s_RCM05(j,1)<Flow_Obs_baseline_Q95(i,1)
        Days_future_2060s_RCM05_flow_below_Q95(i,1)=Days_future_2060s_RCM05_flow_below_Q95(i,1)+1;
    end
end
    Days_future_2060s_RCM05_flow_below_Q95_perc(i,1)=Days_future_2060s_RCM05_flow_below_Q95(i,1)/length(Flow_Sim_future_2060s_RCM05)*100;
 
%% RCM06
Days_future_2060s_RCM06_flow_below_Q95(i,1)=0;
 
for j =1:length(Flow_Sim_future_2060s_RCM06)
    if Flow_Sim_future_2060s_RCM06(j,1)<Flow_Obs_baseline_Q95(i,1)
        Days_future_2060s_RCM06_flow_below_Q95(i,1)=Days_future_2060s_RCM06_flow_below_Q95(i,1)+1;
    end
end
    Days_future_2060s_RCM06_flow_below_Q95_perc(i,1)=Days_future_2060s_RCM06_flow_below_Q95(i,1)/length(Flow_Sim_future_2060s_RCM06)*100;
 
%% RCM07
Days_future_2060s_RCM07_flow_below_Q95(i,1)=0;
 
for j =1:length(Flow_Sim_future_2060s_RCM07)
    if Flow_Sim_future_2060s_RCM07(j,1)<Flow_Obs_baseline_Q95(i,1)
        Days_future_2060s_RCM07_flow_below_Q95(i,1)=Days_future_2060s_RCM07_flow_below_Q95(i,1)+1;
    end
end
    Days_future_2060s_RCM07_flow_below_Q95_perc(i,1)=Days_future_2060s_RCM07_flow_below_Q95(i,1)/length(Flow_Sim_future_2060s_RCM07)*100;
 
%% RCM08
Days_future_2060s_RCM08_flow_below_Q95(i,1)=0;
 
for j =1:length(Flow_Sim_future_2060s_RCM08)
    if Flow_Sim_future_2060s_RCM08(j,1)<Flow_Obs_baseline_Q95(i,1)
        Days_future_2060s_RCM08_flow_below_Q95(i,1)=Days_future_2060s_RCM08_flow_below_Q95(i,1)+1;
    end
end
    Days_future_2060s_RCM08_flow_below_Q95_perc(i,1)=Days_future_2060s_RCM08_flow_below_Q95(i,1)/length(Flow_Sim_future_2060s_RCM08)*100;
 
%% RCM09
Days_future_2060s_RCM09_flow_below_Q95(i,1)=0;
 
for j =1:length(Flow_Sim_future_2060s_RCM09)
    if Flow_Sim_future_2060s_RCM09(j,1)<Flow_Obs_baseline_Q95(i,1)
        Days_future_2060s_RCM09_flow_below_Q95(i,1)=Days_future_2060s_RCM09_flow_below_Q95(i,1)+1;
    end
end
    Days_future_2060s_RCM09_flow_below_Q95_perc(i,1)=Days_future_2060s_RCM09_flow_below_Q95(i,1)/length(Flow_Sim_future_2060s_RCM09)*100;
 
%% RCM10
Days_future_2060s_RCM10_flow_below_Q95(i,1)=0;
 
for j =1:length(Flow_Sim_future_2060s_RCM10)
    if Flow_Sim_future_2060s_RCM10(j,1)<Flow_Obs_baseline_Q95(i,1)
        Days_future_2060s_RCM10_flow_below_Q95(i,1)=Days_future_2060s_RCM10_flow_below_Q95(i,1)+1;
    end
end
    Days_future_2060s_RCM10_flow_below_Q95_perc(i,1)=Days_future_2060s_RCM10_flow_below_Q95(i,1)/length(Flow_Sim_future_2060s_RCM10)*100;
 
%% RCM11
Days_future_2060s_RCM11_flow_below_Q95(i,1)=0;
 
for j =1:length(Flow_Sim_future_2060s_RCM11)
    if Flow_Sim_future_2060s_RCM11(j,1)<Flow_Obs_baseline_Q95(i,1)
        Days_future_2060s_RCM11_flow_below_Q95(i,1)=Days_future_2060s_RCM11_flow_below_Q95(i,1)+1;
    end
end
    Days_future_2060s_RCM11_flow_below_Q95_perc(i,1)=Days_future_2060s_RCM11_flow_below_Q95(i,1)/length(Flow_Sim_future_2060s_RCM11)*100;
 
%% RCM12
Days_future_2060s_RCM12_flow_below_Q95(i,1)=0;
 
for j =1:length(Flow_Sim_future_2060s_RCM12)
    if Flow_Sim_future_2060s_RCM12(j,1)<Flow_Obs_baseline_Q95(i,1)
        Days_future_2060s_RCM12_flow_below_Q95(i,1)=Days_future_2060s_RCM12_flow_below_Q95(i,1)+1;
    end
end
    Days_future_2060s_RCM12_flow_below_Q95_perc(i,1)=Days_future_2060s_RCM12_flow_below_Q95(i,1)/length(Flow_Sim_future_2060s_RCM12)*100;
  
%% RCM13
Days_future_2060s_RCM13_flow_below_Q95(i,1)=0;
 
for j =1:length(Flow_Sim_future_2060s_RCM13)
    if Flow_Sim_future_2060s_RCM13(j,1)<Flow_Obs_baseline_Q95(i,1)
        Days_future_2060s_RCM13_flow_below_Q95(i,1)=Days_future_2060s_RCM13_flow_below_Q95(i,1)+1;
    end
end
    Days_future_2060s_RCM13_flow_below_Q95_perc(i,1)=Days_future_2060s_RCM13_flow_below_Q95(i,1)/length(Flow_Sim_future_2060s_RCM13)*100;
 
%% RCM15
Days_future_2060s_RCM15_flow_below_Q95(i,1)=0;
 
for j =1:length(Flow_Sim_future_2060s_RCM15)
    if Flow_Sim_future_2060s_RCM15(j,1)<Flow_Obs_baseline_Q95(i,1)
        Days_future_2060s_RCM15_flow_below_Q95(i,1)=Days_future_2060s_RCM15_flow_below_Q95(i,1)+1;
    end
end
    Days_future_2060s_RCM15_flow_below_Q95_perc(i,1)=Days_future_2060s_RCM15_flow_below_Q95(i,1)/length(Flow_Sim_future_2060s_RCM15)*100;
 
%% All RCM
Days_future_2060s_allRCM_flow_below_Q95(i,1)=0;
 
for j =1:length(Flow_Sim_future_2060s_allRCM)
    if Flow_Sim_future_2060s_allRCM(j,1)<Flow_Obs_baseline_Q95(i,1)
        Days_future_2060s_allRCM_flow_below_Q95(i,1)=Days_future_2060s_allRCM_flow_below_Q95(i,1)+1;
    end
end
    Days_future_2060s_allRCM_flow_below_Q95_perc(i,1)=Days_future_2060s_allRCM_flow_below_Q95(i,1)/length(Flow_Sim_future_2060s_allRCM)*100;
 
%% Days with flow below design flow
 
%% Baseline
Days_baseline_flow_below_design_flow(i,1)=0;
 
for j =1:length(Flow_Obs_baseline)
    if Flow_Obs_baseline(j,1)<Flow_Obs_baseline_Q40(i,1)
        Days_baseline_flow_below_design_flow(i,1)=Days_baseline_flow_below_design_flow(i,1)+1;
    end
end
    Days_baseline_flow_below_design_flow_perc(i,1)=Days_baseline_flow_below_design_flow(i,1)/length(Flow_Obs_baseline)*100;
 
%% 2040s
 
%% RCM01
Days_future_2040s_RCM01_flow_below_design_flow(i,1)=0;
 
for j =1:length(Flow_Sim_future_2040s_RCM01)
    if Flow_Sim_future_2040s_RCM01(j,1)<Flow_Obs_baseline_Q40(i,1)
        Days_future_2040s_RCM01_flow_below_design_flow(i,1)=Days_future_2040s_RCM01_flow_below_design_flow(i,1)+1;
    end
end
    Days_future_2040s_RCM01_flow_below_design_flow_perc(i,1)=Days_future_2040s_RCM01_flow_below_design_flow(i,1)/length(Flow_Sim_future_2040s_RCM01)*100;
 
%% RCM04
Days_future_2040s_RCM04_flow_below_design_flow(i,1)=0;
 
for j =1:length(Flow_Sim_future_2040s_RCM04)
    if Flow_Sim_future_2040s_RCM04(j,1)<Flow_Obs_baseline_Q40(i,1)
        Days_future_2040s_RCM04_flow_below_design_flow(i,1)=Days_future_2040s_RCM04_flow_below_design_flow(i,1)+1;
    end
end
    Days_future_2040s_RCM04_flow_below_design_flow_perc(i,1)=Days_future_2040s_RCM04_flow_below_design_flow(i,1)/length(Flow_Sim_future_2040s_RCM04)*100;
 
%% RCM05
Days_future_2040s_RCM05_flow_below_design_flow(i,1)=0;
 
for j =1:length(Flow_Sim_future_2040s_RCM05)
    if Flow_Sim_future_2040s_RCM05(j,1)<Flow_Obs_baseline_Q40(i,1)
        Days_future_2040s_RCM05_flow_below_design_flow(i,1)=Days_future_2040s_RCM05_flow_below_design_flow(i,1)+1;
    end
end
    Days_future_2040s_RCM05_flow_below_design_flow_perc(i,1)=Days_future_2040s_RCM05_flow_below_design_flow(i,1)/length(Flow_Sim_future_2040s_RCM05)*100;
 
%% RCM06
Days_future_2040s_RCM06_flow_below_design_flow(i,1)=0;
 
for j =1:length(Flow_Sim_future_2040s_RCM06)
    if Flow_Sim_future_2040s_RCM06(j,1)<Flow_Obs_baseline_Q40(i,1)
        Days_future_2040s_RCM06_flow_below_design_flow(i,1)=Days_future_2040s_RCM06_flow_below_design_flow(i,1)+1;
    end
end
    Days_future_2040s_RCM06_flow_below_design_flow_perc(i,1)=Days_future_2040s_RCM06_flow_below_design_flow(i,1)/length(Flow_Sim_future_2040s_RCM06)*100;
 
%% RCM07
Days_future_2040s_RCM07_flow_below_design_flow(i,1)=0;
 
for j =1:length(Flow_Sim_future_2040s_RCM07)
    if Flow_Sim_future_2040s_RCM07(j,1)<Flow_Obs_baseline_Q40(i,1)
        Days_future_2040s_RCM07_flow_below_design_flow(i,1)=Days_future_2040s_RCM07_flow_below_design_flow(i,1)+1;
    end
end
    Days_future_2040s_RCM07_flow_below_design_flow_perc(i,1)=Days_future_2040s_RCM07_flow_below_design_flow(i,1)/length(Flow_Sim_future_2040s_RCM07)*100;
 
%% RCM08
Days_future_2040s_RCM08_flow_below_design_flow(i,1)=0;
 
for j =1:length(Flow_Sim_future_2040s_RCM08)
    if Flow_Sim_future_2040s_RCM08(j,1)<Flow_Obs_baseline_Q40(i,1)
        Days_future_2040s_RCM08_flow_below_design_flow(i,1)=Days_future_2040s_RCM08_flow_below_design_flow(i,1)+1;
    end
end
    Days_future_2040s_RCM08_flow_below_design_flow_perc(i,1)=Days_future_2040s_RCM08_flow_below_design_flow(i,1)/length(Flow_Sim_future_2040s_RCM08)*100;
 
%% RCM09
Days_future_2040s_RCM09_flow_below_design_flow(i,1)=0;
 
for j =1:length(Flow_Sim_future_2040s_RCM09)
    if Flow_Sim_future_2040s_RCM09(j,1)<Flow_Obs_baseline_Q40(i,1)
        Days_future_2040s_RCM09_flow_below_design_flow(i,1)=Days_future_2040s_RCM09_flow_below_design_flow(i,1)+1;
    end
end
    Days_future_2040s_RCM09_flow_below_design_flow_perc(i,1)=Days_future_2040s_RCM09_flow_below_design_flow(i,1)/length(Flow_Sim_future_2040s_RCM09)*100;
 
%% RCM10
Days_future_2040s_RCM10_flow_below_design_flow(i,1)=0;
 
for j =1:length(Flow_Sim_future_2040s_RCM10)
    if Flow_Sim_future_2040s_RCM10(j,1)<Flow_Obs_baseline_Q40(i,1)
        Days_future_2040s_RCM10_flow_below_design_flow(i,1)=Days_future_2040s_RCM10_flow_below_design_flow(i,1)+1;
    end
end
    Days_future_2040s_RCM10_flow_below_design_flow_perc(i,1)=Days_future_2040s_RCM10_flow_below_design_flow(i,1)/length(Flow_Sim_future_2040s_RCM10)*100;
 
%% RCM11
Days_future_2040s_RCM11_flow_below_design_flow(i,1)=0;
 
for j =1:length(Flow_Sim_future_2040s_RCM11)
    if Flow_Sim_future_2040s_RCM11(j,1)<Flow_Obs_baseline_Q40(i,1)
        Days_future_2040s_RCM11_flow_below_design_flow(i,1)=Days_future_2040s_RCM11_flow_below_design_flow(i,1)+1;
    end
end
    Days_future_2040s_RCM11_flow_below_design_flow_perc(i,1)=Days_future_2040s_RCM11_flow_below_design_flow(i,1)/length(Flow_Sim_future_2040s_RCM11)*100;
 
%% RCM12
Days_future_2040s_RCM12_flow_below_design_flow(i,1)=0;
 
for j =1:length(Flow_Sim_future_2040s_RCM12)
    if Flow_Sim_future_2040s_RCM12(j,1)<Flow_Obs_baseline_Q40(i,1)
        Days_future_2040s_RCM12_flow_below_design_flow(i,1)=Days_future_2040s_RCM12_flow_below_design_flow(i,1)+1;
    end
end
    Days_future_2040s_RCM12_flow_below_design_flow_perc(i,1)=Days_future_2040s_RCM12_flow_below_design_flow(i,1)/length(Flow_Sim_future_2040s_RCM12)*100;
 
 
%% RCM13
Days_future_2040s_RCM13_flow_below_design_flow(i,1)=0;
 
for j =1:length(Flow_Sim_future_2040s_RCM13)
    if Flow_Sim_future_2040s_RCM13(j,1)<Flow_Obs_baseline_Q40(i,1)
        Days_future_2040s_RCM13_flow_below_design_flow(i,1)=Days_future_2040s_RCM13_flow_below_design_flow(i,1)+1;
    end
end
    Days_future_2040s_RCM13_flow_below_design_flow_perc(i,1)=Days_future_2040s_RCM13_flow_below_design_flow(i,1)/length(Flow_Sim_future_2040s_RCM13)*100;
 
%% RCM15
Days_future_2040s_RCM15_flow_below_design_flow(i,1)=0;
 
for j =1:length(Flow_Sim_future_2040s_RCM15)
    if Flow_Sim_future_2040s_RCM15(j,1)<Flow_Obs_baseline_Q40(i,1)
        Days_future_2040s_RCM15_flow_below_design_flow(i,1)=Days_future_2040s_RCM15_flow_below_design_flow(i,1)+1;
    end
end
    Days_future_2040s_RCM15_flow_below_design_flow_perc(i,1)=Days_future_2040s_RCM15_flow_below_design_flow(i,1)/length(Flow_Sim_future_2040s_RCM15)*100;
 
%% All RCM
Days_future_2040s_allRCM_flow_below_design_flow(i,1)=0;
 
for j =1:length(Flow_Sim_future_2040s_allRCM)
    if Flow_Sim_future_2040s_allRCM(j,1)<Flow_Obs_baseline_Q40(i,1)
        Days_future_2040s_allRCM_flow_below_design_flow(i,1)=Days_future_2040s_allRCM_flow_below_design_flow(i,1)+1;
    end
end
    Days_future_2040s_allRCM_flow_below_design_flow_perc(i,1)=Days_future_2040s_allRCM_flow_below_design_flow(i,1)/length(Flow_Sim_future_2040s_allRCM)*100;
    
 
%% 2060s
 
%% RCM01
Days_future_2060s_RCM01_flow_below_design_flow(i,1)=0;
 
for j =1:length(Flow_Sim_future_2060s_RCM01)
    if Flow_Sim_future_2060s_RCM01(j,1)<Flow_Obs_baseline_Q40(i,1)
        Days_future_2060s_RCM01_flow_below_design_flow(i,1)=Days_future_2060s_RCM01_flow_below_design_flow(i,1)+1;
    end
end
    Days_future_2060s_RCM01_flow_below_design_flow_perc(i,1)=Days_future_2060s_RCM01_flow_below_design_flow(i,1)/length(Flow_Sim_future_2060s_RCM01)*100;
 
%% RCM04
Days_future_2060s_RCM04_flow_below_design_flow(i,1)=0;
 
for j =1:length(Flow_Sim_future_2060s_RCM04)
    if Flow_Sim_future_2060s_RCM04(j,1)<Flow_Obs_baseline_Q40(i,1)
        Days_future_2060s_RCM04_flow_below_design_flow(i,1)=Days_future_2060s_RCM04_flow_below_design_flow(i,1)+1;
    end
end
    Days_future_2060s_RCM04_flow_below_design_flow_perc(i,1)=Days_future_2060s_RCM04_flow_below_design_flow(i,1)/length(Flow_Sim_future_2060s_RCM04)*100;
 
%% RCM05
Days_future_2060s_RCM05_flow_below_design_flow(i,1)=0;
 
for j =1:length(Flow_Sim_future_2060s_RCM05)
    if Flow_Sim_future_2060s_RCM05(j,1)<Flow_Obs_baseline_Q40(i,1)
        Days_future_2060s_RCM05_flow_below_design_flow(i,1)=Days_future_2060s_RCM05_flow_below_design_flow(i,1)+1;
    end
end
    Days_future_2060s_RCM05_flow_below_design_flow_perc(i,1)=Days_future_2060s_RCM05_flow_below_design_flow(i,1)/length(Flow_Sim_future_2060s_RCM05)*100;
 
%% RCM06
Days_future_2060s_RCM06_flow_below_design_flow(i,1)=0;
 
for j =1:length(Flow_Sim_future_2060s_RCM06)
    if Flow_Sim_future_2060s_RCM06(j,1)<Flow_Obs_baseline_Q40(i,1)
        Days_future_2060s_RCM06_flow_below_design_flow(i,1)=Days_future_2060s_RCM06_flow_below_design_flow(i,1)+1;
    end
end
    Days_future_2060s_RCM06_flow_below_design_flow_perc(i,1)=Days_future_2060s_RCM06_flow_below_design_flow(i,1)/length(Flow_Sim_future_2060s_RCM06)*100;
 
%% RCM07
Days_future_2060s_RCM07_flow_below_design_flow(i,1)=0;
 
for j =1:length(Flow_Sim_future_2060s_RCM07)
    if Flow_Sim_future_2060s_RCM07(j,1)<Flow_Obs_baseline_Q40(i,1)
        Days_future_2060s_RCM07_flow_below_design_flow(i,1)=Days_future_2060s_RCM07_flow_below_design_flow(i,1)+1;
    end
end
    Days_future_2060s_RCM07_flow_below_design_flow_perc(i,1)=Days_future_2060s_RCM07_flow_below_design_flow(i,1)/length(Flow_Sim_future_2060s_RCM07)*100;
 
%% RCM08
Days_future_2060s_RCM08_flow_below_design_flow(i,1)=0;
 
for j =1:length(Flow_Sim_future_2060s_RCM08)
    if Flow_Sim_future_2060s_RCM08(j,1)<Flow_Obs_baseline_Q40(i,1)
        Days_future_2060s_RCM08_flow_below_design_flow(i,1)=Days_future_2060s_RCM08_flow_below_design_flow(i,1)+1;
    end
end
    Days_future_2060s_RCM08_flow_below_design_flow_perc(i,1)=Days_future_2060s_RCM08_flow_below_design_flow(i,1)/length(Flow_Sim_future_2060s_RCM08)*100;
 
%% RCM09
Days_future_2060s_RCM09_flow_below_design_flow(i,1)=0;
 
for j =1:length(Flow_Sim_future_2060s_RCM09)
    if Flow_Sim_future_2060s_RCM09(j,1)<Flow_Obs_baseline_Q40(i,1)
        Days_future_2060s_RCM09_flow_below_design_flow(i,1)=Days_future_2060s_RCM09_flow_below_design_flow(i,1)+1;
    end
end
    Days_future_2060s_RCM09_flow_below_design_flow_perc(i,1)=Days_future_2060s_RCM09_flow_below_design_flow(i,1)/length(Flow_Sim_future_2060s_RCM09)*100;
 
%% RCM10
Days_future_2060s_RCM10_flow_below_design_flow(i,1)=0;
 
for j =1:length(Flow_Sim_future_2060s_RCM10)
    if Flow_Sim_future_2060s_RCM10(j,1)<Flow_Obs_baseline_Q40(i,1)
        Days_future_2060s_RCM10_flow_below_design_flow(i,1)=Days_future_2060s_RCM10_flow_below_design_flow(i,1)+1;
    end
end
    Days_future_2060s_RCM10_flow_below_design_flow_perc(i,1)=Days_future_2060s_RCM10_flow_below_design_flow(i,1)/length(Flow_Sim_future_2060s_RCM10)*100;
 
%% RCM11
Days_future_2060s_RCM11_flow_below_design_flow(i,1)=0;
 
for j =1:length(Flow_Sim_future_2060s_RCM11)
    if Flow_Sim_future_2060s_RCM11(j,1)<Flow_Obs_baseline_Q40(i,1)
        Days_future_2060s_RCM11_flow_below_design_flow(i,1)=Days_future_2060s_RCM11_flow_below_design_flow(i,1)+1;
    end
end
    Days_future_2060s_RCM11_flow_below_design_flow_perc(i,1)=Days_future_2060s_RCM11_flow_below_design_flow(i,1)/length(Flow_Sim_future_2060s_RCM11)*100;
 
%% RCM12
Days_future_2060s_RCM12_flow_below_design_flow(i,1)=0;
 
for j =1:length(Flow_Sim_future_2060s_RCM12)
    if Flow_Sim_future_2060s_RCM12(j,1)<Flow_Obs_baseline_Q40(i,1)
        Days_future_2060s_RCM12_flow_below_design_flow(i,1)=Days_future_2060s_RCM12_flow_below_design_flow(i,1)+1;
    end
end
    Days_future_2060s_RCM12_flow_below_design_flow_perc(i,1)=Days_future_2060s_RCM12_flow_below_design_flow(i,1)/length(Flow_Sim_future_2060s_RCM12)*100;
 
 
%% RCM13
Days_future_2060s_RCM13_flow_below_design_flow(i,1)=0;
 
for j =1:length(Flow_Sim_future_2060s_RCM13)
    if Flow_Sim_future_2060s_RCM13(j,1)<Flow_Obs_baseline_Q40(i,1)
        Days_future_2060s_RCM13_flow_below_design_flow(i,1)=Days_future_2060s_RCM13_flow_below_design_flow(i,1)+1;
    end
end
    Days_future_2060s_RCM13_flow_below_design_flow_perc(i,1)=Days_future_2060s_RCM13_flow_below_design_flow(i,1)/length(Flow_Sim_future_2060s_RCM13)*100;
 
%% RCM15
Days_future_2060s_RCM15_flow_below_design_flow(i,1)=0;
 
for j =1:length(Flow_Sim_future_2060s_RCM15)
    if Flow_Sim_future_2060s_RCM15(j,1)<Flow_Obs_baseline_Q40(i,1)
        Days_future_2060s_RCM15_flow_below_design_flow(i,1)=Days_future_2060s_RCM15_flow_below_design_flow(i,1)+1;
    end
end
    Days_future_2060s_RCM15_flow_below_design_flow_perc(i,1)=Days_future_2060s_RCM15_flow_below_design_flow(i,1)/length(Flow_Sim_future_2060s_RCM15)*100;
 
%% All RCM
Days_future_2060s_allRCM_flow_below_design_flow(i,1)=0;
 
for j =1:length(Flow_Sim_future_2060s_allRCM)
    if Flow_Sim_future_2060s_allRCM(j,1)<Flow_Obs_baseline_Q40(i,1)
        Days_future_2060s_allRCM_flow_below_design_flow(i,1)=Days_future_2060s_allRCM_flow_below_design_flow(i,1)+1;
    end
end
    Days_future_2060s_allRCM_flow_below_design_flow_perc(i,1)=Days_future_2060s_allRCM_flow_below_design_flow(i,1)/length(Flow_Sim_future_2060s_allRCM)*100;
 
%% Table of days with flows below Q95
 
%% 2040s
Table_days_below_Q95_2040s{i,1}=GaugesNo(i,1);
 
Table_days_below_Q95_2040s{i,2}=Days_baseline_flow_below_Q95_perc(i,1);
 
Table_days_below_Q95_2040s{i,3}=Days_future_2040s_RCM01_flow_below_Q95_perc(i,1);
Table_days_below_Q95_2040s{i,4}=Days_future_2040s_RCM04_flow_below_Q95_perc(i,1);
Table_days_below_Q95_2040s{i,5}=Days_future_2040s_RCM05_flow_below_Q95_perc(i,1);
Table_days_below_Q95_2040s{i,6}=Days_future_2040s_RCM06_flow_below_Q95_perc(i,1);
Table_days_below_Q95_2040s{i,7}=Days_future_2040s_RCM07_flow_below_Q95_perc(i,1);
Table_days_below_Q95_2040s{i,8}=Days_future_2040s_RCM08_flow_below_Q95_perc(i,1);
Table_days_below_Q95_2040s{i,9}=Days_future_2040s_RCM09_flow_below_Q95_perc(i,1);
Table_days_below_Q95_2040s{i,10}=Days_future_2040s_RCM10_flow_below_Q95_perc(i,1);
Table_days_below_Q95_2040s{i,11}=Days_future_2040s_RCM11_flow_below_Q95_perc(i,1);
Table_days_below_Q95_2040s{i,12}=Days_future_2040s_RCM12_flow_below_Q95_perc(i,1);
Table_days_below_Q95_2040s{i,13}=Days_future_2040s_RCM13_flow_below_Q95_perc(i,1);
Table_days_below_Q95_2040s{i,14}=Days_future_2040s_RCM15_flow_below_Q95_perc(i,1);
 
Table_days_below_Q95_2040s{i,15}=Days_future_2040s_allRCM_flow_below_Q95_perc(i,1);
 
Table_days_below_Q95_2040s{i,16}=Days_baseline_flow_below_Q95_perc(i,1)-Days_future_2040s_RCM01_flow_below_Q95_perc(i,1);
Table_days_below_Q95_2040s{i,17}=Days_baseline_flow_below_Q95_perc(i,1)-Days_future_2040s_RCM01_flow_below_Q95_perc(i,1);
Table_days_below_Q95_2040s{i,18}=Days_baseline_flow_below_Q95_perc(i,1)-Days_future_2040s_RCM01_flow_below_Q95_perc(i,1);
Table_days_below_Q95_2040s{i,19}=Days_baseline_flow_below_Q95_perc(i,1)-Days_future_2040s_RCM01_flow_below_Q95_perc(i,1);
Table_days_below_Q95_2040s{i,20}=Days_baseline_flow_below_Q95_perc(i,1)-Days_future_2040s_RCM01_flow_below_Q95_perc(i,1);
Table_days_below_Q95_2040s{i,21}=Days_baseline_flow_below_Q95_perc(i,1)-Days_future_2040s_RCM01_flow_below_Q95_perc(i,1);
Table_days_below_Q95_2040s{i,22}=Days_baseline_flow_below_Q95_perc(i,1)-Days_future_2040s_RCM01_flow_below_Q95_perc(i,1);
Table_days_below_Q95_2040s{i,23}=Days_baseline_flow_below_Q95_perc(i,1)-Days_future_2040s_RCM01_flow_below_Q95_perc(i,1);
Table_days_below_Q95_2040s{i,24}=Days_baseline_flow_below_Q95_perc(i,1)-Days_future_2040s_RCM01_flow_below_Q95_perc(i,1);
Table_days_below_Q95_2040s{i,25}=Days_baseline_flow_below_Q95_perc(i,1)-Days_future_2040s_RCM01_flow_below_Q95_perc(i,1);
Table_days_below_Q95_2040s{i,26}=Days_baseline_flow_below_Q95_perc(i,1)-Days_future_2040s_RCM01_flow_below_Q95_perc(i,1);
Table_days_below_Q95_2040s{i,27}=Days_baseline_flow_below_Q95_perc(i,1)-Days_future_2040s_RCM01_flow_below_Q95_perc(i,1);
 
Table_days_below_Q95_2040s{i,28}=Days_baseline_flow_below_Q95_perc(i,1)-Days_future_2040s_RCM01_flow_below_Q95_perc(i,1);
 
Table_days_below_Q95_2040s_header={'ID','Baseline days with flow below Q95 [%]','RCM01 days with flow below Q95 [%]','RCM04 days with flow below Q95 [%]','RCM05 days with flow below Q95 [%]','RCM06 days with flow below Q95 [%]','RCM07 days with flow below Q95 [%]','RCM08 days with flow below Q95 [%]','RCM09 days with flow below Q95 [%]','RCM10 days with flow below Q95 [%]','RCM11 days with flow below Q95 [%]','RCM12 days with flow below Q95 [%]','RCM13 days with flow below Q95 [%]','RCM15 days with flow below Q95 [%]','All RCM days with flow below Q95 [%]','Baseline-RCM01 2040s Q95 [%]','Baseline-RCM04 [%]','Baseline-RCM05 [%]','Baseline-RCM06 [%]','Baseline-RCM07 [%]','Baseline-RCM08 [%]','Baseline-RCM09 [%]','Baseline-RCM10 [%]' ,'Baseline-RCM11 [%]','Baseline-RCM12 [%]','Baseline-RCM13 [%]','Baseline-RCM15 [%]','Baseline - Future days with flow below Q95 [%]'};
 
%Write the table into an excel file
 
if exist(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Station_',no,'_2040s_days_flow_below_Q95.xls'), 'file')==2
   delete(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Station_',no,'_2040s_days_flow_below_Q95.xls'));
end
 
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Station_',no,'_2040s_days_flow_below_Q95.xls'),Table_days_below_Q95_2040s,'Sheet1','A2');
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Station_',no,'_2040s_days_flow_below_Q95.xls'),Table_days_below_Q95_2040s_header,'Sheet1','A1');
 
%% Table of days with flows below design_flow
 
%% 2040s
Table_days_below_design_flow_2040s{i,1}=GaugesNo(i,1);
 
Table_days_below_design_flow_2040s{i,2}=Days_baseline_flow_below_design_flow_perc(i,1);
 
Table_days_below_design_flow_2040s{i,3}=Days_future_2040s_RCM01_flow_below_design_flow_perc(i,1);
Table_days_below_design_flow_2040s{i,4}=Days_future_2040s_RCM04_flow_below_design_flow_perc(i,1);
Table_days_below_design_flow_2040s{i,5}=Days_future_2040s_RCM05_flow_below_design_flow_perc(i,1);
Table_days_below_design_flow_2040s{i,6}=Days_future_2040s_RCM06_flow_below_design_flow_perc(i,1);
Table_days_below_design_flow_2040s{i,7}=Days_future_2040s_RCM07_flow_below_design_flow_perc(i,1);
Table_days_below_design_flow_2040s{i,8}=Days_future_2040s_RCM08_flow_below_design_flow_perc(i,1);
Table_days_below_design_flow_2040s{i,9}=Days_future_2040s_RCM09_flow_below_design_flow_perc(i,1);
Table_days_below_design_flow_2040s{i,10}=Days_future_2040s_RCM10_flow_below_design_flow_perc(i,1);
Table_days_below_design_flow_2040s{i,11}=Days_future_2040s_RCM11_flow_below_design_flow_perc(i,1);
Table_days_below_design_flow_2040s{i,12}=Days_future_2040s_RCM12_flow_below_design_flow_perc(i,1);
Table_days_below_design_flow_2040s{i,13}=Days_future_2040s_RCM13_flow_below_design_flow_perc(i,1);
Table_days_below_design_flow_2040s{i,14}=Days_future_2040s_RCM15_flow_below_design_flow_perc(i,1);
 
Table_days_below_design_flow_2040s{i,15}=Days_future_2040s_allRCM_flow_below_design_flow_perc(i,1);
 
Table_days_below_design_flow_2040s{i,16}=Days_baseline_flow_below_design_flow_perc(i,1)-Days_future_2040s_RCM01_flow_below_design_flow_perc(i,1);
Table_days_below_design_flow_2040s{i,17}=Days_baseline_flow_below_design_flow_perc(i,1)-Days_future_2040s_RCM01_flow_below_design_flow_perc(i,1);
Table_days_below_design_flow_2040s{i,18}=Days_baseline_flow_below_design_flow_perc(i,1)-Days_future_2040s_RCM01_flow_below_design_flow_perc(i,1);
Table_days_below_design_flow_2040s{i,19}=Days_baseline_flow_below_design_flow_perc(i,1)-Days_future_2040s_RCM01_flow_below_design_flow_perc(i,1);
Table_days_below_design_flow_2040s{i,20}=Days_baseline_flow_below_design_flow_perc(i,1)-Days_future_2040s_RCM01_flow_below_design_flow_perc(i,1);
Table_days_below_design_flow_2040s{i,21}=Days_baseline_flow_below_design_flow_perc(i,1)-Days_future_2040s_RCM01_flow_below_design_flow_perc(i,1);
Table_days_below_design_flow_2040s{i,22}=Days_baseline_flow_below_design_flow_perc(i,1)-Days_future_2040s_RCM01_flow_below_design_flow_perc(i,1);
Table_days_below_design_flow_2040s{i,23}=Days_baseline_flow_below_design_flow_perc(i,1)-Days_future_2040s_RCM01_flow_below_design_flow_perc(i,1);
Table_days_below_design_flow_2040s{i,24}=Days_baseline_flow_below_design_flow_perc(i,1)-Days_future_2040s_RCM01_flow_below_design_flow_perc(i,1);
Table_days_below_design_flow_2040s{i,25}=Days_baseline_flow_below_design_flow_perc(i,1)-Days_future_2040s_RCM01_flow_below_design_flow_perc(i,1);
Table_days_below_design_flow_2040s{i,26}=Days_baseline_flow_below_design_flow_perc(i,1)-Days_future_2040s_RCM01_flow_below_design_flow_perc(i,1);
Table_days_below_design_flow_2040s{i,27}=Days_baseline_flow_below_design_flow_perc(i,1)-Days_future_2040s_RCM01_flow_below_design_flow_perc(i,1);
 
Table_days_below_design_flow_2040s{i,28}=Days_baseline_flow_below_design_flow_perc(i,1)-Days_future_2040s_RCM01_flow_below_design_flow_perc(i,1);
 
Table_days_below_design_flow_2040s_header={'ID','Baseline days with flow below design flow [%]','RCM01 days with flow below design flow [%]','RCM04 days with flow below design flow [%]','RCM05 days with flow below design flow [%]','RCM06 days with flow below design flow [%]','RCM07 days with flow below design flow [%]','RCM08 days with flow below design flow [%]','RCM09 days with flow below design flow [%]','RCM10 days with flow below design flow [%]','RCM11 days with flow below design flow [%]','RCM12 days with flow below design flow [%]','RCM13 days with flow below design flow [%]','RCM15 days with flow below design flow [%]','All RCM days with flow below design flow [%]','Baseline-RCM01 2040s design flow [%]','Baseline-RCM04 [%]','Baseline-RCM05 [%]','Baseline-RCM06 [%]','Baseline-RCM07 [%]','Baseline-RCM08 [%]','Baseline-RCM09 [%]','Baseline-RCM10 [%]' ,'Baseline-RCM11 [%]','Baseline-RCM12 [%]','Baseline-RCM13 [%]','Baseline-RCM15 [%]','Baseline - Future days with flow below design flow [%]'};
 
%Write the table into an excel file
 
if exist(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Station_',no,'_2040s_days_flow_below_design_flow.xls'), 'file')==2
   delete(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Station_',no,'_2040s_days_flow_below_design_flow.xls'));
end
 
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Station_',no,'_2040s_days_flow_below_design_flow.xls'),Table_days_below_design_flow_2040s,'Sheet1','A2');
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Station_',no,'_2040s_days_flow_below_design_flow.xls'),Table_days_below_design_flow_2040s_header,'Sheet1','A1');
 
%% Table of days with flows below Q95
 
%% 2060s
Table_days_below_Q95_2060s{i,1}=GaugesNo(i,1);
 
Table_days_below_Q95_2060s{i,2}=Days_baseline_flow_below_Q95_perc(i,1);
 
Table_days_below_Q95_2060s{i,3}=Days_future_2060s_RCM01_flow_below_Q95_perc(i,1);
Table_days_below_Q95_2060s{i,4}=Days_future_2060s_RCM04_flow_below_Q95_perc(i,1);
Table_days_below_Q95_2060s{i,5}=Days_future_2060s_RCM05_flow_below_Q95_perc(i,1);
Table_days_below_Q95_2060s{i,6}=Days_future_2060s_RCM06_flow_below_Q95_perc(i,1);
Table_days_below_Q95_2060s{i,7}=Days_future_2060s_RCM07_flow_below_Q95_perc(i,1);
Table_days_below_Q95_2060s{i,8}=Days_future_2060s_RCM08_flow_below_Q95_perc(i,1);
Table_days_below_Q95_2060s{i,9}=Days_future_2060s_RCM09_flow_below_Q95_perc(i,1);
Table_days_below_Q95_2060s{i,10}=Days_future_2060s_RCM10_flow_below_Q95_perc(i,1);
Table_days_below_Q95_2060s{i,11}=Days_future_2060s_RCM11_flow_below_Q95_perc(i,1);
Table_days_below_Q95_2060s{i,12}=Days_future_2060s_RCM12_flow_below_Q95_perc(i,1);
Table_days_below_Q95_2060s{i,13}=Days_future_2060s_RCM13_flow_below_Q95_perc(i,1);
Table_days_below_Q95_2060s{i,14}=Days_future_2060s_RCM15_flow_below_Q95_perc(i,1);
 
Table_days_below_Q95_2060s{i,15}=Days_future_2060s_allRCM_flow_below_Q95_perc(i,1);
 
Table_days_below_Q95_2060s{i,16}=Days_baseline_flow_below_Q95_perc(i,1)-Days_future_2060s_RCM01_flow_below_Q95_perc(i,1);
Table_days_below_Q95_2060s{i,17}=Days_baseline_flow_below_Q95_perc(i,1)-Days_future_2060s_RCM01_flow_below_Q95_perc(i,1);
Table_days_below_Q95_2060s{i,18}=Days_baseline_flow_below_Q95_perc(i,1)-Days_future_2060s_RCM01_flow_below_Q95_perc(i,1);
Table_days_below_Q95_2060s{i,19}=Days_baseline_flow_below_Q95_perc(i,1)-Days_future_2060s_RCM01_flow_below_Q95_perc(i,1);
Table_days_below_Q95_2060s{i,20}=Days_baseline_flow_below_Q95_perc(i,1)-Days_future_2060s_RCM01_flow_below_Q95_perc(i,1);
Table_days_below_Q95_2060s{i,21}=Days_baseline_flow_below_Q95_perc(i,1)-Days_future_2060s_RCM01_flow_below_Q95_perc(i,1);
Table_days_below_Q95_2060s{i,22}=Days_baseline_flow_below_Q95_perc(i,1)-Days_future_2060s_RCM01_flow_below_Q95_perc(i,1);
Table_days_below_Q95_2060s{i,23}=Days_baseline_flow_below_Q95_perc(i,1)-Days_future_2060s_RCM01_flow_below_Q95_perc(i,1);
Table_days_below_Q95_2060s{i,24}=Days_baseline_flow_below_Q95_perc(i,1)-Days_future_2060s_RCM01_flow_below_Q95_perc(i,1);
Table_days_below_Q95_2060s{i,25}=Days_baseline_flow_below_Q95_perc(i,1)-Days_future_2060s_RCM01_flow_below_Q95_perc(i,1);
Table_days_below_Q95_2060s{i,26}=Days_baseline_flow_below_Q95_perc(i,1)-Days_future_2060s_RCM01_flow_below_Q95_perc(i,1);
Table_days_below_Q95_2060s{i,27}=Days_baseline_flow_below_Q95_perc(i,1)-Days_future_2060s_RCM01_flow_below_Q95_perc(i,1);
 
Table_days_below_Q95_2060s{i,28}=Days_baseline_flow_below_Q95_perc(i,1)-Days_future_2060s_RCM01_flow_below_Q95_perc(i,1);
 
Table_days_below_Q95_2060s_header={'ID','Baseline days with flow below Q95 [%]','RCM01 days with flow below Q95 [%]','RCM04 days with flow below Q95 [%]','RCM05 days with flow below Q95 [%]','RCM06 days with flow below Q95 [%]','RCM07 days with flow below Q95 [%]','RCM08 days with flow below Q95 [%]','RCM09 days with flow below Q95 [%]','RCM10 days with flow below Q95 [%]','RCM11 days with flow below Q95 [%]','RCM12 days with flow below Q95 [%]','RCM13 days with flow below Q95 [%]','RCM15 days with flow below Q95 [%]','All RCM days with flow below Q95 [%]','Baseline-RCM01 2040s Q95 [%]','Baseline-RCM04 [%]','Baseline-RCM05 [%]','Baseline-RCM06 [%]','Baseline-RCM07 [%]','Baseline-RCM08 [%]','Baseline-RCM09 [%]','Baseline-RCM10 [%]' ,'Baseline-RCM11 [%]','Baseline-RCM12 [%]','Baseline-RCM13 [%]','Baseline-RCM15 [%]','Baseline - Future days with flow below Q95 [%]'};
 
%Write the table into an excel file
 
if exist(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Station_',no,'_2060s_days_flow_below_Q95.xls'), 'file')==2
   delete(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Station_',no,'_2060s_days_flow_below_Q95.xls'));
end
 
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Station_',no,'_2060s_days_flow_below_Q95.xls'),Table_days_below_Q95_2060s,'Sheet1','A2');
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Station_',no,'_2060s_days_flow_below_Q95.xls'),Table_days_below_Q95_2060s_header,'Sheet1','A1');
 
%% Table of days with flows below design_flow
 
%% 2060s
Table_days_below_design_flow_2060s{i,1}=GaugesNo(i,1);
 
Table_days_below_design_flow_2060s{i,2}=Days_baseline_flow_below_design_flow_perc(i,1);
 
Table_days_below_design_flow_2060s{i,3}=Days_future_2060s_RCM01_flow_below_design_flow_perc(i,1);
Table_days_below_design_flow_2060s{i,4}=Days_future_2060s_RCM04_flow_below_design_flow_perc(i,1);
Table_days_below_design_flow_2060s{i,5}=Days_future_2060s_RCM05_flow_below_design_flow_perc(i,1);
Table_days_below_design_flow_2060s{i,6}=Days_future_2060s_RCM06_flow_below_design_flow_perc(i,1);
Table_days_below_design_flow_2060s{i,7}=Days_future_2060s_RCM07_flow_below_design_flow_perc(i,1);
Table_days_below_design_flow_2060s{i,8}=Days_future_2060s_RCM08_flow_below_design_flow_perc(i,1);
Table_days_below_design_flow_2060s{i,9}=Days_future_2060s_RCM09_flow_below_design_flow_perc(i,1);
Table_days_below_design_flow_2060s{i,10}=Days_future_2060s_RCM10_flow_below_design_flow_perc(i,1);
Table_days_below_design_flow_2060s{i,11}=Days_future_2060s_RCM11_flow_below_design_flow_perc(i,1);
Table_days_below_design_flow_2060s{i,12}=Days_future_2060s_RCM12_flow_below_design_flow_perc(i,1);
Table_days_below_design_flow_2060s{i,13}=Days_future_2060s_RCM13_flow_below_design_flow_perc(i,1);
Table_days_below_design_flow_2060s{i,14}=Days_future_2060s_RCM15_flow_below_design_flow_perc(i,1);
 
Table_days_below_design_flow_2060s{i,15}=Days_future_2060s_allRCM_flow_below_design_flow_perc(i,1);
 
Table_days_below_design_flow_2060s{i,16}=Days_baseline_flow_below_design_flow_perc(i,1)-Days_future_2060s_RCM01_flow_below_design_flow_perc(i,1);
Table_days_below_design_flow_2060s{i,17}=Days_baseline_flow_below_design_flow_perc(i,1)-Days_future_2060s_RCM01_flow_below_design_flow_perc(i,1);
Table_days_below_design_flow_2060s{i,18}=Days_baseline_flow_below_design_flow_perc(i,1)-Days_future_2060s_RCM01_flow_below_design_flow_perc(i,1);
Table_days_below_design_flow_2060s{i,19}=Days_baseline_flow_below_design_flow_perc(i,1)-Days_future_2060s_RCM01_flow_below_design_flow_perc(i,1);
Table_days_below_design_flow_2060s{i,20}=Days_baseline_flow_below_design_flow_perc(i,1)-Days_future_2060s_RCM01_flow_below_design_flow_perc(i,1);
Table_days_below_design_flow_2060s{i,21}=Days_baseline_flow_below_design_flow_perc(i,1)-Days_future_2060s_RCM01_flow_below_design_flow_perc(i,1);
Table_days_below_design_flow_2060s{i,22}=Days_baseline_flow_below_design_flow_perc(i,1)-Days_future_2060s_RCM01_flow_below_design_flow_perc(i,1);
Table_days_below_design_flow_2060s{i,23}=Days_baseline_flow_below_design_flow_perc(i,1)-Days_future_2060s_RCM01_flow_below_design_flow_perc(i,1);
Table_days_below_design_flow_2060s{i,24}=Days_baseline_flow_below_design_flow_perc(i,1)-Days_future_2060s_RCM01_flow_below_design_flow_perc(i,1);
Table_days_below_design_flow_2060s{i,25}=Days_baseline_flow_below_design_flow_perc(i,1)-Days_future_2060s_RCM01_flow_below_design_flow_perc(i,1);
Table_days_below_design_flow_2060s{i,26}=Days_baseline_flow_below_design_flow_perc(i,1)-Days_future_2060s_RCM01_flow_below_design_flow_perc(i,1);
Table_days_below_design_flow_2060s{i,27}=Days_baseline_flow_below_design_flow_perc(i,1)-Days_future_2060s_RCM01_flow_below_design_flow_perc(i,1);
 
Table_days_below_design_flow_2060s{i,28}=Days_baseline_flow_below_design_flow_perc(i,1)-Days_future_2060s_RCM01_flow_below_design_flow_perc(i,1);
 
Table_days_below_design_flow_2060s_header={'ID','Baseline days with flow below design flow [%]','RCM01 days with flow below design flow [%]','RCM04 days with flow below design flow [%]','RCM05 days with flow below design flow [%]','RCM06 days with flow below design flow [%]','RCM07 days with flow below design flow [%]','RCM08 days with flow below design flow [%]','RCM09 days with flow below design flow [%]','RCM10 days with flow below design flow [%]','RCM11 days with flow below design flow [%]','RCM12 days with flow below design flow [%]','RCM13 days with flow below design flow [%]','RCM15 days with flow below design flow [%]','All RCM days with flow below design flow [%]','Baseline-RCM01 2040s design flow [%]','Baseline-RCM04 [%]','Baseline-RCM05 [%]','Baseline-RCM06 [%]','Baseline-RCM07 [%]','Baseline-RCM08 [%]','Baseline-RCM09 [%]','Baseline-RCM10 [%]' ,'Baseline-RCM11 [%]','Baseline-RCM12 [%]','Baseline-RCM13 [%]','Baseline-RCM15 [%]','Baseline - Future days with flow below design flow [%]'};
 
%Write the table into an excel file
 
if exist(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Station_',no,'_2060s_days_flow_below_design_flow.xls'), 'file')==2
   delete(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Station_',no,'_2060s_days_flow_below_design_flow.xls'));
end
 
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Station_',no,'_2060s_days_flow_below_design_flow.xls'),Table_days_below_design_flow_2060s,'Sheet1','A2');
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\G2G\Station_',no,'_2060s_days_flow_below_design_flow.xls'),Table_days_below_design_flow_2060s_header,'Sheet1','A1');

    end
end