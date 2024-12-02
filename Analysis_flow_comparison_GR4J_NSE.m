clearvars;

%% Read the gauges locations and time
location = "H:\01.PhD\004.Chapter4\Input_data_CEH\Supporting_Documentation\eFLaG_Station_Matlab.xlsx";
time_file="H:\01.PhD\004.Chapter4\Input_data_CEH\Observed Flows_eFlag\Time.xlsx";
flow_file="H:\01.PhD\004.Chapter4\Input_data_CEH\Observed Flows_eFlag\GR4J\GR4J_simobs_";

%% Read the gauge number
Gauges=readtable(location);
GaugesNo=Gauges(:,1);
GaugesNo=table2array(GaugesNo);

%% Read the time
Time=readtable(time_file);
Time=table2array(Time);

%% Read the files containing observed and simulated flows information
for i=1:length(GaugesNo)
    %if i~=[42,62,102,115,154,192,193,194,195,196,197,198,199,200]
    no=num2str(GaugesNo(i,1));
    Flows_table=readtable(strcat(flow_file,no,".csv"));
    Flows_Obs=Flows_table(:,2);
    Flows_Sim=Flows_table(:,3);

    %Transform the flows table into matrices
    Flows_Obs=table2array(Flows_Obs);
    Flows_Sim=table2array(Flows_Sim);

     %Calculate Nash-Sutcliffe Efficiency
    NSE(i,2)=nash_sutcliffe_efficiency(Flows_Sim,Flows_Obs);
    NSE(i,1)=GaugesNo(i,1);
end

NSE_save_file='H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR4J\Validate_flows\NSE_values_GR4J';
    
if exist(NSE_save_file, 'file')==2
   delete(NSE_save_file);
end
saveas(gcf,NSE_save_file);

xlswrite(NSE_save_file,NSE);
  
