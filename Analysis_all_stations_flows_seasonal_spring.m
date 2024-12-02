clearvars;

%% Constants

%Start and end dates for the baseline period (30 years)
Baseline_Start_time=datetime(1980,01,01);
Baseline_End_time=datetime(2010,12,31);

%Start and end dates for the 2030s future period (30 years)
Future_2030s_Start_time=datetime(2020,01,01);
Future_2030s_End_time=datetime(2050,12,30);

%Start and end dates for the 2050s future period (30 years)
Future_2050s_Start_time=datetime(2040,01,01);
Future_2050s_End_time=datetime(2070,12,30);

%Baseline and future months
Months_baseline=readtable('H:\01.PhD\004.Chapter4\Matlab Code\Months_Baseline.xlsx');
Months_baseline=table2array(Months_baseline);
Months_2030s=readtable('H:\01.PhD\004.Chapter4\Matlab Code\Months_2030s.xlsx');
Months_2030s=table2array(Months_2030s);
Months_2050s=readtable('H:\01.PhD\004.Chapter4\Matlab Code\Months_2050s.xlsx');
Months_2050s=table2array(Months_2050s);

%Baseline and future years
Years_baseline=readtable('H:\01.PhD\004.Chapter4\Matlab Code\Years_Baseline.xlsx');
Years_baseline=table2array(Years_baseline);
Years_2030s=readtable('H:\01.PhD\004.Chapter4\Matlab Code\Years_2030s.xlsx');
Years_2030s=table2array(Years_2030s);
Years_2050s=readtable('H:\01.PhD\004.Chapter4\Matlab Code\Years_2050s.xlsx');
Years_2050s=table2array(Years_2050s);

Months=["Jan";'Feb';'Mar';'Apr';'May';'Jun';'Jul';'Aug';'Sep';'Oct';'Nov';'Dec'];

%Read the gauges locations and time
location = "H:\01.PhD\004.Chapter4\Input_data_CEH\Supporting_Documentation\eFLaG_Station_Matlab.xlsx";
time_file="H:\01.PhD\004.Chapter4\Input_data_CEH\Observed Flows_eFlag\Time.xlsx";

%Read the gauge numbe
Gauges=readtable(location);
GaugesNo=Gauges(:,1);
Obs_percentile(:,1)=table2array(GaugesNo(:,1));
GaugesNo=table2array(GaugesNo);

%Seasonal months
Spring_months=[3 4 5];
Summer_months=[6 7 8];
Autumn_months=[9 10 11];
Winter_months=[12 1 2];

for i=1:191
    no=num2str(GaugesNo(i,1));
    %These are excluded because there is no gauged data
    if i~=27 && i~=28 && i~=42 && i~=62 && i~=66 && i~=67 && i~=68 && i~=69 && i~=70 && i~=71 && i~=78 && i~=102 && i~=115 && i~=123 && i~=124 && i~=125 && i~=126 && i~=127 && i~=128 &&i~=129 && i~=130 && i~=131 && i~=132 && i~=133 && i~=134 && i~=135 && i~=136 && i~=137 && i~=138 && i~=139 && i~=154
