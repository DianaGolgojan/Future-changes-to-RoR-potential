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

for i=130:200
    no=num2str(GaugesNo(i,1));
    %These are excluded because there is no gauged data
    if i~=[30,34,45,88]

%% Read the baseline flows and save the 1990s flows in an Excel file
    Current_station_location_baseline=strcat('H:\01.PhD\004.Chapter4\Input_data_CEH\Observed Flows_eFlag\GR4J\GR4J_simobs_',no,'.csv');
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
    if exist(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Baseline\Baseline_station_',no,'.xls'), 'file')==2
        delete(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Baseline\Baseline_station_',no,'.xls'));
    end
    writetable(Current_station_baseline,strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Baseline\Baseline_station_',no,'.xls'));

%% Read the future flows and save the 2040s future flows in an Excel file
    Current_station_future_2040s_location=strcat('H:\01.PhD\004.Chapter4\Input_data_CEH\Future Flow_eFlag\GR4J\GR4J_simrcm_',no,'.csv');
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
    if exist(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2040s\Future_2040s_station_',no,'.xls'), 'file')==2
        delete(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2040s\Future_flow_inputs\Future_2040s_station_',no,'.xls'));
    end
    writetable(Current_station_future_2040s,strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2040s\Future_2040s_station_',no,'.xls'));
    
%% Read the future flows and save the 2060s future flows in an Excel file
    Current_station_future_2060s_location=strcat('H:\01.PhD\004.Chapter4\Input_data_CEH\Future Flow_eFlag\GR4J\GR4J_simrcm_',no,'.csv');
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
    if exist(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2060s\Future_2060s_station_',no,'.xls'), 'file')==2
        delete(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2060s\Future_2060s_station_',no,'.xls'));
    end
    writetable(Current_station_future_2060s,strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2060s\Future_2060s_station_',no,'.xls'));

%% Plot the baseline flow vs 2040s flow for all RCMs
clf %clears figure information
       set(gca,'Box','on');
       hold on
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Baseline_vs_2040s_all_RCM_ID_',no,'.png');
       tiledlayout(2,1)

       %Top plot
       nexttile
       box on
       title_name_baseline=strcat('Daily observed baseline flows at station no.'," ",no);
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Flow [m^3/s]');
       hold on
       plot(Time_Obs_baseline,Flow_Obs_baseline);
       hold on

       %Bottom plot
       nexttile
       box on
       title_name_baseline=strcat('Daily observed future 2040s flows at station no.'," ",no," ",'for all RCMs');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Flow [m^3/s]');
       hold on
       plot(Time_Sim_future_2040s,Flow_Sim_future_2040s_allRCM,'Color','r');
       %legend('Baseline observed flows [m^3/s]','Future simulated flows [m^3/s]','Location','northeast');
       
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
       
%% Plot the baseline flow vs 2060s flow
clf %clears figure information
       set(gca,'Box','on');
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Baseline_vs_2060s_all_RCM_ID_',no,'.png');
       tiledlayout(2,1)

       %Top plot
       nexttile
       box on
       title_name_baseline=strcat('Daily observed baseline flows at station no.'," ",no);
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Flow [m^3/s]');
       hold on
       plot(Time_Obs_baseline,Flow_Obs_baseline);
       hold on

       %Bottom plot
       nexttile
       box on
       title_name_future_2040s=strcat('Daily observed future 2060s flows at station no.'," ",no," ",'for all RCMs');
       title(title_name_future_2040s);
       xlabel('Time');
       ylabel('Flow [m^3/s]');
       hold on
       plot(Time_Sim_future_2060s,Flow_Sim_future_2060s_allRCM,'Color','r');

       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);


%% Plot daily future 2040s flows for all RCMs
clf %clears figure information
       tiledlayout(4,3,'TileSpacing','Compact');
       set(gca,'Box','on','FontSize',9);
       hold on
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Daily_future_flows_2040s_RCM01_ID_',no,'.png');
       title_name_future=strcat('Daily future 2040s flows at station no.'," ",no);
       title(title_name_future);       
       hold on

       %RCM01 Plot
       nexttile
       title('RCM01')
       hold on
       set(gca,'Box','on','FontSize',9);
       xlabel('Time','FontSize',9);
       ylabel('Flow [m^3/s]','FontSize',9);
       hold on
       plot(Time_Sim_future_2040s,Flow_Sim_future_2040s_RCM01);
       hold on 

       %RCM04 Plot
       nexttile
       title('RCM04')
       hold on
       set(gca,'Box','on','FontSize',9);
       hold on
       box on
       xlabel('Time','FontSize',9);
       ylabel('Flow [m^3/s]','FontSize',9);
       hold on
       plot(Time_Sim_future_2040s,Flow_Sim_future_2040s_RCM04);
       hold on 

       %RCM05 Plot
       nexttile
       title('RCM05')
       hold on
       set(gca,'Box','on','FontSize',9);
       hold on
       box on
       xlabel('Time','FontSize',9);
       ylabel('Flow [m^3/s]','FontSize',9);
       hold on
       plot(Time_Sim_future_2040s,Flow_Sim_future_2040s_RCM05);
       hold on 

       %RCM06 Plot
       nexttile
       title('RCM06')
       hold on
       set(gca,'Box','on','FontSize',9);
       hold on
       box on
       xlabel('Time','FontSize',9);
       ylabel('Flow [m^3/s]','FontSize',9);
       hold on
       plot(Time_Sim_future_2040s,Flow_Sim_future_2040s_RCM06);
       hold on 

       %RCM07 Plot
       nexttile
       title('RCM07')
       hold on
       set(gca,'Box','on','FontSize',9);
       hold on
       box on
       xlabel('Time','FontSize',9);
       ylabel('Flow [m^3/s]','FontSize',9);
       hold on
       plot(Time_Sim_future_2040s,Flow_Sim_future_2040s_RCM07);
       hold on 

       %RCM08 Plot
       nexttile
       title('RCM08')
       hold on
       set(gca,'Box','on','FontSize',9);
       hold on
       box on
       xlabel('Time','FontSize',9);
       ylabel('Flow [m^3/s]','FontSize',9);
       hold on
       plot(Time_Sim_future_2040s,Flow_Sim_future_2040s_RCM08);
       hold on 

       %RCM09 Plot
       nexttile
       title('RCM09')
       hold on
       set(gca,'Box','on','FontSize',9);
       hold on
       box on
       xlabel('Time','FontSize',9);
       ylabel('Flow [m^3/s]','FontSize',9);
       hold on
       plot(Time_Sim_future_2040s,Flow_Sim_future_2040s_RCM09);
       hold on 

       %RCM10 Plot
       nexttile
       title('RCM10')
       hold on
       set(gca,'Box','on','FontSize',9);
       hold on
       box on
       xlabel('Time','FontSize',9);
       ylabel('Flow [m^3/s]','FontSize',9);
       hold on
       plot(Time_Sim_future_2040s,Flow_Sim_future_2040s_RCM10);
       hold on 

       %RCM11 Plot
       nexttile
       title('RCM11')
       hold on
       set(gca,'Box','on','FontSize',9);
       hold on
       box on
       xlabel('Time','FontSize',9);
       ylabel('Flow [m^3/s]','FontSize',9);
       hold on
       plot(Time_Sim_future_2040s,Flow_Sim_future_2040s_RCM11);
       hold on 

       %RCM12 Plot
       nexttile
       title('RCM12')
       hold on
       set(gca,'Box','on','FontSize',9);
       hold on
       box on
       xlabel('Time','FontSize',9);
       ylabel('Flow [m^3/s]','FontSize',9);
       hold on
       plot(Time_Sim_future_2040s,Flow_Sim_future_2040s_RCM12);
       hold on 

       %RCM13 Plot
       nexttile
       title('RCM13')
       hold on
       set(gca,'Box','on','FontSize',9);
       hold on
       box on
       xlabel('Time','FontSize',9);
       ylabel('Flow [m^3/s]','FontSize',9);
       hold on
       plot(Time_Sim_future_2040s,Flow_Sim_future_2040s_RCM13);
       hold on 

       %RCM15 Plot
       nexttile
       title('RCM15')
       hold on
       set(gca,'Box','on','FontSize',9);
       hold on
       box on
       xlabel('Time','FontSize',9);
       ylabel('Flow [m^3/s]','FontSize',9);
       hold on
       plot(Time_Sim_future_2040s,Flow_Sim_future_2040s_RCM15);
       hold on 

       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);

%% Plot daily future 2060s flows for all RCMs
clf %clears figure information
       tiledlayout(4,3,'TileSpacing','Compact');
       set(gca,'Box','on','FontSize',9);
       hold on
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Daily_future_flows_2060s_RCM01_ID_',no,'.png');
       title_name_future=strcat('Daily future 2060s flows at station no.'," ",no);
       title(title_name_future);       
       hold on

       %RCM01 Plot
       nexttile
       title('RCM01')
       hold on
       set(gca,'Box','on','FontSize',9);
       xlabel('Time','FontSize',9);
       ylabel('Flow [m^3/s]','FontSize',9);
       hold on
       plot(Time_Sim_future_2060s,Flow_Sim_future_2060s_RCM01);
       hold on 

       %RCM04 Plot
       nexttile
       title('RCM04')
       hold on
       set(gca,'Box','on','FontSize',9);
       hold on
       box on
       xlabel('Time','FontSize',9);
       ylabel('Flow [m^3/s]','FontSize',9);
       hold on
       plot(Time_Sim_future_2060s,Flow_Sim_future_2060s_RCM04);
       hold on 

       %RCM05 Plot
       nexttile
       title('RCM05')
       hold on
       set(gca,'Box','on','FontSize',9);
       hold on
       box on
       xlabel('Time','FontSize',9);
       ylabel('Flow [m^3/s]','FontSize',9);
       hold on
       plot(Time_Sim_future_2060s,Flow_Sim_future_2060s_RCM05);
       hold on 

       %RCM06 Plot
       nexttile
       title('RCM06')
       hold on
       set(gca,'Box','on','FontSize',9);
       hold on
       box on
       xlabel('Time','FontSize',9);
       ylabel('Flow [m^3/s]','FontSize',9);
       hold on
       plot(Time_Sim_future_2060s,Flow_Sim_future_2060s_RCM06);
       hold on 

       %RCM07 Plot
       nexttile
       title('RCM07')
       hold on
       set(gca,'Box','on','FontSize',9);
       hold on
       box on
       xlabel('Time','FontSize',9);
       ylabel('Flow [m^3/s]','FontSize',9);
       hold on
       plot(Time_Sim_future_2060s,Flow_Sim_future_2060s_RCM07);
       hold on 

       %RCM08 Plot
       nexttile
       title('RCM08')
       hold on
       set(gca,'Box','on','FontSize',9);
       hold on
       box on
       xlabel('Time','FontSize',9);
       ylabel('Flow [m^3/s]','FontSize',9);
       hold on
       plot(Time_Sim_future_2060s,Flow_Sim_future_2060s_RCM08);
       hold on 

       %RCM09 Plot
       nexttile
       title('RCM09')
       hold on
       set(gca,'Box','on','FontSize',9);
       hold on
       box on
       xlabel('Time','FontSize',9);
       ylabel('Flow [m^3/s]','FontSize',9);
       hold on
       plot(Time_Sim_future_2060s,Flow_Sim_future_2060s_RCM09);
       hold on 

       %RCM10 Plot
       nexttile
       title('RCM10')
       hold on
       set(gca,'Box','on','FontSize',9);
       hold on
       box on
       xlabel('Time','FontSize',9);
       ylabel('Flow [m^3/s]','FontSize',9);
       hold on
       plot(Time_Sim_future_2060s,Flow_Sim_future_2060s_RCM10);
       hold on 

       %RCM11 Plot
       nexttile
       title('RCM11')
       hold on
       set(gca,'Box','on','FontSize',9);
       hold on
       box on
       xlabel('Time','FontSize',9);
       ylabel('Flow [m^3/s]','FontSize',9);
       hold on
       plot(Time_Sim_future_2060s,Flow_Sim_future_2060s_RCM11);
       hold on 

       %RCM12 Plot
       nexttile
       title('RCM12')
       hold on
       set(gca,'Box','on','FontSize',9);
       hold on
       box on
       xlabel('Time','FontSize',9);
       ylabel('Flow [m^3/s]','FontSize',9);
       hold on
       plot(Time_Sim_future_2060s,Flow_Sim_future_2060s_RCM12);
       hold on 

       %RCM13 Plot
       nexttile
       title('RCM13')
       hold on
       set(gca,'Box','on','FontSize',9);
       hold on
       box on
       xlabel('Time','FontSize',9);
       ylabel('Flow [m^3/s]','FontSize',9);
       hold on
       plot(Time_Sim_future_2060s,Flow_Sim_future_2060s_RCM13);
       hold on 

       %RCM15 Plot
       nexttile
       title('RCM15')
       hold on
       set(gca,'Box','on','FontSize',9);
       hold on
       box on
       xlabel('Time','FontSize',9);
       ylabel('Flow [m^3/s]','FontSize',9);
       hold on
       plot(Time_Sim_future_2060s,Flow_Sim_future_2060s_RCM15);
       hold on 

       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
       

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

%% Plot baseline flow duration curve (FDC) vs future FDC for all RCMs 
clf 
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Baseline_vs_future_FDC_ID_',no,'.png');
title_name_baseline=strcat('Flow duration curves at station no.'," ",no);
title(title_name_baseline);
ylabel('Flows [m^3/s]');
xlabel('Exceeding probability [%]');
hold on
plot([1:100],Flow_Obs_baseline_fdc,'color','#0072BD');
hold on
plot([1:100],Flow_Sim_future_2040s_allRCM_fdc,'color','#77AC30');
hold on
plot([1:100],Flow_Sim_future_2060s_allRCM_fdc,'color','#A2142F');
hold on
legend('Baseline flow duration curve','Future 2040s flow duration curve','Future 2060s flow duration curve');

if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
   saveas(gcf,save_name_baseline);

%% Plot baseline flow duration curve (FDC) vs future FDC for all RCMs 2040s
clf 
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Baseline_vs_future_2040s_allRCMs_FDC_ID_',no,'.png');
title_name_baseline=strcat('Flow duration curves at station no.'," ",no);
title(title_name_baseline);
ylabel('Flows [m^3/s]');
xlabel('Exceeding probability [%]');
hold on
plot([1:100],Flow_Obs_baseline_fdc,'color','#0072BD','LineWidth',1.5,'LineStyle','--');
hold on
h=plot([1:100],Flow_Sim_future_2040s_allRCM_fdc,'color','#000000','LineWidth',2,'LineStyle','-.');
uistack(h,'top')
hold on
plot([1:100],Flow_Sim_future_2040s_RCM01_fdc);
hold on
plot([1:100],Flow_Sim_future_2060s_RCM04_fdc);
hold on
plot([1:100],Flow_Sim_future_2060s_RCM05_fdc);
hold on
plot([1:100],Flow_Sim_future_2060s_RCM06_fdc);
hold on
plot([1:100],Flow_Sim_future_2060s_RCM07_fdc);
hold on
plot([1:100],Flow_Sim_future_2060s_RCM08_fdc);
hold on
plot([1:100],Flow_Sim_future_2060s_RCM09_fdc);
hold on
plot([1:100],Flow_Sim_future_2060s_RCM10_fdc);
hold on
plot([1:100],Flow_Sim_future_2060s_RCM11_fdc);
hold on
plot([1:100],Flow_Sim_future_2060s_RCM12_fdc);
hold on
plot([1:100],Flow_Sim_future_2060s_RCM13_fdc);
hold on
plot([1:100],Flow_Sim_future_2060s_RCM15_fdc);
hold on

legend('Baseline','Future 2040s all RCM','Future 2040s RCM01','Future 2040s RCM04','Future 2040s RCM05','Future 2040s RCM06','Future 2040s RCM07','Future 2040s RCM08','Future 2040s RCM09','Future 2040s RCM10','Future 2040s RCM11','Future 2040s RCM12','Future 2040s RCM13','Future 2040s RCM15');

if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
   saveas(gcf,save_name_baseline);

%% Plot baseline flow duration curve (FDC) vs future FDC for all RCMs 2060s
clf 
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Baseline_vs_future_2060s_allRCMs_FDC_ID_',no,'.png');
title_name_baseline=strcat('Flow duration curves at station no.'," ",no);
title(title_name_baseline);
ylabel('Flows [m^3/s]');
xlabel('Exceeding probability [%]');
hold on
plot([1:100],Flow_Obs_baseline_fdc,'color','#0072BD','LineWidth',1.5,'LineStyle','--');
hold on
h=plot([1:100],Flow_Sim_future_2060s_allRCM_fdc,'color','#000000','LineWidth',2,'LineStyle','-.');
uistack(h,'top')
hold on
plot([1:100],Flow_Sim_future_2060s_RCM01_fdc);
hold on
plot([1:100],Flow_Sim_future_2060s_RCM04_fdc);
hold on
plot([1:100],Flow_Sim_future_2060s_RCM05_fdc);
hold on
plot([1:100],Flow_Sim_future_2060s_RCM06_fdc);
hold on
plot([1:100],Flow_Sim_future_2060s_RCM07_fdc);
hold on
plot([1:100],Flow_Sim_future_2060s_RCM08_fdc);
hold on
plot([1:100],Flow_Sim_future_2060s_RCM09_fdc);
hold on
plot([1:100],Flow_Sim_future_2060s_RCM10_fdc);
hold on
plot([1:100],Flow_Sim_future_2060s_RCM11_fdc);
hold on
plot([1:100],Flow_Sim_future_2060s_RCM12_fdc);
hold on
plot([1:100],Flow_Sim_future_2060s_RCM13_fdc);
hold on
plot([1:100],Flow_Sim_future_2060s_RCM15_fdc);
hold on

legend('Baseline','Future 2060s all RCM','Future 2060s RCM01','Future 2060s RCM04','Future 2060s RCM05','Future 2060s RCM06','Future 2060s RCM07','Future 2060s RCM08','Future 2060s RCM09','Future 2060s RCM10','Future 2060s RCM11','Future 2060s RCM12','Future 2060s RCM13','Future 2060s RCM15');

if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
   saveas(gcf,save_name_baseline);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%% Get monthly baseline flows
Table_baseline=[];
Monthly_values_baseline_mean=[];

Table_baseline=Time_Obs_baseline;
Table_baseline=timetable(Time_Obs_baseline,Flow_Obs_baseline);

Monthly_values_baseline_mean=convert2monthly(Table_baseline,'Aggregation',["mean"]);
Flow_Obs_baseline_monthly_mean=Monthly_values_baseline_mean;

Flow_Obs_baseline_monthly_mean=table2array(Flow_Obs_baseline_monthly_mean);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Get monthly future 2040s flows
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% All RCMs
Flow_Sim_future_2040s_allRCM_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2040s_allRCM)
    Flow_Sim_future_2040s_allRCM_monthly_mean(j,1)=nanmean(Flow_Sim_future_2040s_allRCM(j:j+29));
end
Flow_Sim_future_2040s_allRCM_monthly_mean(any(Flow_Sim_future_2040s_allRCM_monthly_mean==0,2))=[];

%% RCM01
Flow_Sim_future_2040s_RCM01_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2040s_RCM01)
    Flow_Sim_future_2040s_RCM01_monthly_mean(j,1)=nanmean(Flow_Sim_future_2040s_RCM01(j:j+29));
end
Flow_Sim_future_2040s_RCM01_monthly_mean(any(Flow_Sim_future_2040s_RCM01_monthly_mean==0,2))=[];

%% RCM04
Flow_Sim_future_2040s_RCM04_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2040s_RCM04)
    Flow_Sim_future_2040s_RCM04_monthly_mean(j,1)=nanmean(Flow_Sim_future_2040s_RCM04(j:j+29));
end
Flow_Sim_future_2040s_RCM04_monthly_mean(any(Flow_Sim_future_2040s_RCM04_monthly_mean==0,2))=[];

%% RCM05
Flow_Sim_future_2040s_RCM05_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2040s_RCM05)
    Flow_Sim_future_2040s_RCM05_monthly_mean(j,1)=nanmean(Flow_Sim_future_2040s_RCM05(j:j+29));
end
Flow_Sim_future_2040s_RCM05_monthly_mean(any(Flow_Sim_future_2040s_RCM05_monthly_mean==0,2))=[];

%% RCM06
Flow_Sim_future_2040s_RCM06_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2040s_RCM06)
    Flow_Sim_future_2040s_RCM06_monthly_mean(j,1)=nanmean(Flow_Sim_future_2040s_RCM06(j:j+29));
end
Flow_Sim_future_2040s_RCM06_monthly_mean(any(Flow_Sim_future_2040s_RCM06_monthly_mean==0,2))=[];

%% RCM07
Flow_Sim_future_2040s_RCM07_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2040s_RCM07)
    Flow_Sim_future_2040s_RCM07_monthly_mean(j,1)=nanmean(Flow_Sim_future_2040s_RCM07(j:j+29));
end
Flow_Sim_future_2040s_RCM07_monthly_mean(any(Flow_Sim_future_2040s_RCM07_monthly_mean==0,2))=[];

%% RCM08
Flow_Sim_future_2040s_RCM08_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2040s_RCM08)
    Flow_Sim_future_2040s_RCM08_monthly_mean(j,1)=nanmean(Flow_Sim_future_2040s_RCM08(j:j+29));
