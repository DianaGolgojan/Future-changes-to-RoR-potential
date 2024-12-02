clearvars;

%% Read the gauges locations and time
location = "H:\01.PhD\004.Chapter4\Input_data_CEH\Supporting_Documentation\eFLaG_Station_Matlab.xlsx";
time_file="H:\01.PhD\004.Chapter4\Input_data_CEH\Observed Flows_eFlag\Time.xlsx";
flow_file="H:\01.PhD\004.Chapter4\Input_data_CEH\Observed Flows_eFlag\GR6J\GR6J_simobs_";

%% Read the gauge number
Gauges=readtable(location);
GaugesNo=Gauges(:,1);
GaugesNo=table2array(GaugesNo);

%% Read the time
Time=readtable(time_file);
Time=table2array(Time);

%% Read the files containing observed and simulated flows information
for i=1:length(GaugesNo)
    if i~=[2,120,128]
    no=num2str(GaugesNo(i,1));
    Flows_table=readtable(strcat(flow_file,no,".csv"));
    Flows_Obs=Flows_table(:,2);
    Flows_Sim=Flows_table(:,3);

    %Transform the flows table into matrices
    Flows_Obs=table2array(Flows_Obs);
    Flows_Sim=table2array(Flows_Sim);

    %Plot observed vs simulated flows
    clf 
    set(gca,'Box','on');
    save_name=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR6J\Validate_flows\Obs_vs_sim_gauge_',no,'.png');
    title_name_baseline=strcat('Observed vs simulated flows at station no.'," ",no);
    title(title_name_baseline);
    ylabel('Flows [m^3/s]');
    xlabel('Time');
    hold on
    plot(Time,Flows_Obs,'color','#0072BD','LineWidth',0.7);
    hold on
    plot(Time,Flows_Sim,'color','r','LineStyle','--','LineWidth',0.1);
    hold on
    legend('Observed flows','Simulated flows');

    if exist(save_name, 'file')==2
        delete(save_name);
    end
    saveas(gcf,save_name);

    %Plot the fit between the observed and simulated flows
    clf
    X=[];
    Y=[];
    set(gca,'Box','on');
    ylabel('Simulated Flows [m^3/s]');
    xlabel('Observed Flows [m^3/s]');
    hold on
    scatter(Flows_Obs,Flows_Sim);

    %Before doinf the polyfit you need to make sure that the flow values do
    %NOT contain NaN values
    Flows_Sim(isnan(Flows_Obs))=[];
    Flows_Obs(isnan(Flows_Obs))=[];
    %Calculate the fit line
    c = polyfit(Flows_Obs,Flows_Sim,1);
    y_fit=polyval(c,Flows_Obs);
    plot(Flows_Obs,y_fit,'r-','displayname',sprintf('Regression line (y = %0.2f*x + %0.2f)',c(1),c(2)));
    hold on
    legend('Flows',sprintf('Regression line (y = %0.2f*x + %0.2f)',c(1),c(2)));
    legend('location','nw');

    X=Flows_Obs;
    Y=Flows_Sim;
    X(:,2)=1;    
    [~,~,~,~,stats]=regress(Y,X);
    R_squared=num2str(stats(1));
    R_total(i,2)=stats(1);
    R_total(i,1)=GaugesNo(i,1);

    save_name=strcat('H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR6J\Validate_flows\Obs_vs_sim_R2_gauge_',no,'.png');
    title_name_baseline=strcat('Observed vs simulated flows at station no.'," ",no," ",'with R^2=',R_squared);
    title(title_name_baseline);

    if exist(save_name, 'file')==2
        delete(save_name);
    end
    saveas(gcf,save_name);

    end
end

R_save_file='H:\01.PhD\004.Chapter4\00.Results\Flows\All_stations\GR6J\Validate_flows\R2_values_GR6J';
    
if exist(R_save_file, 'file')==2
   delete(R_save_file);
end
saveas(gcf,R_save_file);
xlswrite(R_save_file,R_total);
  