%% Read the baseline flows and save the 1990s spring flows in an Excel file
    Current_station_location_baseline=strcat('H:\01.PhD\004.Chapter4\Input_data_CEH\Observed Flows_eFlag\G2G_simobs_',no,'.csv');
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
    
    Check_months=month(Time_Obs_baseline);
    
    %Add only the spring flows for the analysis
    for j=1:length(Check_months)
        Check_spring_months(j,1)=ismember(Check_months(j,1),Spring_months);
    end
    
    [delete_idx,~]=find(Check_spring_months==0);
    Time_Obs_baseline(delete_idx,:)=[];
    Flow_Obs_baseline(delete_idx,:)=[];
    Current_station_baseline(delete_idx,:)=[];
    
    Check_spring_months=[];
    Check_months=[];
    Check_months=month(Months_baseline);
    delete_idx=[];
    for j=1:length(Months_baseline)
        Check_spring_months(j,1)=ismember(Check_months(j,1),Spring_months);
    end
    [delete_idx,~]=find(Check_spring_months==0);
    Months_baseline(delete_idx,:)=[];
    
    %Check if file exists, if yes delete it
    if exist(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Baseline\Spring\Baseline_station_',no,'.xls'), 'file')==2
        delete(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Baseline\Spring\Baseline_station_',no,'.xls'));
    end
    writetable(Current_station_baseline,strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Baseline\Spring\Baseline_station_',no,'.xls'));
     
    %% Read the future flows and save the 2030s future spring flows in an Excel file
    Check_months=[];
    Check_spring_months=[];
    Current_station_future_2030s_location=strcat('H:\01.PhD\004.Chapter4\Input_data_CEH\Future Flow_eFlag\G2G_simrcm_',no,'.csv');
    Current_station_future_2030s=readtable(Current_station_future_2030s_location);
    Time_Sim_future_2030s=Current_station_future_2030s(:,1);
    Time_Sim_future_2030s=table2array(Time_Sim_future_2030s);
    [start_time_idx,~]=find(Time_Sim_future_2030s==Future_2030s_Start_time);
    [end_time_idx,~]=find(Time_Sim_future_2030s==Future_2030s_End_time);
    Current_station_future_2030s(end_time_idx+1:height(Current_station_future_2030s),:)=[];
    Current_station_future_2030s(1:start_time_idx-1,:)=[];

    Time_Sim_future_2030s=Current_station_future_2030s(:,1);
    Time_Sim_future_2030s=table2array(Time_Sim_future_2030s);
    
    Flow_Sim_future_2030s=Current_station_future_2030s(:,2:13);
    Flow_Sim_future_2030s=table2array(Flow_Sim_future_2030s); 

    Flow_Sim_future_2030s_RCM01=Flow_Sim_future_2030s(:,1);
    Flow_Sim_future_2030s_RCM04=Flow_Sim_future_2030s(:,2);
    Flow_Sim_future_2030s_RCM05=Flow_Sim_future_2030s(:,3);
    Flow_Sim_future_2030s_RCM06=Flow_Sim_future_2030s(:,4);
    Flow_Sim_future_2030s_RCM07=Flow_Sim_future_2030s(:,5);
    Flow_Sim_future_2030s_RCM08=Flow_Sim_future_2030s(:,6);
    Flow_Sim_future_2030s_RCM09=Flow_Sim_future_2030s(:,7);
    Flow_Sim_future_2030s_RCM10=Flow_Sim_future_2030s(:,8);
    Flow_Sim_future_2030s_RCM11=Flow_Sim_future_2030s(:,9);
    Flow_Sim_future_2030s_RCM12=Flow_Sim_future_2030s(:,10);
    Flow_Sim_future_2030s_RCM13=Flow_Sim_future_2030s(:,11);
    Flow_Sim_future_2030s_RCM15=Flow_Sim_future_2030s(:,12);

    Check_index=[1:length(Flow_Sim_future_2030s_RCM01)];
    
    for j=1:length(Flow_Sim_future_2030s_RCM01)
        Flow_Sim_future_2030s_allRCM(j,1)=mean(Flow_Sim_future_2030s(j,:));
    end

    Check_months=month(Time_Sim_future_2030s);
    
    %Add only the spring flows for the analysis
    for j=1:length(Check_months)
        Check_spring_months(j,1)=ismember(Check_months(j,1),Spring_months);
    end
    
    [delete_idx,~]=find(Check_spring_months==0);
    Time_Sim_future_2030s(delete_idx,:)=[];
    Flow_Sim_future_2030s(delete_idx,:)=[];

    Flow_Sim_future_2030s_RCM01(delete_idx,:)=[];
    Flow_Sim_future_2030s_RCM04(delete_idx,:)=[];
    Flow_Sim_future_2030s_RCM05(delete_idx,:)=[];
    Flow_Sim_future_2030s_RCM06(delete_idx,:)=[];
    Flow_Sim_future_2030s_RCM07(delete_idx,:)=[];
    Flow_Sim_future_2030s_RCM08(delete_idx,:)=[];
    Flow_Sim_future_2030s_RCM09(delete_idx,:)=[];
    Flow_Sim_future_2030s_RCM10(delete_idx,:)=[];
    Flow_Sim_future_2030s_RCM11(delete_idx,:)=[];
    Flow_Sim_future_2030s_RCM12(delete_idx,:)=[];
    Flow_Sim_future_2030s_RCM13(delete_idx,:)=[];
    Flow_Sim_future_2030s_RCM15(delete_idx,:)=[];

    Flow_Sim_future_2030s_allRCM(delete_idx,:)=[];

    Current_station_future_2030s(delete_idx,:)=[];
    
    Check_spring_months=[];
    Check_months=[];
    Check_months=month(Months_2030s);
    delete_idx=[];
    for j=1:length(Months_2030s)
        Check_spring_months(j,1)=ismember(Check_months(j,1),Spring_months);
    end
    [delete_idx,~]=find(Check_spring_months==0);
    Months_2030s(delete_idx,:)=[];
    
    %Check if file exists, if yes delete it
    if exist(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Future_2030s\Spring\Future_2030s_station_',no,'.xls'), 'file')==2
        delete(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Future_2030s\Spring\Future_flow_inputs\Future_2030s_station_',no,'.xls'));
    end
    writetable(Current_station_future_2030s,strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Future_2030s\Future_2030s_station_',no,'.xls'));
    
%% Read the future flows and save the 2050s future spring flows in an Excel file
    Check_months=[];
    Check_spring_months=[];
    Current_station_future_2050s_location=strcat('H:\01.PhD\004.Chapter4\Input_data_CEH\Future Flow_eFlag\G2G_simrcm_',no,'.csv');
    Current_station_future_2050s=readtable(Current_station_future_2050s_location);
    Time_Sim_future_2050s=Current_station_future_2050s(:,1);
    Time_Sim_future_2050s=table2array(Time_Sim_future_2050s);
    [start_time_idx,~]=find(Time_Sim_future_2050s==Future_2050s_Start_time);
    [end_time_idx,~]=find(Time_Sim_future_2050s==Future_2050s_End_time);
    Current_station_future_2050s(end_time_idx+1:height(Current_station_future_2050s),:)=[];
    Current_station_future_2050s(1:start_time_idx-1,:)=[];

    Time_Sim_future_2050s=Current_station_future_2050s(:,1);
    Time_Sim_future_2050s=table2array(Time_Sim_future_2050s);
    
    Flow_Sim_future_2050s=Current_station_future_2050s(:,2:13);
    Flow_Sim_future_2050s=table2array(Flow_Sim_future_2050s);

    Flow_Sim_future_2050s_RCM01=Flow_Sim_future_2050s(:,1);
    Flow_Sim_future_2050s_RCM04=Flow_Sim_future_2050s(:,2);
    Flow_Sim_future_2050s_RCM05=Flow_Sim_future_2050s(:,3);
    Flow_Sim_future_2050s_RCM06=Flow_Sim_future_2050s(:,4);
    Flow_Sim_future_2050s_RCM07=Flow_Sim_future_2050s(:,5);
    Flow_Sim_future_2050s_RCM08=Flow_Sim_future_2050s(:,6);
    Flow_Sim_future_2050s_RCM09=Flow_Sim_future_2050s(:,7);
    Flow_Sim_future_2050s_RCM10=Flow_Sim_future_2050s(:,8);
    Flow_Sim_future_2050s_RCM11=Flow_Sim_future_2050s(:,9);
    Flow_Sim_future_2050s_RCM12=Flow_Sim_future_2050s(:,10);
    Flow_Sim_future_2050s_RCM13=Flow_Sim_future_2050s(:,11);
    Flow_Sim_future_2050s_RCM15=Flow_Sim_future_2050s(:,12);

    for j=1:length(Flow_Sim_future_2050s_RCM01)
        Flow_Sim_future_2050s_allRCM(j,1)=mean(Flow_Sim_future_2050s(j,:));
    end
    
    Check_months=month(Time_Sim_future_2050s);
    
    %Add only the spring flows for the analysis
    for j=1:length(Check_months)
        Check_spring_months(j,1)=ismember(Check_months(j,1),Spring_months);
    end
    
    [delete_idx,~]=find(Check_spring_months==0);
    Time_Sim_future_2050s(delete_idx,:)=[];
    Flow_Sim_future_2050s(delete_idx,:)=[];

    Flow_Sim_future_2050s_RCM01(delete_idx,:)=[];
    Flow_Sim_future_2050s_RCM04(delete_idx,:)=[];
    Flow_Sim_future_2050s_RCM05(delete_idx,:)=[];
    Flow_Sim_future_2050s_RCM06(delete_idx,:)=[];
    Flow_Sim_future_2050s_RCM07(delete_idx,:)=[];
    Flow_Sim_future_2050s_RCM08(delete_idx,:)=[];
    Flow_Sim_future_2050s_RCM09(delete_idx,:)=[];
    Flow_Sim_future_2050s_RCM10(delete_idx,:)=[];
    Flow_Sim_future_2050s_RCM11(delete_idx,:)=[];
    Flow_Sim_future_2050s_RCM12(delete_idx,:)=[];
    Flow_Sim_future_2050s_RCM13(delete_idx,:)=[];
    Flow_Sim_future_2050s_RCM15(delete_idx,:)=[];

    Flow_Sim_future_2050s_allRCM(delete_idx,:)=[];

    Current_station_future_2050s(delete_idx,:)=[];
    
    Check_spring_months=[];
    Check_months=[];
    Check_months=month(Months_2050s);
    delete_idx=[];
    for j=1:length(Months_2050s)
        Check_spring_months(j,1)=ismember(Check_months(j,1),Spring_months);
    end
    [delete_idx,~]=find(Check_spring_months==0);
    Months_2050s(delete_idx,:)=[];

    %Check if file exists, if yes delete it
    if exist(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Future_2050s\Spring\Future_2050s_station_',no,'.xls'), 'file')==2
        delete(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Future_2050s\Spring\Future_2050s_station_',no,'.xls'));
    end
    writetable(Current_station_future_2050s,strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Future_2050s\Spring\Future_2050s_station_',no,'.xls'));

%% Plot the baseline spring flow vs 2030s spring flow for all RCMs
clf %clears figure information
       set(gca,'Box','on');
       hold on
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Baseline_vs_2030s_all_RCM_ID_',no,'.png');
       tiledlayout(2,1)
 
       %Top plot
       nexttile
       box on
       title_name_baseline=strcat('Daily observed baseline spring flows at station no.'," ",no);
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Flow [m^3/s]');
       hold on
       plot(Time_Obs_baseline,Flow_Obs_baseline);
       hold on
 
       %Bottom plot
       nexttile
       box on
       title_name_baseline=strcat('Daily observed future 2030s spring flows at station no.'," ",no," ",'for all RCMs');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Flow [m^3/s]');
       hold on
       plot(Time_Sim_future_2030s,Flow_Sim_future_2030s_allRCM,'Color','r');
       %legend('Baseline observed flows [m^3/s]','Future simulated flows [m^3/s]','Location','northeast');
       
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
       
%% Plot the baseline spring flow vs 2050s spring flow
clf %clears figure information
       set(gca,'Box','on');
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Baseline_vs_2050s_all_RCM_ID_',no,'.png');
       tiledlayout(2,1)
 
       %Top plot
       nexttile
       box on
       title_name_baseline=strcat('Daily observed baseline spring flows at station no.'," ",no);
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Flow [m^3/s]');
       hold on
       plot(Time_Obs_baseline,Flow_Obs_baseline);
       hold on
 
       %Bottom plot
       nexttile
       box on
       title_name_future_2030s=strcat('Daily observed future 2050s spring flows at station no.'," ",no," ",'for all RCMs');
       title(title_name_future_2030s);
       xlabel('Time');
       ylabel('Flow [m^3/s]');
       hold on
       plot(Time_Sim_future_2050s,Flow_Sim_future_2050s_allRCM,'Color','r');
 
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
 
%% Plot daily future 2030s spring flows for all RCMs
clf %clears figure information
       tiledlayout(4,3,'TileSpacing','Compact');
       set(gca,'Box','on','FontSize',9);
       hold on
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Daily_future_flows_2030s_RCM01_ID_',no,'.png');
       title_name_future=strcat('Daily future 2030s spring flows at station no.'," ",no);
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
       plot(Time_Sim_future_2030s,Flow_Sim_future_2030s_RCM01);
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
       plot(Time_Sim_future_2030s,Flow_Sim_future_2030s_RCM04);
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
       plot(Time_Sim_future_2030s,Flow_Sim_future_2030s_RCM05);
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
       plot(Time_Sim_future_2030s,Flow_Sim_future_2030s_RCM06);
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
       plot(Time_Sim_future_2030s,Flow_Sim_future_2030s_RCM07);
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
       plot(Time_Sim_future_2030s,Flow_Sim_future_2030s_RCM08);
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
       plot(Time_Sim_future_2030s,Flow_Sim_future_2030s_RCM09);
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
       plot(Time_Sim_future_2030s,Flow_Sim_future_2030s_RCM10);
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
       plot(Time_Sim_future_2030s,Flow_Sim_future_2030s_RCM11);
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
       plot(Time_Sim_future_2030s,Flow_Sim_future_2030s_RCM12);
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
       plot(Time_Sim_future_2030s,Flow_Sim_future_2030s_RCM13);
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
       plot(Time_Sim_future_2030s,Flow_Sim_future_2030s_RCM15);
       hold on 
 
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot daily future 2050s spring flows for all RCMs
clf %clears figure information
       tiledlayout(4,3,'TileSpacing','Compact');
       set(gca,'Box','on','FontSize',9);
       hold on
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Daily_future_flows_2050s_RCM01_ID_',no,'.png');
       title_name_future=strcat('Daily future 2050s spring flows at station no.'," ",no);
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
       plot(Time_Sim_future_2050s,Flow_Sim_future_2050s_RCM01);
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
       plot(Time_Sim_future_2050s,Flow_Sim_future_2050s_RCM04);
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
       plot(Time_Sim_future_2050s,Flow_Sim_future_2050s_RCM05);
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
       plot(Time_Sim_future_2050s,Flow_Sim_future_2050s_RCM06);
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
       plot(Time_Sim_future_2050s,Flow_Sim_future_2050s_RCM07);
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
       plot(Time_Sim_future_2050s,Flow_Sim_future_2050s_RCM08);
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
       plot(Time_Sim_future_2050s,Flow_Sim_future_2050s_RCM09);
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
       plot(Time_Sim_future_2050s,Flow_Sim_future_2050s_RCM10);
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
       plot(Time_Sim_future_2050s,Flow_Sim_future_2050s_RCM11);
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
       plot(Time_Sim_future_2050s,Flow_Sim_future_2050s_RCM12);
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
       plot(Time_Sim_future_2050s,Flow_Sim_future_2050s_RCM13);
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
       plot(Time_Sim_future_2050s,Flow_Sim_future_2050s_RCM15);
       hold on 
 
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%% Get monthly baseline spring flows
Table_baseline=[];
Monthly_values_baseline_mean=[];
 
Table_baseline=Time_Obs_baseline;
Table_baseline=timetable(Time_Obs_baseline,Flow_Obs_baseline);
 
Monthly_values_baseline_mean=convert2monthly(Table_baseline,'Aggregation',["mean"]);
Flow_Obs_baseline_monthly_mean=Monthly_values_baseline_mean;
 
Flow_Obs_baseline_monthly_mean=table2array(Flow_Obs_baseline_monthly_mean);
 
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Get monthly future 2030s spring flows
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
%% All RCMs
Flow_Sim_future_2030s_allRCM_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2030s_allRCM)
    Flow_Sim_future_2030s_allRCM_monthly_mean(j,1)=nanmean(Flow_Sim_future_2030s_allRCM(j:j+29));
end
Flow_Sim_future_2030s_allRCM_monthly_mean(any(Flow_Sim_future_2030s_allRCM_monthly_mean==0,2))=[];
 
%% RCM01
Flow_Sim_future_2030s_RCM01_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2030s_RCM01)
    Flow_Sim_future_2030s_RCM01_monthly_mean(j,1)=nanmean(Flow_Sim_future_2030s_RCM01(j:j+29));
end
Flow_Sim_future_2030s_RCM01_monthly_mean(any(Flow_Sim_future_2030s_RCM01_monthly_mean==0,2))=[];
 
%% RCM04
Flow_Sim_future_2030s_RCM04_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2030s_RCM04)
    Flow_Sim_future_2030s_RCM04_monthly_mean(j,1)=nanmean(Flow_Sim_future_2030s_RCM04(j:j+29));
end
Flow_Sim_future_2030s_RCM04_monthly_mean(any(Flow_Sim_future_2030s_RCM04_monthly_mean==0,2))=[];
 
%% RCM05
Flow_Sim_future_2030s_RCM05_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2030s_RCM05)
    Flow_Sim_future_2030s_RCM05_monthly_mean(j,1)=nanmean(Flow_Sim_future_2030s_RCM05(j:j+29));
end
Flow_Sim_future_2030s_RCM05_monthly_mean(any(Flow_Sim_future_2030s_RCM05_monthly_mean==0,2))=[];
 
%% RCM06
Flow_Sim_future_2030s_RCM06_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2030s_RCM06)
    Flow_Sim_future_2030s_RCM06_monthly_mean(j,1)=nanmean(Flow_Sim_future_2030s_RCM06(j:j+29));
end
Flow_Sim_future_2030s_RCM06_monthly_mean(any(Flow_Sim_future_2030s_RCM06_monthly_mean==0,2))=[];
 
%% RCM07
Flow_Sim_future_2030s_RCM07_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2030s_RCM07)
    Flow_Sim_future_2030s_RCM07_monthly_mean(j,1)=nanmean(Flow_Sim_future_2030s_RCM07(j:j+29));
end
Flow_Sim_future_2030s_RCM07_monthly_mean(any(Flow_Sim_future_2030s_RCM07_monthly_mean==0,2))=[];
 
%% RCM08
Flow_Sim_future_2030s_RCM08_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2030s_RCM08)
    Flow_Sim_future_2030s_RCM08_monthly_mean(j,1)=nanmean(Flow_Sim_future_2030s_RCM08(j:j+29));
end
Flow_Sim_future_2030s_RCM08_monthly_mean(any(Flow_Sim_future_2030s_RCM08_monthly_mean==0,2))=[];
 
%% RCM09
Flow_Sim_future_2030s_RCM09_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2030s_RCM09)
    Flow_Sim_future_2030s_RCM09_monthly_mean(j,1)=nanmean(Flow_Sim_future_2030s_RCM09(j:j+29));
end
Flow_Sim_future_2030s_RCM09_monthly_mean(any(Flow_Sim_future_2030s_RCM09_monthly_mean==0,2))=[];
 
%% RCM10
Flow_Sim_future_2030s_RCM10_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2030s_RCM10)
    Flow_Sim_future_2030s_RCM10_monthly_mean(j,1)=nanmean(Flow_Sim_future_2030s_RCM10(j:j+29));