end
Flow_Sim_future_2040s_RCM08_monthly_mean(any(Flow_Sim_future_2040s_RCM08_monthly_mean==0,2))=[];

%% RCM09
Flow_Sim_future_2040s_RCM09_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2040s_RCM09)
    Flow_Sim_future_2040s_RCM09_monthly_mean(j,1)=nanmean(Flow_Sim_future_2040s_RCM09(j:j+29));
end
Flow_Sim_future_2040s_RCM09_monthly_mean(any(Flow_Sim_future_2040s_RCM09_monthly_mean==0,2))=[];

%% RCM10
Flow_Sim_future_2040s_RCM10_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2040s_RCM10)
    Flow_Sim_future_2040s_RCM10_monthly_mean(j,1)=nanmean(Flow_Sim_future_2040s_RCM10(j:j+29));
end
Flow_Sim_future_2040s_RCM10_monthly_mean(any(Flow_Sim_future_2040s_RCM10_monthly_mean==0,2))=[];

%% RCM11
Flow_Sim_future_2040s_RCM11_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2040s_RCM11)
    Flow_Sim_future_2040s_RCM11_monthly_mean(j,1)=nanmean(Flow_Sim_future_2040s_RCM11(j:j+29));
end
Flow_Sim_future_2040s_RCM11_monthly_mean(any(Flow_Sim_future_2040s_RCM11_monthly_mean==0,2))=[];

%% RCM12
Flow_Sim_future_2040s_RCM12_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2040s_RCM12)
    Flow_Sim_future_2040s_RCM12_monthly_mean(j,1)=nanmean(Flow_Sim_future_2040s_RCM12(j:j+29));
end
Flow_Sim_future_2040s_RCM12_monthly_mean(any(Flow_Sim_future_2040s_RCM12_monthly_mean==0,2))=[];

%% RCM13
Flow_Sim_future_2040s_RCM13_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2040s_RCM13)
    Flow_Sim_future_2040s_RCM13_monthly_mean(j,1)=nanmean(Flow_Sim_future_2040s_RCM13(j:j+29));
end
Flow_Sim_future_2040s_RCM13_monthly_mean(any(Flow_Sim_future_2040s_RCM13_monthly_mean==0,2))=[];

%% RCM15
Flow_Sim_future_2040s_RCM15_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2040s_RCM15)
    Flow_Sim_future_2040s_RCM15_monthly_mean(j,1)=nanmean(Flow_Sim_future_2040s_RCM15(j:j+29));
end
Flow_Sim_future_2040s_RCM15_monthly_mean(any(Flow_Sim_future_2040s_RCM15_monthly_mean==0,2))=[];

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Get monthly future 2060s flows
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% All RCMs
Flow_Sim_future_2060s_allRCM_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2060s_allRCM)
    Flow_Sim_future_2060s_allRCM_monthly_mean(j,1)=nanmean(Flow_Sim_future_2060s_allRCM(j:j+29));
end
Flow_Sim_future_2060s_allRCM_monthly_mean(any(Flow_Sim_future_2060s_allRCM_monthly_mean==0,2))=[];

%% RCM01
Flow_Sim_future_2060s_RCM01_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2060s_RCM01)
    Flow_Sim_future_2060s_RCM01_monthly_mean(j,1)=nanmean(Flow_Sim_future_2060s_RCM01(j:j+29));
end
Flow_Sim_future_2060s_RCM01_monthly_mean(any(Flow_Sim_future_2060s_RCM01_monthly_mean==0,2))=[];

%% RCM04
Flow_Sim_future_2060s_RCM04_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2060s_RCM04)
    Flow_Sim_future_2060s_RCM04_monthly_mean(j,1)=nanmean(Flow_Sim_future_2060s_RCM04(j:j+29));
end
Flow_Sim_future_2060s_RCM04_monthly_mean(any(Flow_Sim_future_2060s_RCM04_monthly_mean==0,2))=[];

%% RCM05
Flow_Sim_future_2060s_RCM05_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2060s_RCM05)
    Flow_Sim_future_2060s_RCM05_monthly_mean(j,1)=nanmean(Flow_Sim_future_2060s_RCM05(j:j+29));
end
Flow_Sim_future_2060s_RCM05_monthly_mean(any(Flow_Sim_future_2060s_RCM05_monthly_mean==0,2))=[];

%% RCM06
Flow_Sim_future_2060s_RCM06_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2060s_RCM06)
    Flow_Sim_future_2060s_RCM06_monthly_mean(j,1)=nanmean(Flow_Sim_future_2060s_RCM06(j:j+29));
end
Flow_Sim_future_2060s_RCM06_monthly_mean(any(Flow_Sim_future_2060s_RCM06_monthly_mean==0,2))=[];

%% RCM07
Flow_Sim_future_2060s_RCM07_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2060s_RCM07)
    Flow_Sim_future_2060s_RCM07_monthly_mean(j,1)=nanmean(Flow_Sim_future_2060s_RCM07(j:j+29));
end
Flow_Sim_future_2060s_RCM07_monthly_mean(any(Flow_Sim_future_2060s_RCM07_monthly_mean==0,2))=[];

%% RCM08
Flow_Sim_future_2060s_RCM08_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2060s_RCM08)
    Flow_Sim_future_2060s_RCM08_monthly_mean(j,1)=nanmean(Flow_Sim_future_2060s_RCM08(j:j+29));
end
Flow_Sim_future_2060s_RCM08_monthly_mean(any(Flow_Sim_future_2060s_RCM08_monthly_mean==0,2))=[];

%% RCM09
Flow_Sim_future_2060s_RCM09_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2060s_RCM09)
    Flow_Sim_future_2060s_RCM09_monthly_mean(j,1)=nanmean(Flow_Sim_future_2060s_RCM09(j:j+29));
end
Flow_Sim_future_2060s_RCM09_monthly_mean(any(Flow_Sim_future_2060s_RCM09_monthly_mean==0,2))=[];

%% RCM10
Flow_Sim_future_2060s_RCM10_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2060s_RCM10)
    Flow_Sim_future_2060s_RCM10_monthly_mean(j,1)=nanmean(Flow_Sim_future_2060s_RCM10(j:j+29));
end
Flow_Sim_future_2060s_RCM10_monthly_mean(any(Flow_Sim_future_2060s_RCM10_monthly_mean==0,2))=[];

%% RCM11
Flow_Sim_future_2060s_RCM11_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2060s_RCM11)
    Flow_Sim_future_2060s_RCM11_monthly_mean(j,1)=nanmean(Flow_Sim_future_2060s_RCM11(j:j+29));
end
Flow_Sim_future_2060s_RCM11_monthly_mean(any(Flow_Sim_future_2060s_RCM11_monthly_mean==0,2))=[];

%% RCM12
Flow_Sim_future_2060s_RCM12_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2060s_RCM12)
    Flow_Sim_future_2060s_RCM12_monthly_mean(j,1)=nanmean(Flow_Sim_future_2060s_RCM12(j:j+29));
end
Flow_Sim_future_2060s_RCM12_monthly_mean(any(Flow_Sim_future_2060s_RCM12_monthly_mean==0,2))=[];

%% RCM13
Flow_Sim_future_2060s_RCM13_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2060s_RCM13)
    Flow_Sim_future_2060s_RCM13_monthly_mean(j,1)=nanmean(Flow_Sim_future_2060s_RCM13(j:j+29));
end
Flow_Sim_future_2060s_RCM13_monthly_mean(any(Flow_Sim_future_2060s_RCM13_monthly_mean==0,2))=[];

%% RCM15
Flow_Sim_future_2060s_RCM15_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2060s_RCM15)
    Flow_Sim_future_2060s_RCM15_monthly_mean(j,1)=nanmean(Flow_Sim_future_2060s_RCM15(j:j+29));
end
Flow_Sim_future_2060s_RCM15_monthly_mean(any(Flow_Sim_future_2060s_RCM15_monthly_mean==0,2))=[];

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Get baseline vs future 2040s monthly percentage difference
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Table for differences
Table_monthly=[];
 