end
Flow_Sim_future_2030s_RCM10_monthly_mean(any(Flow_Sim_future_2030s_RCM10_monthly_mean==0,2))=[];
 
%% RCM11
Flow_Sim_future_2030s_RCM11_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2030s_RCM11)
    Flow_Sim_future_2030s_RCM11_monthly_mean(j,1)=nanmean(Flow_Sim_future_2030s_RCM11(j:j+29));
end
Flow_Sim_future_2030s_RCM11_monthly_mean(any(Flow_Sim_future_2030s_RCM11_monthly_mean==0,2))=[];
 
%% RCM12
Flow_Sim_future_2030s_RCM12_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2030s_RCM12)
    Flow_Sim_future_2030s_RCM12_monthly_mean(j,1)=nanmean(Flow_Sim_future_2030s_RCM12(j:j+29));
end
Flow_Sim_future_2030s_RCM12_monthly_mean(any(Flow_Sim_future_2030s_RCM12_monthly_mean==0,2))=[];
 
%% RCM13
Flow_Sim_future_2030s_RCM13_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2030s_RCM13)
    Flow_Sim_future_2030s_RCM13_monthly_mean(j,1)=nanmean(Flow_Sim_future_2030s_RCM13(j:j+29));
end
Flow_Sim_future_2030s_RCM13_monthly_mean(any(Flow_Sim_future_2030s_RCM13_monthly_mean==0,2))=[];
 
%% RCM15
Flow_Sim_future_2030s_RCM15_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2030s_RCM15)
    Flow_Sim_future_2030s_RCM15_monthly_mean(j,1)=nanmean(Flow_Sim_future_2030s_RCM15(j:j+29));
end
Flow_Sim_future_2030s_RCM15_monthly_mean(any(Flow_Sim_future_2030s_RCM15_monthly_mean==0,2))=[];
 
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Get monthly future 2050s spring flows
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
%% All RCMs
Flow_Sim_future_2050s_allRCM_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2050s_allRCM)
    Flow_Sim_future_2050s_allRCM_monthly_mean(j,1)=nanmean(Flow_Sim_future_2050s_allRCM(j:j+29));
end
Flow_Sim_future_2050s_allRCM_monthly_mean(any(Flow_Sim_future_2050s_allRCM_monthly_mean==0,2))=[];
 
%% RCM01
Flow_Sim_future_2050s_RCM01_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2050s_RCM01)
    Flow_Sim_future_2050s_RCM01_monthly_mean(j,1)=nanmean(Flow_Sim_future_2050s_RCM01(j:j+29));
end
Flow_Sim_future_2050s_RCM01_monthly_mean(any(Flow_Sim_future_2050s_RCM01_monthly_mean==0,2))=[];
 
%% RCM04
Flow_Sim_future_2050s_RCM04_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2050s_RCM04)
    Flow_Sim_future_2050s_RCM04_monthly_mean(j,1)=nanmean(Flow_Sim_future_2050s_RCM04(j:j+29));
end
Flow_Sim_future_2050s_RCM04_monthly_mean(any(Flow_Sim_future_2050s_RCM04_monthly_mean==0,2))=[];
 
%% RCM05
Flow_Sim_future_2050s_RCM05_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2050s_RCM05)
    Flow_Sim_future_2050s_RCM05_monthly_mean(j,1)=nanmean(Flow_Sim_future_2050s_RCM05(j:j+29));
end
Flow_Sim_future_2050s_RCM05_monthly_mean(any(Flow_Sim_future_2050s_RCM05_monthly_mean==0,2))=[];
 
%% RCM06
Flow_Sim_future_2050s_RCM06_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2050s_RCM06)
    Flow_Sim_future_2050s_RCM06_monthly_mean(j,1)=nanmean(Flow_Sim_future_2050s_RCM06(j:j+29));
end
Flow_Sim_future_2050s_RCM06_monthly_mean(any(Flow_Sim_future_2050s_RCM06_monthly_mean==0,2))=[];
 
%% RCM07
Flow_Sim_future_2050s_RCM07_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2050s_RCM07)
    Flow_Sim_future_2050s_RCM07_monthly_mean(j,1)=nanmean(Flow_Sim_future_2050s_RCM07(j:j+29));
end
Flow_Sim_future_2050s_RCM07_monthly_mean(any(Flow_Sim_future_2050s_RCM07_monthly_mean==0,2))=[];
 
%% RCM08
Flow_Sim_future_2050s_RCM08_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2050s_RCM08)
    Flow_Sim_future_2050s_RCM08_monthly_mean(j,1)=nanmean(Flow_Sim_future_2050s_RCM08(j:j+29));
end
Flow_Sim_future_2050s_RCM08_monthly_mean(any(Flow_Sim_future_2050s_RCM08_monthly_mean==0,2))=[];
 
%% RCM09
Flow_Sim_future_2050s_RCM09_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2050s_RCM09)
    Flow_Sim_future_2050s_RCM09_monthly_mean(j,1)=nanmean(Flow_Sim_future_2050s_RCM09(j:j+29));
end
Flow_Sim_future_2050s_RCM09_monthly_mean(any(Flow_Sim_future_2050s_RCM09_monthly_mean==0,2))=[];
 
%% RCM10
Flow_Sim_future_2050s_RCM10_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2050s_RCM10)
    Flow_Sim_future_2050s_RCM10_monthly_mean(j,1)=nanmean(Flow_Sim_future_2050s_RCM10(j:j+29));
end
Flow_Sim_future_2050s_RCM10_monthly_mean(any(Flow_Sim_future_2050s_RCM10_monthly_mean==0,2))=[];
 
%% RCM11
Flow_Sim_future_2050s_RCM11_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2050s_RCM11)
    Flow_Sim_future_2050s_RCM11_monthly_mean(j,1)=nanmean(Flow_Sim_future_2050s_RCM11(j:j+29));
end
Flow_Sim_future_2050s_RCM11_monthly_mean(any(Flow_Sim_future_2050s_RCM11_monthly_mean==0,2))=[];
 
%% RCM12
Flow_Sim_future_2050s_RCM12_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2050s_RCM12)
    Flow_Sim_future_2050s_RCM12_monthly_mean(j,1)=nanmean(Flow_Sim_future_2050s_RCM12(j:j+29));
end
Flow_Sim_future_2050s_RCM12_monthly_mean(any(Flow_Sim_future_2050s_RCM12_monthly_mean==0,2))=[];
 
%% RCM13
Flow_Sim_future_2050s_RCM13_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2050s_RCM13)
    Flow_Sim_future_2050s_RCM13_monthly_mean(j,1)=nanmean(Flow_Sim_future_2050s_RCM13(j:j+29));
end
Flow_Sim_future_2050s_RCM13_monthly_mean(any(Flow_Sim_future_2050s_RCM13_monthly_mean==0,2))=[];
 
%% RCM15
Flow_Sim_future_2050s_RCM15_monthly_mean=[];
 
for j=1:30:length(Flow_Sim_future_2050s_RCM15)
    Flow_Sim_future_2050s_RCM15_monthly_mean(j,1)=nanmean(Flow_Sim_future_2050s_RCM15(j:j+29));
end
Flow_Sim_future_2050s_RCM15_monthly_mean(any(Flow_Sim_future_2050s_RCM15_monthly_mean==0,2))=[];
 
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Get baseline vs future 2030s monthly percentage difference
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Table for differences
Table_monthly=[];
 