for j=1:length(Months_baseline)
    % Baseline info
    Table_monthly{j,1}=Months_baseline(j,:);
    Table_monthly{j,2}=Flow_Obs_baseline_monthly_mean(j,1);
    Table_monthly{j,3}=Months_2040s(j,:);
   
    % Future 2040s info for each RCM
    Table_monthly{j,4}=Flow_Sim_future_2040s_RCM01_monthly_mean(j,1);
    Table_monthly{j,5}=Flow_Sim_future_2040s_RCM04_monthly_mean(j,1);
    Table_monthly{j,6}=Flow_Sim_future_2040s_RCM05_monthly_mean(j,1);
    Table_monthly{j,7}=Flow_Sim_future_2040s_RCM06_monthly_mean(j,1);
    Table_monthly{j,8}=Flow_Sim_future_2040s_RCM07_monthly_mean(j,1);
    Table_monthly{j,9}=Flow_Sim_future_2040s_RCM08_monthly_mean(j,1);
    Table_monthly{j,10}=Flow_Sim_future_2040s_RCM09_monthly_mean(j,1);
    Table_monthly{j,11}=Flow_Sim_future_2040s_RCM10_monthly_mean(j,1);
    Table_monthly{j,12}=Flow_Sim_future_2040s_RCM11_monthly_mean(j,1);
    Table_monthly{j,13}=Flow_Sim_future_2040s_RCM12_monthly_mean(j,1);
    Table_monthly{j,14}=Flow_Sim_future_2040s_RCM13_monthly_mean(j,1);
    Table_monthly{j,15}=Flow_Sim_future_2040s_RCM15_monthly_mean(j,1);

    % Future 2040s info for all RCMS
    Table_monthly{j,16}=Flow_Sim_future_2040s_allRCM_monthly_mean(j,1);

    % Future 2040s info for the differences
    Table_monthly{j,17}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2040s_RCM01_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,18}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2040s_RCM04_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,19}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2040s_RCM05_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,20}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2040s_RCM06_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,21}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2040s_RCM07_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,22}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2040s_RCM08_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,23}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2040s_RCM09_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,24}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2040s_RCM10_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,25}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2040s_RCM11_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,26}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2040s_RCM12_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,27}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2040s_RCM13_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,28}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2040s_RCM15_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;

    % Future 2040s infor for the difference for all RCMs
    Table_monthly{j,29}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2040s_allRCM_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;

    % Same as above, but for the plots
    Flow_diff_monthly_RCM01(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2040s_RCM01_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Flow_diff_monthly_RCM04(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2040s_RCM04_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Flow_diff_monthly_RCM05(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2040s_RCM05_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Flow_diff_monthly_RCM06(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2040s_RCM06_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Flow_diff_monthly_RCM07(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2040s_RCM07_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Flow_diff_monthly_RCM08(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2040s_RCM08_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Flow_diff_monthly_RCM09(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2040s_RCM09_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Flow_diff_monthly_RCM10(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2040s_RCM10_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Flow_diff_monthly_RCM11(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2040s_RCM11_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Flow_diff_monthly_RCM12(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2040s_RCM12_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Flow_diff_monthly_RCM13(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2040s_RCM13_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Flow_diff_monthly_RCM15(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2040s_RCM15_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;

    Flow_diff_monthly_allRCM_2040s(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2040s_allRCM_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
end
    
Table_monthly_header={'Baseline','Baseline monthly mean flows [m^3/s]','RCM01 monthly mean flow [m^3/s]','RCM04 monthly mean flow [m^3/s]','RCM05 monthly mean flow [m^3/s]','RCM06 monthly mean flow [m^3/s]','RCM07 monthly mean flow [m^3/s]','RCM08 monthly mean flow [m^3/s]','RCM09 monthly mean flow [m^3/s]','RCM10 monthly mean flow [m^3/s]','RCM11 monthly mean flow [m^3/s]','RCM12 monthly mean flow [m^3/s]','RCM13 monthly mean flow [m^3/s]','RCM15 monthly mean flow [m^3/s]','All RCM future monthly mean flow [m^3/s]','Baseline-RCM01 [%]','Baseline-RCM04 [%]','Baseline-RCM05 [%]','Baseline-RCM06 [%]','Baseline-RCM07 [%]','Baseline-RCM08 [%]','Baseline-RCM09 [%]','Baseline-RCM10 [%]' ,'Baseline-RCM11 [%]','Baseline-RCM12 [%]','Baseline-RCM13 [%]','Baseline-RCM15 [%]','Baseline mean-Future mean flow [%]'};
 
%Write the table into an excel file
 
if exist(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Station_',no,'_flows_2040s_monthly_vs_baseline.xls'), 'file')==2
   delete(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Station_',no,'_flows_2040s_monthly_vs_baseline.xls'));
end
 
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Station_',no,'_flows_2040s_monthly_vs_baseline.xls'),Table_monthly,'Sheet1','A2');
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Station_',no,'_flows_2040s_monthly_vs_baseline.xls'),Table_monthly_header,'Sheet1','A1');

%% Plot the differences in monthly mean flows
 
No_of_months=[1:length(Months_baseline)];
No_of_months=No_of_months.';
x_max=length(No_of_months);
 
ymin=-300;
ymax=+300;
 
X_line_zero=zeros(length(No_of_months),1);
 
%% Difference in monthly mean flows for RCM01
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2040s\Monthly_mean_flows_diff_RCM01_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2040s monthly mean flows and baseline flows at station no.'," ",no," ",'for RCM01');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Flow_diff_monthly_RCM01);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Difference in monthly mean flows for RCM04
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2040s\Monthly_mean_flows_diff_RCM04_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2040s monthly mean flows and baseline flows at station no.'," ",no," ",'for RCM04');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Flow_diff_monthly_RCM04);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Difference in monthly mean flows for RCM05
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2040s\Monthly_mean_flows_diff_RCM05_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2040s monthly mean flows and baseline flows at station no.'," ",no," ",'for RCM05');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Flow_diff_monthly_RCM05);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Difference in monthly mean flows for RCM06
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2040s\Monthly_mean_flows_diff_RCM06_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2040s monthly mean flows and baseline flows at station no.'," ",no," ",'for RCM06');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Flow_diff_monthly_RCM06);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Difference in monthly mean flows for RCM07
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2040s\Monthly_mean_flows_diff_RCM07_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2040s monthly mean flows and baseline flows at station no.'," ",no," ",'for RCM07');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Flow_diff_monthly_RCM07);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Difference in monthly mean flows for RCM08
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2040s\Monthly_mean_flows_diff_RCM08_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2040s monthly mean flows and baseline flows at station no.'," ",no," ",'for RCM08');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Flow_diff_monthly_RCM08);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Difference in monthly mean flows for RCM09
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2040s\Monthly_mean_flows_diff_RCM09_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2040s monthly mean flows and baseline flows at station no.'," ",no," ",'for RCM09');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Flow_diff_monthly_RCM09);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Difference in monthly mean flows for RCM10
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2040s\Monthly_mean_flows_diff_RCM10_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2040s monthly mean flows and baseline flows at station no.'," ",no," ",'for RCM10');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Flow_diff_monthly_RCM10);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Difference in monthly mean flows for RCM11
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2040s\Monthly_mean_flows_diff_RCM11_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2040s monthly mean flows and baseline flows at station no.'," ",no," ",'for RCM11');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Flow_diff_monthly_RCM11);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Difference in monthly mean flows for RCM12
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2040s\Monthly_mean_flows_diff_RCM12_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2040s monthly mean flows and baseline flows at station no.'," ",no," ",'for RCM12');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Flow_diff_monthly_RCM12);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Difference in monthly mean flows for RCM13
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2040s\Monthly_mean_flows_diff_RCM13_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2040s monthly mean flows and baseline flows at station no.'," ",no," ",'for RCM13');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Flow_diff_monthly_RCM13);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Difference in monthly mean flows for RCM15
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2040s\Monthly_mean_flows_diff_RCM15_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2040s monthly mean flows and baseline flows at station no.'," ",no," ",'for RCM15');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Flow_diff_monthly_RCM15);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Difference in monthly mean flows for all RCMs
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2040s\Monthly_mean_flows_diff_allRCM_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2040s monthly mean flows and baseline flows at station no.'," ",no," ",'for all RCMs');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Flow_diff_monthly_allRCM_2040s);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Get baseline vs future 2060s monthly percentage difference
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Table_monthly=[];
 
for j=1:length(Months_baseline)
    % Baseline info
    Table_monthly{j,1}=Months_baseline(j,:);
    Table_monthly{j,2}=Flow_Obs_baseline_monthly_mean(j,1);
    Table_monthly{j,3}=Months_2060s(j,:);
   
    % Future 2060s info for each RCM
    Table_monthly{j,4}=Flow_Sim_future_2060s_RCM01_monthly_mean(j,1);
    Table_monthly{j,5}=Flow_Sim_future_2060s_RCM04_monthly_mean(j,1);
    Table_monthly{j,6}=Flow_Sim_future_2060s_RCM05_monthly_mean(j,1);
    Table_monthly{j,7}=Flow_Sim_future_2060s_RCM06_monthly_mean(j,1);
    Table_monthly{j,8}=Flow_Sim_future_2060s_RCM07_monthly_mean(j,1);
    Table_monthly{j,9}=Flow_Sim_future_2060s_RCM08_monthly_mean(j,1);
    Table_monthly{j,10}=Flow_Sim_future_2060s_RCM09_monthly_mean(j,1);
    Table_monthly{j,11}=Flow_Sim_future_2060s_RCM10_monthly_mean(j,1);
    Table_monthly{j,12}=Flow_Sim_future_2060s_RCM11_monthly_mean(j,1);
    Table_monthly{j,13}=Flow_Sim_future_2060s_RCM12_monthly_mean(j,1);
    Table_monthly{j,14}=Flow_Sim_future_2060s_RCM13_monthly_mean(j,1);
    Table_monthly{j,15}=Flow_Sim_future_2060s_RCM15_monthly_mean(j,1);

    % Future 2060s info for all RCMS
    Table_monthly{j,16}=Flow_Sim_future_2060s_allRCM_monthly_mean(j,1);

    % Future 2060s info for the differences
    Table_monthly{j,17}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2060s_RCM01_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,18}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2060s_RCM04_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,19}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2060s_RCM05_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,20}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2060s_RCM06_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,21}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2060s_RCM07_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,22}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2060s_RCM08_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,23}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2060s_RCM09_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,24}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2060s_RCM10_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,25}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2060s_RCM11_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,26}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2060s_RCM12_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,27}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2060s_RCM13_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,28}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2060s_RCM15_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;

    % Future 2060s infor for the difference for all RCMs
    Table_monthly{j,29}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2060s_allRCM_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;

    % Same as above, but for the plots
    Flow_diff_monthly_RCM01(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2060s_RCM01_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Flow_diff_monthly_RCM04(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2060s_RCM04_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Flow_diff_monthly_RCM05(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2060s_RCM05_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Flow_diff_monthly_RCM06(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2060s_RCM06_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Flow_diff_monthly_RCM07(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2060s_RCM07_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Flow_diff_monthly_RCM08(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2060s_RCM08_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Flow_diff_monthly_RCM09(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2060s_RCM09_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Flow_diff_monthly_RCM10(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2060s_RCM10_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Flow_diff_monthly_RCM11(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2060s_RCM11_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Flow_diff_monthly_RCM12(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2060s_RCM12_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Flow_diff_monthly_RCM13(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2060s_RCM13_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Flow_diff_monthly_RCM15(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2060s_RCM15_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;

    Flow_diff_monthly_allRCM_2060s(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2060s_allRCM_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
end
    
Table_monthly_header={'Baseline','Baseline monthly mean flows [m^3/s]','Future','RCM01 monthly mean flow [m^3/s]','RCM04 monthly mean flow [m^3/s]','RCM05 monthly mean flow [m^3/s]','RCM06 monthly mean flow [m^3/s]','RCM07 monthly mean flow [m^3/s]','RCM08 monthly mean flow [m^3/s]','RCM09 monthly mean flow [m^3/s]','RCM10 monthly mean flow [m^3/s]','RCM11 monthly mean flow [m^3/s]','RCM12 monthly mean flow [m^3/s]','RCM13 monthly mean flow [m^3/s]','RCM15 monthly mean flow [m^3/s]','All RCM future monthly mean flow [m^3/s]','Baseline-RCM01 [%]','Baseline-RCM04 [%]','Baseline-RCM05 [%]','Baseline-RCM06 [%]','Baseline-RCM07 [%]','Baseline-RCM08 [%]','Baseline-RCM09 [%]','Baseline-RCM10 [%]' ,'Baseline-RCM11 [%]','Baseline-RCM12 [%]','Baseline-RCM13 [%]','Baseline-RCM15 [%]','Baseline mean-Future mean flow [%]'};
 
%Write the table into an excel file
 
if exist(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Station_',no,'_flows_2060s_monthly_vs_baseline.xls'), 'file')==2
   delete(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Station_',no,'_flows_2060s_monthly_vs_baseline.xls'));
end
 
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Station_',no,'_flows_2060s_monthly_vs_baseline.xls'),Table_monthly,'Sheet1','A2');
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Station_',no,'_flows_2060s_monthly_vs_baseline.xls'),Table_monthly_header,'Sheet1','A1');

%% Plot the differences in monthly mean flows
 
No_of_months=[1:length(Months_baseline)];
No_of_months=No_of_months.';
x_max=length(No_of_months);
 
ymin=-300;
ymax=+300;
 
X_line_zero=zeros(length(No_of_months),1);
 
%% Difference in monthly mean flows for RCM01
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2060s\Monthly_mean_flows_diff_RCM01_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2060s monthly mean flows and baseline flows at station no.'," ",no," ",'for RCM01');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Flow_diff_monthly_RCM01);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Difference in monthly mean flows for RCM04
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2060s\Monthly_mean_flows_diff_RCM04_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2060s monthly mean flows and baseline flows at station no.'," ",no," ",'for RCM04');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Flow_diff_monthly_RCM04);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Difference in monthly mean flows for RCM05
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2060s\Monthly_mean_flows_diff_RCM05_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2060s monthly mean flows and baseline flows at station no.'," ",no," ",'for RCM05');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Flow_diff_monthly_RCM05);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Difference in monthly mean flows for RCM06
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2060s\Monthly_mean_flows_diff_RCM06_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2060s monthly mean flows and baseline flows at station no.'," ",no," ",'for RCM06');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Flow_diff_monthly_RCM06);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Difference in monthly mean flows for RCM07
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2060s\Monthly_mean_flows_diff_RCM07_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2060s monthly mean flows and baseline flows at station no.'," ",no," ",'for RCM07');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Flow_diff_monthly_RCM07);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Difference in monthly mean flows for RCM08
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2060s\Monthly_mean_flows_diff_RCM08_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2060s monthly mean flows and baseline flows at station no.'," ",no," ",'for RCM08');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Flow_diff_monthly_RCM08);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Difference in monthly mean flows for RCM09
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2060s\Monthly_mean_flows_diff_RCM09_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2060s monthly mean flows and baseline flows at station no.'," ",no," ",'for RCM09');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Flow_diff_monthly_RCM09);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Difference in monthly mean flows for RCM10
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2060s\Monthly_mean_flows_diff_RCM10_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2060s monthly mean flows and baseline flows at station no.'," ",no," ",'for RCM10');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Flow_diff_monthly_RCM10);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Difference in monthly mean flows for RCM11
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2060s\Monthly_mean_flows_diff_RCM11_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2060s monthly mean flows and baseline flows at station no.'," ",no," ",'for RCM11');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Flow_diff_monthly_RCM11);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Difference in monthly mean flows for RCM12
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2060s\Monthly_mean_flows_diff_RCM12_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2060s monthly mean flows and baseline flows at station no.'," ",no," ",'for RCM12');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Flow_diff_monthly_RCM12);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Difference in monthly mean flows for RCM13
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2060s\Monthly_mean_flows_diff_RCM13_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2060s monthly mean flows and baseline flows at station no.'," ",no," ",'for RCM13');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Flow_diff_monthly_RCM13);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Difference in monthly mean flows for RCM15
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2060s\Monthly_mean_flows_diff_RCM15_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2060s monthly mean flows and baseline flows at station no.'," ",no," ",'for RCM15');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Flow_diff_monthly_RCM15);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Difference in monthly mean flows for all RCMs
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2060s\Monthly_mean_flows_diff_allRCM_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2060s monthly mean flows and baseline flows at station no.'," ",no," ",'for all RCMs');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Flow_diff_monthly_allRCM_2060s);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);


%% Get annual baseline flows
Table_baseline=[];
Annual_values_baseline_mean=[];

Table_baseline=Time_Obs_baseline;
Table_baseline=timetable(Time_Obs_baseline,Flow_Obs_baseline);

Annual_values_baseline_mean=convert2annual(Table_baseline,'Aggregation',["mean"]);
Flow_Obs_baseline_annual_mean=Annual_values_baseline_mean;

Flow_Obs_baseline_annual_mean=table2array(Flow_Obs_baseline_annual_mean);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Get annual future 2040s mean flows
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Calculate the mean annual flow considering all the RCMs
%% All RCMs
Flow_Sim_future_2040s_allRCM_annual_mean=[];

for j=1:360:length(Flow_Sim_future_2040s_allRCM)
    Flow_Sim_future_2040s_allRCM_annual_mean(j,1)=nanmean(Flow_Sim_future_2040s_allRCM(j:j+359));
end
Flow_Sim_future_2040s_allRCM_annual_mean(any(Flow_Sim_future_2040s_allRCM_annual_mean==0,2))=[];

%% RCM01
Flow_Sim_future_2040s_RCM01_annual_mean=[];
 
for j=1:360:length(Flow_Sim_future_2040s_RCM01)
    Flow_Sim_future_2040s_RCM01_annual_mean(j,1)=nanmean(Flow_Sim_future_2040s_RCM01(j:j+359));
end
Flow_Sim_future_2040s_RCM01_annual_mean(any(Flow_Sim_future_2040s_RCM01_annual_mean==0,2))=[];

%% RCM04
Flow_Sim_future_2040s_RCM04_annual_mean=[];
 
for j=1:360:length(Flow_Sim_future_2040s_RCM04)
    Flow_Sim_future_2040s_RCM04_annual_mean(j,1)=nanmean(Flow_Sim_future_2040s_RCM04(j:j+359));
end
Flow_Sim_future_2040s_RCM04_annual_mean(any(Flow_Sim_future_2040s_RCM04_annual_mean==0,2))=[];

%% RCM05
Flow_Sim_future_2040s_RCM05_annual_mean=[];
 
for j=1:360:length(Flow_Sim_future_2040s_RCM05)
    Flow_Sim_future_2040s_RCM05_annual_mean(j,1)=nanmean(Flow_Sim_future_2040s_RCM05(j:j+359));
end
Flow_Sim_future_2040s_RCM05_annual_mean(any(Flow_Sim_future_2040s_RCM05_annual_mean==0,2))=[];

%% RCM06
Flow_Sim_future_2040s_RCM06_annual_mean=[];
 
for j=1:360:length(Flow_Sim_future_2040s_RCM06)
    Flow_Sim_future_2040s_RCM06_annual_mean(j,1)=nanmean(Flow_Sim_future_2040s_RCM06(j:j+359));
end
Flow_Sim_future_2040s_RCM06_annual_mean(any(Flow_Sim_future_2040s_RCM06_annual_mean==0,2))=[];

%% RCM07
Flow_Sim_future_2040s_RCM07_annual_mean=[];
 
for j=1:360:length(Flow_Sim_future_2040s_RCM07)
    Flow_Sim_future_2040s_RCM07_annual_mean(j,1)=nanmean(Flow_Sim_future_2040s_RCM07(j:j+359));
end
Flow_Sim_future_2040s_RCM07_annual_mean(any(Flow_Sim_future_2040s_RCM07_annual_mean==0,2))=[];

%% RCM08
Flow_Sim_future_2040s_RCM08_annual_mean=[];
 
for j=1:360:length(Flow_Sim_future_2040s_RCM08)
    Flow_Sim_future_2040s_RCM08_annual_mean(j,1)=nanmean(Flow_Sim_future_2040s_RCM08(j:j+359));
end
Flow_Sim_future_2040s_RCM08_annual_mean(any(Flow_Sim_future_2040s_RCM08_annual_mean==0,2))=[];

%% RCM09
Flow_Sim_future_2040s_RCM09_annual_mean=[];
 
for j=1:360:length(Flow_Sim_future_2040s_RCM09)
    Flow_Sim_future_2040s_RCM09_annual_mean(j,1)=nanmean(Flow_Sim_future_2040s_RCM09(j:j+359));
end
Flow_Sim_future_2040s_RCM09_annual_mean(any(Flow_Sim_future_2040s_RCM09_annual_mean==0,2))=[];

%% RCM10
Flow_Sim_future_2040s_RCM10_annual_mean=[];
 
for j=1:360:length(Flow_Sim_future_2040s_RCM10)
    Flow_Sim_future_2040s_RCM10_annual_mean(j,1)=nanmean(Flow_Sim_future_2040s_RCM10(j:j+359));
end
Flow_Sim_future_2040s_RCM10_annual_mean(any(Flow_Sim_future_2040s_RCM10_annual_mean==0,2))=[];

%% RCM11
Flow_Sim_future_2040s_RCM11_annual_mean=[];
 
for j=1:360:length(Flow_Sim_future_2040s_RCM11)
    Flow_Sim_future_2040s_RCM11_annual_mean(j,1)=nanmean(Flow_Sim_future_2040s_RCM11(j:j+359));
end
Flow_Sim_future_2040s_RCM11_annual_mean(any(Flow_Sim_future_2040s_RCM11_annual_mean==0,2))=[];

%% RCM12
Flow_Sim_future_2040s_RCM12_annual_mean=[];
 
for j=1:360:length(Flow_Sim_future_2040s_RCM12)
    Flow_Sim_future_2040s_RCM12_annual_mean(j,1)=nanmean(Flow_Sim_future_2040s_RCM12(j:j+359));
end
Flow_Sim_future_2040s_RCM12_annual_mean(any(Flow_Sim_future_2040s_RCM12_annual_mean==0,2))=[];

%% RCM13
Flow_Sim_future_2040s_RCM13_annual_mean=[];
 
for j=1:360:length(Flow_Sim_future_2040s_RCM13)
    Flow_Sim_future_2040s_RCM13_annual_mean(j,1)=nanmean(Flow_Sim_future_2040s_RCM13(j:j+359));
end
Flow_Sim_future_2040s_RCM13_annual_mean(any(Flow_Sim_future_2040s_RCM13_annual_mean==0,2))=[];

%% RCM15
Flow_Sim_future_2040s_RCM15_annual_mean=[];
 
for j=1:360:length(Flow_Sim_future_2040s_RCM15)
    Flow_Sim_future_2040s_RCM15_annual_mean(j,1)=nanmean(Flow_Sim_future_2040s_RCM15(j:j+359));
end
Flow_Sim_future_2040s_RCM15_annual_mean(any(Flow_Sim_future_2040s_RCM15_annual_mean==0,2))=[];

%% Get annual future 2060s mean flows
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Calculate the mean annual flow considering all the RCMs
%% All RCMs
Flow_Sim_future_2060s_allRCM_annual_mean=[];

for j=1:360:length(Flow_Sim_future_2060s_allRCM)
    Flow_Sim_future_2060s_allRCM_annual_mean(j,1)=nanmean(Flow_Sim_future_2060s_allRCM(j:j+359));
end
Flow_Sim_future_2060s_allRCM_annual_mean(any(Flow_Sim_future_2060s_allRCM_annual_mean==0,2))=[];

%% RCM01
Flow_Sim_future_2060s_RCM01_annual_mean=[];
 
for j=1:360:length(Flow_Sim_future_2060s_RCM01)
    Flow_Sim_future_2060s_RCM01_annual_mean(j,1)=nanmean(Flow_Sim_future_2060s_RCM01(j:j+359));
end
Flow_Sim_future_2060s_RCM01_annual_mean(any(Flow_Sim_future_2060s_RCM01_annual_mean==0,2))=[];

%% RCM04
Flow_Sim_future_2060s_RCM04_annual_mean=[];
 
for j=1:360:length(Flow_Sim_future_2060s_RCM04)
    Flow_Sim_future_2060s_RCM04_annual_mean(j,1)=nanmean(Flow_Sim_future_2060s_RCM04(j:j+359));
end
Flow_Sim_future_2060s_RCM04_annual_mean(any(Flow_Sim_future_2060s_RCM04_annual_mean==0,2))=[];

%% RCM05
Flow_Sim_future_2060s_RCM05_annual_mean=[];
 
for j=1:360:length(Flow_Sim_future_2060s_RCM05)
    Flow_Sim_future_2060s_RCM05_annual_mean(j,1)=nanmean(Flow_Sim_future_2060s_RCM05(j:j+359));
end
Flow_Sim_future_2060s_RCM05_annual_mean(any(Flow_Sim_future_2060s_RCM05_annual_mean==0,2))=[];

%% RCM06
Flow_Sim_future_2060s_RCM06_annual_mean=[];
 
for j=1:360:length(Flow_Sim_future_2060s_RCM06)
    Flow_Sim_future_2060s_RCM06_annual_mean(j,1)=nanmean(Flow_Sim_future_2060s_RCM06(j:j+359));
end
Flow_Sim_future_2060s_RCM06_annual_mean(any(Flow_Sim_future_2060s_RCM06_annual_mean==0,2))=[];

%% RCM07
Flow_Sim_future_2060s_RCM07_annual_mean=[];
 
for j=1:360:length(Flow_Sim_future_2060s_RCM07)
    Flow_Sim_future_2060s_RCM07_annual_mean(j,1)=nanmean(Flow_Sim_future_2060s_RCM07(j:j+359));
end
Flow_Sim_future_2060s_RCM07_annual_mean(any(Flow_Sim_future_2060s_RCM07_annual_mean==0,2))=[];

%% RCM08
Flow_Sim_future_2060s_RCM08_annual_mean=[];
 
for j=1:360:length(Flow_Sim_future_2060s_RCM08)
    Flow_Sim_future_2060s_RCM08_annual_mean(j,1)=nanmean(Flow_Sim_future_2060s_RCM08(j:j+359));
end
Flow_Sim_future_2060s_RCM08_annual_mean(any(Flow_Sim_future_2060s_RCM08_annual_mean==0,2))=[];

%% RCM09
Flow_Sim_future_2060s_RCM09_annual_mean=[];
 
for j=1:360:length(Flow_Sim_future_2060s_RCM09)
    Flow_Sim_future_2060s_RCM09_annual_mean(j,1)=nanmean(Flow_Sim_future_2060s_RCM09(j:j+359));
end
Flow_Sim_future_2060s_RCM09_annual_mean(any(Flow_Sim_future_2060s_RCM09_annual_mean==0,2))=[];

%% RCM10
Flow_Sim_future_2060s_RCM10_annual_mean=[];
 
for j=1:360:length(Flow_Sim_future_2060s_RCM10)
    Flow_Sim_future_2060s_RCM10_annual_mean(j,1)=nanmean(Flow_Sim_future_2060s_RCM10(j:j+359));
end
Flow_Sim_future_2060s_RCM10_annual_mean(any(Flow_Sim_future_2060s_RCM10_annual_mean==0,2))=[];

%% RCM11
Flow_Sim_future_2060s_RCM11_annual_mean=[];
 
for j=1:360:length(Flow_Sim_future_2060s_RCM11)
    Flow_Sim_future_2060s_RCM11_annual_mean(j,1)=nanmean(Flow_Sim_future_2060s_RCM11(j:j+359));
end
Flow_Sim_future_2060s_RCM11_annual_mean(any(Flow_Sim_future_2060s_RCM11_annual_mean==0,2))=[];

%% RCM12
Flow_Sim_future_2060s_RCM12_annual_mean=[];
 
for j=1:360:length(Flow_Sim_future_2060s_RCM12)
    Flow_Sim_future_2060s_RCM12_annual_mean(j,1)=nanmean(Flow_Sim_future_2060s_RCM12(j:j+359));
end
Flow_Sim_future_2060s_RCM12_annual_mean(any(Flow_Sim_future_2060s_RCM12_annual_mean==0,2))=[];

%% RCM13
Flow_Sim_future_2060s_RCM13_annual_mean=[];
 
for j=1:360:length(Flow_Sim_future_2060s_RCM13)
    Flow_Sim_future_2060s_RCM13_annual_mean(j,1)=nanmean(Flow_Sim_future_2060s_RCM13(j:j+359));
end
Flow_Sim_future_2060s_RCM13_annual_mean(any(Flow_Sim_future_2060s_RCM13_annual_mean==0,2))=[];

%% RCM15
Flow_Sim_future_2060s_RCM15_annual_mean=[];
 
for j=1:360:length(Flow_Sim_future_2060s_RCM15)
    Flow_Sim_future_2060s_RCM15_annual_mean(j,1)=nanmean(Flow_Sim_future_2060s_RCM15(j:j+359));
end
Flow_Sim_future_2060s_RCM15_annual_mean(any(Flow_Sim_future_2060s_RCM15_annual_mean==0,2))=[];

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Get baseline vs future 2040s annual percentage difference
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Table for the differences
Table_annual=[];
 
for j=1:length(Years_baseline)
    % Baseline info
    Table_annual{j,1}=Years_baseline(j,:);
    Table_annual{j,2}=Flow_Obs_baseline_annual_mean(j,1);
    Table_annual{j,3}=Years_2040s(j,:);
   
    % Future 2040s info for each RCM
    Table_annual{j,4}=Flow_Sim_future_2040s_RCM01_annual_mean(j,1);
    Table_annual{j,5}=Flow_Sim_future_2040s_RCM04_annual_mean(j,1);
    Table_annual{j,6}=Flow_Sim_future_2040s_RCM05_annual_mean(j,1);
    Table_annual{j,7}=Flow_Sim_future_2040s_RCM06_annual_mean(j,1);
    Table_annual{j,8}=Flow_Sim_future_2040s_RCM07_annual_mean(j,1);
    Table_annual{j,9}=Flow_Sim_future_2040s_RCM08_annual_mean(j,1);
    Table_annual{j,10}=Flow_Sim_future_2040s_RCM09_annual_mean(j,1);
    Table_annual{j,11}=Flow_Sim_future_2040s_RCM10_annual_mean(j,1);
    Table_annual{j,12}=Flow_Sim_future_2040s_RCM11_annual_mean(j,1);
    Table_annual{j,13}=Flow_Sim_future_2040s_RCM12_annual_mean(j,1);
    Table_annual{j,14}=Flow_Sim_future_2040s_RCM13_annual_mean(j,1);
    Table_annual{j,15}=Flow_Sim_future_2040s_RCM15_annual_mean(j,1);

    % Future 2040s info for all RCMS
    Table_annual{j,16}=Flow_Sim_future_2040s_allRCM_annual_mean(j,1);

    % Future 2040s info for the differences
    Table_annual{j,17}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2040s_RCM01_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Table_annual{j,18}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2040s_RCM04_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Table_annual{j,19}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2040s_RCM05_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Table_annual{j,20}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2040s_RCM06_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Table_annual{j,21}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2040s_RCM07_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Table_annual{j,22}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2040s_RCM08_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Table_annual{j,23}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2040s_RCM09_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Table_annual{j,24}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2040s_RCM10_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Table_annual{j,25}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2040s_RCM11_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Table_annual{j,26}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2040s_RCM12_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Table_annual{j,27}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2040s_RCM13_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Table_annual{j,28}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2040s_RCM15_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;

    % Future 2040s infor for the difference for all RCMs
    Table_annual{j,29}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2040s_allRCM_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;

    % Same as above, but for the plots
    Flow_diff_annual_RCM01(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2040s_RCM01_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Flow_diff_annual_RCM04(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2040s_RCM04_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Flow_diff_annual_RCM05(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2040s_RCM05_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Flow_diff_annual_RCM06(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2040s_RCM06_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Flow_diff_annual_RCM07(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2040s_RCM07_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Flow_diff_annual_RCM08(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2040s_RCM08_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Flow_diff_annual_RCM09(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2040s_RCM09_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Flow_diff_annual_RCM10(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2040s_RCM10_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Flow_diff_annual_RCM11(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2040s_RCM11_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Flow_diff_annual_RCM12(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2040s_RCM12_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Flow_diff_annual_RCM13(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2040s_RCM13_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Flow_diff_annual_RCM15(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2040s_RCM15_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;

    Flow_diff_annual_allRCM_2040s(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2040s_allRCM_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
end
    
Table_annual_header={'Baseline','Baseline annual mean flows [m^3/s]','Future','RCM01 annual mean flow [m^3/s]','RCM04 annual mean flow [m^3/s]','RCM05 annual mean flow [m^3/s]','RCM06 annual mean flow [m^3/s]','RCM07 annual mean flow [m^3/s]','RCM08 annual mean flow [m^3/s]','RCM09 annual mean flow [m^3/s]','RCM10 annual mean flow [m^3/s]','RCM11 annual mean flow [m^3/s]','RCM12 annual mean flow [m^3/s]','RCM13 annual mean flow [m^3/s]','RCM15 annual mean flow [m^3/s]','All RCM future annual mean flow [m^3/s]','Baseline-RCM01 [%]','Baseline-RCM04 [%]','Baseline-RCM05 [%]','Baseline-RCM06 [%]','Baseline-RCM07 [%]','Baseline-RCM08 [%]','Baseline-RCM09 [%]','Baseline-RCM10 [%]' ,'Baseline-RCM11 [%]','Baseline-RCM12 [%]','Baseline-RCM13 [%]','Baseline-RCM15 [%]','Baseline annual mean-Future annual mean flow [%]'};
 
%Write the table into an excel file
 
if exist(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Station_',no,'_flows_2040s_annual_vs_baseline.xls'), 'file')==2
   delete(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Station_',no,'_flows_2040s_annual_vs_baseline.xls'));
end
 
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Station_',no,'_flows_2040s_annual_vs_baseline.xls'),Table_annual,'Sheet1','A2');
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Station_',no,'_flows_2040s_annual_vs_baseline.xls'),Table_annual_header,'Sheet1','A1');

%% Plot the differences in annual mean flows

No_of_years=[1:length(Years_baseline)];
No_of_years=No_of_years.';

x_max=length(No_of_years);
 
ymin=-300;
ymax=+300;
 
X_line_zero=zeros(length(No_of_years),1);

%% Difference in annual mean flows for RCM01
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2040s\Annual_mean_flows_diff_RCM01_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2040s annual mean flows and baseline flows at station no.'," ",no," ",'for RCM01');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Flow_diff_annual_RCM01);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Plot the 2040s annual mean flows vs baseline mean flows for RCM01 as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2040s\Future_2040s_RCM01_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2040s annual mean flows vs baseline annual mean flows at station no.'," ",no," ",'for RCM01');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2040s_RCM01_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean flow [m^3/s]','Future 2040s annual mean flow [m^3/s]','Location','northeast');

if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Difference in annual mean flows for RCM04
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2040s\Annual_mean_flows_diff_RCM04_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2040s annual mean flows and baseline flows at station no.'," ",no," ",'for RCM04');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Flow_diff_annual_RCM04);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Plot the 2040s annual mean flows vs baseline mean flows for RCM04 as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2040s\Future_2040s_RCM04_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2040s annual mean flows vs baseline annual mean flows at station no.'," ",no," ",'for RCM04');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2040s_RCM04_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean flow [m^3/s]','Future 2040s annual mean flow [m^3/s]','Location','northeast');

if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Difference in annual mean flows for RCM05
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2040s\Annual_mean_flows_diff_RCM05_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2040s annual mean flows and baseline flows at station no.'," ",no," ",'for RCM05');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Flow_diff_annual_RCM05);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Plot the 2040s annual mean flows vs baseline mean flows for RCM05 as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2040s\Future_2040s_RCM05_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2040s annual mean flows vs baseline annual mean flows at station no.'," ",no," ",'for RCM05');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2040s_RCM05_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean flow [m^3/s]','Future 2040s annual mean flow [m^3/s]','Location','northeast');

if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Difference in annual mean flows for RCM06
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2040s\Annual_mean_flows_diff_RCM06_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2040s annual mean flows and baseline flows at station no.'," ",no," ",'for RCM06');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Flow_diff_annual_RCM06);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Plot the 2040s annual mean flows vs baseline mean flows for RCM06 as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2040s\Future_2040s_RCM06_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2040s annual mean flows vs baseline annual mean flows at station no.'," ",no," ",'for RCM06');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2040s_RCM06_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean flow [m^3/s]','Future 2040s annual mean flow [m^3/s]','Location','northeast');

if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Difference in annual mean flows for RCM07
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2040s\Annual_mean_flows_diff_RCM07_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2040s annual mean flows and baseline flows at station no.'," ",no," ",'for RCM07');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Flow_diff_annual_RCM07);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Plot the 2040s annual mean flows vs baseline mean flows for RCM07 as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2040s\Future_2040s_RCM07_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2040s annual mean flows vs baseline annual mean flows at station no.'," ",no," ",'for RCM07');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2040s_RCM07_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean flow [m^3/s]','Future 2040s annual mean flow [m^3/s]','Location','northeast');

if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Difference in annual mean flows for RCM08
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2040s\Annual_mean_flows_diff_RCM08_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2040s annual mean flows and baseline flows at station no.'," ",no," ",'for RCM08');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Flow_diff_annual_RCM08);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Plot the 2040s annual mean flows vs baseline mean flows for RCM08 as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2040s\Future_2040s_RCM08_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2040s annual mean flows vs baseline annual mean flows at station no.'," ",no," ",'for RCM08');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2040s_RCM08_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean flow [m^3/s]','Future 2040s annual mean flow [m^3/s]','Location','northeast');

if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Difference in annual mean flows for RCM09
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2040s\Annual_mean_flows_diff_RCM09_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2040s annual mean flows and baseline flows at station no.'," ",no," ",'for RCM09');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Flow_diff_annual_RCM09);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Plot the 2040s annual mean flows vs baseline mean flows for RCM09 as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2040s\Future_2040s_RCM09_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2040s annual mean flows vs baseline annual mean flows at station no.'," ",no," ",'for RCM09');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2040s_RCM09_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean flow [m^3/s]','Future 2040s annual mean flow [m^3/s]','Location','northeast');

if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Difference in annual mean flows for RCM10
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2040s\Annual_mean_flows_diff_RCM10_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2040s annual mean flows and baseline flows at station no.'," ",no," ",'for RCM10');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Flow_diff_annual_RCM10);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Plot the 2040s annual mean flows vs baseline mean flows for RCM10 as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2040s\Future_2040s_RCM10_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2040s annual mean flows vs baseline annual mean flows at station no.'," ",no," ",'for RCM10');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2040s_RCM10_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean flow [m^3/s]','Future 2040s annual mean flow [m^3/s]','Location','northeast');

if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Difference in annual mean flows for RCM11
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2040s\Annual_mean_flows_diff_RCM11_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2040s annual mean flows and baseline flows at station no.'," ",no," ",'for RCM11');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Flow_diff_annual_RCM11);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Plot the 2040s annual mean flows vs baseline mean flows for RCM11 as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2040s\Future_2040s_RCM11_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2040s annual mean flows vs baseline annual mean flows at station no.'," ",no," ",'for RCM11');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2040s_RCM11_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean flow [m^3/s]','Future 2040s annual mean flow [m^3/s]','Location','northeast');

if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Difference in annual mean flows for RCM12
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2040s\Annual_mean_flows_diff_RCM12_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2040s annual mean flows and baseline flows at station no.'," ",no," ",'for RCM12');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Flow_diff_annual_RCM12);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Plot the 2040s annual mean flows vs baseline mean flows for RCM12 as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2040s\Future_2040s_RCM12_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2040s annual mean flows vs baseline annual mean flows at station no.'," ",no," ",'for RCM12');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2040s_RCM12_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean flow [m^3/s]','Future 2040s annual mean flow [m^3/s]','Location','northeast');

if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Difference in annual mean flows for RCM13
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2040s\Annual_mean_flows_diff_RCM13_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2040s annual mean flows and baseline flows at station no.'," ",no," ",'for RCM13');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Flow_diff_annual_RCM13);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Plot the 2040s annual mean flows vs baseline mean flows for RCM13 as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2040s\Future_2040s_RCM13_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2040s annual mean flows vs baseline annual mean flows at station no.'," ",no," ",'for RCM13');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2040s_RCM13_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean flow [m^3/s]','Future 2040s annual mean flow [m^3/s]','Location','northeast');

if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Difference in annual mean flows for RCM15
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2040s\Annual_mean_flows_diff_RCM15_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2040s annual mean flows and baseline flows at station no.'," ",no," ",'for RCM15');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Flow_diff_annual_RCM15);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Plot the 2040s annual mean flows vs baseline mean flows for RCM15 as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2040s\Future_2040s_RCM15_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2040s annual mean flows vs baseline annual mean flows at station no.'," ",no," ",'for RCM15');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2040s_RCM15_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean flow [m^3/s]','Future 2040s annual mean flow [m^3/s]','Location','northeast');

if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Difference in annual mean flows for all RCMs
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2040s\Annual_mean_flows_diff_allRCM_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2040s annual mean flows and baseline flows at station no.'," ",no," ",'for all RCMs');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Flow_diff_annual_allRCM_2040s);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Plot the 2040s annual mean flows vs baseline mean flows for all RCMs as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2040s\Future_2040s_allRCM_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2040s annual mean flows vs baseline annual mean flows at station no.'," ",no," ",'for all RCMs');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2040s_allRCM_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean flow [m^3/s]','Future 2040s annual mean flow [m^3/s]','Location','northeast');

if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Get baseline vs future 2060s annual percentage difference
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Table for the differences
Table_annual=[];
 
for j=1:length(Years_baseline)
    % Baseline info
    Table_annual{j,1}=Years_baseline(j,:);
    Table_annual{j,2}=Flow_Obs_baseline_annual_mean(j,1);
    Table_annual{j,3}=Years_2060s(j,:);
   
    % Future 2060s info for each RCM
    Table_annual{j,4}=Flow_Sim_future_2060s_RCM01_annual_mean(j,1);
    Table_annual{j,5}=Flow_Sim_future_2060s_RCM04_annual_mean(j,1);
    Table_annual{j,6}=Flow_Sim_future_2060s_RCM05_annual_mean(j,1);
    Table_annual{j,7}=Flow_Sim_future_2060s_RCM06_annual_mean(j,1);
    Table_annual{j,8}=Flow_Sim_future_2060s_RCM07_annual_mean(j,1);
    Table_annual{j,9}=Flow_Sim_future_2060s_RCM08_annual_mean(j,1);
    Table_annual{j,10}=Flow_Sim_future_2060s_RCM09_annual_mean(j,1);
    Table_annual{j,11}=Flow_Sim_future_2060s_RCM10_annual_mean(j,1);
    Table_annual{j,12}=Flow_Sim_future_2060s_RCM11_annual_mean(j,1);
    Table_annual{j,13}=Flow_Sim_future_2060s_RCM12_annual_mean(j,1);
    Table_annual{j,14}=Flow_Sim_future_2060s_RCM13_annual_mean(j,1);
    Table_annual{j,15}=Flow_Sim_future_2060s_RCM15_annual_mean(j,1);

    % Future 2060s info for all RCMS
    Table_annual{j,16}=Flow_Sim_future_2060s_allRCM_annual_mean(j,1);

    % Future 2060s info for the differences
    Table_annual{j,17}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2060s_RCM01_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Table_annual{j,18}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2060s_RCM04_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Table_annual{j,19}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2060s_RCM05_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Table_annual{j,20}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2060s_RCM06_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Table_annual{j,21}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2060s_RCM07_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Table_annual{j,22}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2060s_RCM08_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Table_annual{j,23}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2060s_RCM09_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Table_annual{j,24}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2060s_RCM10_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Table_annual{j,25}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2060s_RCM11_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Table_annual{j,26}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2060s_RCM12_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Table_annual{j,27}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2060s_RCM13_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Table_annual{j,28}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2060s_RCM15_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;

    % Future 2060s infor for the difference for all RCMs
    Table_annual{j,29}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2060s_allRCM_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;

    % Same as above, but for the plots
    Flow_diff_annual_RCM01(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2060s_RCM01_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Flow_diff_annual_RCM04(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2060s_RCM04_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Flow_diff_annual_RCM05(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2060s_RCM05_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Flow_diff_annual_RCM06(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2060s_RCM06_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Flow_diff_annual_RCM07(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2060s_RCM07_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Flow_diff_annual_RCM08(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2060s_RCM08_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Flow_diff_annual_RCM09(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2060s_RCM09_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Flow_diff_annual_RCM10(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2060s_RCM10_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Flow_diff_annual_RCM11(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2060s_RCM11_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Flow_diff_annual_RCM12(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2060s_RCM12_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Flow_diff_annual_RCM13(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2060s_RCM13_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Flow_diff_annual_RCM15(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2060s_RCM15_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;

    Flow_diff_annual_allRCM_2060s(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2060s_allRCM_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
end
    
Table_annual_header={'Baseline','Baseline annual mean flows [m^3/s]','RCM01 annual mean flow [m^3/s]','RCM04 annual mean flow [m^3/s]','RCM05 annual mean flow [m^3/s]','RCM06 annual mean flow [m^3/s]','RCM07 annual mean flow [m^3/s]','RCM08 annual mean flow [m^3/s]','RCM09 annual mean flow [m^3/s]','RCM10 annual mean flow [m^3/s]','RCM11 annual mean flow [m^3/s]','RCM12 annual mean flow [m^3/s]','RCM13 annual mean flow [m^3/s]','RCM15 annual mean flow [m^3/s]','All RCM future annual mean flow [m^3/s]','Baseline-RCM01 [%]','Baseline-RCM04 [%]','Baseline-RCM05 [%]','Baseline-RCM06 [%]','Baseline-RCM07 [%]','Baseline-RCM08 [%]','Baseline-RCM09 [%]','Baseline-RCM10 [%]' ,'Baseline-RCM11 [%]','Baseline-RCM12 [%]','Baseline-RCM13 [%]','Baseline-RCM15 [%]','Baseline annual mean-Future annual mean flow [%]'};
%Write the table into an excel file
 
if exist(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Station_',no,'_flows_2060s_annual_vs_baseline.xls'), 'file')==2
   delete(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Station_',no,'_flows_2060s_annual_vs_baseline.xls'));
end
 
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Station_',no,'_flows_2060s_annual_vs_baseline.xls'),Table_annual,'Sheet1','A2');
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Station_',no,'_flows_2060s_annual_vs_baseline.xls'),Table_annual_header,'Sheet1','A1');

%% Plot the differences in annual mean flows

No_of_years=[1:length(Years_baseline)];
No_of_years=No_of_years.';

x_max=length(No_of_years);
 
ymin=-300;
ymax=+300;
 
X_line_zero=zeros(length(No_of_years),1);

%% Difference in annual mean flows for RCM01
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2060s\Annual_mean_flows_diff_RCM01_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2060s annual mean flows and baseline flows at station no.'," ",no," ",'for RCM01');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Flow_diff_annual_RCM01);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Plot the 2060s annual mean flows vs baseline mean flows for RCM01 as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2060s\Future_2060s_RCM01_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2060s annual mean flows vs baseline annual mean flows at station no.'," ",no," ",'for RCM01');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2060s_RCM01_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean flow [m^3/s]','Future 2060s annual mean flow [m^3/s]','Location','northeast');

if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Difference in annual mean flows for RCM04
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2060s\Annual_mean_flows_diff_RCM04_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2060s annual mean flows and baseline flows at station no.'," ",no," ",'for RCM04');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Flow_diff_annual_RCM04);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Plot the 2060s annual mean flows vs baseline mean flows for RCM04 as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2060s\Future_2060s_RCM04_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2060s annual mean flows vs baseline annual mean flows at station no.'," ",no," ",'for RCM04');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2060s_RCM04_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean flow [m^3/s]','Future 2060s annual mean flow [m^3/s]','Location','northeast');

if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Difference in annual mean flows for RCM05
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2060s\Annual_mean_flows_diff_RCM05_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2060s annual mean flows and baseline flows at station no.'," ",no," ",'for RCM05');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Flow_diff_annual_RCM05);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Plot the 2060s annual mean flows vs baseline mean flows for RCM05 as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2060s\Future_2060s_RCM05_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2060s annual mean flows vs baseline annual mean flows at station no.'," ",no," ",'for RCM05');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2060s_RCM05_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean flow [m^3/s]','Future 2060s annual mean flow [m^3/s]','Location','northeast');

if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Difference in annual mean flows for RCM06
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2060s\Annual_mean_flows_diff_RCM06_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2060s annual mean flows and baseline flows at station no.'," ",no," ",'for RCM06');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Flow_diff_annual_RCM06);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Plot the 2060s annual mean flows vs baseline mean flows for RCM06 as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2060s\Future_2060s_RCM06_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2060s annual mean flows vs baseline annual mean flows at station no.'," ",no," ",'for RCM06');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2060s_RCM06_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean flow [m^3/s]','Future 2060s annual mean flow [m^3/s]','Location','northeast');

if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Difference in annual mean flows for RCM07
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2060s\Annual_mean_flows_diff_RCM07_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2060s annual mean flows and baseline flows at station no.'," ",no," ",'for RCM07');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Flow_diff_annual_RCM07);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Plot the 2060s annual mean flows vs baseline mean flows for RCM07 as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2060s\Future_2060s_RCM07_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2060s annual mean flows vs baseline annual mean flows at station no.'," ",no," ",'for RCM07');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2060s_RCM07_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean flow [m^3/s]','Future 2060s annual mean flow [m^3/s]','Location','northeast');

if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Difference in annual mean flows for RCM08
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2060s\Annual_mean_flows_diff_RCM08_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2060s annual mean flows and baseline flows at station no.'," ",no," ",'for RCM08');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Flow_diff_annual_RCM08);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Plot the 2060s annual mean flows vs baseline mean flows for RCM08 as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2060s\Future_2060s_RCM08_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2060s annual mean flows vs baseline annual mean flows at station no.'," ",no," ",'for RCM08');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2060s_RCM08_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean flow [m^3/s]','Future 2060s annual mean flow [m^3/s]','Location','northeast');

if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Difference in annual mean flows for RCM09
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2060s\Annual_mean_flows_diff_RCM09_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2060s annual mean flows and baseline flows at station no.'," ",no," ",'for RCM09');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Flow_diff_annual_RCM09);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Plot the 2060s annual mean flows vs baseline mean flows for RCM09 as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2060s\Future_2060s_RCM09_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2060s annual mean flows vs baseline annual mean flows at station no.'," ",no," ",'for RCM09');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2060s_RCM09_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean flow [m^3/s]','Future 2060s annual mean flow [m^3/s]','Location','northeast');

if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Difference in annual mean flows for RCM10
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2060s\Annual_mean_flows_diff_RCM10_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2060s annual mean flows and baseline flows at station no.'," ",no," ",'for RCM10');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Flow_diff_annual_RCM10);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Plot the 2060s annual mean flows vs baseline mean flows for RCM10 as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2060s\Future_2060s_RCM10_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2060s annual mean flows vs baseline annual mean flows at station no.'," ",no," ",'for RCM10');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2060s_RCM10_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean flow [m^3/s]','Future 2060s annual mean flow [m^3/s]','Location','northeast');

if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Difference in annual mean flows for RCM11
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2060s\Annual_mean_flows_diff_RCM11_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2060s annual mean flows and baseline flows at station no.'," ",no," ",'for RCM11');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Flow_diff_annual_RCM11);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Plot the 2060s annual mean flows vs baseline mean flows for RCM11 as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2060s\Future_2060s_RCM11_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2060s annual mean flows vs baseline annual mean flows at station no.'," ",no," ",'for RCM11');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2060s_RCM11_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean flow [m^3/s]','Future 2060s annual mean flow [m^3/s]','Location','northeast');

if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Difference in annual mean flows for RCM12
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2060s\Annual_mean_flows_diff_RCM12_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2060s annual mean flows and baseline flows at station no.'," ",no," ",'for RCM12');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Flow_diff_annual_RCM12);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Plot the 2060s annual mean flows vs baseline mean flows for RCM12 as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2060s\Future_2060s_RCM12_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2060s annual mean flows vs baseline annual mean flows at station no.'," ",no," ",'for RCM12');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2060s_RCM12_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean flow [m^3/s]','Future 2060s annual mean flow [m^3/s]','Location','northeast');

if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Difference in annual mean flows for RCM13
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2060s\Annual_mean_flows_diff_RCM13_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2060s annual mean flows and baseline flows at station no.'," ",no," ",'for RCM13');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Flow_diff_annual_RCM13);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Plot the 2060s annual mean flows vs baseline mean flows for RCM13 as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2060s\Future_2060s_RCM13_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2060s annual mean flows vs baseline annual mean flows at station no.'," ",no," ",'for RCM13');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2060s_RCM13_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean flow [m^3/s]','Future 2060s annual mean flow [m^3/s]','Location','northeast');

if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Difference in annual mean flows for RCM15
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2060s\Annual_mean_flows_diff_RCM15_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2060s annual mean flows and baseline flows at station no.'," ",no," ",'for RCM15');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Flow_diff_annual_RCM15);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Plot the 2060s annual mean flows vs baseline mean flows for RCM15 as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2060s\Future_2060s_RCM15_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2060s annual mean flows vs baseline annual mean flows at station no.'," ",no," ",'for RCM15');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2060s_RCM15_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean flow [m^3/s]','Future 2060s annual mean flow [m^3/s]','Location','northeast');

if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Difference in annual mean flows for all RCMs
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2060s\Annual_mean_flows_diff_allRCM_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2060s annual mean flows and baseline flows at station no.'," ",no," ",'for all RCMs');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Flow_diff_annual_allRCM_2060s);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Plot the 2060s annual mean flows vs baseline mean flows for all RCMs as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Future_2060s\Future_2060s_allRCM_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2060s annual mean flows vs baseline annual mean flows at station no.'," ",no," ",'for all RCMs');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2060s_allRCM_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean flow [m^3/s]','Future 2060s annual mean flow [m^3/s]','Location','northeast');

if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);

%% Calculate the mean monthly flows for the baseline and for the future

%% Baseline mean monthly flows per each month
Flow_Obs_baseline_monthly_mean_allmonths=[];
Check_months=[];

Check_months=month(Months_baseline);
for j=1:12
    Flow_Obs_baseline_monthly_mean_allmonths(j,1)=mean(Flow_Obs_baseline_monthly_mean(Check_months==j));
end

%% 2040s mean flows per each month
%% Future 2040s mean monthly flows per each month for all RCMs
Flow_Simfuture_2040s_monthly_mean_allmonths_allRCM=[];
Check_months=[];

Check_months=month(Months_baseline);
for j=1:12
    Flow_Simfuture_2040s_monthly_mean_allmonths_allRCM(j,1)=mean(Flow_Sim_future_2040s_allRCM_monthly_mean(Check_months==j));
end

%% Future 2040s mean monthly flows per each month for RCM01
Flow_Simfuture_2040s_monthly_mean_allmonths_RCM01=[];
Check_months=[];

Check_months=month(Months_baseline);
for j=1:12
    Flow_Simfuture_2040s_monthly_mean_allmonths_RCM01(j,1)=mean(Flow_Sim_future_2040s_RCM01_monthly_mean(Check_months==j));
end

%% Future 2040s mean monthly flows per each month for RCM04
Flow_Simfuture_2040s_monthly_mean_allmonths_RCM04=[];
Check_months=[];

Check_months=month(Months_baseline);
for j=1:12
    Flow_Simfuture_2040s_monthly_mean_allmonths_RCM04(j,1)=mean(Flow_Sim_future_2040s_RCM04_monthly_mean(Check_months==j));
end

%% Future 2040s mean monthly flows per each month for RCM05
Flow_Simfuture_2040s_monthly_mean_allmonths_RCM05=[];
Check_months=[];

Check_months=month(Months_baseline);
for j=1:12
    Flow_Simfuture_2040s_monthly_mean_allmonths_RCM05(j,1)=mean(Flow_Sim_future_2040s_RCM05_monthly_mean(Check_months==j));
end

%% Future 2040s mean monthly flows per each month for RCM06
Flow_Simfuture_2040s_monthly_mean_allmonths_RCM06=[];
Check_months=[];

Check_months=month(Months_baseline);
for j=1:12
    Flow_Simfuture_2040s_monthly_mean_allmonths_RCM06(j,1)=mean(Flow_Sim_future_2040s_RCM06_monthly_mean(Check_months==j));
end

%% Future 2040s mean monthly flows per each month for RCM07
Flow_Simfuture_2040s_monthly_mean_allmonths_RCM07=[];
Check_months=[];

Check_months=month(Months_baseline);
for j=1:12
    Flow_Simfuture_2040s_monthly_mean_allmonths_RCM07(j,1)=mean(Flow_Sim_future_2040s_RCM07_monthly_mean(Check_months==j));
end

%% Future 2040s mean monthly flows per each month for RCM08
Flow_Simfuture_2040s_monthly_mean_allmonths_RCM08=[];
Check_months=[];

Check_months=month(Months_baseline);
for j=1:12
    Flow_Simfuture_2040s_monthly_mean_allmonths_RCM08(j,1)=mean(Flow_Sim_future_2040s_RCM08_monthly_mean(Check_months==j));
end

%% Future 2040s mean monthly flows per each month for RCM09
Flow_Simfuture_2040s_monthly_mean_allmonths_RCM09=[];
Check_months=[];

Check_months=month(Months_baseline);
for j=1:12
    Flow_Simfuture_2040s_monthly_mean_allmonths_RCM09(j,1)=mean(Flow_Sim_future_2040s_RCM09_monthly_mean(Check_months==j));
end

%% Future 2040s mean monthly flows per each month for RCM10
Flow_Simfuture_2040s_monthly_mean_allmonths_RCM10=[];
Check_months=[];

Check_months=month(Months_baseline);
for j=1:12
    Flow_Simfuture_2040s_monthly_mean_allmonths_RCM10(j,1)=mean(Flow_Sim_future_2040s_RCM10_monthly_mean(Check_months==j));
end

%% Future 2040s mean monthly flows per each month for RCM11
Flow_Simfuture_2040s_monthly_mean_allmonths_RCM11=[];
Check_months=[];

Check_months=month(Months_baseline);
for j=1:12
    Flow_Simfuture_2040s_monthly_mean_allmonths_RCM11(j,1)=mean(Flow_Sim_future_2040s_RCM11_monthly_mean(Check_months==j));
end

%% Future 2040s mean monthly flows per each month for RCM12
Flow_Simfuture_2040s_monthly_mean_allmonths_RCM12=[];
Check_months=[];

Check_months=month(Months_baseline);
for j=1:12
    Flow_Simfuture_2040s_monthly_mean_allmonths_RCM12(j,1)=mean(Flow_Sim_future_2040s_RCM12_monthly_mean(Check_months==j));
end

%% Future 2040s mean monthly flows per each month for RCM13
Flow_Simfuture_2040s_monthly_mean_allmonths_RCM13=[];
Check_months=[];

Check_months=month(Months_baseline);
for j=1:12
    Flow_Simfuture_2040s_monthly_mean_allmonths_RCM13(j,1)=mean(Flow_Sim_future_2040s_RCM13_monthly_mean(Check_months==j));
end

%% Future 2040s mean monthly flows per each month for RCM15
Flow_Simfuture_2040s_monthly_mean_allmonths_RCM15=[];
Check_months=[];

Check_months=month(Months_baseline);
for j=1:12
    Flow_Simfuture_2040s_monthly_mean_allmonths_RCM15(j,1)=mean(Flow_Sim_future_2040s_RCM15_monthly_mean(Check_months==j));
end

%% 2060s mean flows for each month
%% Future 2060s mean monthly flows per each month for all RCMs
Flow_Simfuture_2060s_monthly_mean_allmonths=[];
Check_months=[];

Check_months=month(Months_baseline);
for j=1:12
    Flow_Simfuture_2060s_monthly_mean_allmonths_allRCM(j,1)=mean(Flow_Sim_future_2060s_allRCM_monthly_mean(Check_months==j));
end

%% Future 2060s mean monthly flows per each month for RCM01
Flow_Simfuture_2060s_monthly_mean_allmonths_RCM01=[];
Check_months=[];

Check_months=month(Months_baseline);
for j=1:12
    Flow_Simfuture_2060s_monthly_mean_allmonths_RCM01(j,1)=mean(Flow_Sim_future_2060s_RCM01_monthly_mean(Check_months==j));
end

%% Future 2060s mean monthly flows per each month for RCM04
Flow_Simfuture_2060s_monthly_mean_allmonths_RCM04=[];
Check_months=[];

Check_months=month(Months_baseline);
for j=1:12
    Flow_Simfuture_2060s_monthly_mean_allmonths_RCM04(j,1)=mean(Flow_Sim_future_2060s_RCM04_monthly_mean(Check_months==j));
end

%% Future 2060s mean monthly flows per each month for RCM05
Flow_Simfuture_2060s_monthly_mean_allmonths_RCM05=[];
Check_months=[];

Check_months=month(Months_baseline);
for j=1:12
    Flow_Simfuture_2060s_monthly_mean_allmonths_RCM05(j,1)=mean(Flow_Sim_future_2060s_RCM05_monthly_mean(Check_months==j));
end

%% Future 2060s mean monthly flows per each month for RCM06
Flow_Simfuture_2060s_monthly_mean_allmonths_RCM06=[];
Check_months=[];

Check_months=month(Months_baseline);
for j=1:12
    Flow_Simfuture_2060s_monthly_mean_allmonths_RCM06(j,1)=mean(Flow_Sim_future_2060s_RCM06_monthly_mean(Check_months==j));
end

%% Future 2060s mean monthly flows per each month for RCM07
Flow_Simfuture_2060s_monthly_mean_allmonths_RCM07=[];
Check_months=[];

Check_months=month(Months_baseline);
for j=1:12
    Flow_Simfuture_2060s_monthly_mean_allmonths_RCM07(j,1)=mean(Flow_Sim_future_2060s_RCM07_monthly_mean(Check_months==j));
end

%% Future 2060s mean monthly flows per each month for RCM08
Flow_Simfuture_2060s_monthly_mean_allmonths_RCM08=[];
Check_months=[];

Check_months=month(Months_baseline);
for j=1:12
    Flow_Simfuture_2060s_monthly_mean_allmonths_RCM08(j,1)=mean(Flow_Sim_future_2060s_RCM08_monthly_mean(Check_months==j));
end

%% Future 2060s mean monthly flows per each month for RCM09
Flow_Simfuture_2060s_monthly_mean_allmonths_RCM09=[];
Check_months=[];

Check_months=month(Months_baseline);
for j=1:12
    Flow_Simfuture_2060s_monthly_mean_allmonths_RCM09(j,1)=mean(Flow_Sim_future_2060s_RCM09_monthly_mean(Check_months==j));
end

%% Future 2060s mean monthly flows per each month for RCM10
Flow_Simfuture_2060s_monthly_mean_allmonths_RCM10=[];
Check_months=[];

Check_months=month(Months_baseline);
for j=1:12
    Flow_Simfuture_2060s_monthly_mean_allmonths_RCM10(j,1)=mean(Flow_Sim_future_2060s_RCM10_monthly_mean(Check_months==j));
end

%% Future 2060s mean monthly flows per each month for RCM11
Flow_Simfuture_2060s_monthly_mean_allmonths_RCM11=[];
Check_months=[];

Check_months=month(Months_baseline);
for j=1:12
    Flow_Simfuture_2060s_monthly_mean_allmonths_RCM11(j,1)=mean(Flow_Sim_future_2060s_RCM11_monthly_mean(Check_months==j));
end

%% Future 2060s mean monthly flows per each month for RCM12
Flow_Simfuture_2060s_monthly_mean_allmonths_RCM12=[];
Check_months=[];

Check_months=month(Months_baseline);
for j=1:12
    Flow_Simfuture_2060s_monthly_mean_allmonths_RCM12(j,1)=mean(Flow_Sim_future_2060s_RCM12_monthly_mean(Check_months==j));
end

%% Future 2060s mean monthly flows per each month for RCM13
Flow_Simfuture_2060s_monthly_mean_allmonths_RCM13=[];
Check_months=[];

Check_months=month(Months_baseline);
for j=1:12
    Flow_Simfuture_2060s_monthly_mean_allmonths_RCM13(j,1)=mean(Flow_Sim_future_2060s_RCM13_monthly_mean(Check_months==j));
end

%% Future 2060s mean monthly flows per each month for RCM15
Flow_Simfuture_2060s_monthly_mean_allmonths_RCM15=[];
Check_months=[];

Check_months=month(Months_baseline);
for j=1:12
    Flow_Simfuture_2060s_monthly_mean_allmonths_RCM15(j,1)=mean(Flow_Sim_future_2060s_RCM15_monthly_mean(Check_months==j));
end

%% Create table for mean monthly flows for each month for 2040s

Table_allmonths=[];

for j=1:length(Months)
% Baseline info for each month
    Table_allmonths{j,1}=Months(j,1);
    Table_allmonths{j,2}=Flow_Obs_baseline_monthly_mean_allmonths(j,1);
   
    % Future 2040s info for each RCM for each month
    Table_allmonths{j,3}=Flow_Simfuture_2040s_monthly_mean_allmonths_RCM01(j,1);
    Table_allmonths{j,4}=Flow_Simfuture_2040s_monthly_mean_allmonths_RCM04(j,1);
    Table_allmonths{j,5}=Flow_Simfuture_2040s_monthly_mean_allmonths_RCM05(j,1);
    Table_allmonths{j,6}=Flow_Simfuture_2040s_monthly_mean_allmonths_RCM06(j,1);
    Table_allmonths{j,7}=Flow_Simfuture_2040s_monthly_mean_allmonths_RCM07(j,1);
    Table_allmonths{j,8}=Flow_Simfuture_2040s_monthly_mean_allmonths_RCM08(j,1);
    Table_allmonths{j,9}=Flow_Simfuture_2040s_monthly_mean_allmonths_RCM09(j,1);
    Table_allmonths{j,10}=Flow_Simfuture_2040s_monthly_mean_allmonths_RCM10(j,1);
    Table_allmonths{j,11}=Flow_Simfuture_2040s_monthly_mean_allmonths_RCM11(j,1);
    Table_allmonths{j,12}=Flow_Simfuture_2040s_monthly_mean_allmonths_RCM12(j,1);
    Table_allmonths{j,13}=Flow_Simfuture_2040s_monthly_mean_allmonths_RCM13(j,1);
    Table_allmonths{j,14}=Flow_Simfuture_2040s_monthly_mean_allmonths_RCM15(j,1);

    % Future 2040s info for all RCMS
    Table_allmonths{j,15}=Flow_Simfuture_2040s_monthly_mean_allmonths_allRCM(j,1);

    % Future 2040s info for the differences
    Table_allmonths{j,16}=(Flow_Obs_baseline_monthly_mean_allmonths(j,1)-Flow_Simfuture_2040s_monthly_mean_allmonths_RCM01(j,1))/Flow_Obs_baseline_monthly_mean_allmonths(j,1)*100;
    Table_allmonths{j,17}=(Flow_Obs_baseline_monthly_mean_allmonths(j,1)-Flow_Simfuture_2040s_monthly_mean_allmonths_RCM04(j,1))/Flow_Obs_baseline_monthly_mean_allmonths(j,1)*100;
    Table_allmonths{j,18}=(Flow_Obs_baseline_monthly_mean_allmonths(j,1)-Flow_Simfuture_2040s_monthly_mean_allmonths_RCM05(j,1))/Flow_Obs_baseline_monthly_mean_allmonths(j,1)*100;
    Table_allmonths{j,19}=(Flow_Obs_baseline_monthly_mean_allmonths(j,1)-Flow_Simfuture_2040s_monthly_mean_allmonths_RCM06(j,1))/Flow_Obs_baseline_monthly_mean_allmonths(j,1)*100;
    Table_allmonths{j,20}=(Flow_Obs_baseline_monthly_mean_allmonths(j,1)-Flow_Simfuture_2040s_monthly_mean_allmonths_RCM07(j,1))/Flow_Obs_baseline_monthly_mean_allmonths(j,1)*100;
    Table_allmonths{j,21}=(Flow_Obs_baseline_monthly_mean_allmonths(j,1)-Flow_Simfuture_2040s_monthly_mean_allmonths_RCM08(j,1))/Flow_Obs_baseline_monthly_mean_allmonths(j,1)*100;
    Table_allmonths{j,22}=(Flow_Obs_baseline_monthly_mean_allmonths(j,1)-Flow_Simfuture_2040s_monthly_mean_allmonths_RCM09(j,1))/Flow_Obs_baseline_monthly_mean_allmonths(j,1)*100;
    Table_allmonths{j,23}=(Flow_Obs_baseline_monthly_mean_allmonths(j,1)-Flow_Simfuture_2040s_monthly_mean_allmonths_RCM10(j,1))/Flow_Obs_baseline_monthly_mean_allmonths(j,1)*100;
    Table_allmonths{j,24}=(Flow_Obs_baseline_monthly_mean_allmonths(j,1)-Flow_Simfuture_2040s_monthly_mean_allmonths_RCM11(j,1))/Flow_Obs_baseline_monthly_mean_allmonths(j,1)*100;
    Table_allmonths{j,25}=(Flow_Obs_baseline_monthly_mean_allmonths(j,1)-Flow_Simfuture_2040s_monthly_mean_allmonths_RCM12(j,1))/Flow_Obs_baseline_monthly_mean_allmonths(j,1)*100;
    Table_allmonths{j,26}=(Flow_Obs_baseline_monthly_mean_allmonths(j,1)-Flow_Simfuture_2040s_monthly_mean_allmonths_RCM13(j,1))/Flow_Obs_baseline_monthly_mean_allmonths(j,1)*100;
    Table_allmonths{j,27}=(Flow_Obs_baseline_monthly_mean_allmonths(j,1)-Flow_Simfuture_2040s_monthly_mean_allmonths_RCM15(j,1))/Flow_Obs_baseline_monthly_mean_allmonths(j,1)*100;

    % Future 2040s infor for the difference for all RCMs
    Table_allmonths{j,28}=(Flow_Obs_baseline_monthly_mean_allmonths(j,1)-Flow_Simfuture_2040s_monthly_mean_allmonths_allRCM(j,1))/Flow_Obs_baseline_monthly_mean_allmonths(j,1)*100;
    end

    Table_allmonths_header={'Baseline','Baseline monthly mean flows [m^3/s]','RCM01 monthly mean flow [m^3/s]','RCM04 monthly mean flow [m^3/s]','RCM05 monthly mean flow [m^3/s]','RCM06 monthly mean flow [m^3/s]','RCM07 monthly mean flow [m^3/s]','RCM08 monthly mean flow [m^3/s]','RCM09 monthly mean flow [m^3/s]','RCM10 monthly mean flow [m^3/s]','RCM11 monthly mean flow [m^3/s]','RCM12 monthly mean flow [m^3/s]','RCM13 monthly mean flow [m^3/s]','RCM15 monthly mean flow [m^3/s]','All RCM future monthly mean flow [m^3/s]','Baseline-RCM01 [%]','Baseline-RCM04 [%]','Baseline-RCM05 [%]','Baseline-RCM06 [%]','Baseline-RCM07 [%]','Baseline-RCM08 [%]','Baseline-RCM09 [%]','Baseline-RCM10 [%]' ,'Baseline-RCM11 [%]','Baseline-RCM12 [%]','Baseline-RCM13 [%]','Baseline-RCM15 [%]','Baseline mean-Future mean flow [%]'};
 
%Write the table into an excel file
 
if exist(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Station_',no,'_flows_2040s_allmonths_vs_baseline.xls'), 'file')==2
   delete(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Station_',no,'_flows_2040s_allmonths_vs_baseline.xls'));
end
 
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Station_',no,'_flows_2040s_allmonths_vs_baseline.xls'),Table_allmonths,'Sheet1','A2');
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Station_',no,'_flows_2040s_allmonths_vs_baseline.xls'),Table_allmonths_header,'Sheet1','A1');

%% Create table for mean monthly flows for each month for 2060s

Table_allmonths=[];

for j=1:length(Months)
% Baseline info for each month
    Table_allmonths{j,1}=Months(j,1);
    Table_allmonths{j,2}=Flow_Obs_baseline_monthly_mean_allmonths(j,1);
   
    % Future 2060s info for each RCM for each month
    Table_allmonths{j,3}=Flow_Simfuture_2060s_monthly_mean_allmonths_RCM01(j,1);
    Table_allmonths{j,4}=Flow_Simfuture_2060s_monthly_mean_allmonths_RCM04(j,1);
    Table_allmonths{j,5}=Flow_Simfuture_2060s_monthly_mean_allmonths_RCM05(j,1);
    Table_allmonths{j,6}=Flow_Simfuture_2060s_monthly_mean_allmonths_RCM06(j,1);
    Table_allmonths{j,7}=Flow_Simfuture_2060s_monthly_mean_allmonths_RCM07(j,1);
    Table_allmonths{j,8}=Flow_Simfuture_2060s_monthly_mean_allmonths_RCM08(j,1);
    Table_allmonths{j,9}=Flow_Simfuture_2060s_monthly_mean_allmonths_RCM09(j,1);
    Table_allmonths{j,10}=Flow_Simfuture_2060s_monthly_mean_allmonths_RCM10(j,1);
    Table_allmonths{j,11}=Flow_Simfuture_2060s_monthly_mean_allmonths_RCM11(j,1);
    Table_allmonths{j,12}=Flow_Simfuture_2060s_monthly_mean_allmonths_RCM12(j,1);
    Table_allmonths{j,13}=Flow_Simfuture_2060s_monthly_mean_allmonths_RCM13(j,1);
    Table_allmonths{j,14}=Flow_Simfuture_2060s_monthly_mean_allmonths_RCM15(j,1);

    % Future 2060s info for all RCMS
    Table_allmonths{j,15}=Flow_Simfuture_2060s_monthly_mean_allmonths_allRCM(j,1);

    % Future 2060s info for the differences
    Table_allmonths{j,16}=(Flow_Obs_baseline_monthly_mean_allmonths(j,1)-Flow_Simfuture_2060s_monthly_mean_allmonths_RCM01(j,1))/Flow_Obs_baseline_monthly_mean_allmonths(j,1)*100;
    Table_allmonths{j,17}=(Flow_Obs_baseline_monthly_mean_allmonths(j,1)-Flow_Simfuture_2060s_monthly_mean_allmonths_RCM04(j,1))/Flow_Obs_baseline_monthly_mean_allmonths(j,1)*100;
    Table_allmonths{j,18}=(Flow_Obs_baseline_monthly_mean_allmonths(j,1)-Flow_Simfuture_2060s_monthly_mean_allmonths_RCM05(j,1))/Flow_Obs_baseline_monthly_mean_allmonths(j,1)*100;
    Table_allmonths{j,19}=(Flow_Obs_baseline_monthly_mean_allmonths(j,1)-Flow_Simfuture_2060s_monthly_mean_allmonths_RCM06(j,1))/Flow_Obs_baseline_monthly_mean_allmonths(j,1)*100;
    Table_allmonths{j,20}=(Flow_Obs_baseline_monthly_mean_allmonths(j,1)-Flow_Simfuture_2060s_monthly_mean_allmonths_RCM07(j,1))/Flow_Obs_baseline_monthly_mean_allmonths(j,1)*100;
    Table_allmonths{j,21}=(Flow_Obs_baseline_monthly_mean_allmonths(j,1)-Flow_Simfuture_2060s_monthly_mean_allmonths_RCM08(j,1))/Flow_Obs_baseline_monthly_mean_allmonths(j,1)*100;
    Table_allmonths{j,22}=(Flow_Obs_baseline_monthly_mean_allmonths(j,1)-Flow_Simfuture_2060s_monthly_mean_allmonths_RCM09(j,1))/Flow_Obs_baseline_monthly_mean_allmonths(j,1)*100;
    Table_allmonths{j,23}=(Flow_Obs_baseline_monthly_mean_allmonths(j,1)-Flow_Simfuture_2060s_monthly_mean_allmonths_RCM10(j,1))/Flow_Obs_baseline_monthly_mean_allmonths(j,1)*100;
    Table_allmonths{j,24}=(Flow_Obs_baseline_monthly_mean_allmonths(j,1)-Flow_Simfuture_2060s_monthly_mean_allmonths_RCM11(j,1))/Flow_Obs_baseline_monthly_mean_allmonths(j,1)*100;
    Table_allmonths{j,25}=(Flow_Obs_baseline_monthly_mean_allmonths(j,1)-Flow_Simfuture_2060s_monthly_mean_allmonths_RCM12(j,1))/Flow_Obs_baseline_monthly_mean_allmonths(j,1)*100;
    Table_allmonths{j,26}=(Flow_Obs_baseline_monthly_mean_allmonths(j,1)-Flow_Simfuture_2060s_monthly_mean_allmonths_RCM13(j,1))/Flow_Obs_baseline_monthly_mean_allmonths(j,1)*100;
    Table_allmonths{j,27}=(Flow_Obs_baseline_monthly_mean_allmonths(j,1)-Flow_Simfuture_2060s_monthly_mean_allmonths_RCM15(j,1))/Flow_Obs_baseline_monthly_mean_allmonths(j,1)*100;

    % Future 2060s infor for the difference for all RCMs
    Table_allmonths{j,28}=(Flow_Obs_baseline_monthly_mean_allmonths(j,1)-Flow_Simfuture_2060s_monthly_mean_allmonths_allRCM(j,1))/Flow_Obs_baseline_monthly_mean_allmonths(j,1)*100;
end

    Table_allmonths_header={'Baseline','Baseline monthly mean flows [m^3/s]','RCM01 monthly mean flow [m^3/s]','RCM04 monthly mean flow [m^3/s]','RCM05 monthly mean flow [m^3/s]','RCM06 monthly mean flow [m^3/s]','RCM07 monthly mean flow [m^3/s]','RCM08 monthly mean flow [m^3/s]','RCM09 monthly mean flow [m^3/s]','RCM10 monthly mean flow [m^3/s]','RCM11 monthly mean flow [m^3/s]','RCM12 monthly mean flow [m^3/s]','RCM13 monthly mean flow [m^3/s]','RCM15 monthly mean flow [m^3/s]','All RCM future monthly mean flow [m^3/s]','Baseline-RCM01 [%]','Baseline-RCM04 [%]','Baseline-RCM05 [%]','Baseline-RCM06 [%]','Baseline-RCM07 [%]','Baseline-RCM08 [%]','Baseline-RCM09 [%]','Baseline-RCM10 [%]' ,'Baseline-RCM11 [%]','Baseline-RCM12 [%]','Baseline-RCM13 [%]','Baseline-RCM15 [%]','Baseline mean-Future mean flow [%]'};
 
%Write the table into an excel file
 
if exist(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Station_',no,'_flows_2060s_allmonths_vs_baseline.xls'), 'file')==2
   delete(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Station_',no,'_flows_2060s_allmonths_vs_baseline.xls'));
end
 
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Station_',no,'_flows_2060s_allmonths_vs_baseline.xls'),Table_allmonths,'Sheet1','A2');
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Station_',no,'_flows_2060s_allmonths_vs_baseline.xls'),Table_allmonths_header,'Sheet1','A1');

%% Calculate the mean flows for the baseline and for the future
 
Flows_Obs_baseline_all(i,1)=nanmean(Flow_Obs_baseline_annual_mean);
 
Flows_future_2040s_all(i,1)=nanmean(Flow_Sim_future_2040s_allRCM_annual_mean);
 
Flows_future_2060s_all(i,1)=nanmean(Flow_Sim_future_2060s_allRCM_annual_mean);
 
Table_final(i,1)=GaugesNo(i,1);
Table_final(i,2)=Flows_Obs_baseline_all(i,1);
Table_final(i,3)=Flows_future_2040s_all(i,1);
Table_final(i,4)=Flows_future_2060s_all(i,1);
 
Table_final_header={'Station ID','Baseline mean flow [m^3/s]','Future 2040s mean flow [m^3/s]','Future 2060s mean flow [m^3/s]'};
 
if exist(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Station_',no,'_final_annual_vs_baseline_means.xls'), 'file')==2
   delete(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Station_',no,'_final_annual_vs_bGR4Jaseline_means.xls'));
end
 
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Station_',no,'_final_annual_vs_baseline_means.xls'),Table_final,'Sheet1','A2');
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Station_',no,'_final_annual_vs_baseline_means.xls'),Table_final_header,'Sheet1','A1');

%% Calculate the sum of daily flows for the baseline and for the future

Flows_Obs_baseline_all_sum(i,1)=nansum(Flow_Obs_baseline);
 
Flows_future_2040s_all_sum(i,1)=nansum(Flow_Sim_future_2040s_allRCM);
 
Flows_future_2060s_all_sum(i,1)=nansum(Flow_Sim_future_2060s_allRCM);
 
Table_final(i,1)=GaugesNo(i,1);
Table_final(i,2)=Flows_Obs_baseline_all_sum(i,1);
Table_final(i,3)=Flows_future_2040s_all_sum(i,1);
Table_final(i,4)=Flows_future_2060s_all_sum(i,1);
 
Table_final_header={'Station ID','Baseline total flows [m^3/s]','Future 2040s total flows [m^3/s]','Future 2060s total flows [m^3/s]'};
 
if exist(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Station_',no,'_final_annual_vs_baseline_sum.xls'), 'file')==2
   delete(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Station_',no,'_final_annual_vs_baseline_sum.xls'));
end
 
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Station_',no,'_final_annual_vs_baseline_sum.xls'),Table_final,'Sheet1','A2');
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Station_',no,'_final_annual_vs_baseline_sum.xls'),Table_final_header,'Sheet1','A1');
    end
end