for j=1:93
    % Baseline info
    Table_monthly{j,1}=Months_baseline(j,:);
    Table_monthly{j,2}=Flow_Obs_baseline_monthly_mean(j,1);
    Table_monthly{j,3}=Months_2030s(j,:);
   
    % Future 2030s info for each RCM
    Table_monthly{j,4}=Flow_Sim_future_2030s_RCM01_monthly_mean(j,1);
    Table_monthly{j,5}=Flow_Sim_future_2030s_RCM04_monthly_mean(j,1);
    Table_monthly{j,6}=Flow_Sim_future_2030s_RCM05_monthly_mean(j,1);
    Table_monthly{j,7}=Flow_Sim_future_2030s_RCM06_monthly_mean(j,1);
    Table_monthly{j,8}=Flow_Sim_future_2030s_RCM07_monthly_mean(j,1);
    Table_monthly{j,9}=Flow_Sim_future_2030s_RCM08_monthly_mean(j,1);
    Table_monthly{j,10}=Flow_Sim_future_2030s_RCM09_monthly_mean(j,1);
    Table_monthly{j,11}=Flow_Sim_future_2030s_RCM10_monthly_mean(j,1);
    Table_monthly{j,12}=Flow_Sim_future_2030s_RCM11_monthly_mean(j,1);
    Table_monthly{j,13}=Flow_Sim_future_2030s_RCM12_monthly_mean(j,1);
    Table_monthly{j,14}=Flow_Sim_future_2030s_RCM13_monthly_mean(j,1);
    Table_monthly{j,15}=Flow_Sim_future_2030s_RCM15_monthly_mean(j,1);
 
    % Future 2030s info for all RCMS
    Table_monthly{j,16}=Flow_Sim_future_2030s_allRCM_monthly_mean(j,1);
 
    % Future 2030s info for the differences
    Table_monthly{j,17}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2030s_RCM01_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,18}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2030s_RCM04_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,19}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2030s_RCM05_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,20}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2030s_RCM06_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,21}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2030s_RCM07_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,22}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2030s_RCM08_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,23}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2030s_RCM09_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,24}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2030s_RCM10_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,25}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2030s_RCM11_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,26}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2030s_RCM12_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,27}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2030s_RCM13_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,28}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2030s_RCM15_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
 
    % Future 2030s info for the difference for all RCMs
    Table_monthly{j,29}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2030s_allRCM_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
 
    % Same as above, but for the plots
    Flow_diff_monthly_RCM01(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2030s_RCM01_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Flow_diff_monthly_RCM04(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2030s_RCM04_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Flow_diff_monthly_RCM05(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2030s_RCM05_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Flow_diff_monthly_RCM06(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2030s_RCM06_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Flow_diff_monthly_RCM07(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2030s_RCM07_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Flow_diff_monthly_RCM08(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2030s_RCM08_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Flow_diff_monthly_RCM09(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2030s_RCM09_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Flow_diff_monthly_RCM10(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2030s_RCM10_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Flow_diff_monthly_RCM11(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2030s_RCM11_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Flow_diff_monthly_RCM12(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2030s_RCM12_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Flow_diff_monthly_RCM13(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2030s_RCM13_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Flow_diff_monthly_RCM15(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2030s_RCM15_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
 
    Flow_diff_monthly_allRCM_2030s(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2030s_allRCM_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
end
    
Table_monthly_header={'Baseline','Baseline monthly mean spring flows [m^3/s]','RCM01 monthly mean spring flow [m^3/s]','RCM04 monthly mean spring flow [m^3/s]','RCM05 monthly mean spring flow [m^3/s]','RCM06 monthly mean spring flow [m^3/s]','RCM07 monthly mean spring flow [m^3/s]','RCM08 monthly mean spring flow [m^3/s]','RCM09 monthly mean spring flow [m^3/s]','RCM10 monthly mean spring flow [m^3/s]','RCM11 monthly mean spring flow [m^3/s]','RCM12 monthly mean spring flow [m^3/s]','RCM13 monthly mean spring flow [m^3/s]','RCM15 monthly mean spring flow [m^3/s]','All RCM future monthly mean spring flow [m^3/s]','Baseline-RCM01 [%]','Baseline-RCM04 [%]','Baseline-RCM05 [%]','Baseline-RCM06 [%]','Baseline-RCM07 [%]','Baseline-RCM08 [%]','Baseline-RCM09 [%]','Baseline-RCM10 [%]' ,'Baseline-RCM11 [%]','Baseline-RCM12 [%]','Baseline-RCM13 [%]','Baseline-RCM15 [%]','Baseline mean-Future mean flow [%]'};
 
%Write the table into an excel file
 
if exist(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Station_',no,'_flows_2030s_monthly_vs_baseline.xls'), 'file')==2
   delete(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Station_',no,'_flows_2030s_monthly_vs_baseline.xls'));
end
 
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Station_',no,'_flows_2030s_monthly_vs_baseline.xls'),Table_monthly,'Sheet1','A2');
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Station_',no,'_flows_2030s_monthly_vs_baseline.xls'),Table_monthly_header,'Sheet1','A1');
 
%% Plot the differences in monthly mean spring flows
 
No_of_months=[1:93];
No_of_months=No_of_months.';
x_max=length(No_of_months);
 
ymin=-300;
ymax=+300;
 
X_line_zero=zeros(length(No_of_months),1);
 
%% Difference in monthly mean spring flows for RCM01
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2030s\Monthly_mean_flows_diff_RCM01_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2030s monthly mean spring flows and baseline spring flows at station no.'," ",no," ",'for RCM01');
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
 
%% Difference in monthly mean spring flows for RCM04
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2030s\Monthly_mean_flows_diff_RCM04_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2030s monthly mean spring flows and baseline spring flows at station no.'," ",no," ",'for RCM04');
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
 
%% Difference in monthly mean spring flows for RCM05
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2030s\Monthly_mean_flows_diff_RCM05_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2030s monthly mean spring flows and baseline spring flows at station no.'," ",no," ",'for RCM05');
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
 
%% Difference in monthly mean spring flows for RCM06
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2030s\Monthly_mean_flows_diff_RCM06_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2030s monthly mean spring flows and baseline spring flows at station no.'," ",no," ",'for RCM06');
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
 
%% Difference in monthly mean spring flows for RCM07
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2030s\Monthly_mean_flows_diff_RCM07_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2030s monthly mean spring flows and baseline spring flows at station no.'," ",no," ",'for RCM07');
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
 
%% Difference in monthly mean spring flows for RCM08
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2030s\Monthly_mean_flows_diff_RCM08_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2030s monthly mean spring flows and baseline spring flows at station no.'," ",no," ",'for RCM08');
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
 
%% Difference in monthly mean spring flows for RCM09
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2030s\Monthly_mean_flows_diff_RCM09_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2030s monthly mean spring flows and baseline spring flows at station no.'," ",no," ",'for RCM09');
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
 
%% Difference in monthly mean spring flows for RCM10
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2030s\Monthly_mean_flows_diff_RCM10_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2030s monthly mean spring flows and baseline spring flows at station no.'," ",no," ",'for RCM10');
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
 
%% Difference in monthly mean spring flows for RCM11
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2030s\Monthly_mean_flows_diff_RCM11_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2030s monthly mean spring flows and baseline spring flows at station no.'," ",no," ",'for RCM11');
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
 
%% Difference in monthly mean spring flows for RCM12
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2030s\Monthly_mean_flows_diff_RCM12_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2030s monthly mean spring flows and baseline spring flows at station no.'," ",no," ",'for RCM12');
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
 
%% Difference in monthly mean spring flows for RCM13
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2030s\Monthly_mean_flows_diff_RCM13_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2030s monthly mean spring flows and baseline spring flows at station no.'," ",no," ",'for RCM13');
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
 
%% Difference in monthly mean spring flows for RCM15
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2030s\Monthly_mean_flows_diff_RCM15_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2030s monthly mean spring flows and baseline spring flows at station no.'," ",no," ",'for RCM15');
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
 
%% Difference in monthly mean spring flows for all RCMs
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2030s\Monthly_mean_flows_diff_allRCM_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2030s monthly mean spring flows and baseline spring flows at station no.'," ",no," ",'for all RCMs');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Flow_diff_monthly_allRCM_2030s);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Get baseline vs future 2050s monthly percentage difference
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Table_monthly=[];
 
for j=1:length(Months_baseline)
    % Baseline info
    Table_monthly{j,1}=Months_baseline(j,:);
    Table_monthly{j,2}=Flow_Obs_baseline_monthly_mean(j,1);
    Table_monthly{j,3}=Months_2050s(j,:);
   
    % Future 2050s info for each RCM
    Table_monthly{j,4}=Flow_Sim_future_2050s_RCM01_monthly_mean(j,1);
    Table_monthly{j,5}=Flow_Sim_future_2050s_RCM04_monthly_mean(j,1);
    Table_monthly{j,6}=Flow_Sim_future_2050s_RCM05_monthly_mean(j,1);
    Table_monthly{j,7}=Flow_Sim_future_2050s_RCM06_monthly_mean(j,1);
    Table_monthly{j,8}=Flow_Sim_future_2050s_RCM07_monthly_mean(j,1);
    Table_monthly{j,9}=Flow_Sim_future_2050s_RCM08_monthly_mean(j,1);
    Table_monthly{j,10}=Flow_Sim_future_2050s_RCM09_monthly_mean(j,1);
    Table_monthly{j,11}=Flow_Sim_future_2050s_RCM10_monthly_mean(j,1);
    Table_monthly{j,12}=Flow_Sim_future_2050s_RCM11_monthly_mean(j,1);
    Table_monthly{j,13}=Flow_Sim_future_2050s_RCM12_monthly_mean(j,1);
    Table_monthly{j,14}=Flow_Sim_future_2050s_RCM13_monthly_mean(j,1);
    Table_monthly{j,15}=Flow_Sim_future_2050s_RCM15_monthly_mean(j,1);
 
    % Future 2050s info for all RCMS
    Table_monthly{j,16}=Flow_Sim_future_2050s_allRCM_monthly_mean(j,1);
 
    % Future 2050s info for the differences
    Table_monthly{j,17}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2050s_RCM01_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,18}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2050s_RCM04_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,19}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2050s_RCM05_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,20}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2050s_RCM06_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,21}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2050s_RCM07_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,22}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2050s_RCM08_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,23}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2050s_RCM09_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,24}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2050s_RCM10_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,25}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2050s_RCM11_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,26}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2050s_RCM12_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,27}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2050s_RCM13_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,28}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2050s_RCM15_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
 
    % Future 2050s infor for the difference for all RCMs
    Table_monthly{j,29}=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2050s_allRCM_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
 
    % Same as above, but for the plots
    Flow_diff_monthly_RCM01(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2050s_RCM01_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Flow_diff_monthly_RCM04(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2050s_RCM04_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Flow_diff_monthly_RCM05(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2050s_RCM05_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Flow_diff_monthly_RCM06(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2050s_RCM06_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Flow_diff_monthly_RCM07(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2050s_RCM07_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Flow_diff_monthly_RCM08(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2050s_RCM08_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Flow_diff_monthly_RCM09(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2050s_RCM09_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Flow_diff_monthly_RCM10(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2050s_RCM10_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Flow_diff_monthly_RCM11(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2050s_RCM11_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Flow_diff_monthly_RCM12(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2050s_RCM12_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Flow_diff_monthly_RCM13(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2050s_RCM13_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
    Flow_diff_monthly_RCM15(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2050s_RCM15_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
 
    Flow_diff_monthly_allRCM_2050s(j,1)=(Flow_Obs_baseline_monthly_mean(j,1)-Flow_Sim_future_2050s_allRCM_monthly_mean(j,1))/Flow_Obs_baseline_monthly_mean(j,1)*100;
end
    
Table_monthly_header={'Baseline','Baseline monthly mean spring flows [m^3/s]','Future','RCM01 monthly mean spring flow [m^3/s]','RCM04 monthly mean spring flow [m^3/s]','RCM05 monthly mean spring flow [m^3/s]','RCM06 monthly mean spring flow [m^3/s]','RCM07 monthly mean spring flow [m^3/s]','RCM08 monthly mean spring flow [m^3/s]','RCM09 monthly mean spring flow [m^3/s]','RCM10 monthly mean spring flow [m^3/s]','RCM11 monthly mean spring flow [m^3/s]','RCM12 monthly mean spring flow [m^3/s]','RCM13 monthly mean spring flow [m^3/s]','RCM15 monthly mean spring flow [m^3/s]','All RCM future monthly mean spring flow [m^3/s]','Baseline-RCM01 [%]','Baseline-RCM04 [%]','Baseline-RCM05 [%]','Baseline-RCM06 [%]','Baseline-RCM07 [%]','Baseline-RCM08 [%]','Baseline-RCM09 [%]','Baseline-RCM10 [%]' ,'Baseline-RCM11 [%]','Baseline-RCM12 [%]','Baseline-RCM13 [%]','Baseline-RCM15 [%]','Baseline mean-Future mean flow [%]'};
 
%Write the table into an excel file
 
if exist(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Station_',no,'_flows_2050s_monthly_vs_baseline.xls'), 'file')==2
   delete(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Station_',no,'_flows_2050s_monthly_vs_baseline.xls'));
end
 
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Station_',no,'_flows_2050s_monthly_vs_baseline.xls'),Table_monthly,'Sheet1','A2');
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Station_',no,'_flows_2050s_monthly_vs_baseline.xls'),Table_monthly_header,'Sheet1','A1');
 
%% Plot the differences in monthly mean spring flows
 
No_of_months=[1:length(Months_baseline)];
No_of_months=No_of_months.';
x_max=length(No_of_months);
 
ymin=-300;
ymax=+300;
 
X_line_zero=zeros(length(No_of_months),1);
 
%% Difference in monthly mean spring flows for RCM01
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2050s\Monthly_mean_flows_diff_RCM01_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2050s monthly mean spring flows and baseline spring flows at station no.'," ",no," ",'for RCM01');
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
 
%% Difference in monthly mean spring flows for RCM04
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2050s\Monthly_mean_flows_diff_RCM04_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2050s monthly mean spring flows and baseline spring flows at station no.'," ",no," ",'for RCM04');
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
 
%% Difference in monthly mean spring flows for RCM05
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2050s\Monthly_mean_flows_diff_RCM05_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2050s monthly mean spring flows and baseline spring flows at station no.'," ",no," ",'for RCM05');
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
 
%% Difference in monthly mean spring flows for RCM06
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2050s\Monthly_mean_flows_diff_RCM06_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2050s monthly mean spring flows and baseline spring flows at station no.'," ",no," ",'for RCM06');
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
 
%% Difference in monthly mean spring flows for RCM07
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2050s\Monthly_mean_flows_diff_RCM07_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2050s monthly mean spring flows and baseline spring flows at station no.'," ",no," ",'for RCM07');
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
 
%% Difference in monthly mean spring flows for RCM08
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2050s\Monthly_mean_flows_diff_RCM08_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2050s monthly mean spring flows and baseline spring flows at station no.'," ",no," ",'for RCM08');
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
 
%% Difference in monthly mean spring flows for RCM09
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2050s\Monthly_mean_flows_diff_RCM09_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2050s monthly mean spring flows and baseline spring flows at station no.'," ",no," ",'for RCM09');
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
 
%% Difference in monthly mean spring flows for RCM10
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2050s\Monthly_mean_flows_diff_RCM10_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2050s monthly mean spring flows and baseline spring flows at station no.'," ",no," ",'for RCM10');
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
 
%% Difference in monthly mean spring flows for RCM11
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2050s\Monthly_mean_flows_diff_RCM11_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2050s monthly mean spring flows and baseline spring flows at station no.'," ",no," ",'for RCM11');
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
 
%% Difference in monthly mean spring flows for RCM12
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2050s\Monthly_mean_flows_diff_RCM12_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2050s monthly mean spring flows and baseline spring flows at station no.'," ",no," ",'for RCM12');
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
 
%% Difference in monthly mean spring flows for RCM13
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2050s\Monthly_mean_flows_diff_RCM13_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2050s monthly mean spring flows and baseline spring flows at station no.'," ",no," ",'for RCM13');
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
 
%% Difference in monthly mean spring flows for RCM15
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2050s\Monthly_mean_flows_diff_RCM15_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2050s monthly mean spring flows and baseline spring flows at station no.'," ",no," ",'for RCM15');
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
 
%% Difference in monthly mean spring flows for all RCMs
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2050s\Monthly_mean_flows_diff_allRCM_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2050s monthly mean spring flows and baseline spring flows at station no.'," ",no," ",'for all RCMs');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Flow_diff_monthly_allRCM_2050s);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
 
%% Get annual baseline spring flows
Table_baseline=[];
Annual_values_baseline_mean=[];
 
Table_baseline=Time_Obs_baseline;
Table_baseline=timetable(Time_Obs_baseline,Flow_Obs_baseline);
 
Annual_values_baseline_mean=convert2annual(Table_baseline,'Aggregation',["mean"]);
Flow_Obs_baseline_annual_mean=Annual_values_baseline_mean;
 
Flow_Obs_baseline_annual_mean=table2array(Flow_Obs_baseline_annual_mean);
 
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Get annual future 2030s mean spring flows
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
%% Calculate the mean annual spring flow considering all the RCMs
%% All RCMs
Flow_Sim_future_2030s_allRCM_annual_mean=[];
 
for j=1:90:length(Flow_Sim_future_2030s_allRCM)
    Flow_Sim_future_2030s_allRCM_annual_mean(j,1)=nanmean(Flow_Sim_future_2030s_allRCM(j:j+89));
end
Flow_Sim_future_2030s_allRCM_annual_mean(any(Flow_Sim_future_2030s_allRCM_annual_mean==0,2))=[];
 
%% RCM01
Flow_Sim_future_2030s_RCM01_annual_mean=[];
 
for j=1:90:length(Flow_Sim_future_2030s_RCM01)
    Flow_Sim_future_2030s_RCM01_annual_mean(j,1)=nanmean(Flow_Sim_future_2030s_RCM01(j:j+89));
end
Flow_Sim_future_2030s_RCM01_annual_mean(any(Flow_Sim_future_2030s_RCM01_annual_mean==0,2))=[];
 
%% RCM04
Flow_Sim_future_2030s_RCM04_annual_mean=[];
 
for j=1:90:length(Flow_Sim_future_2030s_RCM04)
    Flow_Sim_future_2030s_RCM04_annual_mean(j,1)=nanmean(Flow_Sim_future_2030s_RCM04(j:j+89));
end
Flow_Sim_future_2030s_RCM04_annual_mean(any(Flow_Sim_future_2030s_RCM04_annual_mean==0,2))=[];
 
%% RCM05
Flow_Sim_future_2030s_RCM05_annual_mean=[];
 
for j=1:90:length(Flow_Sim_future_2030s_RCM05)
    Flow_Sim_future_2030s_RCM05_annual_mean(j,1)=nanmean(Flow_Sim_future_2030s_RCM05(j:j+89));
end
Flow_Sim_future_2030s_RCM05_annual_mean(any(Flow_Sim_future_2030s_RCM05_annual_mean==0,2))=[];
 
%% RCM06
Flow_Sim_future_2030s_RCM06_annual_mean=[];
 
for j=1:90:length(Flow_Sim_future_2030s_RCM06)
    Flow_Sim_future_2030s_RCM06_annual_mean(j,1)=nanmean(Flow_Sim_future_2030s_RCM06(j:j+89));
end
Flow_Sim_future_2030s_RCM06_annual_mean(any(Flow_Sim_future_2030s_RCM06_annual_mean==0,2))=[];
 
%% RCM07
Flow_Sim_future_2030s_RCM07_annual_mean=[];
 
for j=1:90:length(Flow_Sim_future_2030s_RCM07)
    Flow_Sim_future_2030s_RCM07_annual_mean(j,1)=nanmean(Flow_Sim_future_2030s_RCM07(j:j+89));
end
Flow_Sim_future_2030s_RCM07_annual_mean(any(Flow_Sim_future_2030s_RCM07_annual_mean==0,2))=[];
 
%% RCM08
Flow_Sim_future_2030s_RCM08_annual_mean=[];
 
for j=1:90:length(Flow_Sim_future_2030s_RCM08)
    Flow_Sim_future_2030s_RCM08_annual_mean(j,1)=nanmean(Flow_Sim_future_2030s_RCM08(j:j+89));
end
Flow_Sim_future_2030s_RCM08_annual_mean(any(Flow_Sim_future_2030s_RCM08_annual_mean==0,2))=[];
 
%% RCM09
Flow_Sim_future_2030s_RCM09_annual_mean=[];
 
for j=1:90:length(Flow_Sim_future_2030s_RCM09)
    Flow_Sim_future_2030s_RCM09_annual_mean(j,1)=nanmean(Flow_Sim_future_2030s_RCM09(j:j+89));
end
Flow_Sim_future_2030s_RCM09_annual_mean(any(Flow_Sim_future_2030s_RCM09_annual_mean==0,2))=[];
 
%% RCM10
Flow_Sim_future_2030s_RCM10_annual_mean=[];
 
for j=1:90:length(Flow_Sim_future_2030s_RCM10)
    Flow_Sim_future_2030s_RCM10_annual_mean(j,1)=nanmean(Flow_Sim_future_2030s_RCM10(j:j+89));
end
Flow_Sim_future_2030s_RCM10_annual_mean(any(Flow_Sim_future_2030s_RCM10_annual_mean==0,2))=[];
 
%% RCM11
Flow_Sim_future_2030s_RCM11_annual_mean=[];
 
for j=1:90:length(Flow_Sim_future_2030s_RCM11)
    Flow_Sim_future_2030s_RCM11_annual_mean(j,1)=nanmean(Flow_Sim_future_2030s_RCM11(j:j+89));
end
Flow_Sim_future_2030s_RCM11_annual_mean(any(Flow_Sim_future_2030s_RCM11_annual_mean==0,2))=[];
 
%% RCM12
Flow_Sim_future_2030s_RCM12_annual_mean=[];
 
for j=1:90:length(Flow_Sim_future_2030s_RCM12)
    Flow_Sim_future_2030s_RCM12_annual_mean(j,1)=nanmean(Flow_Sim_future_2030s_RCM12(j:j+89));
end
Flow_Sim_future_2030s_RCM12_annual_mean(any(Flow_Sim_future_2030s_RCM12_annual_mean==0,2))=[];
 
%% RCM13
Flow_Sim_future_2030s_RCM13_annual_mean=[];
 
for j=1:90:length(Flow_Sim_future_2030s_RCM13)
    Flow_Sim_future_2030s_RCM13_annual_mean(j,1)=nanmean(Flow_Sim_future_2030s_RCM13(j:j+89));
end
Flow_Sim_future_2030s_RCM13_annual_mean(any(Flow_Sim_future_2030s_RCM13_annual_mean==0,2))=[];
 
%% RCM15
Flow_Sim_future_2030s_RCM15_annual_mean=[];
 
for j=1:90:length(Flow_Sim_future_2030s_RCM15)
    Flow_Sim_future_2030s_RCM15_annual_mean(j,1)=nanmean(Flow_Sim_future_2030s_RCM15(j:j+89));
end
Flow_Sim_future_2030s_RCM15_annual_mean(any(Flow_Sim_future_2030s_RCM15_annual_mean==0,2))=[];
 
%% Get annual future 2050s mean spring flows
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
%% Calculate the mean annual spring flow considering all the RCMs
%% All RCMs
Flow_Sim_future_2050s_allRCM_annual_mean=[];
 
for j=1:90:length(Flow_Sim_future_2050s_allRCM)
    Flow_Sim_future_2050s_allRCM_annual_mean(j,1)=nanmean(Flow_Sim_future_2050s_allRCM(j:j+89));
end
Flow_Sim_future_2050s_allRCM_annual_mean(any(Flow_Sim_future_2050s_allRCM_annual_mean==0,2))=[];
 
%% RCM01
Flow_Sim_future_2050s_RCM01_annual_mean=[];
 
for j=1:90:length(Flow_Sim_future_2050s_RCM01)
    Flow_Sim_future_2050s_RCM01_annual_mean(j,1)=nanmean(Flow_Sim_future_2050s_RCM01(j:j+89));
end
Flow_Sim_future_2050s_RCM01_annual_mean(any(Flow_Sim_future_2050s_RCM01_annual_mean==0,2))=[];
 
%% RCM04
Flow_Sim_future_2050s_RCM04_annual_mean=[];
 
for j=1:90:length(Flow_Sim_future_2050s_RCM04)
    Flow_Sim_future_2050s_RCM04_annual_mean(j,1)=nanmean(Flow_Sim_future_2050s_RCM04(j:j+89));
end
Flow_Sim_future_2050s_RCM04_annual_mean(any(Flow_Sim_future_2050s_RCM04_annual_mean==0,2))=[];
 
%% RCM05
Flow_Sim_future_2050s_RCM05_annual_mean=[];
 
for j=1:90:length(Flow_Sim_future_2050s_RCM05)
    Flow_Sim_future_2050s_RCM05_annual_mean(j,1)=nanmean(Flow_Sim_future_2050s_RCM05(j:j+89));
end
Flow_Sim_future_2050s_RCM05_annual_mean(any(Flow_Sim_future_2050s_RCM05_annual_mean==0,2))=[];
 
%% RCM06
Flow_Sim_future_2050s_RCM06_annual_mean=[];
 
for j=1:90:length(Flow_Sim_future_2050s_RCM06)
    Flow_Sim_future_2050s_RCM06_annual_mean(j,1)=nanmean(Flow_Sim_future_2050s_RCM06(j:j+89));
end
Flow_Sim_future_2050s_RCM06_annual_mean(any(Flow_Sim_future_2050s_RCM06_annual_mean==0,2))=[];
 
%% RCM07
Flow_Sim_future_2050s_RCM07_annual_mean=[];
 
for j=1:90:length(Flow_Sim_future_2050s_RCM07)
    Flow_Sim_future_2050s_RCM07_annual_mean(j,1)=nanmean(Flow_Sim_future_2050s_RCM07(j:j+89));
end
Flow_Sim_future_2050s_RCM07_annual_mean(any(Flow_Sim_future_2050s_RCM07_annual_mean==0,2))=[];
 
%% RCM08
Flow_Sim_future_2050s_RCM08_annual_mean=[];
 
for j=1:90:length(Flow_Sim_future_2050s_RCM08)
    Flow_Sim_future_2050s_RCM08_annual_mean(j,1)=nanmean(Flow_Sim_future_2050s_RCM08(j:j+89));
end
Flow_Sim_future_2050s_RCM08_annual_mean(any(Flow_Sim_future_2050s_RCM08_annual_mean==0,2))=[];
 
%% RCM09
Flow_Sim_future_2050s_RCM09_annual_mean=[];
 
for j=1:90:length(Flow_Sim_future_2050s_RCM09)
    Flow_Sim_future_2050s_RCM09_annual_mean(j,1)=nanmean(Flow_Sim_future_2050s_RCM09(j:j+89));
end
Flow_Sim_future_2050s_RCM09_annual_mean(any(Flow_Sim_future_2050s_RCM09_annual_mean==0,2))=[];
 
%% RCM10
Flow_Sim_future_2050s_RCM10_annual_mean=[];
 
for j=1:90:length(Flow_Sim_future_2050s_RCM10)
    Flow_Sim_future_2050s_RCM10_annual_mean(j,1)=nanmean(Flow_Sim_future_2050s_RCM10(j:j+89));
end
Flow_Sim_future_2050s_RCM10_annual_mean(any(Flow_Sim_future_2050s_RCM10_annual_mean==0,2))=[];
 
%% RCM11
Flow_Sim_future_2050s_RCM11_annual_mean=[];
 
for j=1:90:length(Flow_Sim_future_2050s_RCM11)
    Flow_Sim_future_2050s_RCM11_annual_mean(j,1)=nanmean(Flow_Sim_future_2050s_RCM11(j:j+89));
end
Flow_Sim_future_2050s_RCM11_annual_mean(any(Flow_Sim_future_2050s_RCM11_annual_mean==0,2))=[];
 
%% RCM12
Flow_Sim_future_2050s_RCM12_annual_mean=[];
 
for j=1:90:length(Flow_Sim_future_2050s_RCM12)
    Flow_Sim_future_2050s_RCM12_annual_mean(j,1)=nanmean(Flow_Sim_future_2050s_RCM12(j:j+89));
end
Flow_Sim_future_2050s_RCM12_annual_mean(any(Flow_Sim_future_2050s_RCM12_annual_mean==0,2))=[];
 
%% RCM13
Flow_Sim_future_2050s_RCM13_annual_mean=[];
 
for j=1:90:length(Flow_Sim_future_2050s_RCM13)
    Flow_Sim_future_2050s_RCM13_annual_mean(j,1)=nanmean(Flow_Sim_future_2050s_RCM13(j:j+89));
end
Flow_Sim_future_2050s_RCM13_annual_mean(any(Flow_Sim_future_2050s_RCM13_annual_mean==0,2))=[];
 
%% RCM15
Flow_Sim_future_2050s_RCM15_annual_mean=[];
 
for j=1:90:length(Flow_Sim_future_2050s_RCM15)
    Flow_Sim_future_2050s_RCM15_annual_mean(j,1)=nanmean(Flow_Sim_future_2050s_RCM15(j:j+89));
end
Flow_Sim_future_2050s_RCM15_annual_mean(any(Flow_Sim_future_2050s_RCM15_annual_mean==0,2))=[];
 
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Get baseline vs future 2030s annual percentage difference
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Table for the differences
Table_annual=[];
 
for j=1:length(Years_baseline)
    % Baseline info
    Table_annual{j,1}=Years_baseline(j,:);
    Table_annual{j,2}=Flow_Obs_baseline_annual_mean(j,1);
    Table_annual{j,3}=Years_2030s(j,:);
   
    % Future 2030s info for each RCM
    Table_annual{j,4}=Flow_Sim_future_2030s_RCM01_annual_mean(j,1);
    Table_annual{j,5}=Flow_Sim_future_2030s_RCM04_annual_mean(j,1);
    Table_annual{j,6}=Flow_Sim_future_2030s_RCM05_annual_mean(j,1);
    Table_annual{j,7}=Flow_Sim_future_2030s_RCM06_annual_mean(j,1);
    Table_annual{j,8}=Flow_Sim_future_2030s_RCM07_annual_mean(j,1);
    Table_annual{j,9}=Flow_Sim_future_2030s_RCM08_annual_mean(j,1);
    Table_annual{j,10}=Flow_Sim_future_2030s_RCM09_annual_mean(j,1);
    Table_annual{j,11}=Flow_Sim_future_2030s_RCM10_annual_mean(j,1);
    Table_annual{j,12}=Flow_Sim_future_2030s_RCM11_annual_mean(j,1);
    Table_annual{j,13}=Flow_Sim_future_2030s_RCM12_annual_mean(j,1);
    Table_annual{j,14}=Flow_Sim_future_2030s_RCM13_annual_mean(j,1);
    Table_annual{j,15}=Flow_Sim_future_2030s_RCM15_annual_mean(j,1);
 
    % Future 2030s info for all RCMS
    Table_annual{j,16}=Flow_Sim_future_2030s_allRCM_annual_mean(j,1);
 
    % Future 2030s info for the differences
    Table_annual{j,17}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2030s_RCM01_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Table_annual{j,18}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2030s_RCM04_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Table_annual{j,19}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2030s_RCM05_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Table_annual{j,20}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2030s_RCM06_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Table_annual{j,21}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2030s_RCM07_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Table_annual{j,22}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2030s_RCM08_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Table_annual{j,23}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2030s_RCM09_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Table_annual{j,24}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2030s_RCM10_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Table_annual{j,25}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2030s_RCM11_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Table_annual{j,26}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2030s_RCM12_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Table_annual{j,27}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2030s_RCM13_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Table_annual{j,28}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2030s_RCM15_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
 
    % Future 2030s infor for the difference for all RCMs
    Table_annual{j,29}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2030s_allRCM_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
 
    % Same as above, but for the plots
    Flow_diff_annual_RCM01(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2030s_RCM01_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Flow_diff_annual_RCM04(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2030s_RCM04_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Flow_diff_annual_RCM05(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2030s_RCM05_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Flow_diff_annual_RCM06(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2030s_RCM06_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Flow_diff_annual_RCM07(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2030s_RCM07_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Flow_diff_annual_RCM08(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2030s_RCM08_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Flow_diff_annual_RCM09(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2030s_RCM09_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Flow_diff_annual_RCM10(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2030s_RCM10_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Flow_diff_annual_RCM11(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2030s_RCM11_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Flow_diff_annual_RCM12(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2030s_RCM12_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Flow_diff_annual_RCM13(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2030s_RCM13_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Flow_diff_annual_RCM15(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2030s_RCM15_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
 
    Flow_diff_annual_allRCM_2030s(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2030s_allRCM_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
end
    
Table_annual_header={'Baseline','Baseline annual mean spring flows [m^3/s]','Future','RCM01 annual mean spring flow [m^3/s]','RCM04 annual mean spring flow [m^3/s]','RCM05 annual mean spring flow [m^3/s]','RCM06 annual mean spring flow [m^3/s]','RCM07 annual mean spring flow [m^3/s]','RCM08 annual mean spring flow [m^3/s]','RCM09 annual mean spring flow [m^3/s]','RCM10 annual mean spring flow [m^3/s]','RCM11 annual mean spring flow [m^3/s]','RCM12 annual mean spring flow [m^3/s]','RCM13 annual mean spring flow [m^3/s]','RCM15 annual mean spring flow [m^3/s]','All RCM future annual mean spring flow [m^3/s]','Baseline-RCM01 [%]','Baseline-RCM04 [%]','Baseline-RCM05 [%]','Baseline-RCM06 [%]','Baseline-RCM07 [%]','Baseline-RCM08 [%]','Baseline-RCM09 [%]','Baseline-RCM10 [%]' ,'Baseline-RCM11 [%]','Baseline-RCM12 [%]','Baseline-RCM13 [%]','Baseline-RCM15 [%]','Baseline-Future annual mean flow [%]'};
 
%Write the table into an excel file
 
if exist(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Station_',no,'_flows_2030s_annual_vs_baseline.xls'), 'file')==2
   delete(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Station_',no,'_flows_2030s_annual_vs_baseline.xls'));
end
 
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Station_',no,'_flows_2030s_annual_vs_baseline.xls'),Table_annual,'Sheet1','A2');
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Station_',no,'_flows_2030s_annual_vs_baseline.xls'),Table_annual_header,'Sheet1','A1');
 
%% Plot the differences in annual mean spring flows
 
No_of_years=[1:length(Years_baseline)];
No_of_years=No_of_years.';
 
x_max=length(No_of_years);
 
ymin=-300;
ymax=+300;
 
X_line_zero=zeros(length(No_of_years),1);
 
%% Difference in annual mean spring flows for RCM01
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2030s\Annual_mean_flows_diff_RCM01_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2030s annual mean spring flows and baseline spring flows at station no.'," ",no," ",'for RCM01');
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
 
%% Plot the 2030s annual mean spring flows vs baseline mean flows for RCM01 as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2030s\Future_2030s_RCM01_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2030s annual mean spring flows vs baseline annual mean spring flows at station no.'," ",no," ",'for RCM01');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2030s_RCM01_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean spring flow [m^3/s]','Future 2030s annual mean spring flow [m^3/s]','Location','northeast');
 
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in annual mean spring flows for RCM04
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2030s\Annual_mean_flows_diff_RCM04_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2030s annual mean spring flows and baseline spring flows at station no.'," ",no," ",'for RCM04');
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
 
%% Plot the 2030s annual mean spring flows vs baseline mean flows for RCM04 as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2030s\Future_2030s_RCM04_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2030s annual mean spring flows vs baseline annual mean spring flows at station no.'," ",no," ",'for RCM04');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2030s_RCM04_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean spring flow [m^3/s]','Future 2030s annual mean spring flow [m^3/s]','Location','northeast');
 
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in annual mean spring flows for RCM05
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2030s\Annual_mean_flows_diff_RCM05_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2030s annual mean spring flows and baseline spring flows at station no.'," ",no," ",'for RCM05');
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
 
%% Plot the 2030s annual mean spring flows vs baseline mean flows for RCM05 as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2030s\Future_2030s_RCM05_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2030s annual mean spring flows vs baseline annual mean spring flows at station no.'," ",no," ",'for RCM05');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2030s_RCM05_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean spring flow [m^3/s]','Future 2030s annual mean spring flow [m^3/s]','Location','northeast');
 
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in annual mean spring flows for RCM06
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2030s\Annual_mean_flows_diff_RCM06_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2030s annual mean spring flows and baseline spring flows at station no.'," ",no," ",'for RCM06');
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
 
%% Plot the 2030s annual mean spring flows vs baseline mean flows for RCM06 as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2030s\Future_2030s_RCM06_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2030s annual mean spring flows vs baseline annual mean spring flows at station no.'," ",no," ",'for RCM06');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2030s_RCM06_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean spring flow [m^3/s]','Future 2030s annual mean spring flow [m^3/s]','Location','northeast');
 
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in annual mean spring flows for RCM07
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2030s\Annual_mean_flows_diff_RCM07_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2030s annual mean spring flows and baseline spring flows at station no.'," ",no," ",'for RCM07');
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
 
%% Plot the 2030s annual mean spring flows vs baseline mean flows for RCM07 as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2030s\Future_2030s_RCM07_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2030s annual mean spring flows vs baseline annual mean spring flows at station no.'," ",no," ",'for RCM07');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2030s_RCM07_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean spring flow [m^3/s]','Future 2030s annual mean spring flow [m^3/s]','Location','northeast');
 
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in annual mean spring flows for RCM08
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2030s\Annual_mean_flows_diff_RCM08_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2030s annual mean spring flows and baseline spring flows at station no.'," ",no," ",'for RCM08');
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
 
%% Plot the 2030s annual mean spring flows vs baseline mean flows for RCM08 as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2030s\Future_2030s_RCM08_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2030s annual mean spring flows vs baseline annual mean spring flows at station no.'," ",no," ",'for RCM08');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2030s_RCM08_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean spring flow [m^3/s]','Future 2030s annual mean spring flow [m^3/s]','Location','northeast');
 
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in annual mean spring flows for RCM09
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2030s\Annual_mean_flows_diff_RCM09_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2030s annual mean spring flows and baseline spring flows at station no.'," ",no," ",'for RCM09');
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
 
%% Plot the 2030s annual mean spring flows vs baseline mean flows for RCM09 as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2030s\Future_2030s_RCM09_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2030s annual mean spring flows vs baseline annual mean spring flows at station no.'," ",no," ",'for RCM09');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2030s_RCM09_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean spring flow [m^3/s]','Future 2030s annual mean spring flow [m^3/s]','Location','northeast');
 
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in annual mean spring flows for RCM10
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2030s\Annual_mean_flows_diff_RCM10_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2030s annual mean spring flows and baseline spring flows at station no.'," ",no," ",'for RCM10');
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
 
%% Plot the 2030s annual mean spring flows vs baseline mean flows for RCM10 as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2030s\Future_2030s_RCM10_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2030s annual mean spring flows vs baseline annual mean spring flows at station no.'," ",no," ",'for RCM10');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2030s_RCM10_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean spring flow [m^3/s]','Future 2030s annual mean spring flow [m^3/s]','Location','northeast');
 
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in annual mean spring flows for RCM11
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2030s\Annual_mean_flows_diff_RCM11_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2030s annual mean spring flows and baseline spring flows at station no.'," ",no," ",'for RCM11');
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
 
%% Plot the 2030s annual mean spring flows vs baseline mean flows for RCM11 as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2030s\Future_2030s_RCM11_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2030s annual mean spring flows vs baseline annual mean spring flows at station no.'," ",no," ",'for RCM11');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2030s_RCM11_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean spring flow [m^3/s]','Future 2030s annual mean spring flow [m^3/s]','Location','northeast');
 
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in annual mean spring flows for RCM12
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2030s\Annual_mean_flows_diff_RCM12_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2030s annual mean spring flows and baseline spring flows at station no.'," ",no," ",'for RCM12');
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
 
%% Plot the 2030s annual mean spring flows vs baseline mean flows for RCM12 as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2030s\Future_2030s_RCM12_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2030s annual mean spring flows vs baseline annual mean spring flows at station no.'," ",no," ",'for RCM12');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2030s_RCM12_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean spring flow [m^3/s]','Future 2030s annual mean spring flow [m^3/s]','Location','northeast');
 
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in annual mean spring flows for RCM13
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2030s\Annual_mean_flows_diff_RCM13_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2030s annual mean spring flows and baseline spring flows at station no.'," ",no," ",'for RCM13');
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
 
%% Plot the 2030s annual mean spring flows vs baseline mean flows for RCM13 as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2030s\Future_2030s_RCM13_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2030s annual mean spring flows vs baseline annual mean spring flows at station no.'," ",no," ",'for RCM13');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2030s_RCM13_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean spring flow [m^3/s]','Future 2030s annual mean spring flow [m^3/s]','Location','northeast');
 
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in annual mean spring flows for RCM15
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2030s\Annual_mean_flows_diff_RCM15_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2030s annual mean spring flows and baseline spring flows at station no.'," ",no," ",'for RCM15');
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
 
%% Plot the 2030s annual mean spring flows vs baseline mean flows for RCM15 as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2030s\Future_2030s_RCM15_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2030s annual mean spring flows vs baseline annual mean spring flows at station no.'," ",no," ",'for RCM15');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2030s_RCM15_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean spring flow [m^3/s]','Future 2030s annual mean spring flow [m^3/s]','Location','northeast');
 
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in annual mean spring flows for all RCMs
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2030s\Annual_mean_flows_diff_allRCM_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2030s annual mean spring flows and baseline spring flows at station no.'," ",no," ",'for all RCMs');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Flow_diff_annual_allRCM_2030s);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Plot the 2030s annual mean spring flows vs baseline mean flows for all RCMs as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2030s\Future_2030s_allRCM_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2030s annual mean spring flows vs baseline annual mean spring flows at station no.'," ",no," ",'for all RCMs');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2030s_allRCM_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean spring flow [m^3/s]','Future 2030s annual mean spring flow [m^3/s]','Location','northeast');
 
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Get baseline vs future 2050s annual percentage difference
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Table for the differences
Table_annual=[];
 
for j=1:length(Years_baseline)
    % Baseline info
    Table_annual{j,1}=Years_baseline(j,:);
    Table_annual{j,2}=Flow_Obs_baseline_annual_mean(j,1);
    Table_annual{j,3}=Years_2050s(j,:);
   
    % Future 2050s info for each RCM
    Table_annual{j,4}=Flow_Sim_future_2050s_RCM01_annual_mean(j,1);
    Table_annual{j,5}=Flow_Sim_future_2050s_RCM04_annual_mean(j,1);
    Table_annual{j,6}=Flow_Sim_future_2050s_RCM05_annual_mean(j,1);
    Table_annual{j,7}=Flow_Sim_future_2050s_RCM06_annual_mean(j,1);
    Table_annual{j,8}=Flow_Sim_future_2050s_RCM07_annual_mean(j,1);
    Table_annual{j,9}=Flow_Sim_future_2050s_RCM08_annual_mean(j,1);
    Table_annual{j,10}=Flow_Sim_future_2050s_RCM09_annual_mean(j,1);
    Table_annual{j,11}=Flow_Sim_future_2050s_RCM10_annual_mean(j,1);
    Table_annual{j,12}=Flow_Sim_future_2050s_RCM11_annual_mean(j,1);
    Table_annual{j,13}=Flow_Sim_future_2050s_RCM12_annual_mean(j,1);
    Table_annual{j,14}=Flow_Sim_future_2050s_RCM13_annual_mean(j,1);
    Table_annual{j,15}=Flow_Sim_future_2050s_RCM15_annual_mean(j,1);
 
    % Future 2050s info for all RCMS
    Table_annual{j,16}=Flow_Sim_future_2050s_allRCM_annual_mean(j,1);
 
    % Future 2050s info for the differences
    Table_annual{j,17}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2050s_RCM01_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Table_annual{j,18}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2050s_RCM04_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Table_annual{j,19}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2050s_RCM05_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Table_annual{j,20}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2050s_RCM06_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Table_annual{j,21}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2050s_RCM07_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Table_annual{j,22}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2050s_RCM08_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Table_annual{j,23}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2050s_RCM09_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Table_annual{j,24}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2050s_RCM10_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Table_annual{j,25}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2050s_RCM11_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Table_annual{j,26}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2050s_RCM12_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Table_annual{j,27}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2050s_RCM13_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Table_annual{j,28}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2050s_RCM15_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
 
    % Future 2050s infor for the difference for all RCMs
    Table_annual{j,29}=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2050s_allRCM_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
 
    % Same as above, but for the plots
    Flow_diff_annual_RCM01(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2050s_RCM01_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Flow_diff_annual_RCM04(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2050s_RCM04_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Flow_diff_annual_RCM05(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2050s_RCM05_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Flow_diff_annual_RCM06(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2050s_RCM06_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Flow_diff_annual_RCM07(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2050s_RCM07_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Flow_diff_annual_RCM08(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2050s_RCM08_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Flow_diff_annual_RCM09(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2050s_RCM09_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Flow_diff_annual_RCM10(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2050s_RCM10_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Flow_diff_annual_RCM11(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2050s_RCM11_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Flow_diff_annual_RCM12(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2050s_RCM12_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Flow_diff_annual_RCM13(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2050s_RCM13_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
    Flow_diff_annual_RCM15(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2050s_RCM15_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
 
    Flow_diff_annual_allRCM_2050s(j,1)=(Flow_Obs_baseline_annual_mean(j,1)-Flow_Sim_future_2050s_allRCM_annual_mean(j,1))/Flow_Obs_baseline_annual_mean(j,1)*100;
end
    
Table_annual_header={'Baseline','Baseline annual mean spring flows [m^3/s]','RCM01 annual mean spring flow [m^3/s]','RCM04 annual mean spring flow [m^3/s]','RCM05 annual mean spring flow [m^3/s]','RCM06 annual mean spring flow [m^3/s]','RCM07 annual mean spring flow [m^3/s]','RCM08 annual mean spring flow [m^3/s]','RCM09 annual mean spring flow [m^3/s]','RCM10 annual mean spring flow [m^3/s]','RCM11 annual mean spring flow [m^3/s]','RCM12 annual mean spring flow [m^3/s]','RCM13 annual mean spring flow [m^3/s]','RCM15 annual mean spring flow [m^3/s]','All RCM future annual mean spring flow [m^3/s]','Baseline-RCM01 [%]','Baseline-RCM04 [%]','Baseline-RCM05 [%]','Baseline-RCM06 [%]','Baseline-RCM07 [%]','Baseline-RCM08 [%]','Baseline-RCM09 [%]','Baseline-RCM10 [%]' ,'Baseline-RCM11 [%]','Baseline-RCM12 [%]','Baseline-RCM13 [%]','Baseline-RCM15 [%]','Baseline-Future annual mean spring flow [%]'};
%Write the table into an excel file
 
if exist(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Station_',no,'_flows_2050s_annual_vs_baseline.xls'), 'file')==2
   delete(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Station_',no,'_flows_2050s_annual_vs_baseline.xls'));
end
 
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Station_',no,'_flows_2050s_annual_vs_baseline.xls'),Table_annual,'Sheet1','A2');
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Station_',no,'_flows_2050s_annual_vs_baseline.xls'),Table_annual_header,'Sheet1','A1');
 
%% Plot the differences in annual mean spring flows
 
No_of_years=[1:length(Years_baseline)];
No_of_years=No_of_years.';
 
x_max=length(No_of_years);
 
ymin=-300;
ymax=+300;
 
X_line_zero=zeros(length(No_of_years),1);
 
%% Difference in annual mean spring flows for RCM01
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2050s\Annual_mean_flows_diff_RCM01_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2050s annual mean spring flows and baseline spring flows at station no.'," ",no," ",'for RCM01');
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
 
%% Plot the 2050s annual mean spring flows vs baseline mean flows for RCM01 as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2050s\Future_2050s_RCM01_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2050s annual mean spring flows vs baseline annual mean spring flows at station no.'," ",no," ",'for RCM01');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2050s_RCM01_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean spring flow [m^3/s]','Future 2050s annual mean spring flow [m^3/s]','Location','northeast');
 
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in annual mean spring flows for RCM04
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2050s\Annual_mean_flows_diff_RCM04_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2050s annual mean spring flows and baseline spring flows at station no.'," ",no," ",'for RCM04');
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
 
%% Plot the 2050s annual mean spring flows vs baseline mean flows for RCM04 as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2050s\Future_2050s_RCM04_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2050s annual mean spring flows vs baseline annual mean spring flows at station no.'," ",no," ",'for RCM04');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2050s_RCM04_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean spring flow [m^3/s]','Future 2050s annual mean spring flow [m^3/s]','Location','northeast');
 
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in annual mean spring flows for RCM05
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2050s\Annual_mean_flows_diff_RCM05_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2050s annual mean spring flows and baseline spring flows at station no.'," ",no," ",'for RCM05');
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
 
%% Plot the 2050s annual mean spring flows vs baseline mean flows for RCM05 as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2050s\Future_2050s_RCM05_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2050s annual mean spring flows vs baseline annual mean spring flows at station no.'," ",no," ",'for RCM05');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2050s_RCM05_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean spring flow [m^3/s]','Future 2050s annual mean spring flow [m^3/s]','Location','northeast');
 
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in annual mean spring flows for RCM06
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2050s\Annual_mean_flows_diff_RCM06_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2050s annual mean spring flows and baseline spring flows at station no.'," ",no," ",'for RCM06');
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
 
%% Plot the 2050s annual mean spring flows vs baseline mean flows for RCM06 as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2050s\Future_2050s_RCM06_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2050s annual mean spring flows vs baseline annual mean spring flows at station no.'," ",no," ",'for RCM06');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2050s_RCM06_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean spring flow [m^3/s]','Future 2050s annual mean spring flow [m^3/s]','Location','northeast');
 
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in annual mean spring flows for RCM07
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2050s\Annual_mean_flows_diff_RCM07_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2050s annual mean spring flows and baseline spring flows at station no.'," ",no," ",'for RCM07');
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
 
%% Plot the 2050s annual mean spring flows vs baseline mean flows for RCM07 as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2050s\Future_2050s_RCM07_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2050s annual mean spring flows vs baseline annual mean spring flows at station no.'," ",no," ",'for RCM07');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2050s_RCM07_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean spring flow [m^3/s]','Future 2050s annual mean spring flow [m^3/s]','Location','northeast');
 
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in annual mean spring flows for RCM08
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2050s\Annual_mean_flows_diff_RCM08_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2050s annual mean spring flows and baseline spring flows at station no.'," ",no," ",'for RCM08');
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
 
%% Plot the 2050s annual mean spring flows vs baseline mean flows for RCM08 as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2050s\Future_2050s_RCM08_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2050s annual mean spring flows vs baseline annual mean spring flows at station no.'," ",no," ",'for RCM08');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2050s_RCM08_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean spring flow [m^3/s]','Future 2050s annual mean spring flow [m^3/s]','Location','northeast');
 
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in annual mean spring flows for RCM09
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2050s\Annual_mean_flows_diff_RCM09_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2050s annual mean spring flows and baseline spring flows at station no.'," ",no," ",'for RCM09');
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
 
%% Plot the 2050s annual mean spring flows vs baseline mean flows for RCM09 as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2050s\Future_2050s_RCM09_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2050s annual mean spring flows vs baseline annual mean spring flows at station no.'," ",no," ",'for RCM09');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2050s_RCM09_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean spring flow [m^3/s]','Future 2050s annual mean spring flow [m^3/s]','Location','northeast');
 
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in annual mean spring flows for RCM10
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2050s\Annual_mean_flows_diff_RCM10_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2050s annual mean spring flows and baseline spring flows at station no.'," ",no," ",'for RCM10');
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
 
%% Plot the 2050s annual mean spring flows vs baseline mean flows for RCM10 as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2050s\Future_2050s_RCM10_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2050s annual mean spring flows vs baseline annual mean spring flows at station no.'," ",no," ",'for RCM10');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2050s_RCM10_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean spring flow [m^3/s]','Future 2050s annual mean spring flow [m^3/s]','Location','northeast');
 
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in annual mean spring flows for RCM11
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2050s\Annual_mean_flows_diff_RCM11_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2050s annual mean spring flows and baseline spring flows at station no.'," ",no," ",'for RCM11');
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
 
%% Plot the 2050s annual mean spring flows vs baseline mean flows for RCM11 as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2050s\Future_2050s_RCM11_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2050s annual mean spring flows vs baseline annual mean spring flows at station no.'," ",no," ",'for RCM11');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2050s_RCM11_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean spring flow [m^3/s]','Future 2050s annual mean spring flow [m^3/s]','Location','northeast');
 
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in annual mean spring flows for RCM12
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2050s\Annual_mean_flows_diff_RCM12_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2050s annual mean spring flows and baseline spring flows at station no.'," ",no," ",'for RCM12');
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
 
%% Plot the 2050s annual mean spring flows vs baseline mean flows for RCM12 as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2050s\Future_2050s_RCM12_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2050s annual mean spring flows vs baseline annual mean spring flows at station no.'," ",no," ",'for RCM12');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2050s_RCM12_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean spring flow [m^3/s]','Future 2050s annual mean spring flow [m^3/s]','Location','northeast');
 
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in annual mean spring flows for RCM13
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2050s\Annual_mean_flows_diff_RCM13_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2050s annual mean spring flows and baseline spring flows at station no.'," ",no," ",'for RCM13');
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
 
%% Plot the 2050s annual mean spring flows vs baseline mean flows for RCM13 as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2050s\Future_2050s_RCM13_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2050s annual mean spring flows vs baseline annual mean spring flows at station no.'," ",no," ",'for RCM13');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2050s_RCM13_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean spring flow [m^3/s]','Future 2050s annual mean spring flow [m^3/s]','Location','northeast');
 
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in annual mean spring flows for RCM15
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2050s\Annual_mean_flows_diff_RCM15_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2050s annual mean spring flows and baseline spring flows at station no.'," ",no," ",'for RCM15');
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
 
%% Plot the 2050s annual mean spring flows vs baseline mean flows for RCM15 as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2050s\Future_2050s_RCM15_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2050s annual mean spring flows vs baseline annual mean spring flows at station no.'," ",no," ",'for RCM15');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2050s_RCM15_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean spring flow [m^3/s]','Future 2050s annual mean spring flow [m^3/s]','Location','northeast');
 
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in annual mean spring flows for all RCMs
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2050s\Annual_mean_flows_diff_allRCM_ID_',no,'.png');
title_name_baseline=strcat('Difference between future 2050s annual mean spring flows and baseline spring flows at station no.'," ",no," ",'for all RCMs');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Flow_diff_annual_allRCM_2050s);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Plot the 2050s annual mean spring flows vs baseline mean flows for all RCMs as a bar graph
clf %clears figure information
set(gca,'Box','on');
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Future_2050s\Future_2050s_allRCM_bar_chart_annual_mean_flows_ID_',no,'.png');
title_name_baseline=strcat('Future 2050s annual mean spring flows vs baseline annual mean spring flows at station no.'," ",no," ",'for all RCMs');
title(title_name_baseline);
xlabel('Years');
ylabel('Flows [m^3/s]');
hold on
bar(No_of_years,Flow_Obs_baseline_annual_mean,'b');      
hold on
bar(No_of_years,Flow_Sim_future_2050s_allRCM_annual_mean,'c');
hold on
hold on
legend('Baseline annual mean spring flow [m^3/s]','Future 2050s annual mean spring flow [m^3/s]','Location','northeast');
 
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
  
%% Calculate the mean flows for the baseline and for the future
 
Flows_Obs_baseline_all(i,1)=nanmean(Flow_Obs_baseline_annual_mean);
 
Flows_future_2030s_all(i,1)=nanmean(Flow_Sim_future_2030s_allRCM_annual_mean);
 
Flows_future_2050s_all(i,1)=nanmean(Flow_Sim_future_2050s_allRCM_annual_mean);
 
Table_final(i,1)=GaugesNo(i,1);
Table_final(i,2)=Flows_Obs_baseline_all(i,1);
Table_final(i,3)=Flows_future_2030s_all(i,1);
Table_final(i,4)=Flows_future_2050s_all(i,1);
 
Table_final_header={'Station ID','Baseline mean spring flow [m^3/s]','Future 2030s mean spring flow [m^3/s]','Future 2050s mean spring flow [m^3/s]'};
 
if exist(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Station_',no,'_final_annual_vs_baseline_means.xls'), 'file')==2
   delete(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Station_',no,'_final_annual_vs_baseline_means.xls'));
end
 
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Station_',no,'_final_annual_vs_baseline_means.xls'),Table_final,'Sheet1','A2');
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Station_',no,'_final_annual_vs_baseline_means.xls'),Table_final_header,'Sheet1','A1');
 
%% Calculate the sum of daily flows for the baseline and for the future
 
Flows_Obs_baseline_all_sum(i,1)=nansum(Flow_Obs_baseline);
 
Flows_future_2030s_all_sum(i,1)=nansum(Flow_Sim_future_2030s_allRCM);
 
Flows_future_2050s_all_sum(i,1)=nansum(Flow_Sim_future_2050s_allRCM);
 
Table_final(i,1)=GaugesNo(i,1);
Table_final(i,2)=Flows_Obs_baseline_all_sum(i,1);
Table_final(i,3)=Flows_future_2030s_all_sum(i,1);
Table_final(i,4)=Flows_future_2050s_all_sum(i,1);
 
Table_final_header={'Station ID','Baseline total spring flows [m^3/s]','Future 2030s total spring flows [m^3/s]','Future 2050s total spring flows [m^3/s]'};
 
if exist(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Station_',no,'_final_annual_vs_baseline_sum.xls'), 'file')==2
   delete(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Station_',no,'_final_annual_vs_baseline_sum.xls'));
end
 
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Station_',no,'_final_annual_vs_baseline_sum.xls'),Table_final,'Sheet1','A2');
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\Spring\Station_',no,'_final_annual_vs_baseline_sum.xls'),Table_final_header,'Sheet1','A1');

    
    end   
end