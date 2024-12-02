clearvars;
 
%% Constants
 
%Start and end dates for the baseline period (30 years)
Baseline_Start_time=datetime(1980,01,01);
Baseline_End_time=datetime(2009,12,31);
 
%Start and end dates for the 2060s future period (30 years)
Future_2060s_Start_time=datetime(2050,01,01);
Future_2060s_End_time=datetime(2079,12,30);
 
ro=1000; %ro is the water density in kg/m^3
g=9.8; %g is the acceleration due to gravity in m/s^2
CP=0.4; %capacity factor set to 40% by default
 
%Baseline and future months
Months_baseline=readtable('H:\01.PhD\004.Chapter4\Matlab Code\Months_Baseline_Autumn.xlsx');
Months_baseline=table2array(Months_baseline);
Months_2060s=readtable('H:\01.PhD\004.Chapter4\Matlab Code\Months_2060s_Autumn.xlsx');
Months_2060s=table2array(Months_2060s);
 
%Baseline and future years
Years_baseline=readtable('H:\01.PhD\004.Chapter4\Matlab Code\Years_Baseline.xlsx');
Years_baseline=table2array(Years_baseline);
Years_2060s=readtable('H:\01.PhD\004.Chapter4\Matlab Code\Years_2060s.xlsx');
Years_2060s=table2array(Years_2060s);
 
%Seasonal months
Autumn_months=[3 4 5];
Autumn_months=[6 7 8];
Autumn_months=[9 10 11];
Winter_months=[12 1 2];
 
%% Read the files containg the selected ROR
 
Micro_info_location='H:\01.PhD\004.Chapter4\Matlab Code\Micro_ROR.xlsx';
Micro_info=readtable(Micro_info_location);
Micro_turbine_type=Micro_info(:,7); %read the turbine type
Micro_turbine_type=table2array(Micro_turbine_type);
Micro_desing_flow=Micro_info(:,8); %read the installed flow (Q40-Q95)
Micro_desing_flow=table2array(Micro_desing_flow);
Micro_net_head=Micro_info(:,9); %read the net head
Micro_net_head=table2array(Micro_net_head);
Micro_installed_power=Micro_info(:,4); %read the installed power
Micro_installed_power=table2array(Micro_installed_power);
 
Micro_Stations=Micro_info(:,1); %read the station IDs
Micro_Stations=table2array(Micro_Stations);
Micro_Intake_ID=Micro_info(:,3); %read intake ID
Micro_Intake_ID=table2array(Micro_Intake_ID);
 
 
for i=1:length(Micro_Stations)
%Clear the station information (dates, observed and future flows) to prevent overwriting
    Current_station_baseline=[];
    Current_station_future_2060s=[];
    Current_station_future_2060s=[];
 
%Get the station number as a string to save station information to Excel file
    no=num2str(Micro_Stations(i,:));
   
%% Read the baseline flows and save the 1990s autumn flows in an Excel file
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
      
    Check_months=month(Time_Obs_baseline);
    
    %Add only the autumn flows for the analysis
    for j=1:length(Check_months)
        Check_autumn_months(j,1)=ismember(Check_months(j,1),Autumn_months);
    end
    
    [delete_idx,~]=find(Check_autumn_months==0);
    Time_Obs_baseline(delete_idx,:)=[];
    Current_station_baseline(delete_idx,:)=[];
 
    %Check if file exists, if yes delete it
    if exist(strcat('H:\01.PhD\004.Chapter4\Matlab Code\Obs_flow_inputs\Baseline_autumn_station_',no,'.xls'), 'file')==2
        delete(strcat('H:\01.PhD\004.Chapter4\Matlab Code\Obs_flow_inputs\Baseline_autumn_station_',no,'.xls'));
    end
    writetable(Current_station_baseline,strcat('H:\01.PhD\004.Chapter4\Matlab Code\Obs_flow_inputs\Baseline_autumn_station_',no,'.xls'));
    
%% Read the future flows and save the 2060s autumn future flows in an Excel file
    Check_months=[];
    Check_autumn_months=[];
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
 
    Check_months=month(Time_Sim_future_2060s);
    
    %Add only the autumn flows for the analysis
    for j=1:length(Check_months)
        Check_autumn_months(j,1)=ismember(Check_months(j,1),Autumn_months);
    end
    
    [delete_idx,~]=find(Check_autumn_months==0);
    Time_Sim_future_2060s(delete_idx,:)=[];
    Current_station_future_2060s(delete_idx,:)=[];
 
    
    %Check if file exists, if yes delete it
    if exist(strcat('H:\01.PhD\004.Chapter4\Matlab Code\Future_flow_inputs\Future_autumn_2060s_station_',no,'.xls'), 'file')==2
        delete(strcat('H:\01.PhD\004.Chapter4\Matlab Code\Future_flow_inputs\Future_autumn_2060s_station_',no,'.xls'));
    end
    writetable(Current_station_future_2060s,strcat('H:\01.PhD\004.Chapter4\Matlab Code\Future_flow_inputs\Future_2060s_station_',no,'.xls'));
    
%% Calculate the autumn baseline total energy output and daily power
    if(Micro_turbine_type(i,1)=="Cross-flow")
%Micro scheme characteristics needed for the energy output calculation
        Qp=0.7*Micro_desing_flow(i,1); %peak efficiency flow in cum/s
        Qd=Micro_desing_flow(i,1); %design flow in cum/s
        Obs_flow=[];
        eq=zeros(height(Current_station_baseline),1);
        Power_baseline=[];
        Obs_flow=Current_station_baseline(:,3); %observed flows at the station in cum/s
        Obs_flow=table2array(Obs_flow);
        Check=isa(Obs_flow,'double');
        if Check==0
            Obs_flow=cellfun(@str2num,Obs_flow);
        end
 
        Head=Micro_net_head(i,1); %net head in m
 
       for j=1:height(Current_station_baseline)           
%Calculate flows
           if (Obs_flow(j,1)>Qd)
               Obs_flow(j,1)=Qd; %if flows exceed the insalled flow, the scheme can only use the installed flow because of its installed penstock and turbine
           end
 
%Calculate turbine efficiency based on flows 
            if (Obs_flow(j,1)<Qp*0.103 && Obs_flow(j,1)>=Qp*0.078)
                eq(j,1)=-925.33841*(Obs_flow(j,1)/Qd)^2+188.14434*(Obs_flow(j,1)/Qd)-8.95889; %efficiency at flow below peak efficiency flow
            else
                if Obs_flow(j,1)>Qp*0.103 && Obs_flow(j,1)<Qp*0.145
                    eq(j,1)=2.38095*(Obs_flow(j,1)/Qd)+0.35476; %efficiency at flow below peak efficiency flow
                else
                    if Obs_flow(j,1)>Qp*0.145
                        eq(j,1)=-0.38935*(Obs_flow(j,1)/Qd)^2+0.54132*(Obs_flow(j,1)/Qd)+0.63050; %efficiency at flow above peak efficiency flow 
                    end
                end
            end
 
%Calculate available daily power in kW
            Power_baseline(j,1)=(ro*g*Obs_flow(j,1)*Micro_net_head(i,1)*eq(j,1))/1000;
 
            if Power_baseline(j,1)<=0 %if power is negative it means that the flow is too small to be able to use the scheme
                Power_baseline(j,1)=0.0001;
            end
 
            Power_installed(j,1)=Micro_installed_power(i,1);
 
%Calculate daily energy in kWh with the capapcity factor set in the beginning (default 40%)
            Energy_baseline(j,1)=Power_baseline(j,1)*24*CP;
       end
    else if (Micro_turbine_type(i,1)=="Archimedean Screw")
%Micro scheme characteristics needed for the energy output calculation
        Qp=0.7*Micro_desing_flow(i,1); %peak efficiency flow in cum/s
        Qd=Micro_desing_flow(i,1); %design flow in cum/s
        Obs_flow=[];
        eq=zeros(height(Current_station_baseline),1);
        Power_baseline=[];
        Obs_flow=Current_station_baseline(:,2); %observed flows at the station in cum/s
        Obs_flow=table2array(Obs_flow);
        Check=isa(Obs_flow,'double');
        if Check==0
            Obs_flow=cellfun(@str2num,Obs_flow);
        end
 
        Head=Micro_net_head(i,1); %net head in m
 
       for j=1:height(Current_station_baseline)           
%Calculate flows
           if (Obs_flow(j,1)>Qd)
               Obs_flow(j,1)=Qd; %if flows exceed the insalled flow, the scheme can only use the installed flow because of its installed penstock and turbine
           end
 
%Calculate turbine efficiency based on flows 
            if (Obs_flow(j,1)<=Qp*0.78 && Obs_flow(j,1)>=Qp*0.43)
                eq(j,1)=-1.3763*(Obs_flow(j,1)/Qd)^2+2.0858*(Obs_flow(j,1)/Qd)+0.0346; %efficiency at flow below peak efficiency flow
            else
                if Obs_flow(j,1)>Qp*1.219
                eq(j,1)=-565.6932290792*(Obs_flow(j,1)/Qd)^6+3345.5341490459*(Obs_flow(j,1)/Qd)^5-8204.1750190284*(Obs_flow(j,1)/Qd)^4+10676.6071388550*(Obs_flow(j,1)/Qd)^3-7775.4512628411*(Obs_flow(j,1)/Qd)^2+3004.2384250625*(Obs_flow(j,1)/Qd)-480.2389292428; %efficiency at flow above peak efficiency flow                              
                end
            end
 
%Calculate available daily power in kW
            Power_baseline(j,1)=(ro*g*Obs_flow(j,1)*Micro_net_head(i,1)*eq(j,1))/1000;
 
            if Power_baseline(j,1)<=0 %if power is negative it means that the flow is too small to be able to use the scheme
                Power_baseline(j,1)=0.0001;
            end
 
            Power_installed(j,1)=Micro_installed_power(i,1);
 
%Calculate daily energy in kWh with the capapcity factor set in the beginning (default 40%)
            Energy_baseline(j,1)=Power_baseline(j,1)*24*CP;
       end 
        end
    end
%% Plot the baseline daily power vs installed power
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Baseline\Autumn\Baseline_autumn_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Daily autumn available power vs installed power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no);
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Power [kW]');
       hold on
       plot(Time_Obs_baseline,Power_baseline);
       hold on
       plot(Time_Obs_baseline,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available daily power [kW]','Installed power [kW]','Location','southeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the baseline daily energy
       clf %clears figure information
       set(gca,'Box','on');       
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Baseline\Autumn\Baseline_autumn_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Baseline autumn daily energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no);
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Energy [kWh]');
       hold on
       plot(Time_Obs_baseline,Energy_baseline);
       hold on
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
       
%% 2060s Calculations       
 
%% Calculate the future 2060s total energy output and daily power
   %% Calculate the future 2060s total energy output and daily power
    if (Micro_turbine_type(i,1)=="Cross-flow")

Power_installed=[];        
%Micro scheme characteristics needed for the energy output calculation
        Qp=0.7*Micro_desing_flow(i,1); %peak efficiency flow in cum/s
        Qd=Micro_desing_flow(i,1); %design flow in cum/s
        Head=Micro_net_head(i,1); %net head in m
 
%% Get simulated future flows for each RCM
        % RCM01
        Sim_flow_2060s_RCM01=Current_station_future_2060s(:,2); 
        Sim_flow_2060s_RCM01=table2array(Sim_flow_2060s_RCM01);
 
        % RCM04
        Sim_flow_2060s_RCM04=Current_station_future_2060s(:,3); 
        Sim_flow_2060s_RCM04=table2array(Sim_flow_2060s_RCM04);
 
        % RCM05
        Sim_flow_2060s_RCM05=Current_station_future_2060s(:,4); 
        Sim_flow_2060s_RCM05=table2array(Sim_flow_2060s_RCM05);
 
        % RCM06
        Sim_flow_2060s_RCM06=Current_station_future_2060s(:,5); 
        Sim_flow_2060s_RCM06=table2array(Sim_flow_2060s_RCM06);      
 
        % RCM07
        Sim_flow_2060s_RCM07=Current_station_future_2060s(:,6); 
        Sim_flow_2060s_RCM07=table2array(Sim_flow_2060s_RCM07);
 
        % RCM08
        Sim_flow_2060s_RCM08=Current_station_future_2060s(:,7); 
        Sim_flow_2060s_RCM08=table2array(Sim_flow_2060s_RCM08);  
 
        % RCM09
        Sim_flow_2060s_RCM09=Current_station_future_2060s(:,8); 
        Sim_flow_2060s_RCM09=table2array(Sim_flow_2060s_RCM09);
 
        % RCM10
        Sim_flow_2060s_RCM10=Current_station_future_2060s(:,9); 
        Sim_flow_2060s_RCM10=table2array(Sim_flow_2060s_RCM10);
 
        % RCM11
        Sim_flow_2060s_RCM11=Current_station_future_2060s(:,10); 
        Sim_flow_2060s_RCM11=table2array(Sim_flow_2060s_RCM11);
 
        % RCM12
        Sim_flow_2060s_RCM12=Current_station_future_2060s(:,11); 
        Sim_flow_2060s_RCM12=table2array(Sim_flow_2060s_RCM12);
 
        % RCM13
        Sim_flow_2060s_RCM13=Current_station_future_2060s(:,12); 
        Sim_flow_2060s_RCM13=table2array(Sim_flow_2060s_RCM13);
 
        % RCM15
        Sim_flow_2060s_RCM15=Current_station_future_2060s(:,13); 
        Sim_flow_2060s_RCM15=table2array(Sim_flow_2060s_RCM15);
 
%% Calculate future power and energy for the 2060s for each RCM
        for j=1:height(Current_station_future_2060s)           
%% RCM01
%Calculate flows for RCM01
           if (Sim_flow_2060s_RCM01(j,1)>Qd)
               Sim_flow_2060s_RCM01(j,1)=Qd; %if flows exceed the insalled flow, the scheme can only use the installed flow because of its installed penstock and turbine
           end
 
%Calculate turbine efficiency based on flows for RCM01
           if (Sim_flow_2060s_RCM01(j,1)<Qp*0.103)
               eq(j,1)=-925.33841*(Sim_flow_2060s_RCM01(j,1)/Qd)^2+188.14434*(Sim_flow_2060s_RCM01(j,1)/Qd)-8.95889; %efficiency at flow below peak efficiency flow
           else
               if Sim_flow_2060s_RCM01(j,1)>Qp*0.103 && Sim_flow_2060s_RCM01(j,1)<Qp*0.145
                   eq(j,1)=2.38095*(Sim_flow_2060s_RCM01(j,1)/Qd)+0.35476; %efficiency at flow below peak efficiency flow
               else
                   if Sim_flow_2060s_RCM01(j,1)>Qp*0.145
                       eq(j,1)=-0.38935*(Sim_flow_2060s_RCM01(j,1)/Qd)^2+0.54132*(Sim_flow_2060s_RCM01(j,1)/Qd)+0.63050; %efficiency at flow above peak efficiency flow 
                   end
               end
           end
 
%Calculate available daily power in kW for RCM01
       Power_future_2060s_RCM01(j,1)=(ro*g*Sim_flow_2060s_RCM01(j,1)*Micro_net_head(i,1)*eq(j,1))/1000;
 
       if Power_future_2060s_RCM01(j,1)<=0 %if power is negative it means that the flow is too small to be able to use the scheme
          Power_future_2060s_RCM01(j,1)=0.0001;
       end
 
       Power_installed(j,1)=Micro_installed_power(i,1);
 
%Calculate daily energy in kWh with the capapcity factor set in the beginning (default 40%) for RCM01
       Energy_future_2060s_RCM01(j,1)=Power_future_2060s_RCM01(j,1)*24*CP;
 
%% RCM04
%Calculate flows for RCM04
           if (Sim_flow_2060s_RCM04(j,1)>Qd)
               Sim_flow_2060s_RCM04(j,1)=Qd; %if flows exceed the insalled flow, the scheme can only use the installed flow because of its installed penstock and turbine
           end
 
%Calculate turbine efficiency based on flows for RCM04
           if (Sim_flow_2060s_RCM04(j,1)<Qp*0.103)
               eq(j,1)=-925.33841*(Sim_flow_2060s_RCM04(j,1)/Qd)^2+188.14434*(Sim_flow_2060s_RCM04(j,1)/Qd)-8.95889; %efficiency at flow below peak efficiency flow
           else
               if Sim_flow_2060s_RCM04(j,1)>Qp*0.103 && Sim_flow_2060s_RCM04(j,1)<Qp*0.145
                   eq(j,1)=2.38095*(Sim_flow_2060s_RCM04(j,1)/Qd)+0.35476; %efficiency at flow below peak efficiency flow
               else
                   if Sim_flow_2060s_RCM04(j,1)>Qp*0.145
                       eq(j,1)=-0.38935*(Sim_flow_2060s_RCM04(j,1)/Qd)^2+0.54132*(Sim_flow_2060s_RCM04(j,1)/Qd)+0.63050; %efficiency at flow above peak efficiency flow 
                   end
               end
           end
 
%Calculate available daily power in kW for RCM04
       Power_future_2060s_RCM04(j,1)=(ro*g*Sim_flow_2060s_RCM04(j,1)*Micro_net_head(i,1)*eq(j,1))/1000;
 
       if Power_future_2060s_RCM04(j,1)<=0 %if power is negative it means that the flow is too small to be able to use the scheme
          Power_future_2060s_RCM04(j,1)=0.0001;
       end
       
       Power_installed(j,1)=Micro_installed_power(i,1);
 
%Calculate daily energy in kWh with the capapcity factor set in the beginning (default 40%) for RCM01
       Energy_future_2060s_RCM04(j,1)=Power_future_2060s_RCM04(j,1)*24*CP;
 
%% RCM05
%Calculate flows for RCM05
           if (Sim_flow_2060s_RCM05(j,1)>Qd)
               Sim_flow_2060s_RCM05(j,1)=Qd; %if flows exceed the insalled flow, the scheme can only use the installed flow because of its installed penstock and turbine
           end
 
%Calculate turbine efficiency based on flows for RCM05
           if (Sim_flow_2060s_RCM05(j,1)<Qp*0.103)
               eq(j,1)=-925.33841*(Sim_flow_2060s_RCM05(j,1)/Qd)^2+188.14434*(Sim_flow_2060s_RCM05(j,1)/Qd)-8.95889; %efficiency at flow below peak efficiency flow
           else
               if Sim_flow_2060s_RCM05(j,1)>Qp*0.103 && Sim_flow_2060s_RCM05(j,1)<Qp*0.145
                   eq(j,1)=2.38095*(Sim_flow_2060s_RCM05(j,1)/Qd)+0.35476; %efficiency at flow below peak efficiency flow
               else
                   if Sim_flow_2060s_RCM05(j,1)>Qp*0.145
                       eq(j,1)=-0.38935*(Sim_flow_2060s_RCM05(j,1)/Qd)^2+0.54132*(Sim_flow_2060s_RCM05(j,1)/Qd)+0.63050; %efficiency at flow above peak efficiency flow 
                   end
               end
           end
 
%Calculate available daily power in kW for RCM05
       Power_future_2060s_RCM05(j,1)=(ro*g*Sim_flow_2060s_RCM05(j,1)*Micro_net_head(i,1)*eq(j,1))/1000;
 
       if Power_future_2060s_RCM05(j,1)<=0 %if power is negative it means that the flow is too small to be able to use the scheme
          Power_future_2060s_RCM05(j,1)=0.0001;
       end
       
       Power_installed(j,1)=Micro_installed_power(i,1);
 
%Calculate daily energy in kWh with the capapcity factor set in the beginning (default 40%) for RCM01
       Energy_future_2060s_RCM05(j,1)=Power_future_2060s_RCM05(j,1)*24*CP;
 
%% RCM06
%Calculate flows for RCM06
           if (Sim_flow_2060s_RCM06(j,1)>Qd)
               Sim_flow_2060s_RCM06(j,1)=Qd; %if flows exceed the insalled flow, the scheme can only use the installed flow because of its installed penstock and turbine
           end
 
%Calculate turbine efficiency based on flows for RCM06
           if (Sim_flow_2060s_RCM06(j,1)<Qp*0.103)
               eq(j,1)=-925.33841*(Sim_flow_2060s_RCM06(j,1)/Qd)^2+188.14434*(Sim_flow_2060s_RCM06(j,1)/Qd)-8.95889; %efficiency at flow below peak efficiency flow
           else
               if Sim_flow_2060s_RCM06(j,1)>Qp*0.103 && Sim_flow_2060s_RCM06(j,1)<Qp*0.145
                   eq(j,1)=2.38095*(Sim_flow_2060s_RCM06(j,1)/Qd)+0.35476; %efficiency at flow below peak efficiency flow
               else
                   if Sim_flow_2060s_RCM06(j,1)>Qp*0.145
                       eq(j,1)=-0.38935*(Sim_flow_2060s_RCM06(j,1)/Qd)^2+0.54132*(Sim_flow_2060s_RCM06(j,1)/Qd)+0.63050; %efficiency at flow above peak efficiency flow 
                   end
               end
           end
 
%Calculate available daily power in kW for RCM06
       Power_future_2060s_RCM06(j,1)=(ro*g*Sim_flow_2060s_RCM06(j,1)*Micro_net_head(i,1)*eq(j,1))/1000;
 
       if Power_future_2060s_RCM06(j,1)<=0 %if power is negative it means that the flow is too small to be able to use the scheme
          Power_future_2060s_RCM06(j,1)=0.0001;
       end
       
       Power_installed(j,1)=Micro_installed_power(i,1);
 
%Calculate daily energy in kWh with the capapcity factor set in the beginning (default 40%) for RCM01
       Energy_future_2060s_RCM06(j,1)=Power_future_2060s_RCM06(j,1)*24*CP;
 
%% RCM07
%Calculate flows for RCM07
           if (Sim_flow_2060s_RCM07(j,1)>Qd)
               Sim_flow_2060s_RCM07(j,1)=Qd; %if flows exceed the insalled flow, the scheme can only use the installed flow because of its installed penstock and turbine
           end
 
%Calculate turbine efficiency based on flows for RCM07
           if (Sim_flow_2060s_RCM07(j,1)<Qp*0.103)
               eq(j,1)=-925.33841*(Sim_flow_2060s_RCM07(j,1)/Qd)^2+188.14434*(Sim_flow_2060s_RCM07(j,1)/Qd)-8.95889; %efficiency at flow below peak efficiency flow
           else
               if Sim_flow_2060s_RCM07(j,1)>Qp*0.103 && Sim_flow_2060s_RCM07(j,1)<Qp*0.145
                   eq(j,1)=2.38095*(Sim_flow_2060s_RCM07(j,1)/Qd)+0.35476; %efficiency at flow below peak efficiency flow
               else
                   if Sim_flow_2060s_RCM07(j,1)>Qp*0.145
                       eq(j,1)=-0.38935*(Sim_flow_2060s_RCM07(j,1)/Qd)^2+0.54132*(Sim_flow_2060s_RCM07(j,1)/Qd)+0.63050; %efficiency at flow above peak efficiency flow 
                   end
               end
           end
 
%Calculate available daily power in kW for RCM07
       Power_future_2060s_RCM07(j,1)=(ro*g*Sim_flow_2060s_RCM07(j,1)*Micro_net_head(i,1)*eq(j,1))/1000;
 
       if Power_future_2060s_RCM07(j,1)<=0 %if power is negative it means that the flow is too small to be able to use the scheme
          Power_future_2060s_RCM07(j,1)=0.0001;
       end
       
       Power_installed(j,1)=Micro_installed_power(i,1);
 
%Calculate daily energy in kWh with the capapcity factor set in the beginning (default 40%) for RCM01
       Energy_future_2060s_RCM07(j,1)=Power_future_2060s_RCM07(j,1)*24*CP;
 
%% RCM08
%Calculate flows for RCM08
           if (Sim_flow_2060s_RCM08(j,1)>Qd)
               Sim_flow_2060s_RCM08(j,1)=Qd; %if flows exceed the insalled flow, the scheme can only use the installed flow because of its installed penstock and turbine
           end
 
%Calculate turbine efficiency based on flows for RCM08
           if (Sim_flow_2060s_RCM08(j,1)<Qp*0.103)
               eq(j,1)=-925.33841*(Sim_flow_2060s_RCM08(j,1)/Qd)^2+188.14434*(Sim_flow_2060s_RCM08(j,1)/Qd)-8.95889; %efficiency at flow below peak efficiency flow
           else
               if Sim_flow_2060s_RCM08(j,1)>Qp*0.103 && Sim_flow_2060s_RCM08(j,1)<Qp*0.145
                   eq(j,1)=2.38095*(Sim_flow_2060s_RCM08(j,1)/Qd)+0.35476; %efficiency at flow below peak efficiency flow
               else
                   if Sim_flow_2060s_RCM08(j,1)>Qp*0.145
                       eq(j,1)=-0.38935*(Sim_flow_2060s_RCM08(j,1)/Qd)^2+0.54132*(Sim_flow_2060s_RCM08(j,1)/Qd)+0.63050; %efficiency at flow above peak efficiency flow 
                   end
               end
           end
 
%Calculate available daily power in kW for RCM08
       Power_future_2060s_RCM08(j,1)=(ro*g*Sim_flow_2060s_RCM08(j,1)*Micro_net_head(i,1)*eq(j,1))/1000;
 
       if Power_future_2060s_RCM08(j,1)<=0 %if power is negative it means that the flow is too small to be able to use the scheme
          Power_future_2060s_RCM08(j,1)=0.0001;
       end
       
       Power_installed(j,1)=Micro_installed_power(i,1);
 
%Calculate daily energy in kWh with the capapcity factor set in the beginning (default 40%) for RCM01
       Energy_future_2060s_RCM08(j,1)=Power_future_2060s_RCM08(j,1)*24*CP;
 
%% RCM09
%Calculate flows for RCM09
           if (Sim_flow_2060s_RCM09(j,1)>Qd)
               Sim_flow_2060s_RCM09(j,1)=Qd; %if flows exceed the insalled flow, the scheme can only use the installed flow because of its installed penstock and turbine
           end
 
%Calculate turbine efficiency based on flows for RCM09
           if (Sim_flow_2060s_RCM09(j,1)<Qp*0.103)
               eq(j,1)=-925.33841*(Sim_flow_2060s_RCM09(j,1)/Qd)^2+188.14434*(Sim_flow_2060s_RCM09(j,1)/Qd)-8.95889; %efficiency at flow below peak efficiency flow
           else
               if Sim_flow_2060s_RCM09(j,1)>Qp*0.103 && Sim_flow_2060s_RCM09(j,1)<Qp*0.145
                   eq(j,1)=2.38095*(Sim_flow_2060s_RCM09(j,1)/Qd)+0.35476; %efficiency at flow below peak efficiency flow
               else
                   if Sim_flow_2060s_RCM09(j,1)>Qp*0.145
                       eq(j,1)=-0.38935*(Sim_flow_2060s_RCM09(j,1)/Qd)^2+0.54132*(Sim_flow_2060s_RCM09(j,1)/Qd)+0.63050; %efficiency at flow above peak efficiency flow 
                   end
               end
           end
 
%Calculate available daily power in kW for RCM09
       Power_future_2060s_RCM09(j,1)=(ro*g*Sim_flow_2060s_RCM09(j,1)*Micro_net_head(i,1)*eq(j,1))/1000;
 
       if Power_future_2060s_RCM09(j,1)<=0 %if power is negative it means that the flow is too small to be able to use the scheme
          Power_future_2060s_RCM09(j,1)=0.0001;
       end
       
       Power_installed(j,1)=Micro_installed_power(i,1);
 
%Calculate daily energy in kWh with the capapcity factor set in the beginning (default 40%) for RCM01
       Energy_future_2060s_RCM09(j,1)=Power_future_2060s_RCM09(j,1)*24*CP;
 
%% RCM10
%Calculate flows for RCM10
           if (Sim_flow_2060s_RCM10(j,1)>Qd)
               Sim_flow_2060s_RCM10(j,1)=Qd; %if flows exceed the insalled flow, the scheme can only use the installed flow because of its installed penstock and turbine
           end
 
%Calculate turbine efficiency based on flows for RCM10
           if (Sim_flow_2060s_RCM10(j,1)<Qp*0.103)
               eq(j,1)=-925.33841*(Sim_flow_2060s_RCM10(j,1)/Qd)^2+188.14434*(Sim_flow_2060s_RCM10(j,1)/Qd)-8.95889; %efficiency at flow below peak efficiency flow
           else
               if Sim_flow_2060s_RCM10(j,1)>Qp*0.103 && Sim_flow_2060s_RCM10(j,1)<Qp*0.145
                   eq(j,1)=2.38095*(Sim_flow_2060s_RCM10(j,1)/Qd)+0.35476; %efficiency at flow below peak efficiency flow
               else
                   if Sim_flow_2060s_RCM10(j,1)>Qp*0.145
                       eq(j,1)=-0.38935*(Sim_flow_2060s_RCM10(j,1)/Qd)^2+0.54132*(Sim_flow_2060s_RCM10(j,1)/Qd)+0.63050; %efficiency at flow above peak efficiency flow 
                   end
               end
           end
 
%Calculate available daily power in kW for RCM10
       Power_future_2060s_RCM10(j,1)=(ro*g*Sim_flow_2060s_RCM10(j,1)*Micro_net_head(i,1)*eq(j,1))/1000;
 
       if Power_future_2060s_RCM10(j,1)<=0 %if power is negative it means that the flow is too small to be able to use the scheme
          Power_future_2060s_RCM10(j,1)=0.0001;
       end
       
       Power_installed(j,1)=Micro_installed_power(i,1);
 
%Calculate daily energy in kWh with the capapcity factor set in the beginning (default 40%) for RCM01
       Energy_future_2060s_RCM10(j,1)=Power_future_2060s_RCM10(j,1)*24*CP;
 
%% RCM11
%Calculate flows for RCM11
           if (Sim_flow_2060s_RCM11(j,1)>Qd)
               Sim_flow_2060s_RCM11(j,1)=Qd; %if flows exceed the insalled flow, the scheme can only use the installed flow because of its installed penstock and turbine
           end
 
%Calculate turbine efficiency based on flows for RCM11
           if (Sim_flow_2060s_RCM11(j,1)<Qp*0.103)
               eq(j,1)=-925.33841*(Sim_flow_2060s_RCM11(j,1)/Qd)^2+188.14434*(Sim_flow_2060s_RCM11(j,1)/Qd)-8.95889; %efficiency at flow below peak efficiency flow
           else
               if Sim_flow_2060s_RCM11(j,1)>Qp*0.103 && Sim_flow_2060s_RCM11(j,1)<Qp*0.145
                   eq(j,1)=2.38095*(Sim_flow_2060s_RCM11(j,1)/Qd)+0.35476; %efficiency at flow below peak efficiency flow
               else
                   if Sim_flow_2060s_RCM11(j,1)>Qp*0.145
                       eq(j,1)=-0.38935*(Sim_flow_2060s_RCM11(j,1)/Qd)^2+0.54132*(Sim_flow_2060s_RCM11(j,1)/Qd)+0.63050; %efficiency at flow above peak efficiency flow 
                   end
               end
           end
 
%Calculate available daily power in kW for RCM11
       Power_future_2060s_RCM11(j,1)=(ro*g*Sim_flow_2060s_RCM11(j,1)*Micro_net_head(i,1)*eq(j,1))/1000;
 
       if Power_future_2060s_RCM11(j,1)<=0 %if power is negative it means that the flow is too small to be able to use the scheme
          Power_future_2060s_RCM11(j,1)=0.0001;
       end
       
       Power_installed(j,1)=Micro_installed_power(i,1);
 
%Calculate daily energy in kWh with the capapcity factor set in the beginning (default 40%) for RCM01
       Energy_future_2060s_RCM11(j,1)=Power_future_2060s_RCM11(j,1)*24*CP;
 
%% RCM12
%Calculate flows for RCM12
           if (Sim_flow_2060s_RCM12(j,1)>Qd)
               Sim_flow_2060s_RCM12(j,1)=Qd; %if flows exceed the insalled flow, the scheme can only use the installed flow because of its installed penstock and turbine
           end
 
%Calculate turbine efficiency based on flows for RCM12
           if (Sim_flow_2060s_RCM12(j,1)<Qp*0.103)
               eq(j,1)=-925.33841*(Sim_flow_2060s_RCM12(j,1)/Qd)^2+188.14434*(Sim_flow_2060s_RCM12(j,1)/Qd)-8.95889; %efficiency at flow below peak efficiency flow
           else
               if Sim_flow_2060s_RCM12(j,1)>Qp*0.103 && Sim_flow_2060s_RCM12(j,1)<Qp*0.145
                   eq(j,1)=2.38095*(Sim_flow_2060s_RCM12(j,1)/Qd)+0.35476; %efficiency at flow below peak efficiency flow
               else
                   if Sim_flow_2060s_RCM12(j,1)>Qp*0.145
                       eq(j,1)=-0.38935*(Sim_flow_2060s_RCM12(j,1)/Qd)^2+0.54132*(Sim_flow_2060s_RCM12(j,1)/Qd)+0.63050; %efficiency at flow above peak efficiency flow 
                   end
               end
           end
 
%Calculate available daily power in kW for RCM12
       Power_future_2060s_RCM12(j,1)=(ro*g*Sim_flow_2060s_RCM12(j,1)*Micro_net_head(i,1)*eq(j,1))/1000;
 
       if Power_future_2060s_RCM12(j,1)<=0 %if power is negative it means that the flow is too small to be able to use the scheme
          Power_future_2060s_RCM12(j,1)=0.0001;
       end
       
       Power_installed(j,1)=Micro_installed_power(i,1);
 
%Calculate daily energy in kWh with the capapcity factor set in the beginning (default 40%) for RCM01
       Energy_future_2060s_RCM12(j,1)=Power_future_2060s_RCM12(j,1)*24*CP;
 
%% RCM13
%Calculate flows for RCM13
           if (Sim_flow_2060s_RCM13(j,1)>Qd)
               Sim_flow_2060s_RCM13(j,1)=Qd; %if flows exceed the insalled flow, the scheme can only use the installed flow because of its installed penstock and turbine
           end
 
%Calculate turbine efficiency based on flows for RCM13
           if (Sim_flow_2060s_RCM13(j,1)<Qp*0.103)
               eq(j,1)=-925.33841*(Sim_flow_2060s_RCM13(j,1)/Qd)^2+188.14434*(Sim_flow_2060s_RCM13(j,1)/Qd)-8.95889; %efficiency at flow below peak efficiency flow
           else
               if Sim_flow_2060s_RCM13(j,1)>Qp*0.103 && Sim_flow_2060s_RCM13(j,1)<Qp*0.145
                   eq(j,1)=2.38095*(Sim_flow_2060s_RCM13(j,1)/Qd)+0.35476; %efficiency at flow below peak efficiency flow
               else
                   if Sim_flow_2060s_RCM13(j,1)>Qp*0.145
                       eq(j,1)=-0.38935*(Sim_flow_2060s_RCM13(j,1)/Qd)^2+0.54132*(Sim_flow_2060s_RCM13(j,1)/Qd)+0.63050; %efficiency at flow above peak efficiency flow 
                   end
               end
           end
 
%Calculate available daily power in kW for RCM13
       Power_future_2060s_RCM13(j,1)=(ro*g*Sim_flow_2060s_RCM13(j,1)*Micro_net_head(i,1)*eq(j,1))/1000;
 
       if Power_future_2060s_RCM13(j,1)<=0 %if power is negative it means that the flow is too small to be able to use the scheme
          Power_future_2060s_RCM13(j,1)=0.0001;
       end
       
       Power_installed(j,1)=Micro_installed_power(i,1);
 
%Calculate daily energy in kWh with the capapcity factor set in the beginning (default 40%) for RCM01
       Energy_future_2060s_RCM13(j,1)=Power_future_2060s_RCM13(j,1)*24*CP;
 
%% RCM15
%Calculate flows for RCM15
           if (Sim_flow_2060s_RCM15(j,1)>Qd)
               Sim_flow_2060s_RCM15(j,1)=Qd; %if flows exceed the insalled flow, the scheme can only use the installed flow because of its installed penstock and turbine
           end
 
%Calculate turbine efficiency based on flows for RCM15
           if (Sim_flow_2060s_RCM15(j,1)<Qp*0.103)
               eq(j,1)=-925.33841*(Sim_flow_2060s_RCM15(j,1)/Qd)^2+188.14434*(Sim_flow_2060s_RCM15(j,1)/Qd)-8.95889; %efficiency at flow below peak efficiency flow
           else
               if Sim_flow_2060s_RCM15(j,1)>Qp*0.103 && Sim_flow_2060s_RCM15(j,1)<Qp*0.145
                   eq(j,1)=2.38095*(Sim_flow_2060s_RCM15(j,1)/Qd)+0.35476; %efficiency at flow below peak efficiency flow
               else
                   if Sim_flow_2060s_RCM15(j,1)>Qp*0.145
                       eq(j,1)=-0.38935*(Sim_flow_2060s_RCM15(j,1)/Qd)^2+0.54132*(Sim_flow_2060s_RCM15(j,1)/Qd)+0.63050; %efficiency at flow above peak efficiency flow 
                   end
               end
           end
 
%Calculate available daily power in kW for RCM15
       Power_future_2060s_RCM15(j,1)=(ro*g*Sim_flow_2060s_RCM15(j,1)*Micro_net_head(i,1)*eq(j,1))/1000;
 
       if Power_future_2060s_RCM15(j,1)<=0 %if power is negative it means that the flow is too small to be able to use the scheme
                Power_future_2060s_RCM15(j,1)=0.0001;
       end
       
       Power_installed(j,1)=Micro_installed_power(i,1);
 
%Calculate daily energy in kWh with the capapcity factor set in the beginning (default 40%) for RCM01
       Energy_future_2060s_RCM15(j,1)=Power_future_2060s_RCM15(j,1)*24*CP;
 
%% Add the daily power and energy output for each RCM to a matrix
 
Power_future_2060s_allRCM(j,1)=Power_future_2060s_RCM01(j,1);
Power_future_2060s_allRCM(j,2)=Power_future_2060s_RCM04(j,1);
Power_future_2060s_allRCM(j,3)=Power_future_2060s_RCM05(j,1);
Power_future_2060s_allRCM(j,4)=Power_future_2060s_RCM06(j,1);
Power_future_2060s_allRCM(j,5)=Power_future_2060s_RCM07(j,1);
Power_future_2060s_allRCM(j,6)=Power_future_2060s_RCM08(j,1);
Power_future_2060s_allRCM(j,7)=Power_future_2060s_RCM09(j,1);
Power_future_2060s_allRCM(j,8)=Power_future_2060s_RCM10(j,1);
Power_future_2060s_allRCM(j,9)=Power_future_2060s_RCM11(j,1);
Power_future_2060s_allRCM(j,10)=Power_future_2060s_RCM12(j,1);
Power_future_2060s_allRCM(j,11)=Power_future_2060s_RCM13(j,1);
Power_future_2060s_allRCM(j,12)=Power_future_2060s_RCM15(j,1);
 
Energy_future_2060s_allRCM(j,1)=Energy_future_2060s_RCM01(j,1);
Energy_future_2060s_allRCM(j,2)=Energy_future_2060s_RCM04(j,1);
Energy_future_2060s_allRCM(j,3)=Energy_future_2060s_RCM05(j,1);
Energy_future_2060s_allRCM(j,4)=Energy_future_2060s_RCM06(j,1);
Energy_future_2060s_allRCM(j,5)=Energy_future_2060s_RCM07(j,1);
Energy_future_2060s_allRCM(j,6)=Energy_future_2060s_RCM08(j,1);
Energy_future_2060s_allRCM(j,7)=Energy_future_2060s_RCM09(j,1);
Energy_future_2060s_allRCM(j,8)=Energy_future_2060s_RCM10(j,1);
Energy_future_2060s_allRCM(j,9)=Energy_future_2060s_RCM11(j,1);
Energy_future_2060s_allRCM(j,10)=Energy_future_2060s_RCM12(j,1);
Energy_future_2060s_allRCM(j,11)=Energy_future_2060s_RCM13(j,1);
Energy_future_2060s_allRCM(j,12)=Energy_future_2060s_RCM15(j,1);
 
%% Calculate the mean daily power and energy output considering all the RCMs
Power_future_2060s_mean(j,1)=mean(Power_future_2060s_allRCM(j,:));
Energy_future_2060s_mean(j,1)=mean(Energy_future_2060s_allRCM(j,:));
       
        end
    else if (Micro_turbine_type(i,1)=="Archimedean Screw")
            Power_installed=[];      
%% Get simulated future flows for each RCM
        % RCM01
        Sim_flow_2060s_RCM01=Current_station_future_2060s(:,2); 
        Sim_flow_2060s_RCM01=table2array(Sim_flow_2060s_RCM01);
 
        % RCM04
        Sim_flow_2060s_RCM04=Current_station_future_2060s(:,3); 
        Sim_flow_2060s_RCM04=table2array(Sim_flow_2060s_RCM04);
 
        % RCM05
        Sim_flow_2060s_RCM05=Current_station_future_2060s(:,4); 
        Sim_flow_2060s_RCM05=table2array(Sim_flow_2060s_RCM05);
 
        % RCM06
        Sim_flow_2060s_RCM06=Current_station_future_2060s(:,5); 
        Sim_flow_2060s_RCM06=table2array(Sim_flow_2060s_RCM06);      
 
        % RCM07
        Sim_flow_2060s_RCM07=Current_station_future_2060s(:,6); 
        Sim_flow_2060s_RCM07=table2array(Sim_flow_2060s_RCM07);
 
        % RCM08
        Sim_flow_2060s_RCM08=Current_station_future_2060s(:,7); 
        Sim_flow_2060s_RCM08=table2array(Sim_flow_2060s_RCM08);  
 
        % RCM09
        Sim_flow_2060s_RCM09=Current_station_future_2060s(:,8); 
        Sim_flow_2060s_RCM09=table2array(Sim_flow_2060s_RCM09);
 
        % RCM10
        Sim_flow_2060s_RCM10=Current_station_future_2060s(:,9); 
        Sim_flow_2060s_RCM10=table2array(Sim_flow_2060s_RCM10);
 
        % RCM11
        Sim_flow_2060s_RCM11=Current_station_future_2060s(:,10); 
        Sim_flow_2060s_RCM11=table2array(Sim_flow_2060s_RCM11);
 
        % RCM12
        Sim_flow_2060s_RCM12=Current_station_future_2060s(:,11); 
        Sim_flow_2060s_RCM12=table2array(Sim_flow_2060s_RCM12);
 
        % RCM13
        Sim_flow_2060s_RCM13=Current_station_future_2060s(:,12); 
        Sim_flow_2060s_RCM13=table2array(Sim_flow_2060s_RCM13);
 
        % RCM15
        Sim_flow_2060s_RCM15=Current_station_future_2060s(:,13); 
        Sim_flow_2060s_RCM15=table2array(Sim_flow_2060s_RCM15);
        
       for j=1:height(Current_station_future_2060s)                        
%% RCM01
%Calculate flows for RCM01
           if (Sim_flow_2060s_RCM01(j,1)>Qd)
               Sim_flow_2060s_RCM01(j,1)=Qd; %if flows exceed the insalled flow, the scheme can only use the installed flow because of its installed penstock and turbine
           end

%Calculate turbine efficiency based on flows for RCM01
            if (Sim_flow_2060s_RCM01 (j,1)<=Qp*0.78 && Sim_flow_2060s_RCM01 (j,1)>=Qp*0.43)
                eq(j,1)=-1.3763*( Sim_flow_2060s_RCM01 (j,1)/Qd)^2+2.0858*( Sim_flow_2060s_RCM01 (j,1)/Qd)+0.0346; %efficiency at flow below peak efficiency flow
            else
                if Sim_flow_2060s_RCM01 (j,1)>Qp*1.219
                eq(j,1)=-565.6932290792*( Sim_flow_2060s_RCM01 (j,1)/Qd)^6+3345.5341490459*( Sim_flow_2060s_RCM01 (j,1)/Qd)^5-8204.1750190284*( Sim_flow_2060s_RCM01 (j,1)/Qd)^4+10676.6071388550*( Sim_flow_2060s_RCM01 (j,1)/Qd)^3-7775.4512628411*( Sim_flow_2060s_RCM01 (j,1)/Qd)^2+3004.2384250625*( Sim_flow_2060s_RCM01 (j,1)/Qd)-480.2389292428; %efficiency at flow above peak efficiency flow                              
                end
            end

%Calculate available daily power in kW for RCM01
       Power_future_2060s_RCM01(j,1)=(ro*g*Sim_flow_2060s_RCM01(j,1)*Micro_net_head(i,1)*eq(j,1))/1000;
 
       if Power_future_2060s_RCM01(j,1)<=0 %if power is negative it means that the flow is too small to be able to use the scheme
          Power_future_2060s_RCM01(j,1)=0.0001;
       end
 
       Power_installed(j,1)=Micro_installed_power(i,1);
 
%Calculate daily energy in kWh with the capapcity factor set in the beginning (default 40%) for RCM01
       Energy_future_2060s_RCM01(j,1)=Power_future_2060s_RCM01(j,1)*24*CP;
 
%% RCM04
%Calculate flows for RCM04
           if (Sim_flow_2060s_RCM04(j,1)>Qd)
               Sim_flow_2060s_RCM04(j,1)=Qd; %if flows exceed the insalled flow, the scheme can only use the installed flow because of its installed penstock and turbine
           end
 
%Calculate turbine efficiency based on flows for RCM04
            if (Sim_flow_2060s_RCM04 (j,1)<=Qp*0.78 && Sim_flow_2060s_RCM04 (j,1)>=Qp*0.43)
                eq(j,1)=-1.3763*( Sim_flow_2060s_RCM04 (j,1)/Qd)^2+2.0858*( Sim_flow_2060s_RCM04 (j,1)/Qd)+0.0346; %efficiency at flow below peak efficiency flow
            else
                if Sim_flow_2060s_RCM04 (j,1)>Qp*1.219
                eq(j,1)=-565.6932290792*( Sim_flow_2060s_RCM04 (j,1)/Qd)^6+3345.5341490459*( Sim_flow_2060s_RCM04 (j,1)/Qd)^5-8204.1750190284*( Sim_flow_2060s_RCM04 (j,1)/Qd)^4+10676.6071388550*( Sim_flow_2060s_RCM04 (j,1)/Qd)^3-7775.4512628411*( Sim_flow_2060s_RCM04 (j,1)/Qd)^2+3004.2384250625*( Sim_flow_2060s_RCM04 (j,1)/Qd)-480.2389292428; %efficiency at flow above peak efficiency flow                              
                end
            end
 
%Calculate available daily power in kW for RCM04
       Power_future_2060s_RCM04(j,1)=(ro*g*Sim_flow_2060s_RCM04(j,1)*Micro_net_head(i,1)*eq(j,1))/1000;
 
       if Power_future_2060s_RCM04(j,1)<=0 %if power is negative it means that the flow is too small to be able to use the scheme
          Power_future_2060s_RCM04(j,1)=0.0001;
       end
 
       Power_installed(j,1)=Micro_installed_power(i,1);
 
%Calculate daily energy in kWh with the capapcity factor set in the beginning (default 40%) for RCM04
       Energy_future_2060s_RCM04(j,1)=Power_future_2060s_RCM04(j,1)*24*CP;

%% RCM05
%Calculate flows for RCM05
           if (Sim_flow_2060s_RCM05(j,1)>Qd)
               Sim_flow_2060s_RCM05(j,1)=Qd; %if flows exceed the insalled flow, the scheme can only use the installed flow because of its installed penstock and turbine
           end
 
%Calculate turbine efficiency based on flows for RCM05
            if (Sim_flow_2060s_RCM05 (j,1)<=Qp*0.78 && Sim_flow_2060s_RCM05 (j,1)>=Qp*0.43)
                eq(j,1)=-1.3763*( Sim_flow_2060s_RCM05 (j,1)/Qd)^2+2.0858*( Sim_flow_2060s_RCM05 (j,1)/Qd)+0.0346; %efficiency at flow below peak efficiency flow
            else
                if Sim_flow_2060s_RCM05 (j,1)>Qp*1.219
                eq(j,1)=-565.6932290792*( Sim_flow_2060s_RCM05 (j,1)/Qd)^6+3345.5341490459*( Sim_flow_2060s_RCM05 (j,1)/Qd)^5-8204.1750190284*( Sim_flow_2060s_RCM05 (j,1)/Qd)^4+10676.6071388550*( Sim_flow_2060s_RCM05 (j,1)/Qd)^3-7775.4512628411*( Sim_flow_2060s_RCM05 (j,1)/Qd)^2+3004.2384250625*( Sim_flow_2060s_RCM05 (j,1)/Qd)-480.2389292428; %efficiency at flow above peak efficiency flow                              
                end
            end
 
%Calculate available daily power in kW for RCM05
       Power_future_2060s_RCM05(j,1)=(ro*g*Sim_flow_2060s_RCM05(j,1)*Micro_net_head(i,1)*eq(j,1))/1000;
 
       if Power_future_2060s_RCM05(j,1)<=0 %if power is negative it means that the flow is too small to be able to use the scheme
          Power_future_2060s_RCM05(j,1)=0.0001;
       end
 
       Power_installed(j,1)=Micro_installed_power(i,1);
 
%Calculate daily energy in kWh with the capapcity factor set in the beginning (default 40%) for RCM05
       Energy_future_2060s_RCM05(j,1)=Power_future_2060s_RCM05(j,1)*24*CP;

%% RCM06
%Calculate flows for RCM06
           if (Sim_flow_2060s_RCM06(j,1)>Qd)
               Sim_flow_2060s_RCM06(j,1)=Qd; %if flows exceed the insalled flow, the scheme can only use the installed flow because of its installed penstock and turbine
           end
 
%Calculate turbine efficiency based on flows for RCM06
            if (Sim_flow_2060s_RCM06 (j,1)<=Qp*0.78 && Sim_flow_2060s_RCM06 (j,1)>=Qp*0.43)
                eq(j,1)=-1.3763*( Sim_flow_2060s_RCM06 (j,1)/Qd)^2+2.0858*( Sim_flow_2060s_RCM06 (j,1)/Qd)+0.0346; %efficiency at flow below peak efficiency flow
            else
                if Sim_flow_2060s_RCM06 (j,1)>Qp*1.219
                eq(j,1)=-565.6932290792*( Sim_flow_2060s_RCM06 (j,1)/Qd)^6+3345.5341490459*( Sim_flow_2060s_RCM06 (j,1)/Qd)^5-8204.1750190284*( Sim_flow_2060s_RCM06 (j,1)/Qd)^4+10676.6071388550*( Sim_flow_2060s_RCM06 (j,1)/Qd)^3-7775.4512628411*( Sim_flow_2060s_RCM06 (j,1)/Qd)^2+3004.2384250625*( Sim_flow_2060s_RCM06 (j,1)/Qd)-480.2389292428; %efficiency at flow above peak efficiency flow                              
                end
            end
 
%Calculate available daily power in kW for RCM06
       Power_future_2060s_RCM06(j,1)=(ro*g*Sim_flow_2060s_RCM06(j,1)*Micro_net_head(i,1)*eq(j,1))/1000;
 
       if Power_future_2060s_RCM06(j,1)<=0 %if power is negative it means that the flow is too small to be able to use the scheme
          Power_future_2060s_RCM06(j,1)=0.0001;
       end
 
       Power_installed(j,1)=Micro_installed_power(i,1);
 
%Calculate daily energy in kWh with the capapcity factor set in the beginning (default 40%) for RCM06
       Energy_future_2060s_RCM06(j,1)=Power_future_2060s_RCM06(j,1)*24*CP;

%% RCM07
%Calculate flows for RCM07
           if (Sim_flow_2060s_RCM07(j,1)>Qd)
               Sim_flow_2060s_RCM07(j,1)=Qd; %if flows exceed the insalled flow, the scheme can only use the installed flow because of its installed penstock and turbine
           end
 
%Calculate turbine efficiency based on flows for RCM07
            if (Sim_flow_2060s_RCM07 (j,1)<=Qp*0.78 && Sim_flow_2060s_RCM07 (j,1)>=Qp*0.43)
                eq(j,1)=-1.3763*( Sim_flow_2060s_RCM07 (j,1)/Qd)^2+2.0858*( Sim_flow_2060s_RCM07 (j,1)/Qd)+0.0346; %efficiency at flow below peak efficiency flow
            else
                if Sim_flow_2060s_RCM07 (j,1)>Qp*1.219
                eq(j,1)=-565.6932290792*( Sim_flow_2060s_RCM07 (j,1)/Qd)^6+3345.5341490459*( Sim_flow_2060s_RCM07 (j,1)/Qd)^5-8204.1750190284*( Sim_flow_2060s_RCM07 (j,1)/Qd)^4+10676.6071388550*( Sim_flow_2060s_RCM07 (j,1)/Qd)^3-7775.4512628411*( Sim_flow_2060s_RCM07 (j,1)/Qd)^2+3004.2384250625*( Sim_flow_2060s_RCM07 (j,1)/Qd)-480.2389292428; %efficiency at flow above peak efficiency flow                              
                end
            end
 
%Calculate available daily power in kW for RCM07
       Power_future_2060s_RCM07(j,1)=(ro*g*Sim_flow_2060s_RCM07(j,1)*Micro_net_head(i,1)*eq(j,1))/1000;
 
       if Power_future_2060s_RCM07(j,1)<=0 %if power is negative it means that the flow is too small to be able to use the scheme
          Power_future_2060s_RCM07(j,1)=0.0001;
       end
 
       Power_installed(j,1)=Micro_installed_power(i,1);
 
%Calculate daily energy in kWh with the capapcity factor set in the beginning (default 40%) for RCM07
       Energy_future_2060s_RCM07(j,1)=Power_future_2060s_RCM07(j,1)*24*CP;

%% RCM08
%Calculate flows for RCM08
           if (Sim_flow_2060s_RCM08(j,1)>Qd)
               Sim_flow_2060s_RCM08(j,1)=Qd; %if flows exceed the insalled flow, the scheme can only use the installed flow because of its installed penstock and turbine
           end
 
%Calculate turbine efficiency based on flows for RCM08
            if (Sim_flow_2060s_RCM08 (j,1)<=Qp*0.78 && Sim_flow_2060s_RCM08 (j,1)>=Qp*0.43)
                eq(j,1)=-1.3763*( Sim_flow_2060s_RCM08 (j,1)/Qd)^2+2.0858*( Sim_flow_2060s_RCM08 (j,1)/Qd)+0.0346; %efficiency at flow below peak efficiency flow
            else
                if Sim_flow_2060s_RCM08 (j,1)>Qp*1.219
                eq(j,1)=-565.6932290792*( Sim_flow_2060s_RCM08 (j,1)/Qd)^6+3345.5341490459*( Sim_flow_2060s_RCM08 (j,1)/Qd)^5-8204.1750190284*( Sim_flow_2060s_RCM08 (j,1)/Qd)^4+10676.6071388550*( Sim_flow_2060s_RCM08 (j,1)/Qd)^3-7775.4512628411*( Sim_flow_2060s_RCM08 (j,1)/Qd)^2+3004.2384250625*( Sim_flow_2060s_RCM08 (j,1)/Qd)-480.2389292428; %efficiency at flow above peak efficiency flow                              
                end
            end
 
%Calculate available daily power in kW for RCM08
       Power_future_2060s_RCM08(j,1)=(ro*g*Sim_flow_2060s_RCM08(j,1)*Micro_net_head(i,1)*eq(j,1))/1000;
 
       if Power_future_2060s_RCM08(j,1)<=0 %if power is negative it means that the flow is too small to be able to use the scheme
          Power_future_2060s_RCM08(j,1)=0.0001;
       end
 
       Power_installed(j,1)=Micro_installed_power(i,1);
 
%Calculate daily energy in kWh with the capapcity factor set in the beginning (default 40%) for RCM08
       Energy_future_2060s_RCM08(j,1)=Power_future_2060s_RCM08(j,1)*24*CP;

%% RCM09
%Calculate flows for RCM09
           if (Sim_flow_2060s_RCM09(j,1)>Qd)
               Sim_flow_2060s_RCM09(j,1)=Qd; %if flows exceed the insalled flow, the scheme can only use the installed flow because of its installed penstock and turbine
           end
 
%Calculate turbine efficiency based on flows for RCM09
            if (Sim_flow_2060s_RCM09 (j,1)<=Qp*0.78 && Sim_flow_2060s_RCM09 (j,1)>=Qp*0.43)
                eq(j,1)=-1.3763*( Sim_flow_2060s_RCM09 (j,1)/Qd)^2+2.0858*( Sim_flow_2060s_RCM09 (j,1)/Qd)+0.0346; %efficiency at flow below peak efficiency flow
            else
                if Sim_flow_2060s_RCM09 (j,1)>Qp*1.219
                eq(j,1)=-565.6932290792*( Sim_flow_2060s_RCM09 (j,1)/Qd)^6+3345.5341490459*( Sim_flow_2060s_RCM09 (j,1)/Qd)^5-8204.1750190284*( Sim_flow_2060s_RCM09 (j,1)/Qd)^4+10676.6071388550*( Sim_flow_2060s_RCM09 (j,1)/Qd)^3-7775.4512628411*( Sim_flow_2060s_RCM09 (j,1)/Qd)^2+3004.2384250625*( Sim_flow_2060s_RCM09 (j,1)/Qd)-480.2389292428; %efficiency at flow above peak efficiency flow                              
                end
            end
 
%Calculate available daily power in kW for RCM09
       Power_future_2060s_RCM09(j,1)=(ro*g*Sim_flow_2060s_RCM09(j,1)*Micro_net_head(i,1)*eq(j,1))/1000;
 
       if Power_future_2060s_RCM09(j,1)<=0 %if power is negative it means that the flow is too small to be able to use the scheme
          Power_future_2060s_RCM09(j,1)=0.0001;
       end
 
       Power_installed(j,1)=Micro_installed_power(i,1);
 
%Calculate daily energy in kWh with the capapcity factor set in the beginning (default 40%) for RCM09
       Energy_future_2060s_RCM09(j,1)=Power_future_2060s_RCM09(j,1)*24*CP;

%% RCM10
%Calculate flows for RCM10
           if (Sim_flow_2060s_RCM10(j,1)>Qd)
               Sim_flow_2060s_RCM10(j,1)=Qd; %if flows exceed the insalled flow, the scheme can only use the installed flow because of its installed penstock and turbine
           end
 
%Calculate turbine efficiency based on flows for RCM10
            if (Sim_flow_2060s_RCM10 (j,1)<=Qp*0.78 && Sim_flow_2060s_RCM10 (j,1)>=Qp*0.43)
                eq(j,1)=-1.3763*( Sim_flow_2060s_RCM10 (j,1)/Qd)^2+2.0858*( Sim_flow_2060s_RCM10 (j,1)/Qd)+0.0346; %efficiency at flow below peak efficiency flow
            else
                if Sim_flow_2060s_RCM10 (j,1)>Qp*1.219
                eq(j,1)=-565.6932290792*( Sim_flow_2060s_RCM10 (j,1)/Qd)^6+3345.5341490459*( Sim_flow_2060s_RCM10 (j,1)/Qd)^5-8204.1750190284*( Sim_flow_2060s_RCM10 (j,1)/Qd)^4+10676.6071388550*( Sim_flow_2060s_RCM10 (j,1)/Qd)^3-7775.4512628411*( Sim_flow_2060s_RCM10 (j,1)/Qd)^2+3004.2384250625*( Sim_flow_2060s_RCM10 (j,1)/Qd)-480.2389292428; %efficiency at flow above peak efficiency flow                              
                end
            end
 
%Calculate available daily power in kW for RCM10
       Power_future_2060s_RCM10(j,1)=(ro*g*Sim_flow_2060s_RCM10(j,1)*Micro_net_head(i,1)*eq(j,1))/1000;
 
       if Power_future_2060s_RCM10(j,1)<=0 %if power is negative it means that the flow is too small to be able to use the scheme
          Power_future_2060s_RCM10(j,1)=0.0001;
       end
 
       Power_installed(j,1)=Micro_installed_power(i,1);
 
%Calculate daily energy in kWh with the capapcity factor set in the beginning (default 40%) for RCM10
       Energy_future_2060s_RCM10(j,1)=Power_future_2060s_RCM10(j,1)*24*CP;

%% RCM11
%Calculate flows for RCM11
           if (Sim_flow_2060s_RCM11(j,1)>Qd)
               Sim_flow_2060s_RCM11(j,1)=Qd; %if flows exceed the insalled flow, the scheme can only use the installed flow because of its installed penstock and turbine
           end
 
%Calculate turbine efficiency based on flows for RCM11
            if (Sim_flow_2060s_RCM11 (j,1)<=Qp*0.78 && Sim_flow_2060s_RCM11 (j,1)>=Qp*0.43)
                eq(j,1)=-1.3763*( Sim_flow_2060s_RCM11 (j,1)/Qd)^2+2.0858*( Sim_flow_2060s_RCM11 (j,1)/Qd)+0.0346; %efficiency at flow below peak efficiency flow
            else
                if Sim_flow_2060s_RCM11 (j,1)>Qp*1.219
                eq(j,1)=-565.6932290792*( Sim_flow_2060s_RCM11 (j,1)/Qd)^6+3345.5341490459*( Sim_flow_2060s_RCM11 (j,1)/Qd)^5-8204.1750190284*( Sim_flow_2060s_RCM11 (j,1)/Qd)^4+10676.6071388550*( Sim_flow_2060s_RCM11 (j,1)/Qd)^3-7775.4512628411*( Sim_flow_2060s_RCM11 (j,1)/Qd)^2+3004.2384250625*( Sim_flow_2060s_RCM11 (j,1)/Qd)-480.2389292428; %efficiency at flow above peak efficiency flow                              
                end
            end
 
%Calculate available daily power in kW for RCM11
       Power_future_2060s_RCM11(j,1)=(ro*g*Sim_flow_2060s_RCM11(j,1)*Micro_net_head(i,1)*eq(j,1))/1000;
 
       if Power_future_2060s_RCM11(j,1)<=0 %if power is negative it means that the flow is too small to be able to use the scheme
          Power_future_2060s_RCM11(j,1)=0.0001;
       end
 
       Power_installed(j,1)=Micro_installed_power(i,1);
 
%Calculate daily energy in kWh with the capapcity factor set in the beginning (default 40%) for RCM11
       Energy_future_2060s_RCM11(j,1)=Power_future_2060s_RCM11(j,1)*24*CP;

%% RCM12
%Calculate flows for RCM12
           if (Sim_flow_2060s_RCM12(j,1)>Qd)
               Sim_flow_2060s_RCM12(j,1)=Qd; %if flows exceed the insalled flow, the scheme can only use the installed flow because of its installed penstock and turbine
           end
 
%Calculate turbine efficiency based on flows for RCM12
            if (Sim_flow_2060s_RCM12 (j,1)<=Qp*0.78 && Sim_flow_2060s_RCM12 (j,1)>=Qp*0.43)
                eq(j,1)=-1.3763*( Sim_flow_2060s_RCM12 (j,1)/Qd)^2+2.0858*( Sim_flow_2060s_RCM12 (j,1)/Qd)+0.0346; %efficiency at flow below peak efficiency flow
            else
                if Sim_flow_2060s_RCM12 (j,1)>Qp*1.219
                eq(j,1)=-565.6932290792*( Sim_flow_2060s_RCM12 (j,1)/Qd)^6+3345.5341490459*( Sim_flow_2060s_RCM12 (j,1)/Qd)^5-8204.1750190284*( Sim_flow_2060s_RCM12 (j,1)/Qd)^4+10676.6071388550*( Sim_flow_2060s_RCM12 (j,1)/Qd)^3-7775.4512628411*( Sim_flow_2060s_RCM12 (j,1)/Qd)^2+3004.2384250625*( Sim_flow_2060s_RCM12 (j,1)/Qd)-480.2389292428; %efficiency at flow above peak efficiency flow                              
                end
            end
 
%Calculate available daily power in kW for RCM12
       Power_future_2060s_RCM12(j,1)=(ro*g*Sim_flow_2060s_RCM12(j,1)*Micro_net_head(i,1)*eq(j,1))/1000;
 
       if Power_future_2060s_RCM12(j,1)<=0 %if power is negative it means that the flow is too small to be able to use the scheme
          Power_future_2060s_RCM12(j,1)=0.0001;
       end
 
       Power_installed(j,1)=Micro_installed_power(i,1);
 
%Calculate daily energy in kWh with the capapcity factor set in the beginning (default 40%) for RCM12
       Energy_future_2060s_RCM12(j,1)=Power_future_2060s_RCM12(j,1)*24*CP;

%% RCM13
%Calculate flows for RCM13
           if (Sim_flow_2060s_RCM13(j,1)>Qd)
               Sim_flow_2060s_RCM13(j,1)=Qd; %if flows exceed the insalled flow, the scheme can only use the installed flow because of its installed penstock and turbine
           end
 
%Calculate turbine efficiency based on flows for RCM13
            if (Sim_flow_2060s_RCM13 (j,1)<=Qp*0.78 && Sim_flow_2060s_RCM13 (j,1)>=Qp*0.43)
                eq(j,1)=-1.3763*( Sim_flow_2060s_RCM13 (j,1)/Qd)^2+2.0858*( Sim_flow_2060s_RCM13 (j,1)/Qd)+0.0346; %efficiency at flow below peak efficiency flow
            else
                if Sim_flow_2060s_RCM13 (j,1)>Qp*1.219
                eq(j,1)=-565.6932290792*( Sim_flow_2060s_RCM13 (j,1)/Qd)^6+3345.5341490459*( Sim_flow_2060s_RCM13 (j,1)/Qd)^5-8204.1750190284*( Sim_flow_2060s_RCM13 (j,1)/Qd)^4+10676.6071388550*( Sim_flow_2060s_RCM13 (j,1)/Qd)^3-7775.4512628411*( Sim_flow_2060s_RCM13 (j,1)/Qd)^2+3004.2384250625*( Sim_flow_2060s_RCM13 (j,1)/Qd)-480.2389292428; %efficiency at flow above peak efficiency flow                              
                end
            end
 
%Calculate available daily power in kW for RCM13
       Power_future_2060s_RCM13(j,1)=(ro*g*Sim_flow_2060s_RCM13(j,1)*Micro_net_head(i,1)*eq(j,1))/1000;
 
       if Power_future_2060s_RCM13(j,1)<=0 %if power is negative it means that the flow is too small to be able to use the scheme
          Power_future_2060s_RCM13(j,1)=0.0001;
       end
 
       Power_installed(j,1)=Micro_installed_power(i,1);
 
%Calculate daily energy in kWh with the capapcity factor set in the beginning (default 40%) for RCM13
       Energy_future_2060s_RCM13(j,1)=Power_future_2060s_RCM13(j,1)*24*CP;

%% RCM15
%Calculate flows for RCM15
           if (Sim_flow_2060s_RCM15(j,1)>Qd)
               Sim_flow_2060s_RCM15(j,1)=Qd; %if flows exceed the insalled flow, the scheme can only use the installed flow because of its installed penstock and turbine
           end
 
%Calculate turbine efficiency based on flows for RCM15
            if (Sim_flow_2060s_RCM15 (j,1)<=Qp*0.78 && Sim_flow_2060s_RCM15 (j,1)>=Qp*0.43)
                eq(j,1)=-1.3763*( Sim_flow_2060s_RCM15 (j,1)/Qd)^2+2.0858*( Sim_flow_2060s_RCM15 (j,1)/Qd)+0.0346; %efficiency at flow below peak efficiency flow
            else
                if Sim_flow_2060s_RCM15 (j,1)>Qp*1.219
                eq(j,1)=-565.6932290792*( Sim_flow_2060s_RCM15 (j,1)/Qd)^6+3345.5341490459*( Sim_flow_2060s_RCM15 (j,1)/Qd)^5-8204.1750190284*( Sim_flow_2060s_RCM15 (j,1)/Qd)^4+10676.6071388550*( Sim_flow_2060s_RCM15 (j,1)/Qd)^3-7775.4512628411*( Sim_flow_2060s_RCM15 (j,1)/Qd)^2+3004.2384250625*( Sim_flow_2060s_RCM15 (j,1)/Qd)-480.2389292428; %efficiency at flow above peak efficiency flow                              
                end
            end
 
%Calculate available daily power in kW for RCM15
       Power_future_2060s_RCM15(j,1)=(ro*g*Sim_flow_2060s_RCM15(j,1)*Micro_net_head(i,1)*eq(j,1))/1000;
 
       if Power_future_2060s_RCM15(j,1)<=0 %if power is negative it means that the flow is too small to be able to use the scheme
          Power_future_2060s_RCM15(j,1)=0.0001;
       end
 
       Power_installed(j,1)=Micro_installed_power(i,1);
 
%Calculate daily energy in kWh with the capapcity factor set in the beginning (default 40%) for RCM15
       Energy_future_2060s_RCM15(j,1)=Power_future_2060s_RCM15(j,1)*24*CP;

%% Add the daily power and energy output for each RCM to a matrix
 
Power_future_2060s_allRCM(j,1)=Power_future_2060s_RCM01(j,1);
Power_future_2060s_allRCM(j,2)=Power_future_2060s_RCM04(j,1);
Power_future_2060s_allRCM(j,3)=Power_future_2060s_RCM05(j,1);
Power_future_2060s_allRCM(j,4)=Power_future_2060s_RCM06(j,1);
Power_future_2060s_allRCM(j,5)=Power_future_2060s_RCM07(j,1);
Power_future_2060s_allRCM(j,6)=Power_future_2060s_RCM08(j,1);
Power_future_2060s_allRCM(j,7)=Power_future_2060s_RCM09(j,1);
Power_future_2060s_allRCM(j,8)=Power_future_2060s_RCM10(j,1);
Power_future_2060s_allRCM(j,9)=Power_future_2060s_RCM11(j,1);
Power_future_2060s_allRCM(j,10)=Power_future_2060s_RCM12(j,1);
Power_future_2060s_allRCM(j,11)=Power_future_2060s_RCM13(j,1);
Power_future_2060s_allRCM(j,12)=Power_future_2060s_RCM15(j,1);
 
Energy_future_2060s_allRCM(j,1)=Energy_future_2060s_RCM01(j,1);
Energy_future_2060s_allRCM(j,2)=Energy_future_2060s_RCM04(j,1);
Energy_future_2060s_allRCM(j,3)=Energy_future_2060s_RCM05(j,1);
Energy_future_2060s_allRCM(j,4)=Energy_future_2060s_RCM06(j,1);
Energy_future_2060s_allRCM(j,5)=Energy_future_2060s_RCM07(j,1);
Energy_future_2060s_allRCM(j,6)=Energy_future_2060s_RCM08(j,1);
Energy_future_2060s_allRCM(j,7)=Energy_future_2060s_RCM09(j,1);
Energy_future_2060s_allRCM(j,8)=Energy_future_2060s_RCM10(j,1);
Energy_future_2060s_allRCM(j,9)=Energy_future_2060s_RCM11(j,1);
Energy_future_2060s_allRCM(j,10)=Energy_future_2060s_RCM12(j,1);
Energy_future_2060s_allRCM(j,11)=Energy_future_2060s_RCM13(j,1);
Energy_future_2060s_allRCM(j,12)=Energy_future_2060s_RCM15(j,1);
 
%% Calculate the mean daily power and energy output considering all the RCMs
Power_future_2060s_mean(j,1)=mean(Power_future_2060s_allRCM(j,:));
Energy_future_2060s_mean(j,1)=mean(Energy_future_2060s_allRCM(j,:));
       end
        end
    end    
No_of_days=[1:length(Sim_flow_2060s_RCM01)];
No_of_days=No_of_days.'; 
 
%% Plot the future autumn 2060s daily power vs installed power for RCM01
       clf %clears figure information
       set(gca,'Box','on');
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_autumn_2030_RCM01_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future autumn 2060s daily available power vs installed power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",' for RCM01');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Power [kW]');
       hold on
       plot(Time_Sim_future_2060s,Power_future_2060s_RCM01);
       hold on
       plot(Time_Sim_future_2060s,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available daily power [kW]','Installed power [kW]','Location','southeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
         
%% Plot the future autumn 2060s daily power vs installed power for RCM04
       clf %clears figure information
       set(gca,'Box','on');
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_autumn_2030_RCM04_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future autumn 2060s daily available power vs installed power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",' for RCM04');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Power [kW]');
       hold on
       plot(Time_Sim_future_2060s,Power_future_2060s_RCM04);
       hold on
       plot(Time_Sim_future_2060s,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available daily power [kW]','Installed power [kW]','Location','southeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the future autumn 2060s daily power vs installed power for RCM05
       clf %clears figure information
       set(gca,'Box','on');
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_autumn_2060s_RCM05_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future autumn 2060s daily available power vs installed power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",' for RCM05');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Power [kW]');
       hold on
       plot(Time_Sim_future_2060s,Power_future_2060s_RCM05);
       hold on
       plot(Time_Sim_future_2060s,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available daily power [kW]','Installed power [kW]','Location','southeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the future autumn 2060s daily power vs installed power for RCM06
       clf %clears figure information
       set(gca,'Box','on');
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_autumn_2030_RCM06_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future autumn 2060s daily available power vs installed power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",' for RCM06');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Power [kW]');
       hold on
       plot(Time_Sim_future_2060s,Power_future_2060s_RCM06);
       hold on
       plot(Time_Sim_future_2060s,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available daily power [kW]','Installed power [kW]','Location','southeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the future autumn 2060s daily power vs installed power for RCM07
       clf %clears figure information
       set(gca,'Box','on');
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_autumn_2030_RCM07_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future autumn 2060s daily available power vs installed power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",' for RCM07');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Power [kW]');
       hold on
       plot(Time_Sim_future_2060s,Power_future_2060s_RCM07);
       hold on
       plot(Time_Sim_future_2060s,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available daily power [kW]','Installed power [kW]','Location','southeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the  autumn 2060s daily power vs installed power for RCM08
       clf %clears figure information
       set(gca,'Box','on');
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_autumn__2030_RCM08_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future autumn 2060s daily available power vs installed power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",' for RCM08');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Power [kW]');
       hold on
       plot(Time_Sim_future_2060s,Power_future_2060s_RCM08);
       hold on
       plot(Time_Sim_future_2060s,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available daily power [kW]','Installed power [kW]','Location','southeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the future autumn 2060s daily power vs installed power for RCM09
       clf %clears figure information
       set(gca,'Box','on');
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_autumn_2030_RCM09_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future autumn 2060s daily available power vs installed power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",' for RCM09');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Power [kW]');
       hold on
       plot(Time_Sim_future_2060s,Power_future_2060s_RCM09);
       hold on
       plot(Time_Sim_future_2060s,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available daily power [kW]','Installed power [kW]','Location','southeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the future autumn 2060s daily power vs installed power for RCM10
       clf %clears figure information
       set(gca,'Box','on');
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_autumn_2030_RCM10_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future autumn 2060s daily available power vs installed power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",' for RCM10');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Power [kW]');
       hold on
       plot(Time_Sim_future_2060s,Power_future_2060s_RCM10);
       hold on
       plot(Time_Sim_future_2060s,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available daily power [kW]','Installed power [kW]','Location','southeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the future autumn 2060s daily power vs installed power for RCM11
       clf %clears figure information
       set(gca,'Box','on');
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_autumn_2030_RCM11_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future autumn 2060s daily available power vs installed power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",' for RCM11');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Power [kW]');
       hold on
       plot(Time_Sim_future_2060s,Power_future_2060s_RCM11);
       hold on
       plot(Time_Sim_future_2060s,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available daily power [kW]','Installed power [kW]','Location','southeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the future autumn 2060s daily power vs installed power for RCM12
       clf %clears figure information
       set(gca,'Box','on');
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_autumn_2030_RCM12_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future autumn 2060s daily available power vs installed power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",' for RCM12');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Power [kW]');
       hold on
       plot(Time_Sim_future_2060s,Power_future_2060s_RCM12);
       hold on
       plot(Time_Sim_future_2060s,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available daily power [kW]','Installed power [kW]','Location','southeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the future autumn 2060s daily power vs installed power for RCM13
       clf %clears figure information
       set(gca,'Box','on');
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_autumn_2030_RCM13_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future autumn 2060s daily available power vs installed power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",' for RCM13');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Power [kW]');
       hold on
       plot(Time_Sim_future_2060s,Power_future_2060s_RCM13);
       hold on
       plot(Time_Sim_future_2060s,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available daily power [kW]','Installed power [kW]','Location','southeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the future autumn 2060s daily power vs installed power for RCM15
       clf %clears figure information
       set(gca,'Box','on');
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_autumn_2030_RCM15_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future autumn 2060s daily available power vs installed power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",' for RCM15');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Power [kW]');
       hold on
       plot(Time_Sim_future_2060s,Power_future_2060s_RCM15);
       hold on
       plot(Time_Sim_future_2060s,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available daily power [kW]','Installed power [kW]','Location','southeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the future autumn mean 2060s daily power vs installed power
       clf %clears figure information
       set(gca,'Box','on');
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_autumn_mean_2030_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future autumn 2060s mean daily available power vs installed power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no);
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Power [kW]');
       hold on
       plot(Time_Sim_future_2060s,Power_future_2060s_mean);
       hold on
       plot(Time_Sim_future_2060s,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available daily power [kW]','Installed power [kW]','Location','southeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
       
%% Plot the future autumn 2060s daily energy for RCM01
       clf %clears figure information
       set(gca,'Box','on');       
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_autumn_2060s_RCM01_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future autumn 2060s daily energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",' for RCM01');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Energy [kWh]');
       hold on
       plot(Time_Sim_future_2060s,Energy_future_2060s_RCM01);
       hold on
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the future autumn 2060s daily energy for RCM04
       clf %clears figure information
       set(gca,'Box','on');       
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_autumn_2060s_RCM04_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future autumn 2060s daily energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",' for RCM04');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Energy [kWh]');
       hold on
       plot(Time_Sim_future_2060s,Energy_future_2060s_RCM04);
       hold on
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the future autumn 2060s daily energy for RCM05
       clf %clears figure information
       set(gca,'Box','on');       
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_autumn_2060s_RCM05_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future autumn 2060s daily energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",' for RCM05');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Energy [kWh]');
       hold on
       plot(Time_Sim_future_2060s,Energy_future_2060s_RCM05);
       hold on
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the future autumn 2060s daily energy for RCM06
       clf %clears figure information
       set(gca,'Box','on');       
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_autumn_2060s_RCM06_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future autumn 2060s daily energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",' for RCM06');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Energy [kWh]');
       hold on
       plot(Time_Sim_future_2060s,Energy_future_2060s_RCM06);
       hold on
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the future autumn 2060s daily energy for RCM07
       clf %clears figure information
       set(gca,'Box','on');       
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_autumn_2060s_RCM07_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future autumn 2060s daily energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",' for RCM07');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Energy [kWh]');
       hold on
       plot(Time_Sim_future_2060s,Energy_future_2060s_RCM07);
       hold on
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the future autumn 2060s daily energy for RCM08
       clf %clears figure information
       set(gca,'Box','on');       
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_autumn_2060s_RCM08_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future autumn 2060s daily energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",' for RCM08');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Energy [kWh]');
       hold on
       plot(Time_Sim_future_2060s,Energy_future_2060s_RCM08);
       hold on
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the future autumn 2060s daily energy for RCM09
       clf %clears figure information
       set(gca,'Box','on');       
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_autumn_2060s_RCM09_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future autumn 2060s daily energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",' for RCM09');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Energy [kWh]');
       hold on
       plot(Time_Sim_future_2060s,Energy_future_2060s_RCM09);
       hold on
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the future autumn 2060s daily energy for RCM10
       clf %clears figure information
       set(gca,'Box','on');       
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_autumn_2060s_RCM10_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future autumn 2060s daily energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",' for RCM10');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Energy [kWh]');
       hold on
       plot(Time_Sim_future_2060s,Energy_future_2060s_RCM10);
       hold on
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the future autumn 2060s daily energy for RCM11
       clf %clears figure information
       set(gca,'Box','on');       
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_autumn_2060s_RCM11_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future autumn 2060s daily energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",' for RCM11');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Energy [kWh]');
       hold on
       plot(Time_Sim_future_2060s,Energy_future_2060s_RCM11);
       hold on
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the future autumn 2060s daily energy for RCM12
       clf %clears figure information
       set(gca,'Box','on');       
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_autumn_2060s_RCM12_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future autumn 2060s daily energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",' for RCM12');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Energy [kWh]');
       hold on
       plot(Time_Sim_future_2060s,Energy_future_2060s_RCM12);
       hold on
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the future autumn 2060s daily energy for RCM13
       clf %clears figure information
       set(gca,'Box','on');       
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_autumn_2060s_RCM13_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future autumn 2060s daily energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",' for RCM13');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Energy [kWh]');
       hold on
       plot(Time_Sim_future_2060s,Energy_future_2060s_RCM13);
       hold on
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the future autumn 2060s daily energy for RCM15
       clf %clears figure information
       set(gca,'Box','on');       
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_autumn_2060s_RCM15_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future autumn 2060s daily energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",' for RCM15');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Energy [kWh]');
       hold on
       plot(Time_Sim_future_2060s,Energy_future_2060s_RCM15);
       hold on
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the future autumn mean daily energy for all RCMs
       clf %clears figure information
       set(gca,'Box','on');       
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_autumn_mean_2060s_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future autumn 2060s mean daily energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no);
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Energy [kWh]');
       hold on
       plot(Time_Sim_future_2060s,Energy_future_2060s_mean);
       hold on
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Add the baseline and future daily power and energy output to a table and calculate the difference
 
Time_Obs_string=[];
Time_Sim_future_string=[];
Time_Obs_string=datestr(Time_Obs_baseline);
%Time_Sim_future_string=datestr(Time_Sim_future_2060s);
%Add the baseline
Table_daily=[];
 
for j=1:length(Sim_flow_2060s_RCM01)
    Table_daily{j,1}=Time_Obs_string(j,:);
    Table_daily{j,2}=Power_baseline(j,1);
    Table_daily{j,3}=Energy_baseline(j,1);
    Table_daily{j,4}=Time_Sim_future_2060s(j,:);
    Table_daily{j,5}=Power_future_2060s_RCM01(j,1);
    Table_daily{j,6}=Power_future_2060s_RCM04(j,1);
    Table_daily{j,7}=Power_future_2060s_RCM05(j,1);
    Table_daily{j,8}=Power_future_2060s_RCM06(j,1);
    Table_daily{j,9}=Power_future_2060s_RCM07(j,1);
    Table_daily{j,10}=Power_future_2060s_RCM08(j,1);
    Table_daily{j,11}=Power_future_2060s_RCM09(j,1);
    Table_daily{j,12}=Power_future_2060s_RCM10(j,1);
    Table_daily{j,13}=Power_future_2060s_RCM11(j,1);
    Table_daily{j,14}=Power_future_2060s_RCM12(j,1);
    Table_daily{j,15}=Power_future_2060s_RCM13(j,1);
    Table_daily{j,16}=Power_future_2060s_RCM15(j,1);
    Table_daily{j,17}=Energy_future_2060s_RCM01(j,1);
    Table_daily{j,18}=Energy_future_2060s_RCM04(j,1);
    Table_daily{j,19}=Energy_future_2060s_RCM05(j,1);
    Table_daily{j,20}=Energy_future_2060s_RCM06(j,1);
    Table_daily{j,21}=Energy_future_2060s_RCM07(j,1);
    Table_daily{j,22}=Energy_future_2060s_RCM08(j,1);
    Table_daily{j,23}=Energy_future_2060s_RCM09(j,1);
    Table_daily{j,24}=Energy_future_2060s_RCM10(j,1);
    Table_daily{j,25}=Energy_future_2060s_RCM11(j,1);
    Table_daily{j,26}=Energy_future_2060s_RCM12(j,1);
    Table_daily{j,27}=Energy_future_2060s_RCM13(j,1);
    Table_daily{j,28}=Energy_future_2060s_RCM15(j,1);
    Table_daily{j,29}=Power_future_2060s_mean(j,1);
    Table_daily{j,30}=Energy_future_2060s_mean(j,1);
    Table_daily{j,31}=(Power_baseline(j,1)-Power_future_2060s_RCM01(j,1))/Power_baseline(j,1)*100;
    Power_dif_2060s_RCM01(j,1)=(Power_baseline(j,1)-Power_future_2060s_RCM01(j,1))/Power_baseline(j,1)*100;
    Table_daily{j,32}=(Power_baseline(j,1)-Power_future_2060s_RCM04(j,1))/Power_baseline(j,1)*100;
    Power_dif_2060s_RCM04(j,1)=(Power_baseline(j,1)-Power_future_2060s_RCM04(j,1))/Power_baseline(j,1)*100;
    Table_daily{j,33}=(Power_baseline(j,1)-Power_future_2060s_RCM05(j,1))/Power_baseline(j,1)*100;
    Power_dif_2060s_RCM05(j,1)=(Power_baseline(j,1)-Power_future_2060s_RCM05(j,1))/Power_baseline(j,1)*100;
    Table_daily{j,34}=(Power_baseline(j,1)-Power_future_2060s_RCM06(j,1))/Power_baseline(j,1)*100;
    Power_dif_2060s_RCM06(j,1)=(Power_baseline(j,1)-Power_future_2060s_RCM06(j,1))/Power_baseline(j,1)*100;
    Table_daily{j,35}=(Power_baseline(j,1)-Power_future_2060s_RCM07(j,1))/Power_baseline(j,1)*100;
    Power_dif_2060s_RCM07(j,1)=(Power_baseline(j,1)-Power_future_2060s_RCM07(j,1))/Power_baseline(j,1)*100;
    Table_daily{j,36}=(Power_baseline(j,1)-Power_future_2060s_RCM08(j,1))/Power_baseline(j,1)*100;
    Power_dif_2060s_RCM08(j,1)=(Power_baseline(j,1)-Power_future_2060s_RCM08(j,1))/Power_baseline(j,1)*100;
    Table_daily{j,37}=(Power_baseline(j,1)-Power_future_2060s_RCM09(j,1))/Power_baseline(j,1)*100;
    Power_dif_2060s_RCM09(j,1)=(Power_baseline(j,1)-Power_future_2060s_RCM09(j,1))/Power_baseline(j,1)*100;
    Table_daily{j,38}=(Power_baseline(j,1)-Power_future_2060s_RCM10(j,1))/Power_baseline(j,1)*100;
    Power_dif_2060s_RCM10(j,1)=(Power_baseline(j,1)-Power_future_2060s_RCM10(j,1))/Power_baseline(j,1)*100;
    Table_daily{j,39}=(Power_baseline(j,1)-Power_future_2060s_RCM11(j,1))/Power_baseline(j,1)*100;
    Power_dif_2060s_RCM11(j,1)=(Power_baseline(j,1)-Power_future_2060s_RCM11(j,1))/Power_baseline(j,1)*100;
    Table_daily{j,40}=(Power_baseline(j,1)-Power_future_2060s_RCM12(j,1))/Power_baseline(j,1)*100;
    Power_dif_2060s_RCM12(j,1)=(Power_baseline(j,1)-Power_future_2060s_RCM12(j,1))/Power_baseline(j,1)*100;
    Table_daily{j,41}=(Power_baseline(j,1)-Power_future_2060s_RCM13(j,1))/Power_baseline(j,1)*100;
    Power_dif_2060s_RCM13(j,1)=(Power_baseline(j,1)-Power_future_2060s_RCM13(j,1))/Power_baseline(j,1)*100;
    Table_daily{j,42}=(Power_baseline(j,1)-Power_future_2060s_RCM15(j,1))/Power_baseline(j,1)*100;
    Power_dif_2060s_RCM15(j,1)=(Power_baseline(j,1)-Power_future_2060s_RCM15(j,1))/Power_baseline(j,1)*100;
    Table_daily{j,43}=(Energy_baseline(j,1)-Energy_future_2060s_RCM01(j,1))/Energy_baseline(j,1)*100;
    Energy_dif_2060s_RCM01(j,1)=(Energy_baseline(j,1)-Energy_future_2060s_RCM01(j,1))/Energy_baseline(j,1)*100;
    Table_daily{j,44}=(Energy_baseline(j,1)-Energy_future_2060s_RCM04(j,1))/Energy_baseline(j,1)*100;
    Energy_dif_2060s_RCM04(j,1)=(Energy_baseline(j,1)-Energy_future_2060s_RCM04(j,1))/Energy_baseline(j,1)*100;
    Table_daily{j,45}=(Energy_baseline(j,1)-Energy_future_2060s_RCM05(j,1))/Energy_baseline(j,1)*100;
    Energy_dif_2060s_RCM05(j,1)=(Energy_baseline(j,1)-Energy_future_2060s_RCM05(j,1))/Energy_baseline(j,1)*100;
    Table_daily{j,46}=(Energy_baseline(j,1)-Energy_future_2060s_RCM06(j,1))/Energy_baseline(j,1)*100;
    Energy_dif_2060s_RCM06(j,1)=(Energy_baseline(j,1)-Energy_future_2060s_RCM06(j,1))/Energy_baseline(j,1)*100;
    Table_daily{j,47}=(Energy_baseline(j,1)-Energy_future_2060s_RCM07(j,1))/Energy_baseline(j,1)*100;
    Energy_dif_2060s_RCM07(j,1)=(Energy_baseline(j,1)-Energy_future_2060s_RCM07(j,1))/Energy_baseline(j,1)*100;
    Table_daily{j,48}=(Energy_baseline(j,1)-Energy_future_2060s_RCM08(j,1))/Energy_baseline(j,1)*100;
    Energy_dif_2060s_RCM08(j,1)=(Energy_baseline(j,1)-Energy_future_2060s_RCM08(j,1))/Energy_baseline(j,1)*100;
    Table_daily{j,49}=(Energy_baseline(j,1)-Energy_future_2060s_RCM09(j,1))/Energy_baseline(j,1)*100;
    Energy_dif_2060s_RCM09(j,1)=(Energy_baseline(j,1)-Energy_future_2060s_RCM09(j,1))/Energy_baseline(j,1)*100;
    Table_daily{j,50}=(Energy_baseline(j,1)-Energy_future_2060s_RCM10(j,1))/Energy_baseline(j,1)*100;
    Energy_dif_2060s_RCM10(j,1)=(Energy_baseline(j,1)-Energy_future_2060s_RCM10(j,1))/Energy_baseline(j,1)*100;
    Table_daily{j,51}=(Energy_baseline(j,1)-Energy_future_2060s_RCM11(j,1))/Energy_baseline(j,1)*100;
    Energy_dif_2060s_RCM11(j,1)=(Energy_baseline(j,1)-Energy_future_2060s_RCM11(j,1))/Energy_baseline(j,1)*100;
    Table_daily{j,52}=(Energy_baseline(j,1)-Energy_future_2060s_RCM12(j,1))/Energy_baseline(j,1)*100;
    Energy_dif_2060s_RCM12(j,1)=(Energy_baseline(j,1)-Energy_future_2060s_RCM12(j,1))/Energy_baseline(j,1)*100;
    Table_daily{j,53}=(Energy_baseline(j,1)-Energy_future_2060s_RCM13(j,1))/Energy_baseline(j,1)*100;
    Energy_dif_2060s_RCM13(j,1)=(Energy_baseline(j,1)-Energy_future_2060s_RCM13(j,1))/Energy_baseline(j,1)*100;
    Table_daily{j,54}=(Energy_baseline(j,1)-Energy_future_2060s_RCM15(j,1))/Energy_baseline(j,1)*100;
    Energy_dif_2060s_RCM15(j,1)=(Energy_baseline(j,1)-Energy_future_2060s_RCM15(j,1))/Energy_baseline(j,1)*100;
    Table_daily{j,55}=(Power_baseline(j,1)-Power_future_2060s_mean(j,1))/Power_baseline(j,1)*100;
    Power_dif_2060s_mean(j,1)=(Power_baseline(j,1)-Power_future_2060s_mean(j,1))/Power_baseline(j,1)*100;
    Table_daily{j,56}=(Energy_baseline(j,1)-Energy_future_2060s_mean(j,1))/Energy_baseline(j,1)*100; 
    Energy_dif_2060s_mean(j,1)=(Energy_baseline(j,1)-Energy_future_2060s_mean(j,1))/Energy_baseline(j,1)*100;
end
 
Table_daily_header={'Baseline','Baseline daily available power [kW]','Baseline daily energy output [kWh]','Future','RCM01 daily available power [kW]','RCM04 daily available power [kW]','RCM05 daily available power [kW]','RCM06 daily available power [kW]','RCM07 daily available power [kW]','RCM08 daily available power [kW]','RCM09 daily available power [kW]','RCM10 daily available power [kW]','RCM11 daily available power [kW]','RCM12 daily available power [kW]','RCM13 daily available power [kW]','RCM15 daily available power [kW]','RCM01 daily energy output [kWh]','RCM04 daily energy output [kWh]','RCM05 daily energy output [kWh]','RCM06 daily energy output [kWh]','RCM07 daily energy output [kWh]','RCM08 daily energy output [kWh]','RCM09 daily energy output [kWh]','RCM10 daily energy output [kWh]','RCM11 daily energy output [kWh]','RCM12 daily energy output [kWh]','RCM13 daily energy output [kWh]','RCM15 daily energy output [kWh]','Future mean daily available power [kW]','Future mean daily energy output [kWh]','RCM01-Baseline Power [%]','RCM04-Baseline Power [%]','RCM05-Baseline Power [%]','RCM06-Baseline Power [%]','RCM07-Baseline Power [%]','RCM08-Baseline Power [%]','RCM09-Baseline Power [%]','RCM10-Baseline Power [%]' ,'RCM11-Baseline Power [%]','RCM12-Baseline Power [%]','RCM13-Baseline Power [%]','RCM15-Baseline Power [%]','RCM01-Baseline Energy output [%]','RCM04-Baseline Energy output [%]','RCM05-Baseline Energy output [%]','RCM06-Baseline Energy output [%]','RCM07-Baseline Energy output [%]','RCM08-Baseline Energy output [%]','RCM09-Baseline Energy output [%]','RCM10-Baseline Energy output [%]' ,'RCM11-Baseline Energy output [%]','RCM12-Baseline Energy output [%]','RCM13-Baseline Energy output [%]','RCM15-Baseline Energy output [%]','Future mean-Baseline Power [%]','Future mean-Baseline Energy output [%]'};
 
%Write the table into an excel file
 
if exist(strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Autumn\Intake_',Intake_ID,'_autumn_power_and_energy_2060s_vs_baseline.xls'), 'file')==2
   delete(strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Autumn\Intake_',Intake_ID,'_autumn_power_and_energy_2060s_vs_baseline.xls'));
end
 
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Autumn\Intake_',Intake_ID,'_power_and_energy_2060s_vs_baseline.xls'),Table_daily,'Sheet1','A2');
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Autumn\Intake_',Intake_ID,'_power_and_energy_2060s_vs_baseline.xls'),Table_daily_header,'Sheet1','A1');
 
%% Plot the differences in daily power and output
 
No_of_days=[1:length(Sim_flow_2060s_RCM01)];
No_of_days=No_of_days.';
x_max=length(No_of_days);
 
%Create a table of positive and negative difference values to plot them in different colours
Power_dif_2060s_RCM01_positive=zeros(length(No_of_days),1);
Power_dif_2060s_RCM01_negative=zeros(length(No_of_days),1);
 
Power_dif_2060s_RCM04_positive=zeros(length(No_of_days),1);
Power_dif_2060s_RCM04_negative=zeros(length(No_of_days),1);
 
Power_dif_2060s_RCM05_positive=zeros(length(No_of_days),1);
Power_dif_2060s_RCM05_negative=zeros(length(No_of_days),1);
 
Power_dif_2060s_RCM06_positive=zeros(length(No_of_days),1);
Power_dif_2060s_RCM06_negative=zeros(length(No_of_days),1);
 
Power_dif_2060s_RCM07_positive=zeros(length(No_of_days),1);
Power_dif_2060s_RCM07_negative=zeros(length(No_of_days),1);
 
Power_dif_2060s_RCM08_positive=zeros(length(No_of_days),1);
Power_dif_2060s_RCM08_negative=zeros(length(No_of_days),1);
 
Power_dif_2060s_RCM09_positive=zeros(length(No_of_days),1);
Power_dif_2060s_RCM09_negative=zeros(length(No_of_days),1);
 
Power_dif_2060s_RCM10_positive=zeros(length(No_of_days),1);
Power_dif_2060s_RCM10_negative=zeros(length(No_of_days),1);
 
Power_dif_2060s_RCM11_positive=zeros(length(No_of_days),1);
Power_dif_2060s_RCM11_negative=zeros(length(No_of_days),1);
 
Power_dif_2060s_RCM12_positive=zeros(length(No_of_days),1);
Power_dif_2060s_RCM12_negative=zeros(length(No_of_days),1);
 
Power_dif_2060s_RCM13_positive=zeros(length(No_of_days),1);
Power_dif_2060s_RCM13_negative=zeros(length(No_of_days),1);
 
Power_dif_2060s_RCM15_positive=zeros(length(No_of_days),1);
Power_dif_2060s_RCM15_negative=zeros(length(No_of_days),1);
 
Power_dif_2060s_mean_positive=zeros(length(No_of_days),1);
Power_dif_2060s_mean_negative=zeros(length(No_of_days),1);
 
 
for j=1:length(No_of_days)
    if Power_dif_2060s_RCM01(j,1)>=0
        Power_dif_2060s_RCM01_positive(j,1)=Power_dif_2060s_RCM01(j,1);
    else
        Power_dif_2060s_RCM01_negative(j,1)=Power_dif_2060s_RCM01(j,1);
    end
 
    if Power_dif_2060s_RCM04(j,1)>=0
        Power_dif_2060s_RCM04_positive(j,1)=Power_dif_2060s_RCM04(j,1);
    else
        Power_dif_2060s_RCM04_negative(j,1)=Power_dif_2060s_RCM04(j,1);
    end
 
    if Power_dif_2060s_RCM05(j,1)>=0
        Power_dif_2060s_RCM05_positive(j,1)=Power_dif_2060s_RCM05(j,1);
    else
        Power_dif_2060s_RCM05_negative(j,1)=Power_dif_2060s_RCM05(j,1);
    end
 
    if Power_dif_2060s_RCM06(j,1)>=0
        Power_dif_2060s_RCM06_positive(j,1)=Power_dif_2060s_RCM06(j,1);
    else
        Power_dif_2060s_RCM06_negative(j,1)=Power_dif_2060s_RCM06(j,1);
    end
 
    if Power_dif_2060s_RCM07(j,1)>=0
        Power_dif_2060s_RCM07_positive(j,1)=Power_dif_2060s_RCM07(j,1);
    else
        Power_dif_2060s_RCM07_negative(j,1)=Power_dif_2060s_RCM07(j,1);
    end
 
    if Power_dif_2060s_RCM08(j,1)>=0
        Power_dif_2060s_RCM08_positive(j,1)=Power_dif_2060s_RCM08(j,1);
    else
        Power_dif_2060s_RCM08_negative(j,1)=Power_dif_2060s_RCM08(j,1);
    end
 
    if Power_dif_2060s_RCM09(j,1)>=0
        Power_dif_2060s_RCM09_positive(j,1)=Power_dif_2060s_RCM09(j,1);
    else
        Power_dif_2060s_RCM09_negative(j,1)=Power_dif_2060s_RCM09(j,1);
    end
 
    if Power_dif_2060s_RCM10(j,1)>=0
        Power_dif_2060s_RCM10_positive(j,1)=Power_dif_2060s_RCM10(j,1);
    else
        Power_dif_2060s_RCM10_negative(j,1)=Power_dif_2060s_RCM10(j,1);
    end
 
    if Power_dif_2060s_RCM11(j,1)>=0
        Power_dif_2060s_RCM11_positive(j,1)=Power_dif_2060s_RCM11(j,1);
    else
        Power_dif_2060s_RCM11_negative(j,1)=Power_dif_2060s_RCM11(j,1);
    end
 
    if Power_dif_2060s_RCM12(j,1)>=0
        Power_dif_2060s_RCM12_positive(j,1)=Power_dif_2060s_RCM12(j,1);
    else
        Power_dif_2060s_RCM12_negative(j,1)=Power_dif_2060s_RCM12(j,1);
    end
    
    if Power_dif_2060s_RCM13(j,1)>=0
        Power_dif_2060s_RCM13_positive(j,1)=Power_dif_2060s_RCM13(j,1);
    else
        Power_dif_2060s_RCM13_negative(j,1)=Power_dif_2060s_RCM13(j,1);
    end
 
    if Power_dif_2060s_RCM15(j,1)>=0
        Power_dif_2060s_RCM15_positive(j,1)=Power_dif_2060s_RCM15(j,1);
    else
        Power_dif_2060s_RCM15_negative(j,1)=Power_dif_2060s_RCM15(j,1);
    end
 
    if Power_dif_2060s_mean(j,1)>=0
        Power_dif_2060s_mean_positive(j,1)=Power_dif_2060s_mean(j,1);
    else
        Power_dif_2060s_mean_negative(j,1)=Power_dif_2060s_mean(j,1);
    end
end
 
ymin=-300;
ymax=+300;
 
%% Difference in autumn daily power for RCM01
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Daily_autumn_power_diff_RCM01_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future autumn 2060s daily available power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM01');
title(title_name_baseline);
xlabel('Days');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_days,Power_dif_2060s_RCM01_negative,'Color','[0.6350, 0.0780, 0.1840]');
hold on
plot(No_of_days,Power_dif_2060s_RCM01_positive,'Color','[0.4660, 0.6740, 0.1880]');
hold on
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in autumn daily power for RCM04
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Daily_autumn_power_diff_RCM04_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future autumn 2060s daily available power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM04');
title(title_name_baseline);
xlabel('Days');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_days,Power_dif_2060s_RCM04_negative,'Color','[0.6350, 0.0780, 0.1840]');
hold on
plot(No_of_days,Power_dif_2060s_RCM04_positive,'Color','[0.4660, 0.6740, 0.1880]');
hold on
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in autumn daily power for RCM05
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Daily_autumn_power_diff_RCM05_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future autumn 2060s daily available power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM05');
title(title_name_baseline);
xlabel('Days');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_days,Power_dif_2060s_RCM05_negative,'Color','[0.6350, 0.0780, 0.1840]');
hold on
plot(No_of_days,Power_dif_2060s_RCM05_positive,'Color','[0.4660, 0.6740, 0.1880]');
hold on
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in autumn daily power for RCM06
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Daily_autumn_power_diff_RCM06_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future autumn 2060s daily available power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM06');
title(title_name_baseline);
xlabel('Days');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_days,Power_dif_2060s_RCM06_negative,'Color','[0.6350, 0.0780, 0.1840]');
hold on
plot(No_of_days,Power_dif_2060s_RCM06_positive,'Color','[0.4660, 0.6740, 0.1880]');
hold on
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in autumn daily power for RCM07
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Daily_autumn_power_diff_RCM07_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future autumn 2060s daily available power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM07');
title(title_name_baseline);
xlabel('Days');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_days,Power_dif_2060s_RCM07_negative,'Color','[0.6350, 0.0780, 0.1840]');
hold on
plot(No_of_days,Power_dif_2060s_RCM07_positive,'Color','[0.4660, 0.6740, 0.1880]');
hold on
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in autumn daily power for RCM08
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Daily_autumn_power_diff_RCM08_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future autumn 2060s daily available power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM08');
title(title_name_baseline);
xlabel('Days');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_days,Power_dif_2060s_RCM08_negative,'Color','[0.6350, 0.0780, 0.1840]');
hold on
plot(No_of_days,Power_dif_2060s_RCM08_positive,'Color','[0.4660, 0.6740, 0.1880]');
hold on
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in autumn daily power for RCM09
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Daily_autumn_power_diff_RCM09_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future autumn 2060s daily available power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM09');
title(title_name_baseline);
xlabel('Days');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_days,Power_dif_2060s_RCM09_negative,'Color','[0.6350, 0.0780, 0.1840]');
hold on
plot(No_of_days,Power_dif_2060s_RCM09_positive,'Color','[0.4660, 0.6740, 0.1880]');
hold on
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in autumn daily power for RCM10
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Daily_autumn_power_diff_RCM10_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future autumn 2060s daily available power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM10');
title(title_name_baseline);
xlabel('Days');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_days,Power_dif_2060s_RCM10_negative,'Color','[0.6350, 0.0780, 0.1840]');
hold on
plot(No_of_days,Power_dif_2060s_RCM10_positive,'Color','[0.4660, 0.6740, 0.1880]');
hold on
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in autumn daily power for RCM11
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Daily_autumn_power_diff_RCM11_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future autumn 2060s daily available power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM11');
title(title_name_baseline);
xlabel('Days');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_days,Power_dif_2060s_RCM11_negative,'Color','[0.6350, 0.0780, 0.1840]');
hold on
plot(No_of_days,Power_dif_2060s_RCM11_positive,'Color','[0.4660, 0.6740, 0.1880]');
hold on
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in autumn daily power for RCM12
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Daily_autumn_power_diff_RCM12_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future autumn 2060s daily available power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM12');
title(title_name_baseline);
xlabel('Days');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_days,Power_dif_2060s_RCM12_negative,'Color','[0.6350, 0.0780, 0.1840]');
hold on
plot(No_of_days,Power_dif_2060s_RCM12_positive,'Color','[0.4660, 0.6740, 0.1880]');
hold on
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in autumn daily power for RCM13
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Daily_autumn_power_diff_RCM13_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future autumn 2060s daily available power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM13');
title(title_name_baseline);
xlabel('Days');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_days,Power_dif_2060s_RCM13_negative,'Color','[0.6350, 0.0780, 0.1840]');
hold on
plot(No_of_days,Power_dif_2060s_RCM13_positive,'Color','[0.4660, 0.6740, 0.1880]');
hold on
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in autumn daily power for RCM15
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Daily_autumn_power_diff_RCM15_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s autumn daily available power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM15');
title(title_name_baseline);
xlabel('Days');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_days,Power_dif_2060s_RCM15_negative,'Color','[0.6350, 0.0780, 0.1840]');
hold on
plot(No_of_days,Power_dif_2060s_RCM15_positive,'Color','[0.4660, 0.6740, 0.1880]');
hold on
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in autumn daily power for all RCMs
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Daily_autumn_power_diff_mean_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future autumn 2060s mean daily available power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no);
title(title_name_baseline);
xlabel('Days');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_days,Power_dif_2060s_mean_negative,'Color','[0.6350, 0.0780, 0.1840]');
hold on
plot(No_of_days,Power_dif_2060s_mean_positive,'Color','[0.4660, 0.6740, 0.1880]');
hold on
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%Create a table of positive and negative difference values to plot them in different colours
Energy_dif_2060s_RCM01_positive=zeros(length(No_of_days),1);
Energy_dif_2060s_RCM01_negative=zeros(length(No_of_days),1);
 
Energy_dif_2060s_RCM04_positive=zeros(length(No_of_days),1);
Energy_dif_2060s_RCM04_negative=zeros(length(No_of_days),1);
 
Energy_dif_2060s_RCM05_positive=zeros(length(No_of_days),1);
Energy_dif_2060s_RCM05_negative=zeros(length(No_of_days),1);
 
Energy_dif_2060s_RCM06_positive=zeros(length(No_of_days),1);
Energy_dif_2060s_RCM06_negative=zeros(length(No_of_days),1);
 
Energy_dif_2060s_RCM07_positive=zeros(length(No_of_days),1);
Energy_dif_2060s_RCM07_negative=zeros(length(No_of_days),1);
 
Energy_dif_2060s_RCM08_positive=zeros(length(No_of_days),1);
Energy_dif_2060s_RCM08_negative=zeros(length(No_of_days),1);
 
Energy_dif_2060s_RCM09_positive=zeros(length(No_of_days),1);
Energy_dif_2060s_RCM09_negative=zeros(length(No_of_days),1);
 
Energy_dif_2060s_RCM10_positive=zeros(length(No_of_days),1);
Energy_dif_2060s_RCM10_negative=zeros(length(No_of_days),1);
 
Energy_dif_2060s_RCM11_positive=zeros(length(No_of_days),1);
Energy_dif_2060s_RCM11_negative=zeros(length(No_of_days),1);
 
Energy_dif_2060s_RCM12_positive=zeros(length(No_of_days),1);
Energy_dif_2060s_RCM12_negative=zeros(length(No_of_days),1);
 
Energy_dif_2060s_RCM13_positive=zeros(length(No_of_days),1);
Energy_dif_2060s_RCM13_negative=zeros(length(No_of_days),1);
 
Energy_dif_2060s_RCM15_positive=zeros(length(No_of_days),1);
Energy_dif_2060s_RCM15_negative=zeros(length(No_of_days),1);
 
Energy_dif_2060s_mean_positive=zeros(length(No_of_days),1);
Energy_dif_2060s_mean_negative=zeros(length(No_of_days),1);
 
 
for j=1:length(No_of_days)
    if Energy_dif_2060s_RCM01(j,1)>=0
        Energy_dif_2060s_RCM01_positive(j,1)=Energy_dif_2060s_RCM01(j,1);
    else
        Energy_dif_2060s_RCM01_negative(j,1)=Energy_dif_2060s_RCM01(j,1);
    end
 
    if Energy_dif_2060s_RCM04(j,1)>=0
        Energy_dif_2060s_RCM04_positive(j,1)=Energy_dif_2060s_RCM04(j,1);
    else
        Energy_dif_2060s_RCM04_negative(j,1)=Energy_dif_2060s_RCM04(j,1);
    end
 
    if Energy_dif_2060s_RCM05(j,1)>=0
        Energy_dif_2060s_RCM05_positive(j,1)=Energy_dif_2060s_RCM05(j,1);
    else
        Energy_dif_2060s_RCM05_negative(j,1)=Energy_dif_2060s_RCM05(j,1);
    end
 
    if Energy_dif_2060s_RCM06(j,1)>=0
        Energy_dif_2060s_RCM06_positive(j,1)=Energy_dif_2060s_RCM06(j,1);
    else
        Energy_dif_2060s_RCM06_negative(j,1)=Energy_dif_2060s_RCM06(j,1);
    end
 
    if Energy_dif_2060s_RCM07(j,1)>=0
        Energy_dif_2060s_RCM07_positive(j,1)=Energy_dif_2060s_RCM07(j,1);
    else
        Energy_dif_2060s_RCM07_negative(j,1)=Energy_dif_2060s_RCM07(j,1);
    end
 
    if Energy_dif_2060s_RCM08(j,1)>=0
        Energy_dif_2060s_RCM08_positive(j,1)=Energy_dif_2060s_RCM08(j,1);
    else
        Energy_dif_2060s_RCM08_negative(j,1)=Energy_dif_2060s_RCM08(j,1);
    end
 
    if Energy_dif_2060s_RCM09(j,1)>=0
        Energy_dif_2060s_RCM09_positive(j,1)=Energy_dif_2060s_RCM09(j,1);
    else
        Energy_dif_2060s_RCM09_negative(j,1)=Energy_dif_2060s_RCM09(j,1);
    end
 
    if Energy_dif_2060s_RCM10(j,1)>=0
        Energy_dif_2060s_RCM10_positive(j,1)=Energy_dif_2060s_RCM10(j,1);
    else
        Energy_dif_2060s_RCM10_negative(j,1)=Energy_dif_2060s_RCM10(j,1);
    end
 
    if Energy_dif_2060s_RCM11(j,1)>=0
        Energy_dif_2060s_RCM11_positive(j,1)=Energy_dif_2060s_RCM11(j,1);
    else
        Energy_dif_2060s_RCM11_negative(j,1)=Energy_dif_2060s_RCM11(j,1);
    end
 
    if Energy_dif_2060s_RCM12(j,1)>=0
        Energy_dif_2060s_RCM12_positive(j,1)=Energy_dif_2060s_RCM12(j,1);
    else
        Energy_dif_2060s_RCM12_negative(j,1)=Energy_dif_2060s_RCM12(j,1);
    end
    
    if Energy_dif_2060s_RCM13(j,1)>=0
        Energy_dif_2060s_RCM13_positive(j,1)=Energy_dif_2060s_RCM13(j,1);
    else
        Energy_dif_2060s_RCM13_negative(j,1)=Energy_dif_2060s_RCM13(j,1);
    end
 
    if Energy_dif_2060s_RCM15(j,1)>=0
        Energy_dif_2060s_RCM15_positive(j,1)=Energy_dif_2060s_RCM15(j,1);
    else
        Energy_dif_2060s_RCM15_negative(j,1)=Energy_dif_2060s_RCM15(j,1);
    end
 
    if Energy_dif_2060s_mean(j,1)>=0
        Energy_dif_2060s_mean_positive(j,1)=Energy_dif_2060s_mean(j,1);
    else
        Energy_dif_2060s_mean_negative(j,1)=Energy_dif_2060s_mean(j,1);
    end    
end
 
%% Difference in autumn daily energy for RCM01
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Daily_autumn_Energy_diff_RCM01_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future autumn 2060s daily energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM01');
title(title_name_baseline);
xlabel('Days');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_days,Energy_dif_2060s_RCM01_negative,'Color','[0.6350, 0.0780, 0.1840]');
hold on
plot(No_of_days,Energy_dif_2060s_RCM01_positive,'Color','[0.4660, 0.6740, 0.1880]');
hold on
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in autumn daily energy for RCM04
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Daily_autumn_Energy_diff_RCM04_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future autumn 2060s daily energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM04');
title(title_name_baseline);
xlabel('Days');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_days,Energy_dif_2060s_RCM04_negative,'Color','[0.6350, 0.0780, 0.1840]');
hold on
plot(No_of_days,Energy_dif_2060s_RCM04_positive,'Color','[0.4660, 0.6740, 0.1880]');
hold on
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in autumn daily energy for RCM05
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Daily_autumn_Energy_diff_RCM05_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future autumn 2060s daily energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM05');
title(title_name_baseline);
xlabel('Days');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_days,Energy_dif_2060s_RCM05_negative,'Color','[0.6350, 0.0780, 0.1840]');
hold on
plot(No_of_days,Energy_dif_2060s_RCM05_positive,'Color','[0.4660, 0.6740, 0.1880]');
hold on
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in autumn daily energy for RCM06
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Daily_autumn_Energy_diff_RCM06_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future autumn 2060s daily energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM06');
title(title_name_baseline);
xlabel('Days');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_days,Energy_dif_2060s_RCM06_negative,'Color','[0.6350, 0.0780, 0.1840]');
hold on
plot(No_of_days,Energy_dif_2060s_RCM06_positive,'Color','[0.4660, 0.6740, 0.1880]');
hold on
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in autumn daily energy for RCM07
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Daily_autumn_Energy_diff_RCM07_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future autumn 2060s daily energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM07');
title(title_name_baseline);
xlabel('Days');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_days,Energy_dif_2060s_RCM07_negative,'Color','[0.6350, 0.0780, 0.1840]');
hold on
plot(No_of_days,Energy_dif_2060s_RCM07_positive,'Color','[0.4660, 0.6740, 0.1880]');
hold on
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in autumn daily energy for RCM08
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Daily_autumn_Energy_diff_RCM08_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future autumn 2060s daily energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM08');
title(title_name_baseline);
xlabel('Days');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_days,Energy_dif_2060s_RCM08_negative,'Color','[0.6350, 0.0780, 0.1840]');
hold on
plot(No_of_days,Energy_dif_2060s_RCM08_positive,'Color','[0.4660, 0.6740, 0.1880]');
hold on
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in autumn daily energy for RCM09
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Daily_autumn_Energy_diff_RCM09_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future autumn 2060s daily energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM09');
title(title_name_baseline);
xlabel('Days');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_days,Energy_dif_2060s_RCM09_negative,'Color','[0.6350, 0.0780, 0.1840]');
hold on
plot(No_of_days,Energy_dif_2060s_RCM09_positive,'Color','[0.4660, 0.6740, 0.1880]');
hold on
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in autumn daily energy for RCM10
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Daily_autumn_Energy_diff_RCM10_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future autumn 2060s daily energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM10');
title(title_name_baseline);
xlabel('Days');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_days,Energy_dif_2060s_RCM10_negative,'Color','[0.6350, 0.0780, 0.1840]');
hold on
plot(No_of_days,Energy_dif_2060s_RCM10_positive,'Color','[0.4660, 0.6740, 0.1880]');
hold on
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in autumn daily energy for RCM11
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Daily_autumn_Energy_diff_RCM11_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future autumn 2060s daily energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM11');
title(title_name_baseline);
xlabel('Days');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_days,Energy_dif_2060s_RCM11_negative,'Color','[0.6350, 0.0780, 0.1840]');
hold on
plot(No_of_days,Energy_dif_2060s_RCM11_positive,'Color','[0.4660, 0.6740, 0.1880]');
hold on
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in autumn daily energy for RCM12
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Daily_autumn_Energy_diff_RCM12_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future autumn 2060s daily energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM12');
title(title_name_baseline);
xlabel('Days');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_days,Energy_dif_2060s_RCM12_negative,'Color','[0.6350, 0.0780, 0.1840]');
hold on
plot(No_of_days,Energy_dif_2060s_RCM12_positive,'Color','[0.4660, 0.6740, 0.1880]');
hold on
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in autumn daily energy for RCM13
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Daily_autumn_Energy_diff_RCM13_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future autumn 2060s daily energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM13');
title(title_name_baseline);
xlabel('Days');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_days,Energy_dif_2060s_RCM13_negative,'Color','[0.6350, 0.0780, 0.1840]');
hold on
plot(No_of_days,Energy_dif_2060s_RCM13_positive,'Color','[0.4660, 0.6740, 0.1880]');
hold on
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in autumn daily energy for RCM15
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Daily_autumn_Energy_diff_RCM15_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future autumn 2060s daily energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM15');
title(title_name_baseline);
xlabel('Days');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_days,Energy_dif_2060s_RCM15_negative,'Color','[0.6350, 0.0780, 0.1840]');
hold on
plot(No_of_days,Energy_dif_2060s_RCM15_positive,'Color','[0.4660, 0.6740, 0.1880]');
hold on
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in autumn daily energy for all RCMs
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Daily_autumn_energy_diff_mean_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future autumn 2060s mean daily energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no);
title(title_name_baseline);
xlabel('Days');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_days,Energy_dif_2060s_mean_negative,'Color','[0.6350, 0.0780, 0.1840]');
hold on
plot(No_of_days,Energy_dif_2060s_mean_positive,'Color','[0.4660, 0.6740, 0.1880]');
hold on
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
       
%% Mean and total monthly baseline available power and energy output - mean and sum of calculated daily available power and energy output
 
Table_baseline=[];
Monthly_values_baseline_mean=[];
Annual_values_baseline_mean=[];
Monthly_values_baseline_sum=[];
Annual_values_baseline_sum=[];
 
Table_baseline=Time_Obs_baseline;
 
Table_baseline=timetable(Time_Obs_baseline,Power_baseline,Energy_baseline);
 
Monthly_values_baseline_mean=convert2monthly(Table_baseline,'Aggregation',["mean" "mean"]);
 
Power_baseline_monthly_mean=Monthly_values_baseline_mean(:,1);
Power_baseline_monthly_mean=table2array(Power_baseline_monthly_mean);
 
Check_autumn_months=month(Monthly_values_baseline_mean.Time_Obs_baseline);
 
for j=1:height(Check_autumn_months)
    if ~ismember(Check_autumn_months(j,1),Autumn_months)
        Power_baseline_monthly_mean(j,1)=9999;
    end
end
Power_baseline_monthly_mean(Power_baseline_monthly_mean==9999)=[];
 
Energy_baseline_monthly_mean=Monthly_values_baseline_mean(:,2);
Energy_baseline_monthly_mean=table2array(Energy_baseline_monthly_mean);
 
for j=1:height(Check_autumn_months)
    if ~ismember(Check_autumn_months(j,1),Autumn_months)
        Energy_baseline_monthly_mean(j,1)=9999;
    end
end
Energy_baseline_monthly_mean(Energy_baseline_monthly_mean==9999)=[];
 
Annual_values_baseline_mean=convert2annual(Table_baseline,'Aggregation',["mean" "mean"]);
 
Power_baseline_annual_mean=Annual_values_baseline_mean(:,1);
Power_baseline_annual_mean=table2array(Power_baseline_annual_mean);
%Power_baseline_annual_mean(isnan(Power_baseline_annual_mean))=[];
 
Energy_baseline_annual_mean=Annual_values_baseline_mean(:,2);
Energy_baseline_annual_mean=table2array(Energy_baseline_annual_mean);
Energy_baseline_annual_mean(isnan(Energy_baseline_annual_mean))=[];
 
 
Monthly_values_baseline_sum=convert2monthly(Table_baseline,'Aggregation',["sum" "sum"]);
 
Power_baseline_monthly_sum=Monthly_values_baseline_sum(:,1);
Power_baseline_monthly_sum=table2array(Power_baseline_monthly_sum);
 
for j=1:height(Check_autumn_months)
    if ~ismember(Check_autumn_months(j,1),Autumn_months)
        Power_baseline_monthly_sum(j,1)=9999;
    end
end
Power_baseline_monthly_sum(Power_baseline_monthly_sum==9999)=[];
 
Energy_baseline_monthly_sum=Monthly_values_baseline_sum(:,2);
Energy_baseline_monthly_sum=table2array(Energy_baseline_monthly_sum);
 
for j=1:height(Check_autumn_months)
    if ~ismember(Check_autumn_months(j,1),Autumn_months)
        Energy_baseline_monthly_sum(j,1)=9999;
    end
end
Energy_baseline_monthly_sum(Energy_baseline_monthly_sum==9999)=[];
 
Annual_values_baseline_sum=convert2annual(Table_baseline,'Aggregation',["sum" "sum"]);
 
Power_baseline_annual_sum=Annual_values_baseline_sum(:,1);
Power_baseline_annual_sum=table2array(Power_baseline_annual_sum);
Power_baseline_annual_sum(isnan(Power_baseline_annual_sum))=[];
 
Energy_baseline_annual_sum=Annual_values_baseline_sum(:,2);
Energy_baseline_annual_sum=table2array(Energy_baseline_annual_sum);
%Energy_baseline_annual_sum(isnan(Energy_baseline_annual_sum))=[];
 
%% Mean and total monthly 2060s available power and energy output - mean and sum of calculated daily available power and energy output
%% RCM01
Power_future_2060s_RCM01_monthly_mean=[];
Power_future_2060s_RCM01_monthly_sum=[];
Energy_future_2060s_RCM01_monthly_mean=[];
Energy_future_2060s_RCM01_monthly_sum=[];
 
for j=1:30:length(Power_future_2060s_RCM01)
    Power_future_2060s_RCM01_monthly_mean(j,1)=mean(Power_future_2060s_RCM01(j:j+29));
end
Power_future_2060s_RCM01_monthly_mean(any(Power_future_2060s_RCM01_monthly_mean==0,2))=[];
 
for j=1:30:length(Power_future_2060s_RCM01)
    Power_future_2060s_RCM01_monthly_sum(j,1)=sum(Power_future_2060s_RCM01(j:j+29));
end
Power_future_2060s_RCM01_monthly_sum(any(Power_future_2060s_RCM01_monthly_sum==0,2))=[];
 
 
for j=1:30:length(Energy_future_2060s_RCM01)
    Energy_future_2060s_RCM01_monthly_mean(j,1)=mean(Energy_future_2060s_RCM01(j:j+29));
end
Energy_future_2060s_RCM01_monthly_mean(any(Energy_future_2060s_RCM01_monthly_mean==0,2))=[];
 
for j=1:30:length(Energy_future_2060s_RCM01)
    Energy_future_2060s_RCM01_monthly_sum(j,1)=sum(Energy_future_2060s_RCM01(j:j+29));
end
Energy_future_2060s_RCM01_monthly_sum(any(Energy_future_2060s_RCM01_monthly_sum==0,2))=[];
 
%% RCM04
Power_future_2060s_RCM04_monthly_mean=[];
Power_future_2060s_RCM04_monthly_sum=[];
Energy_future_2060s_RCM04_monthly_mean=[];
Energy_future_2060s_RCM04_monthly_sum=[];
 
for j=1:30:length(Power_future_2060s_RCM04)
    Power_future_2060s_RCM04_monthly_mean(j,1)=mean(Power_future_2060s_RCM04(j:j+29));
end
Power_future_2060s_RCM04_monthly_mean(any(Power_future_2060s_RCM04_monthly_mean==0,2))=[];
 
for j=1:30:length(Power_future_2060s_RCM04)
    Power_future_2060s_RCM04_monthly_sum(j,1)=sum(Power_future_2060s_RCM04(j:j+29));
end
Power_future_2060s_RCM04_monthly_sum(any(Power_future_2060s_RCM04_monthly_sum==0,2))=[];
 
 
for j=1:30:length(Energy_future_2060s_RCM04)
    Energy_future_2060s_RCM04_monthly_mean(j,1)=mean(Energy_future_2060s_RCM04(j:j+29));
end
Energy_future_2060s_RCM04_monthly_mean(any(Energy_future_2060s_RCM04_monthly_mean==0,2))=[];
 
for j=1:30:length(Energy_future_2060s_RCM04)
    Energy_future_2060s_RCM04_monthly_sum(j,1)=sum(Energy_future_2060s_RCM04(j:j+29));
end
Energy_future_2060s_RCM04_monthly_sum(any(Energy_future_2060s_RCM04_monthly_sum==0,2))=[];
 
%% RCM05
Power_future_2060s_RCM05_monthly_mean=[];
Power_future_2060s_RCM05_monthly_sum=[];
Energy_future_2060s_RCM05_monthly_mean=[];
Energy_future_2060s_RCM05_monthly_sum=[];
 
for j=1:30:length(Power_future_2060s_RCM05)
    Power_future_2060s_RCM05_monthly_mean(j,1)=mean(Power_future_2060s_RCM05(j:j+29));
end
Power_future_2060s_RCM05_monthly_mean(any(Power_future_2060s_RCM05_monthly_mean==0,2))=[];
 
for j=1:30:length(Power_future_2060s_RCM05)
    Power_future_2060s_RCM05_monthly_sum(j,1)=sum(Power_future_2060s_RCM05(j:j+29));
end
Power_future_2060s_RCM05_monthly_sum(any(Power_future_2060s_RCM05_monthly_sum==0,2))=[];
 
 
for j=1:30:length(Energy_future_2060s_RCM05)
    Energy_future_2060s_RCM05_monthly_mean(j,1)=mean(Energy_future_2060s_RCM05(j:j+29));
end
Energy_future_2060s_RCM05_monthly_mean(any(Energy_future_2060s_RCM05_monthly_mean==0,2))=[];
 
for j=1:30:length(Energy_future_2060s_RCM05)
    Energy_future_2060s_RCM05_monthly_sum(j,1)=sum(Energy_future_2060s_RCM05(j:j+29));
end
Energy_future_2060s_RCM05_monthly_sum(any(Energy_future_2060s_RCM05_monthly_sum==0,2))=[];
 
%% RCM06
Power_future_2060s_RCM06_monthly_mean=[];
Power_future_2060s_RCM06_monthly_sum=[];
Energy_future_2060s_RCM06_monthly_mean=[];
Energy_future_2060s_RCM06_monthly_sum=[];
 
for j=1:30:length(Power_future_2060s_RCM06)
    Power_future_2060s_RCM06_monthly_mean(j,1)=mean(Power_future_2060s_RCM06(j:j+29));
end
Power_future_2060s_RCM06_monthly_mean(any(Power_future_2060s_RCM06_monthly_mean==0,2))=[];
 
for j=1:30:length(Power_future_2060s_RCM06)
    Power_future_2060s_RCM06_monthly_sum(j,1)=sum(Power_future_2060s_RCM06(j:j+29));
end
Power_future_2060s_RCM06_monthly_sum(any(Power_future_2060s_RCM06_monthly_sum==0,2))=[];
 
 
for j=1:30:length(Energy_future_2060s_RCM06)
    Energy_future_2060s_RCM06_monthly_mean(j,1)=mean(Energy_future_2060s_RCM06(j:j+29));
end
Energy_future_2060s_RCM06_monthly_mean(any(Energy_future_2060s_RCM06_monthly_mean==0,2))=[];
 
for j=1:30:length(Energy_future_2060s_RCM06)
    Energy_future_2060s_RCM06_monthly_sum(j,1)=sum(Energy_future_2060s_RCM06(j:j+29));
end
Energy_future_2060s_RCM06_monthly_sum(any(Energy_future_2060s_RCM06_monthly_sum==0,2))=[];
 
%% RCM07
Power_future_2060s_RCM07_monthly_mean=[];
Power_future_2060s_RCM07_monthly_sum=[];
Energy_future_2060s_RCM07_monthly_mean=[];
Energy_future_2060s_RCM07_monthly_sum=[];
 
for j=1:30:length(Power_future_2060s_RCM07)
    Power_future_2060s_RCM07_monthly_mean(j,1)=mean(Power_future_2060s_RCM07(j:j+29));
end
Power_future_2060s_RCM07_monthly_mean(any(Power_future_2060s_RCM07_monthly_mean==0,2))=[];
 
for j=1:30:length(Power_future_2060s_RCM07)
    Power_future_2060s_RCM07_monthly_sum(j,1)=sum(Power_future_2060s_RCM07(j:j+29));
end
Power_future_2060s_RCM07_monthly_sum(any(Power_future_2060s_RCM07_monthly_sum==0,2))=[];
 
 
for j=1:30:length(Energy_future_2060s_RCM07)
    Energy_future_2060s_RCM07_monthly_mean(j,1)=mean(Energy_future_2060s_RCM07(j:j+29));
end
Energy_future_2060s_RCM07_monthly_mean(any(Energy_future_2060s_RCM07_monthly_mean==0,2))=[];
 
for j=1:30:length(Energy_future_2060s_RCM07)
    Energy_future_2060s_RCM07_monthly_sum(j,1)=sum(Energy_future_2060s_RCM07(j:j+29));
end
Energy_future_2060s_RCM07_monthly_sum(any(Energy_future_2060s_RCM07_monthly_sum==0,2))=[];
 
%% RCM08
Power_future_2060s_RCM08_monthly_mean=[];
Power_future_2060s_RCM08_monthly_sum=[];
Energy_future_2060s_RCM08_monthly_mean=[];
Energy_future_2060s_RCM08_monthly_sum=[];
 
for j=1:30:length(Power_future_2060s_RCM08)
    Power_future_2060s_RCM08_monthly_mean(j,1)=mean(Power_future_2060s_RCM08(j:j+29));
end
Power_future_2060s_RCM08_monthly_mean(any(Power_future_2060s_RCM08_monthly_mean==0,2))=[];
 
for j=1:30:length(Power_future_2060s_RCM08)
    Power_future_2060s_RCM08_monthly_sum(j,1)=sum(Power_future_2060s_RCM08(j:j+29));
end
Power_future_2060s_RCM08_monthly_sum(any(Power_future_2060s_RCM08_monthly_sum==0,2))=[];
 
 
for j=1:30:length(Energy_future_2060s_RCM08)
    Energy_future_2060s_RCM08_monthly_mean(j,1)=mean(Energy_future_2060s_RCM08(j:j+29));
end
Energy_future_2060s_RCM08_monthly_mean(any(Energy_future_2060s_RCM08_monthly_mean==0,2))=[];
 
for j=1:30:length(Energy_future_2060s_RCM08)
    Energy_future_2060s_RCM08_monthly_sum(j,1)=sum(Energy_future_2060s_RCM08(j:j+29));
end
Energy_future_2060s_RCM08_monthly_sum(any(Energy_future_2060s_RCM08_monthly_sum==0,2))=[];
 
%% RCM09
Power_future_2060s_RCM09_monthly_mean=[];
Power_future_2060s_RCM09_monthly_sum=[];
Energy_future_2060s_RCM09_monthly_mean=[];
Energy_future_2060s_RCM09_monthly_sum=[];
 
for j=1:30:length(Power_future_2060s_RCM09)
    Power_future_2060s_RCM09_monthly_mean(j,1)=mean(Power_future_2060s_RCM09(j:j+29));
end
Power_future_2060s_RCM09_monthly_mean(any(Power_future_2060s_RCM09_monthly_mean==0,2))=[];
 
for j=1:30:length(Power_future_2060s_RCM09)
    Power_future_2060s_RCM09_monthly_sum(j,1)=sum(Power_future_2060s_RCM09(j:j+29));
end
Power_future_2060s_RCM09_monthly_sum(any(Power_future_2060s_RCM09_monthly_sum==0,2))=[];
 
 
for j=1:30:length(Energy_future_2060s_RCM09)
    Energy_future_2060s_RCM09_monthly_mean(j,1)=mean(Energy_future_2060s_RCM09(j:j+29));
end
Energy_future_2060s_RCM09_monthly_mean(any(Energy_future_2060s_RCM09_monthly_mean==0,2))=[];
 
for j=1:30:length(Energy_future_2060s_RCM09)
    Energy_future_2060s_RCM09_monthly_sum(j,1)=sum(Energy_future_2060s_RCM09(j:j+29));
end
Energy_future_2060s_RCM09_monthly_sum(any(Energy_future_2060s_RCM09_monthly_sum==0,2))=[];
 
%% RCM10
Power_future_2060s_RCM10_monthly_mean=[];
Power_future_2060s_RCM10_monthly_sum=[];
Energy_future_2060s_RCM10_monthly_mean=[];
Energy_future_2060s_RCM10_monthly_sum=[];
 
for j=1:30:length(Power_future_2060s_RCM10)
    Power_future_2060s_RCM10_monthly_mean(j,1)=mean(Power_future_2060s_RCM10(j:j+29));
end
Power_future_2060s_RCM10_monthly_mean(any(Power_future_2060s_RCM10_monthly_mean==0,2))=[];
 
for j=1:30:length(Power_future_2060s_RCM10)
    Power_future_2060s_RCM10_monthly_sum(j,1)=sum(Power_future_2060s_RCM10(j:j+29));
end
Power_future_2060s_RCM10_monthly_sum(any(Power_future_2060s_RCM10_monthly_sum==0,2))=[];
 
 
for j=1:30:length(Energy_future_2060s_RCM10)
    Energy_future_2060s_RCM10_monthly_mean(j,1)=mean(Energy_future_2060s_RCM10(j:j+29));
end
Energy_future_2060s_RCM10_monthly_mean(any(Energy_future_2060s_RCM10_monthly_mean==0,2))=[];
 
for j=1:30:length(Energy_future_2060s_RCM10)
    Energy_future_2060s_RCM10_monthly_sum(j,1)=sum(Energy_future_2060s_RCM10(j:j+29));
end
Energy_future_2060s_RCM10_monthly_sum(any(Energy_future_2060s_RCM10_monthly_sum==0,2))=[];
 
%% RCM11
Power_future_2060s_RCM11_monthly_mean=[];
Power_future_2060s_RCM11_monthly_sum=[];
Energy_future_2060s_RCM11_monthly_mean=[];
Energy_future_2060s_RCM11_monthly_sum=[];
 
for j=1:30:length(Power_future_2060s_RCM11)
    Power_future_2060s_RCM11_monthly_mean(j,1)=mean(Power_future_2060s_RCM11(j:j+29));
end
Power_future_2060s_RCM11_monthly_mean(any(Power_future_2060s_RCM11_monthly_mean==0,2))=[];
 
for j=1:30:length(Power_future_2060s_RCM11)
    Power_future_2060s_RCM11_monthly_sum(j,1)=sum(Power_future_2060s_RCM11(j:j+29));
end
Power_future_2060s_RCM11_monthly_sum(any(Power_future_2060s_RCM11_monthly_sum==0,2))=[];
 
 
for j=1:30:length(Energy_future_2060s_RCM11)
    Energy_future_2060s_RCM11_monthly_mean(j,1)=mean(Energy_future_2060s_RCM11(j:j+29));
end
Energy_future_2060s_RCM11_monthly_mean(any(Energy_future_2060s_RCM11_monthly_mean==0,2))=[];
 
for j=1:30:length(Energy_future_2060s_RCM11)
    Energy_future_2060s_RCM11_monthly_sum(j,1)=sum(Energy_future_2060s_RCM11(j:j+29));
end
Energy_future_2060s_RCM11_monthly_sum(any(Energy_future_2060s_RCM11_monthly_sum==0,2))=[];
 
%% RCM12
Power_future_2060s_RCM12_monthly_mean=[];
Power_future_2060s_RCM12_monthly_sum=[];
Energy_future_2060s_RCM12_monthly_mean=[];
Energy_future_2060s_RCM12_monthly_sum=[];
 
for j=1:30:length(Power_future_2060s_RCM12)
    Power_future_2060s_RCM12_monthly_mean(j,1)=mean(Power_future_2060s_RCM12(j:j+29));
end
Power_future_2060s_RCM12_monthly_mean(any(Power_future_2060s_RCM12_monthly_mean==0,2))=[];
 
for j=1:30:length(Power_future_2060s_RCM12)
    Power_future_2060s_RCM12_monthly_sum(j,1)=sum(Power_future_2060s_RCM12(j:j+29));
end
Power_future_2060s_RCM12_monthly_sum(any(Power_future_2060s_RCM12_monthly_sum==0,2))=[];
 
 
for j=1:30:length(Energy_future_2060s_RCM12)
    Energy_future_2060s_RCM12_monthly_mean(j,1)=mean(Energy_future_2060s_RCM12(j:j+29));
end
Energy_future_2060s_RCM12_monthly_mean(any(Energy_future_2060s_RCM12_monthly_mean==0,2))=[];
 
for j=1:30:length(Energy_future_2060s_RCM12)
    Energy_future_2060s_RCM12_monthly_sum(j,1)=sum(Energy_future_2060s_RCM12(j:j+29));
end
Energy_future_2060s_RCM12_monthly_sum(any(Energy_future_2060s_RCM12_monthly_sum==0,2))=[];
 
%% RCM13
Power_future_2060s_RCM13_monthly_mean=[];
Power_future_2060s_RCM13_monthly_sum=[];
Energy_future_2060s_RCM13_monthly_mean=[];
Energy_future_2060s_RCM13_monthly_sum=[];
 
for j=1:30:length(Power_future_2060s_RCM13)
    Power_future_2060s_RCM13_monthly_mean(j,1)=mean(Power_future_2060s_RCM13(j:j+29));
end
Power_future_2060s_RCM13_monthly_mean(any(Power_future_2060s_RCM13_monthly_mean==0,2))=[];
 
for j=1:30:length(Power_future_2060s_RCM13)
    Power_future_2060s_RCM13_monthly_sum(j,1)=sum(Power_future_2060s_RCM13(j:j+29));
end
Power_future_2060s_RCM13_monthly_sum(any(Power_future_2060s_RCM13_monthly_sum==0,2))=[];
 
 
for j=1:30:length(Energy_future_2060s_RCM13)
    Energy_future_2060s_RCM13_monthly_mean(j,1)=mean(Energy_future_2060s_RCM13(j:j+29));
end
Energy_future_2060s_RCM13_monthly_mean(any(Energy_future_2060s_RCM13_monthly_mean==0,2))=[];
 
for j=1:30:length(Energy_future_2060s_RCM13)
    Energy_future_2060s_RCM13_monthly_sum(j,1)=sum(Energy_future_2060s_RCM13(j:j+29));
end
Energy_future_2060s_RCM13_monthly_sum(any(Energy_future_2060s_RCM13_monthly_sum==0,2))=[];
 
%% RCM15
Power_future_2060s_RCM15_monthly_mean=[];
Power_future_2060s_RCM15_monthly_sum=[];
Energy_future_2060s_RCM15_monthly_mean=[];
Energy_future_2060s_RCM15_monthly_sum=[];
 
for j=1:30:length(Power_future_2060s_RCM15)
    Power_future_2060s_RCM15_monthly_mean(j,1)=mean(Power_future_2060s_RCM15(j:j+29));
end
Power_future_2060s_RCM15_monthly_mean(any(Power_future_2060s_RCM15_monthly_mean==0,2))=[];
 
for j=1:30:length(Power_future_2060s_RCM15)
    Power_future_2060s_RCM15_monthly_sum(j,1)=sum(Power_future_2060s_RCM15(j:j+29));
end
Power_future_2060s_RCM15_monthly_sum(any(Power_future_2060s_RCM15_monthly_sum==0,2))=[];
 
 
for j=1:30:length(Energy_future_2060s_RCM15)
    Energy_future_2060s_RCM15_monthly_mean(j,1)=mean(Energy_future_2060s_RCM15(j:j+29));
end
Energy_future_2060s_RCM15_monthly_mean(any(Energy_future_2060s_RCM15_monthly_mean==0,2))=[];
 
for j=1:30:length(Energy_future_2060s_RCM15)
    Energy_future_2060s_RCM15_monthly_sum(j,1)=sum(Energy_future_2060s_RCM15(j:j+29));
end
Energy_future_2060s_RCM15_monthly_sum(any(Energy_future_2060s_RCM15_monthly_sum==0,2))=[];
 
%% Add the monthly power and energy output for each RCM to a matrix
 
for j=1:length(Months_baseline)
Power_future_2060s_allRCM_monthly_mean(j,1)=Power_future_2060s_RCM01_monthly_mean(j,1);
Power_future_2060s_allRCM_monthly_mean(j,2)=Power_future_2060s_RCM04_monthly_mean(j,1);
Power_future_2060s_allRCM_monthly_mean(j,3)=Power_future_2060s_RCM05_monthly_mean(j,1);
Power_future_2060s_allRCM_monthly_mean(j,4)=Power_future_2060s_RCM06_monthly_mean(j,1);
Power_future_2060s_allRCM_monthly_mean(j,5)=Power_future_2060s_RCM07_monthly_mean(j,1);
Power_future_2060s_allRCM_monthly_mean(j,6)=Power_future_2060s_RCM08_monthly_mean(j,1);
Power_future_2060s_allRCM_monthly_mean(j,7)=Power_future_2060s_RCM09_monthly_mean(j,1);
Power_future_2060s_allRCM_monthly_mean(j,8)=Power_future_2060s_RCM10_monthly_mean(j,1);
Power_future_2060s_allRCM_monthly_mean(j,9)=Power_future_2060s_RCM11_monthly_mean(j,1);
Power_future_2060s_allRCM_monthly_mean(j,10)=Power_future_2060s_RCM12_monthly_mean(j,1);
Power_future_2060s_allRCM_monthly_mean(j,11)=Power_future_2060s_RCM13_monthly_mean(j,1);
Power_future_2060s_allRCM_monthly_mean(j,12)=Power_future_2060s_RCM15_monthly_mean(j,1);
 
Energy_future_2060s_allRCM_monthly_sum(j,1)=Energy_future_2060s_RCM01_monthly_sum(j,1);
Energy_future_2060s_allRCM_monthly_sum(j,2)=Energy_future_2060s_RCM04_monthly_sum(j,1);
Energy_future_2060s_allRCM_monthly_sum(j,3)=Energy_future_2060s_RCM05_monthly_sum(j,1);
Energy_future_2060s_allRCM_monthly_sum(j,4)=Energy_future_2060s_RCM06_monthly_sum(j,1);
Energy_future_2060s_allRCM_monthly_sum(j,5)=Energy_future_2060s_RCM07_monthly_sum(j,1);
Energy_future_2060s_allRCM_monthly_sum(j,6)=Energy_future_2060s_RCM08_monthly_sum(j,1);
Energy_future_2060s_allRCM_monthly_sum(j,7)=Energy_future_2060s_RCM09_monthly_sum(j,1);
Energy_future_2060s_allRCM_monthly_sum(j,8)=Energy_future_2060s_RCM10_monthly_sum(j,1);
Energy_future_2060s_allRCM_monthly_sum(j,9)=Energy_future_2060s_RCM11_monthly_sum(j,1);
Energy_future_2060s_allRCM_monthly_sum(j,10)=Energy_future_2060s_RCM12_monthly_sum(j,1);
Energy_future_2060s_allRCM_monthly_sum(j,11)=Energy_future_2060s_RCM13_monthly_sum(j,1);
Energy_future_2060s_allRCM_monthly_sum(j,12)=Energy_future_2060s_RCM15_monthly_sum(j,1);
 
end
 
%% Calculate the mean monthly power and total energy output considering all the RCMs
for j=1:length(Months_baseline)
Power_future_2060s_mean_monthly(j,1)=mean(Power_future_2060s_allRCM_monthly_mean(j,:));
Energy_future_2060s_sum_monthly(j,1)=mean(Energy_future_2060s_allRCM_monthly_sum(j,:));
end
 
%Redo the installed power for months
Power_installed=[];
for j=1:height(Months_baseline)
    Power_installed(j,1)=Micro_installed_power(i,1);
end
 
%% Plot the baseline monthly autumn mean daily power vs installed power
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Baseline\Autumn\Baseline_monthly_autumn_mean_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Monthly mean autumn available power vs installed power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no);
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Power [kW]');
       hold on
       plot(Months_baseline,Power_baseline_monthly_mean);
       hold on
       plot(Months_baseline,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available daily power [kW]','Installed power [kW]','Location','southeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the baseline autumn monthly sum energy output
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Baseline\Autumn\Baseline_monthly_autumn_sum_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Monthly total energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no);
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Energy [kWh]');
       hold on
       plot(Months_baseline,Energy_baseline_monthly_sum);
       hold on
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
    
%% Plot the 2060s monthly autumn sum energy output for RCM01
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM01_monthly_sum_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s monthly autumn total energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM01');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Energy [kWh]');
       hold on
       plot(Months_2060s,Energy_future_2060s_RCM01_monthly_sum);
       hold on
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the 2060s monthly autumn mean daily power vs installed power for RCM04
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM04_monthly_mean_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s monthly autumn mean available power vs installed power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM04');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Power [kW]');
       hold on
       plot(Months_2060s,Power_future_2060s_RCM04_monthly_mean);
       hold on
       plot(Months_2060s,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available daily power [kW]','Installed power [kW]','Location','southeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the 2060s monthly autumn sum energy output for RCM04
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM04_monthly_sum_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s monthly autumn total energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM04');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Energy [kWh]');
       hold on
       plot(Months_2060s,Energy_future_2060s_RCM04_monthly_sum);
       hold on
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the 2060s monthly autumn mean daily power vs installed power for RCM05
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM05_monthly_mean_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s monthly autumn mean available power vs installed power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM05');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Power [kW]');
       hold on
       plot(Months_2060s,Power_future_2060s_RCM05_monthly_mean);
       hold on
       plot(Months_2060s,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available daily power [kW]','Installed power [kW]','Location','southeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the 2060s monthly autumn sum energy output for RCM05
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM05_monthly_sum_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s monthly autumn total energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM05');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Energy [kWh]');
       hold on
       plot(Months_2060s,Energy_future_2060s_RCM05_monthly_sum);
       hold on
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the 2060s monthly autumn mean daily power vs installed power for RCM06
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM06_monthly_mean_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s monthly autumn mean available power vs installed power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM06');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Power [kW]');
       hold on
       plot(Months_2060s,Power_future_2060s_RCM06_monthly_mean);
       hold on
       plot(Months_2060s,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available daily power [kW]','Installed power [kW]','Location','southeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the 2060s monthly autumn sum energy output for RCM06
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM06_monthly_sum_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s monthly autumn total energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM06');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Energy [kWh]');
       hold on
       plot(Months_2060s,Energy_future_2060s_RCM06_monthly_sum);
       hold on
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the 2060s monthly autumn mean daily power vs installed power for RCM07
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM07_monthly_mean_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s monthly autumn mean available power vs installed power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM07');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Power [kW]');
       hold on
       plot(Months_2060s,Power_future_2060s_RCM07_monthly_mean);
       hold on
       plot(Months_2060s,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available daily power [kW]','Installed power [kW]','Location','southeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the 2060s monthly autumn sum energy output for RCM07
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM07_monthly_sum_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s monthly autumn total energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM07');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Energy [kWh]');
       hold on
       plot(Months_2060s,Energy_future_2060s_RCM07_monthly_sum);
       hold on
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the 2060s monthly autumn mean daily power vs installed power for RCM08
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM08_monthly_mean_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s monthly autumn mean available power vs installed power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM08');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Power [kW]');
       hold on
       plot(Months_2060s,Power_future_2060s_RCM08_monthly_mean);
       hold on
       plot(Months_2060s,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available daily power [kW]','Installed power [kW]','Location','southeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the 2060s monthly autumn sum energy output for RCM08
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM08_monthly_sum_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s monthly autumn total energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM08');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Energy [kWh]');
       hold on
       plot(Months_2060s,Energy_future_2060s_RCM08_monthly_sum);
       hold on
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the 2060s monthly autumn mean daily power vs installed power for RCM09
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM09_monthly_mean_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s monthly autumn mean available power vs installed power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM09');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Power [kW]');
       hold on
       plot(Months_2060s,Power_future_2060s_RCM09_monthly_mean);
       hold on
       plot(Months_2060s,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available daily power [kW]','Installed power [kW]','Location','southeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the 2060s monthly autumn sum energy output for RCM09
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM09_monthly_sum_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s monthly autumn total energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM09');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Energy [kWh]');
       hold on
       plot(Months_2060s,Energy_future_2060s_RCM09_monthly_sum);
       hold on
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the 2060s monthly autumn mean daily power vs installed power for RCM10
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM10_monthly_mean_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s monthly autumn mean available power vs installed power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM10');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Power [kW]');
       hold on
       plot(Months_2060s,Power_future_2060s_RCM10_monthly_mean);
       hold on
       plot(Months_2060s,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available daily power [kW]','Installed power [kW]','Location','southeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the 2060s monthly autumn sum energy output for RCM10
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM10_monthly_sum_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s monthly autumn total energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM10');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Energy [kWh]');
       hold on
       plot(Months_2060s,Energy_future_2060s_RCM10_monthly_sum);
       hold on
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the 2060s monthly autumn mean daily power vs installed power for RCM11
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM11_monthly_mean_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s monthly autumn mean available power vs installed power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM11');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Power [kW]');
       hold on
       plot(Months_2060s,Power_future_2060s_RCM11_monthly_mean);
       hold on
       plot(Months_2060s,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available daily power [kW]','Installed power [kW]','Location','southeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the 2060s monthly autumn sum energy output for RCM11
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM11_monthly_sum_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s monthly autumn total energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM11');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Energy [kWh]');
       hold on
       plot(Months_2060s,Energy_future_2060s_RCM11_monthly_sum);
       hold on
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the 2060s monthly autumn mean daily power vs installed power for RCM12
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM12_monthly_mean_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s monthly autumn mean available power vs installed power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM12');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Power [kW]');
       hold on
       plot(Months_2060s,Power_future_2060s_RCM12_monthly_mean);
       hold on
       plot(Months_2060s,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available daily power [kW]','Installed power [kW]','Location','southeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the 2060s monthly autumn sum energy output for RCM12
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM12_monthly_sum_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s monthly autumn total energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM12');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Energy [kWh]');
       hold on
       plot(Months_2060s,Energy_future_2060s_RCM12_monthly_sum);
       hold on
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the 2060s monthly autumn mean daily power vs installed power for RCM13
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM13_monthly_mean_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s monthly autumn mean available power vs installed power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM13');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Power [kW]');
       hold on
       plot(Months_2060s,Power_future_2060s_RCM13_monthly_mean);
       hold on
       plot(Months_2060s,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available daily power [kW]','Installed power [kW]','Location','southeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the 2060s monthly autumn sum energy output for RCM13
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM13_monthly_sum_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s monthly autumn total energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM13');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Energy [kWh]');
       hold on
       plot(Months_2060s,Energy_future_2060s_RCM13_monthly_sum);
       hold on
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the 2060s monthly autumn mean daily power vs installed power for RCM15
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM15_monthly_mean_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s monthly autumn mean available power vs installed power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM15');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Power [kW]');
       hold on
       plot(Months_2060s,Power_future_2060s_RCM15_monthly_mean);
       hold on
       plot(Months_2060s,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available daily power [kW]','Installed power [kW]','Location','southeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the 2060s monthly autumn sum energy output for RCM15
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM15_monthly_sum_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s monthly autumn total energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM15');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Energy [kWh]');
       hold on
       plot(Months_2060s,Energy_future_2060s_RCM15_monthly_sum);
       hold on
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the 2060s monthly autumn mean daily power vs installed power for all RCMs
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_allRCM_monthly_mean_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s monthly autumn mean available power vs installed power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for all RCMs');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Power [kW]');
       hold on
       plot(Months_2060s,Power_future_2060s_mean_monthly);
       hold on
       plot(Months_2060s,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available daily power [kW]','Installed power [kW]','Location','southeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the 2060s monthly autumn sum energy output for all RCMs
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_allRCM_monthly_sum_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s monthly autumn total energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for all RCMs');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Energy [kWh]');
       hold on
       plot(Months_2060s,Energy_future_2060s_sum_monthly);
       hold on
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline); 
 
%% Mean and total annual all RCMs available power and energy output - mean and sum of calculated daily available power and energy output
 
%% RCM01
Power_future_2060s_RCM01_annual_mean=[];
Power_future_2060s_RCM01_annual_sum=[];
Energy_future_2060s_RCM01_annual_mean=[];
Energy_future_2060s_RCM01_annual_sum=[];
 
for j=1:90:length(Power_future_2060s_RCM01)
    Power_future_2060s_RCM01_annual_mean(j,1)=mean(Power_future_2060s_RCM01(j:j+89));
end
Power_future_2060s_RCM01_annual_mean(any(Power_future_2060s_RCM01_annual_mean==0,2))=[];
 
for j=1:90:length(Power_future_2060s_RCM01)
    Power_future_2060s_RCM01_annual_sum(j,1)=sum(Power_future_2060s_RCM01(j:j+89));
end
Power_future_2060s_RCM01_annual_sum(any(Power_future_2060s_RCM01_annual_sum==0,2))=[];
 
 
for j=1:90:length(Energy_future_2060s_RCM01)
    Energy_future_2060s_RCM01_annual_mean(j,1)=mean(Energy_future_2060s_RCM01(j:j+89));
end
Energy_future_2060s_RCM01_annual_mean(any(Energy_future_2060s_RCM01_annual_mean==0,2))=[];
 
for j=1:90:length(Energy_future_2060s_RCM01)
    Energy_future_2060s_RCM01_annual_sum(j,1)=sum(Energy_future_2060s_RCM01(j:j+89));
end
Energy_future_2060s_RCM01_annual_sum(any(Energy_future_2060s_RCM01_annual_sum==0,2))=[];
 
%% RCM04
Power_future_2060s_RCM04_annual_mean=[];
Power_future_2060s_RCM04_annual_sum=[];
Energy_future_2060s_RCM04_annual_mean=[];
Energy_future_2060s_RCM04_annual_sum=[];
 
for j=1:90:length(Power_future_2060s_RCM04)
    Power_future_2060s_RCM04_annual_mean(j,1)=mean(Power_future_2060s_RCM04(j:j+89));
end
Power_future_2060s_RCM04_annual_mean(any(Power_future_2060s_RCM04_annual_mean==0,2))=[];
 
for j=1:90:length(Power_future_2060s_RCM04)
    Power_future_2060s_RCM04_annual_sum(j,1)=sum(Power_future_2060s_RCM04(j:j+89));
end
Power_future_2060s_RCM04_annual_sum(any(Power_future_2060s_RCM04_annual_sum==0,2))=[];
 
 
for j=1:90:length(Energy_future_2060s_RCM04)
    Energy_future_2060s_RCM04_annual_mean(j,1)=mean(Energy_future_2060s_RCM04(j:j+89));
end
Energy_future_2060s_RCM04_annual_mean(any(Energy_future_2060s_RCM04_annual_mean==0,2))=[];
 
for j=1:90:length(Energy_future_2060s_RCM04)
    Energy_future_2060s_RCM04_annual_sum(j,1)=sum(Energy_future_2060s_RCM04(j:j+89));
end
Energy_future_2060s_RCM04_annual_sum(any(Energy_future_2060s_RCM04_annual_sum==0,2))=[];
 
%% RCM05
Power_future_2060s_RCM05_annual_mean=[];
Power_future_2060s_RCM05_annual_sum=[];
Energy_future_2060s_RCM05_annual_mean=[];
Energy_future_2060s_RCM05_annual_sum=[];
 
for j=1:90:length(Power_future_2060s_RCM05)
    Power_future_2060s_RCM05_annual_mean(j,1)=mean(Power_future_2060s_RCM05(j:j+89));
end
Power_future_2060s_RCM05_annual_mean(any(Power_future_2060s_RCM05_annual_mean==0,2))=[];
 
for j=1:90:length(Power_future_2060s_RCM05)
    Power_future_2060s_RCM05_annual_sum(j,1)=sum(Power_future_2060s_RCM05(j:j+89));
end
Power_future_2060s_RCM05_annual_sum(any(Power_future_2060s_RCM05_annual_sum==0,2))=[];
 
 
for j=1:90:length(Energy_future_2060s_RCM05)
    Energy_future_2060s_RCM05_annual_mean(j,1)=mean(Energy_future_2060s_RCM05(j:j+89));
end
Energy_future_2060s_RCM05_annual_mean(any(Energy_future_2060s_RCM05_annual_mean==0,2))=[];
 
for j=1:90:length(Energy_future_2060s_RCM05)
    Energy_future_2060s_RCM05_annual_sum(j,1)=sum(Energy_future_2060s_RCM05(j:j+89));
end
Energy_future_2060s_RCM05_annual_sum(any(Energy_future_2060s_RCM05_annual_sum==0,2))=[];
 
%% RCM06
Power_future_2060s_RCM06_annual_mean=[];
Power_future_2060s_RCM06_annual_sum=[];
Energy_future_2060s_RCM06_annual_mean=[];
Energy_future_2060s_RCM06_annual_sum=[];
 
for j=1:90:length(Power_future_2060s_RCM06)
    Power_future_2060s_RCM06_annual_mean(j,1)=mean(Power_future_2060s_RCM06(j:j+89));
end
Power_future_2060s_RCM06_annual_mean(any(Power_future_2060s_RCM06_annual_mean==0,2))=[];
 
for j=1:90:length(Power_future_2060s_RCM06)
    Power_future_2060s_RCM06_annual_sum(j,1)=sum(Power_future_2060s_RCM06(j:j+89));
end
Power_future_2060s_RCM06_annual_sum(any(Power_future_2060s_RCM06_annual_sum==0,2))=[];
 
 
for j=1:90:length(Energy_future_2060s_RCM06)
    Energy_future_2060s_RCM06_annual_mean(j,1)=mean(Energy_future_2060s_RCM06(j:j+89));
end
Energy_future_2060s_RCM06_annual_mean(any(Energy_future_2060s_RCM06_annual_mean==0,2))=[];
 
for j=1:90:length(Energy_future_2060s_RCM06)
    Energy_future_2060s_RCM06_annual_sum(j,1)=sum(Energy_future_2060s_RCM06(j:j+89));
end
Energy_future_2060s_RCM06_annual_sum(any(Energy_future_2060s_RCM06_annual_sum==0,2))=[];
 
%% RCM07
Power_future_2060s_RCM07_annual_mean=[];
Power_future_2060s_RCM07_annual_sum=[];
Energy_future_2060s_RCM07_annual_mean=[];
Energy_future_2060s_RCM07_annual_sum=[];
 
for j=1:90:length(Power_future_2060s_RCM07)
    Power_future_2060s_RCM07_annual_mean(j,1)=mean(Power_future_2060s_RCM07(j:j+89));
end
Power_future_2060s_RCM07_annual_mean(any(Power_future_2060s_RCM07_annual_mean==0,2))=[];
 
for j=1:90:length(Power_future_2060s_RCM07)
    Power_future_2060s_RCM07_annual_sum(j,1)=sum(Power_future_2060s_RCM07(j:j+89));
end
Power_future_2060s_RCM07_annual_sum(any(Power_future_2060s_RCM07_annual_sum==0,2))=[];
 
 
for j=1:90:length(Energy_future_2060s_RCM07)
    Energy_future_2060s_RCM07_annual_mean(j,1)=mean(Energy_future_2060s_RCM07(j:j+89));
end
Energy_future_2060s_RCM07_annual_mean(any(Energy_future_2060s_RCM07_annual_mean==0,2))=[];
 
for j=1:90:length(Energy_future_2060s_RCM07)
    Energy_future_2060s_RCM07_annual_sum(j,1)=sum(Energy_future_2060s_RCM07(j:j+89));
end
Energy_future_2060s_RCM07_annual_sum(any(Energy_future_2060s_RCM07_annual_sum==0,2))=[];
 
%% RCM08
Power_future_2060s_RCM08_annual_mean=[];
Power_future_2060s_RCM08_annual_sum=[];
Energy_future_2060s_RCM08_annual_mean=[];
Energy_future_2060s_RCM08_annual_sum=[];
 
for j=1:90:length(Power_future_2060s_RCM08)
    Power_future_2060s_RCM08_annual_mean(j,1)=mean(Power_future_2060s_RCM08(j:j+89));
end
Power_future_2060s_RCM08_annual_mean(any(Power_future_2060s_RCM08_annual_mean==0,2))=[];
 
for j=1:90:length(Power_future_2060s_RCM08)
    Power_future_2060s_RCM08_annual_sum(j,1)=sum(Power_future_2060s_RCM08(j:j+89));
end
Power_future_2060s_RCM08_annual_sum(any(Power_future_2060s_RCM08_annual_sum==0,2))=[];
 
 
for j=1:90:length(Energy_future_2060s_RCM08)
    Energy_future_2060s_RCM08_annual_mean(j,1)=mean(Energy_future_2060s_RCM08(j:j+89));
end
Energy_future_2060s_RCM08_annual_mean(any(Energy_future_2060s_RCM08_annual_mean==0,2))=[];
 
for j=1:90:length(Energy_future_2060s_RCM08)
    Energy_future_2060s_RCM08_annual_sum(j,1)=sum(Energy_future_2060s_RCM08(j:j+89));
end
Energy_future_2060s_RCM08_annual_sum(any(Energy_future_2060s_RCM08_annual_sum==0,2))=[];
 
%% RCM09
Power_future_2060s_RCM09_annual_mean=[];
Power_future_2060s_RCM09_annual_sum=[];
Energy_future_2060s_RCM09_annual_mean=[];
Energy_future_2060s_RCM09_annual_sum=[];
 
for j=1:90:length(Power_future_2060s_RCM09)
    Power_future_2060s_RCM09_annual_mean(j,1)=mean(Power_future_2060s_RCM09(j:j+89));
end
Power_future_2060s_RCM09_annual_mean(any(Power_future_2060s_RCM09_annual_mean==0,2))=[];
 
for j=1:90:length(Power_future_2060s_RCM09)
    Power_future_2060s_RCM09_annual_sum(j,1)=sum(Power_future_2060s_RCM09(j:j+89));
end
Power_future_2060s_RCM09_annual_sum(any(Power_future_2060s_RCM09_annual_sum==0,2))=[];
 
 
for j=1:90:length(Energy_future_2060s_RCM09)
    Energy_future_2060s_RCM09_annual_mean(j,1)=mean(Energy_future_2060s_RCM09(j:j+89));
end
Energy_future_2060s_RCM09_annual_mean(any(Energy_future_2060s_RCM09_annual_mean==0,2))=[];
 
for j=1:90:length(Energy_future_2060s_RCM09)
    Energy_future_2060s_RCM09_annual_sum(j,1)=sum(Energy_future_2060s_RCM09(j:j+89));
end
Energy_future_2060s_RCM09_annual_sum(any(Energy_future_2060s_RCM09_annual_sum==0,2))=[];
 
%% RCM10
Power_future_2060s_RCM10_annual_mean=[];
Power_future_2060s_RCM10_annual_sum=[];
Energy_future_2060s_RCM10_annual_mean=[];
Energy_future_2060s_RCM10_annual_sum=[];
 
for j=1:90:length(Power_future_2060s_RCM10)
    Power_future_2060s_RCM10_annual_mean(j,1)=mean(Power_future_2060s_RCM10(j:j+89));
end
Power_future_2060s_RCM10_annual_mean(any(Power_future_2060s_RCM10_annual_mean==0,2))=[];
 
for j=1:90:length(Power_future_2060s_RCM10)
    Power_future_2060s_RCM10_annual_sum(j,1)=sum(Power_future_2060s_RCM10(j:j+89));
end
Power_future_2060s_RCM10_annual_sum(any(Power_future_2060s_RCM10_annual_sum==0,2))=[];
 
 
for j=1:90:length(Energy_future_2060s_RCM10)
    Energy_future_2060s_RCM10_annual_mean(j,1)=mean(Energy_future_2060s_RCM10(j:j+89));
end
Energy_future_2060s_RCM10_annual_mean(any(Energy_future_2060s_RCM10_annual_mean==0,2))=[];
 
for j=1:90:length(Energy_future_2060s_RCM10)
    Energy_future_2060s_RCM10_annual_sum(j,1)=sum(Energy_future_2060s_RCM10(j:j+89));
end
Energy_future_2060s_RCM10_annual_sum(any(Energy_future_2060s_RCM10_annual_sum==0,2))=[];
 
%% RCM11
Power_future_2060s_RCM11_annual_mean=[];
Power_future_2060s_RCM11_annual_sum=[];
Energy_future_2060s_RCM11_annual_mean=[];
Energy_future_2060s_RCM11_annual_sum=[];
 
for j=1:90:length(Power_future_2060s_RCM11)
    Power_future_2060s_RCM11_annual_mean(j,1)=mean(Power_future_2060s_RCM11(j:j+89));
end
Power_future_2060s_RCM11_annual_mean(any(Power_future_2060s_RCM11_annual_mean==0,2))=[];
 
for j=1:90:length(Power_future_2060s_RCM11)
    Power_future_2060s_RCM11_annual_sum(j,1)=sum(Power_future_2060s_RCM11(j:j+89));
end
Power_future_2060s_RCM11_annual_sum(any(Power_future_2060s_RCM11_annual_sum==0,2))=[];
 
 
for j=1:90:length(Energy_future_2060s_RCM11)
    Energy_future_2060s_RCM11_annual_mean(j,1)=mean(Energy_future_2060s_RCM11(j:j+89));
end
Energy_future_2060s_RCM11_annual_mean(any(Energy_future_2060s_RCM11_annual_mean==0,2))=[];
 
for j=1:90:length(Energy_future_2060s_RCM11)
    Energy_future_2060s_RCM11_annual_sum(j,1)=sum(Energy_future_2060s_RCM11(j:j+89));
end
Energy_future_2060s_RCM11_annual_sum(any(Energy_future_2060s_RCM11_annual_sum==0,2))=[];
 
%% RCM12
Power_future_2060s_RCM12_annual_mean=[];
Power_future_2060s_RCM12_annual_sum=[];
Energy_future_2060s_RCM12_annual_mean=[];
Energy_future_2060s_RCM12_annual_sum=[];
 
for j=1:90:length(Power_future_2060s_RCM12)
    Power_future_2060s_RCM12_annual_mean(j,1)=mean(Power_future_2060s_RCM12(j:j+89));
end
Power_future_2060s_RCM12_annual_mean(any(Power_future_2060s_RCM12_annual_mean==0,2))=[];
 
for j=1:90:length(Power_future_2060s_RCM12)
    Power_future_2060s_RCM12_annual_sum(j,1)=sum(Power_future_2060s_RCM12(j:j+89));
end
Power_future_2060s_RCM12_annual_sum(any(Power_future_2060s_RCM12_annual_sum==0,2))=[];
 
 
for j=1:90:length(Energy_future_2060s_RCM12)
    Energy_future_2060s_RCM12_annual_mean(j,1)=mean(Energy_future_2060s_RCM12(j:j+89));
end
Energy_future_2060s_RCM12_annual_mean(any(Energy_future_2060s_RCM12_annual_mean==0,2))=[];
 
for j=1:90:length(Energy_future_2060s_RCM12)
    Energy_future_2060s_RCM12_annual_sum(j,1)=sum(Energy_future_2060s_RCM12(j:j+89));
end
Energy_future_2060s_RCM12_annual_sum(any(Energy_future_2060s_RCM12_annual_sum==0,2))=[];
 
%% RCM13
Power_future_2060s_RCM13_annual_mean=[];
Power_future_2060s_RCM13_annual_sum=[];
Energy_future_2060s_RCM13_annual_mean=[];
Energy_future_2060s_RCM13_annual_sum=[];
 
for j=1:90:length(Power_future_2060s_RCM13)
    Power_future_2060s_RCM13_annual_mean(j,1)=mean(Power_future_2060s_RCM13(j:j+89));
end
Power_future_2060s_RCM13_annual_mean(any(Power_future_2060s_RCM13_annual_mean==0,2))=[];
 
for j=1:90:length(Power_future_2060s_RCM13)
    Power_future_2060s_RCM13_annual_sum(j,1)=sum(Power_future_2060s_RCM13(j:j+89));
end
Power_future_2060s_RCM13_annual_sum(any(Power_future_2060s_RCM13_annual_sum==0,2))=[];
 
 
for j=1:90:length(Energy_future_2060s_RCM13)
    Energy_future_2060s_RCM13_annual_mean(j,1)=mean(Energy_future_2060s_RCM13(j:j+89));
end
Energy_future_2060s_RCM13_annual_mean(any(Energy_future_2060s_RCM13_annual_mean==0,2))=[];
 
for j=1:90:length(Energy_future_2060s_RCM13)
    Energy_future_2060s_RCM13_annual_sum(j,1)=sum(Energy_future_2060s_RCM13(j:j+89));
end
Energy_future_2060s_RCM13_annual_sum(any(Energy_future_2060s_RCM13_annual_sum==0,2))=[];
 
%% RCM15
Power_future_2060s_RCM15_annual_mean=[];
Power_future_2060s_RCM15_annual_sum=[];
Energy_future_2060s_RCM15_annual_mean=[];
Energy_future_2060s_RCM15_annual_sum=[];
 
for j=1:90:length(Power_future_2060s_RCM15)
    Power_future_2060s_RCM15_annual_mean(j,1)=mean(Power_future_2060s_RCM15(j:j+89));
end
Power_future_2060s_RCM15_annual_mean(any(Power_future_2060s_RCM15_annual_mean==0,2))=[];
 
for j=1:90:length(Power_future_2060s_RCM15)
    Power_future_2060s_RCM15_annual_sum(j,1)=sum(Power_future_2060s_RCM15(j:j+89));
end
Power_future_2060s_RCM15_annual_sum(any(Power_future_2060s_RCM15_annual_sum==0,2))=[];
 
 
for j=1:90:length(Energy_future_2060s_RCM15)
    Energy_future_2060s_RCM15_annual_mean(j,1)=mean(Energy_future_2060s_RCM15(j:j+89));
end
Energy_future_2060s_RCM15_annual_mean(any(Energy_future_2060s_RCM15_annual_mean==0,2))=[];
 
for j=1:90:length(Energy_future_2060s_RCM15)
    Energy_future_2060s_RCM15_annual_sum(j,1)=sum(Energy_future_2060s_RCM15(j:j+89));
end
Energy_future_2060s_RCM15_annual_sum(any(Energy_future_2060s_RCM15_annual_sum==0,2))=[];
 
%% Add the annual power and energy output for each RCM to a matrix
 
for j=1:length(Years_baseline)
Power_future_2060s_allRCM_annual_mean(j,1)=Power_future_2060s_RCM01_annual_mean(j,1);
Power_future_2060s_allRCM_annual_mean(j,2)=Power_future_2060s_RCM04_annual_mean(j,1);
Power_future_2060s_allRCM_annual_mean(j,3)=Power_future_2060s_RCM05_annual_mean(j,1);
Power_future_2060s_allRCM_annual_mean(j,4)=Power_future_2060s_RCM06_annual_mean(j,1);
Power_future_2060s_allRCM_annual_mean(j,5)=Power_future_2060s_RCM07_annual_mean(j,1);
Power_future_2060s_allRCM_annual_mean(j,6)=Power_future_2060s_RCM08_annual_mean(j,1);
Power_future_2060s_allRCM_annual_mean(j,7)=Power_future_2060s_RCM09_annual_mean(j,1);
Power_future_2060s_allRCM_annual_mean(j,8)=Power_future_2060s_RCM10_annual_mean(j,1);
Power_future_2060s_allRCM_annual_mean(j,9)=Power_future_2060s_RCM11_annual_mean(j,1);
Power_future_2060s_allRCM_annual_mean(j,10)=Power_future_2060s_RCM12_annual_mean(j,1);
Power_future_2060s_allRCM_annual_mean(j,11)=Power_future_2060s_RCM13_annual_mean(j,1);
Power_future_2060s_allRCM_annual_mean(j,12)=Power_future_2060s_RCM15_annual_mean(j,1);
 
Energy_future_2060s_allRCM_annual_sum(j,1)=Energy_future_2060s_RCM01_annual_sum(j,1);
Energy_future_2060s_allRCM_annual_sum(j,2)=Energy_future_2060s_RCM04_annual_sum(j,1);
Energy_future_2060s_allRCM_annual_sum(j,3)=Energy_future_2060s_RCM05_annual_sum(j,1);
Energy_future_2060s_allRCM_annual_sum(j,4)=Energy_future_2060s_RCM06_annual_sum(j,1);
Energy_future_2060s_allRCM_annual_sum(j,5)=Energy_future_2060s_RCM07_annual_sum(j,1);
Energy_future_2060s_allRCM_annual_sum(j,6)=Energy_future_2060s_RCM08_annual_sum(j,1);
Energy_future_2060s_allRCM_annual_sum(j,7)=Energy_future_2060s_RCM09_annual_sum(j,1);
Energy_future_2060s_allRCM_annual_sum(j,8)=Energy_future_2060s_RCM10_annual_sum(j,1);
Energy_future_2060s_allRCM_annual_sum(j,9)=Energy_future_2060s_RCM11_annual_sum(j,1);
Energy_future_2060s_allRCM_annual_sum(j,10)=Energy_future_2060s_RCM12_annual_sum(j,1);
Energy_future_2060s_allRCM_annual_sum(j,11)=Energy_future_2060s_RCM13_annual_sum(j,1);
Energy_future_2060s_allRCM_annual_sum(j,12)=Energy_future_2060s_RCM15_annual_sum(j,1);
end
 
%% Calculate the mean annual autumn power and total energy output considering all the RCMs
for j=1:length(Years_baseline)
Power_future_2060s_mean_annual(j,1)=mean(Power_future_2060s_allRCM_annual_mean(j,:));
Energy_future_2060s_sum_annual(j,1)=mean(Energy_future_2060s_allRCM_annual_sum(j,:));
end
 
%Redo the installed power for years
Power_installed=[];
for j=1:height(Years_baseline)
    Power_installed(j,1)=Micro_installed_power(i,1);
end
 
No_of_years=[1:length(Years_baseline)];
No_of_years=No_of_years.';
 
%% Plot the baseline annual autumn mean daily power vs installed power
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Baseline\Autumn\Baseline_annual_autumn_mean_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Annual autumn mean available power vs installed power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no);
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Power [kW]');
       hold on
       plot(Years_baseline,Power_baseline_annual_mean);
       hold on
       plot(Years_baseline,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available daily power [kW]','Installed power [kW]','Location','southeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);   
 
%% Plot the baseline annual autumn sum energy output
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Baseline\Autumn\Baseline_annual_autumn_sum_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Annual autumn total energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no);
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Energy [kWh]');
       hold on
       plot(Years_baseline,Energy_baseline_annual_sum);
       hold on
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);      
 
%% Plot the 2060s annual autumn mean daily power vs installed power RCM01
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM01_annual_mean_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn mean available power vs installed power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",' for RCM01');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Power [kW]');
       hold on
       plot(Years_2060s,Power_future_2060s_RCM01_annual_mean);
       hold on
       plot(Years_2060s,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available daily power [kW]','Installed power [kW]','Location','southeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);   
 
%% Plot the 2060s yearly autumn mean power vs baseline power for RCM01 as a bar graph
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM01_bar_chart_annual_mean_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn mean available power vs baseline power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM01');
       title(title_name_baseline);
       xlabel('Years');
       ylabel('Power [kW]');
       hold on
       bar(No_of_years,Power_baseline_annual_mean,'b');      
       hold on
       bar(No_of_years,Power_future_2060s_RCM01_annual_mean,'c');
       hold on
       plot(No_of_years,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available baseline power [kW]','Available future 2060s power [kW]','Installed power [kW]','Location','northeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
              
%% Plot the 2060s annual autumn sum energy output RCM01
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM01_annual_sum_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn total energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",' for RCM01');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Energy [kWh]');
       hold on
       plot(Years_2060s,Energy_future_2060s_RCM01_annual_sum);
       hold on
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);    
       
%% Plot the 2060s yearly autumn sum energy vs baseline sum energy for RCM01 as a bar graph
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM01_bar_chart_annual_sum_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn sum energy vs baseline sum energy at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM01');
       title(title_name_baseline);
       xlabel('Years');
       ylabel('Energy [kWh]');
       hold on
       bar(No_of_years,Energy_baseline_annual_sum,'b');      
       hold on
       bar(No_of_years,Energy_future_2060s_RCM01_annual_sum,'c');
       hold on
       legend('Total annual baseline energy [kWh]','Total annual future 2060s energy [kWh]','Location','northeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the 2060s annual autumn mean power vs installed power RCM04
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM04_annual_mean_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn mean available power vs installed power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",' for RCM04');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Power [kW]');
       hold on
       plot(Years_2060s,Power_future_2060s_RCM04_annual_mean);
       hold on
       plot(Years_2060s,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available daily power [kW]','Installed power [kW]','Location','southeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);   
 
%% Plot the 2060s annual autumn mean power vs baseline power for RCM04 as a bar graph
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM04_bar_chart_annual_mean_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn mean available power vs baseline power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM04');
       title(title_name_baseline);
       xlabel('Years');
       ylabel('Power [kW]');
       hold on
       bar(No_of_years,Power_baseline_annual_mean,'b');      
       hold on
       bar(No_of_years,Power_future_2060s_RCM04_annual_mean,'c');
       hold on
       plot(No_of_years,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available baseline power [kW]','Available future 2060s power [kW]','Installed power [kW]','Location','northeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
       
%% Plot the 2060s annual autumn sum energy output RCM04
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM04_annual_sum_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn total energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",' for RCM04');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Energy [kWh]');
       hold on
       plot(Years_2060s,Energy_future_2060s_RCM04_annual_sum);
       hold on
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);      
       
%% Plot the 2060s yearly autumn sum energy vs baseline sum energy for RCM04 as a bar graph
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM04_bar_chart_annual_sum_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn sum energy vs baseline sum energy at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM04');
       title(title_name_baseline);
       xlabel('Years');
       ylabel('Energy [kWh]');
       hold on
       bar(No_of_years,Energy_baseline_annual_sum,'b');      
       hold on
       bar(No_of_years,Energy_future_2060s_RCM04_annual_sum,'c');
       hold on
       legend('Total annual baseline energy [kWh]','Total annual future 2060s energy [kWh]','Location','northeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);       
 
%% Plot the 2060s annual autumn mean daily power vs installed power RCM05
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM05_annual_mean_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn mean available power vs installed power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",' for RCM05');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Power [kW]');
       hold on
       plot(Years_2060s,Power_future_2060s_RCM05_annual_mean);
       hold on
       plot(Years_2060s,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available daily power [kW]','Installed power [kW]','Location','southeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);  
       
%% Plot the 2060s yearly autumn mean power vs baseline power for RCM05 as a bar graph
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM05_bar_chart_annual_mean_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn mean available power vs baseline power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM05');
       title(title_name_baseline);
       xlabel('Years');
       ylabel('Power [kW]');
       hold on
       bar(No_of_years,Power_baseline_annual_mean,'b');      
       hold on
       bar(No_of_years,Power_future_2060s_RCM05_annual_mean,'c');
       hold on
       plot(No_of_years,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available baseline power [kW]','Available future 2060s power [kW]','Installed power [kW]','Location','northeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
       
%% Plot the 2060s annual autumn sum energy output RCM05
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM05_annual_sum_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn total energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",' for RCM05');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Energy [kWh]');
       hold on
       plot(Years_2060s,Energy_future_2060s_RCM05_annual_sum);
       hold on
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);    
       
%% Plot the 2060s yearly autumn sum energy vs baseline sum energy for RCM05 as a bar graph
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM05_bar_chart_annual_sum_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn sum energy vs baseline sum energy at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM05');
       title(title_name_baseline);
       xlabel('Years');
       ylabel('Energy [kWh]');
       hold on
       bar(No_of_years,Energy_baseline_annual_sum,'b');      
       hold on
       bar(No_of_years,Energy_future_2060s_RCM05_annual_sum,'c');
       hold on
       legend('Total annual baseline energy [kWh]','Total annual future 2060s energy [kWh]','Location','northeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);       
      
%% Plot the 2060s annual autumn mean daily power vs installed power RCM06
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM06_annual_mean_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn mean available power vs installed power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",' for RCM06');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Power [kW]');
       hold on
       plot(Years_2060s,Power_future_2060s_RCM06_annual_mean);
       hold on
       plot(Years_2060s,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available daily power [kW]','Installed power [kW]','Location','southeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);   
 
%% Plot the 2060s yearly autumn mean power vs baseline power for RCM06 as a bar graph
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM06_bar_chart_annual_mean_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn mean available power vs baseline power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM06');
       title(title_name_baseline);
       xlabel('Years');
       ylabel('Power [kW]');
       hold on
       bar(No_of_years,Power_baseline_annual_mean,'b');      
       hold on
       bar(No_of_years,Power_future_2060s_RCM06_annual_mean,'c');
       hold on
       plot(No_of_years,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available baseline power [kW]','Available future 2060s power [kW]','Installed power [kW]','Location','northeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
 
%% Plot the 2060s annual autumn sum energy output RCM06
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM06_annual_sum_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn total energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",' for RCM06');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Energy [kWh]');
       hold on
       plot(Years_2060s,Energy_future_2060s_RCM06_annual_sum);
       hold on
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);      
       
%% Plot the 2060s yearly autumn sum energy vs baseline sum energy for RCM06 as a bar graph
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM06_bar_chart_annual_sum_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn sum energy vs baseline sum energy at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM06');
       title(title_name_baseline);
       xlabel('Years');
       ylabel('Energy [kWh]');
       hold on
       bar(No_of_years,Energy_baseline_annual_sum,'b');      
       hold on
       bar(No_of_years,Energy_future_2060s_RCM06_annual_sum,'c');
       hold on
       legend('Total annual baseline energy [kWh]','Total annual future 2060s energy [kWh]','Location','northeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
       
%% Plot the 2060s annual autumn mean daily power vs installed power RCM07
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM07_annual_mean_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn mean available power vs installed power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",' for RCM07');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Power [kW]');
       hold on
       plot(Years_2060s,Power_future_2060s_RCM07_annual_mean);
       hold on
       plot(Years_2060s,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available daily power [kW]','Installed power [kW]','Location','southeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);   
       
%% Plot the 2060s yearly autumn mean power vs baseline power for RCM07 as a bar graph
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM07_bar_chart_annual_mean_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn mean available power vs baseline power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM07');
       title(title_name_baseline);
       xlabel('Years');
       ylabel('Power [kW]');
       hold on
       bar(No_of_years,Power_baseline_annual_mean,'b');      
       hold on
       bar(No_of_years,Power_future_2060s_RCM07_annual_mean,'c');
       hold on
       plot(No_of_years,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available baseline power [kW]','Available future 2060s power [kW]','Installed power [kW]','Location','northeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
       
%% Plot the 2060s annual autumn sum energy output RCM07
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM07_annual_sum_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn total energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",' for RCM07');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Energy [kWh]');
       hold on
       plot(Years_2060s,Energy_future_2060s_RCM07_annual_sum);
       hold on
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);      
       
%% Plot the 2060s yearly autumn sum energy vs baseline sum energy for RCM07 as a bar graph
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM07_bar_chart_annual_sum_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn sum energy vs baseline sum energy at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM07');
       title(title_name_baseline);
       xlabel('Years');
       ylabel('Energy [kWh]');
       hold on
       bar(No_of_years,Energy_baseline_annual_sum,'b');      
       hold on
       bar(No_of_years,Energy_future_2060s_RCM07_annual_sum,'c');
       hold on
       legend('Total annual baseline energy [kWh]','Total annual future 2060s energy [kWh]','Location','northeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);       
 
%% Plot the 2060s annual autumn mean daily power vs installed power RCM08
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM08_annual_mean_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn mean available power vs installed power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",' for RCM08');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Power [kW]');
       hold on
       plot(Years_2060s,Power_future_2060s_RCM08_annual_mean);
       hold on
       plot(Years_2060s,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available daily power [kW]','Installed power [kW]','Location','southeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);   
       
%% Plot the 2060s yearly autumn mean power vs baseline power for RCM08 as a bar graph
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM08_bar_chart_annual_mean_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn mean available power vs baseline power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM08');
       title(title_name_baseline);
       xlabel('Years');
       ylabel('Power [kW]');
       hold on
       bar(No_of_years,Power_baseline_annual_mean,'b');      
       hold on
       bar(No_of_years,Power_future_2060s_RCM08_annual_mean,'c');
       hold on
       plot(No_of_years,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available baseline power [kW]','Available future 2060s power [kW]','Installed power [kW]','Location','northeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);       
 
%% Plot the 2060s annual autumn sum energy output RCM08
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM08_annual_sum_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn total energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",' for RCM08');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Energy [kWh]');
       hold on
       plot(Years_2060s,Energy_future_2060s_RCM08_annual_sum);
       hold on
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);      
       
%% Plot the 2060s yearly autumn sum energy vs baseline sum energy for RCM08 as a bar graph
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM08_bar_chart_annual_sum_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn sum energy vs baseline sum energy at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM08');
       title(title_name_baseline);
       xlabel('Years');
       ylabel('Energy [kWh]');
       hold on
       bar(No_of_years,Energy_baseline_annual_sum,'b');      
       hold on
       bar(No_of_years,Energy_future_2060s_RCM08_annual_sum,'c');
       hold on
       legend('Total annual baseline energy [kWh]','Total annual future 2060s energy [kWh]','Location','northeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);       
 
%% Plot the 2060s annual autumn mean daily power vs installed power RCM09
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM09_annual_mean_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn mean available power vs installed power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",' for RCM09');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Power [kW]');
       hold on
       plot(Years_2060s,Power_future_2060s_RCM09_annual_mean);
       hold on
       plot(Years_2060s,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available daily power [kW]','Installed power [kW]','Location','southeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);   
       
%% Plot the 2060s yearly autumn mean power vs baseline power for RCM09 as a bar graph
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM09_bar_chart_annual_mean_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn mean available power vs baseline power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM09');
       title(title_name_baseline);
       xlabel('Years');
       ylabel('Power [kW]');
       hold on
       bar(No_of_years,Power_baseline_annual_mean,'b');      
       hold on
       bar(No_of_years,Power_future_2060s_RCM09_annual_mean,'c');
       hold on
       plot(No_of_years,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available baseline power [kW]','Available future 2060s power [kW]','Installed power [kW]','Location','northeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);       
 
%% Plot the 2060s annual autumn sum energy output RCM09
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM09_annual_sum_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn total energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",' for RCM09');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Energy [kWh]');
       hold on
       plot(Years_2060s,Energy_future_2060s_RCM09_annual_sum);
       hold on
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);      
 
%% Plot the 2060s yearly autumn sum energy vs baseline sum energy for RCM09 as a bar graph
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM09_bar_chart_annual_sum_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn sum energy vs baseline sum energy at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM09');
       title(title_name_baseline);
       xlabel('Years');
       ylabel('Energy [kWh]');
       hold on
       bar(No_of_years,Energy_baseline_annual_sum,'b');      
       hold on
       bar(No_of_years,Energy_future_2060s_RCM09_annual_sum,'c');
       hold on
       legend('Total annual baseline energy [kWh]','Total annual future 2060s energy [kWh]','Location','northeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);       
       
%% Plot the 2060s annual autumn mean daily power vs installed power RCM10
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM10_annual_mean_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn mean available power vs installed power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",' for RCM10');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Power [kW]');
       hold on
       plot(Years_2060s,Power_future_2060s_RCM10_annual_mean);
       hold on
       plot(Years_2060s,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available daily power [kW]','Installed power [kW]','Location','southeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);   
       
%% Plot the 2060s yearly autumn mean power vs baseline power for RCM10 as a bar graph
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM10_bar_chart_annual_mean_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn mean available power vs baseline power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM10');
       title(title_name_baseline);
       xlabel('Years');
       ylabel('Power [kW]');
       hold on
       bar(No_of_years,Power_baseline_annual_mean,'b');      
       hold on
       bar(No_of_years,Power_future_2060s_RCM10_annual_mean,'c');
       hold on
       plot(No_of_years,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available baseline power [kW]','Available future 2060s power [kW]','Installed power [kW]','Location','northeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);       
 
%% Plot the 2060s annual autumn sum energy output RCM10
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM10_annual_sum_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn total energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",' for RCM10');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Energy [kWh]');
       hold on
       plot(Years_2060s,Energy_future_2060s_RCM10_annual_sum);
       hold on
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);      
       
%% Plot the 2060s yearly autumn sum energy vs baseline sum energy for RCM10 as a bar graph
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM10_bar_chart_annual_sum_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn sum energy vs baseline sum energy at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM10');
       title(title_name_baseline);
       xlabel('Years');
       ylabel('Energy [kWh]');
       hold on
       bar(No_of_years,Energy_baseline_annual_sum,'b');      
       hold on
       bar(No_of_years,Energy_future_2060s_RCM10_annual_sum,'c');
       hold on
       legend('Total annual baseline energy [kWh]','Total annual future 2060s energy [kWh]','Location','northeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);       
 
%% Plot the 2060s annual autumn mean daily power vs installed power RCM11
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM11_annual_mean_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn mean available power vs installed power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",' for RCM11');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Power [kW]');
       hold on
       plot(Years_2060s,Power_future_2060s_RCM11_annual_mean);
       hold on
       plot(Years_2060s,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available daily power [kW]','Installed power [kW]','Location','southeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);   
       
%% Plot the 2060s yearly autumn  mean power vs baseline power for RCM11 as a bar graph
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM11_bar_chart_annual_mean_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn mean available power vs baseline power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM11');
       title(title_name_baseline);
       xlabel('Years');
       ylabel('Power [kW]');
       hold on
       bar(No_of_years,Power_baseline_annual_mean,'b');      
       hold on
       bar(No_of_years,Power_future_2060s_RCM11_annual_mean,'c');
       hold on
       plot(No_of_years,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available baseline power [kW]','Available future 2060s power [kW]','Installed power [kW]','Location','northeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);       
 
%% Plot the 2060s annual autumn sum energy output RCM11
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM11_annual_sum_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn total energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",' for RCM11');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Energy [kWh]');
       hold on
       plot(Years_2060s,Energy_future_2060s_RCM11_annual_sum);
       hold on
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);      
       
%% Plot the 2060s yearly autumn sum energy vs baseline sum energy for RCM11 as a bar graph
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM11_bar_chart_annual_sum_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn sum energy vs baseline sum energy at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM11');
       title(title_name_baseline);
       xlabel('Years');
       ylabel('Energy [kWh]');
       hold on
       bar(No_of_years,Energy_baseline_annual_sum,'b');      
       hold on
       bar(No_of_years,Energy_future_2060s_RCM11_annual_sum,'c');
       hold on
       legend('Total annual baseline energy [kWh]','Total annual future 2060s energy [kWh]','Location','northeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);       
 
%% Plot the 2060s annual autumn mean daily power vs installed power RCM12
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM12_annual_mean_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn mean available power vs installed power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",' for RCM12');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Power [kW]');
       hold on
       plot(Years_2060s,Power_future_2060s_RCM12_annual_mean);
       hold on
       plot(Years_2060s,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available daily power [kW]','Installed power [kW]','Location','southeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);   
       
%% Plot the 2060s yearly autumn mean power vs baseline power for RCM12 as a bar graph
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM12_bar_chart_annual_mean_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn mean available power vs baseline power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM12');
       title(title_name_baseline);
       xlabel('Years');
       ylabel('Power [kW]');
       hold on
       bar(No_of_years,Power_baseline_annual_mean,'b');      
       hold on
       bar(No_of_years,Power_future_2060s_RCM12_annual_mean,'c');
       hold on
       plot(No_of_years,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available baseline power [kW]','Available future 2060s power [kW]','Installed power [kW]','Location','northeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);       
 
%% Plot the 2060s annual autumn sum energy output RCM12
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM12_annual_sum_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn total energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",' for RCM12');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Energy [kWh]');
       hold on
       plot(Years_2060s,Energy_future_2060s_RCM12_annual_sum);
       hold on
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);      
       
%% Plot the 2060s yearly autumn sum energy vs baseline sum energy for RCM12 as a bar graph
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM12_bar_chart_annual_sum_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn sum energy vs baseline sum energy at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM12');
       title(title_name_baseline);
       xlabel('Years');
       ylabel('Energy [kWh]');
       hold on
       bar(No_of_years,Energy_baseline_annual_sum,'b');      
       hold on
       bar(No_of_years,Energy_future_2060s_RCM12_annual_sum,'c');
       hold on
       legend('Total annual baseline energy [kWh]','Total annual future 2060s energy [kWh]','Location','northeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);       
 
%% Plot the 2060s annual autumn mean daily power vs installed power RCM13
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM13_annual_mean_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn mean available power vs installed power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",' for RCM13');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Power [kW]');
       hold on
       plot(Years_2060s,Power_future_2060s_RCM13_annual_mean);
       hold on
       plot(Years_2060s,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available daily power [kW]','Installed power [kW]','Location','southeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);   
       
%% Plot the 2060s yearly autumn mean power vs baseline power for RCM13 as a bar graph
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM13_bar_chart_annual_mean_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn mean available power vs baseline power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM13');
       title(title_name_baseline);
       xlabel('Years');
       ylabel('Power [kW]');
       hold on
       bar(No_of_years,Power_baseline_annual_mean,'b');      
       hold on
       bar(No_of_years,Power_future_2060s_RCM13_annual_mean,'c');
       hold on
       plot(No_of_years,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available baseline power [kW]','Available future 2060s power [kW]','Installed power [kW]','Location','northeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);       
 
%% Plot the 2060s annual autumn sum energy output RCM13
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM13_annual_sum_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn total energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",' for RCM13');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Energy [kWh]');
       hold on
       plot(Years_2060s,Energy_future_2060s_RCM13_annual_sum);
       hold on
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);      
       
%% Plot the 2060s yearly autumn sum energy vs baseline sum energy for RCM13 as a bar graph
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM13_bar_chart_annual_sum_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn sum energy vs baseline sum energy at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM13');
       title(title_name_baseline);
       xlabel('Years');
       ylabel('Energy [kWh]');
       hold on
       bar(No_of_years,Energy_baseline_annual_sum,'b');      
       hold on
       bar(No_of_years,Energy_future_2060s_RCM13_annual_sum,'c');
       hold on
       legend('Total annual baseline energy [kWh]','Total annual future 2060s energy [kWh]','Location','northeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);       
 
%% Plot the 2060s annual autumn mean daily power vs installed power RCM15
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM15_annual_mean_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn mean available power vs installed power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",' for RCM15');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Power [kW]');
       hold on
       plot(Years_2060s,Power_future_2060s_RCM15_annual_mean);
       hold on
       plot(Years_2060s,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available daily power [kW]','Installed power [kW]','Location','southeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);   
       
%% Plot the 2060s yearly autumn mean power vs baseline power for RCM13 as a bar graph
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM13_bar_chart_annual_mean_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn mean available power vs baseline power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM13');
       title(title_name_baseline);
       xlabel('Years');
       ylabel('Power [kW]');
       hold on
       bar(No_of_years,Power_baseline_annual_mean,'b');      
       hold on
       bar(No_of_years,Power_future_2060s_RCM13_annual_mean,'c');
       hold on
       plot(No_of_years,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available baseline power [kW]','Available future 2060s power [kW]','Installed power [kW]','Location','northeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);       
 
%% Plot the 2060s annual autumn sum energy output RCM15
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM15_annual_sum_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn total energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",' for RCM15');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Energy [kWh]');
       hold on
       plot(Years_2060s,Energy_future_2060s_RCM15_annual_sum);
       hold on
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);      
       
%% Plot the 2060s yearly autumn sum energy vs baseline sum energy for RCM15 as a bar graph
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_RCM15_bar_chart_annual_sum_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn sum energy vs baseline sum energy at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM15');
       title(title_name_baseline);
       xlabel('Years');
       ylabel('Energy [kW]');
       hold on
       bar(No_of_years,Energy_baseline_annual_sum,'b');      
       hold on
       bar(No_of_years,Energy_future_2060s_RCM15_annual_sum,'c');
       hold on
       legend('Total annual baseline energy [kWh]','Total annual future 2060s energy [kWh]','Location','northeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
     
%% Plot the 2060s annual autumn mean daily power vs installed power for all RCMs
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_allRCM_annual_mean_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn mean available power vs installed power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for all RCMs');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Power [kW]');
       hold on
       plot(Years_2060s,Power_future_2060s_mean_annual);
       hold on
       plot(Years_2060s,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available daily power [kW]','Installed power [kW]','Location','southeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
       
%% Plot the 2060s yearly autumn mean power vs baseline power for all RCMs as a bar graph
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_allRCM_bar_chart_annual_mean_power_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn mean available power vs baseline power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for all RCMs');
       title(title_name_baseline);
       xlabel('Years');
       ylabel('Power [kW]');
       hold on
       bar(No_of_years,Power_baseline_annual_mean,'b');      
       hold on
       bar(No_of_years,Power_future_2060s_mean_annual,'c');
       hold on
       plot(No_of_years,Power_installed,'LineWidth',2,'Color','r');
       hold on
       legend('Available baseline power [kW]','Available future 2060s power [kW]','Installed power [kW]','Location','northeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);  
       
%% Plot the 2060s annual autumn sum energy output for all RCMs
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_allRCM_annual_sum_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn total energy output at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for all RCMs');
       title(title_name_baseline);
       xlabel('Time');
       ylabel('Energy [kWh]');
       hold on
       plot(Years_2060s,Energy_future_2060s_sum_annual);
       hold on
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);
       
%% Plot the 2060s yearly autumn sum energy vs baseline sum energy for all RCMs as a bar graph
       clf %clears figure information
       set(gca,'Box','on');
       Intake_ID=num2str(Micro_Intake_ID(i,1)); %get the Intake ID as a string to add to the tile and save file
       save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Future_2060s_autumn_allRCM_bar_chart_annual_sum_energy_Intake_',Intake_ID,'.png');
       title_name_baseline=strcat('Future 2060s annual autumn sum energy vs baseline sum energy at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for all RCMs');
       title(title_name_baseline);
       xlabel('Years');
       ylabel('Energy [kWh]');
       hold on
       bar(No_of_years,Energy_baseline_annual_sum,'b');      
       hold on
       bar(No_of_years,Energy_future_2060s_sum_annual,'c');
       hold on
       legend('Total annual baseline energy [kWh]','Total annual future 2060s energy [kWh]','Location','northeast');
       if exist(save_name_baseline, 'file')==2
            delete(save_name_baseline);
       end
       saveas(gcf,save_name_baseline);       
       
%% Add the baseline and future monthly power and energy output to a table and calculate the difference
 
Table_monthly=[];
 
for j=1:length(Months_baseline)
    Table_monthly{j,1}=Months_baseline(j,:);
    Table_monthly{j,2}=Power_baseline_monthly_mean(j,1);
    Table_monthly{j,3}=Energy_baseline_monthly_sum(j,1);
    Table_monthly{j,4}=Months_2060s(j,:);
 
    Table_monthly{j,5}=Power_future_2060s_RCM01_monthly_mean(j,1);
    Table_monthly{j,6}=Power_future_2060s_RCM04_monthly_mean(j,1);
    Table_monthly{j,7}=Power_future_2060s_RCM05_monthly_mean(j,1);
    Table_monthly{j,8}=Power_future_2060s_RCM06_monthly_mean(j,1);
    Table_monthly{j,9}=Power_future_2060s_RCM07_monthly_mean(j,1);
    Table_monthly{j,10}=Power_future_2060s_RCM08_monthly_mean(j,1);
    Table_monthly{j,11}=Power_future_2060s_RCM09_monthly_mean(j,1);
    Table_monthly{j,12}=Power_future_2060s_RCM10_monthly_mean(j,1);
    Table_monthly{j,13}=Power_future_2060s_RCM11_monthly_mean(j,1);
    Table_monthly{j,14}=Power_future_2060s_RCM12_monthly_mean(j,1);
    Table_monthly{j,15}=Power_future_2060s_RCM13_monthly_mean(j,1);
    Table_monthly{j,16}=Power_future_2060s_RCM15_monthly_mean(j,1);
 
    Table_monthly{j,17}=Energy_future_2060s_RCM01_monthly_sum(j,1);
    Table_monthly{j,18}=Energy_future_2060s_RCM04_monthly_sum(j,1);
    Table_monthly{j,19}=Energy_future_2060s_RCM05_monthly_sum(j,1);
    Table_monthly{j,20}=Energy_future_2060s_RCM06_monthly_sum(j,1);
    Table_monthly{j,21}=Energy_future_2060s_RCM07_monthly_sum(j,1);
    Table_monthly{j,22}=Energy_future_2060s_RCM08_monthly_sum(j,1);
    Table_monthly{j,23}=Energy_future_2060s_RCM09_monthly_sum(j,1);
    Table_monthly{j,24}=Energy_future_2060s_RCM10_monthly_sum(j,1);
    Table_monthly{j,25}=Energy_future_2060s_RCM11_monthly_sum(j,1);
    Table_monthly{j,26}=Energy_future_2060s_RCM12_monthly_sum(j,1);
    Table_monthly{j,27}=Energy_future_2060s_RCM13_monthly_sum(j,1);
    Table_monthly{j,28}=Energy_future_2060s_RCM15_monthly_sum(j,1);
 
    Table_monthly{j,29}=Power_future_2060s_allRCM_monthly_mean(j,1);
 
    Table_monthly{j,30}=Energy_future_2060s_allRCM_monthly_sum(j,1);
 
    Table_monthly{j,31}=(Power_baseline_monthly_mean(j,1)-Power_future_2060s_RCM01_monthly_mean(j,1))/Power_baseline_monthly_mean(j,1)*100;
    Power_dif_2060s_RCM01_monthly_mean(j,1)=(Power_baseline(j,1)-Power_future_2060s_RCM01_monthly_mean(j,1))/Power_baseline(j,1)*100;
    Table_monthly{j,32}=(Power_baseline_monthly_mean(j,1)-Power_future_2060s_RCM04_monthly_mean(j,1))/Power_baseline_monthly_mean(j,1)*100;
    Power_dif_2060s_RCM04_monthly_mean(j,1)=(Power_baseline(j,1)-Power_future_2060s_RCM04_monthly_mean(j,1))/Power_baseline(j,1)*100;
    Table_monthly{j,33}=(Power_baseline_monthly_mean(j,1)-Power_future_2060s_RCM05_monthly_mean(j,1))/Power_baseline_monthly_mean(j,1)*100;
    Power_dif_2060s_RCM05_monthly_mean(j,1)=(Power_baseline_monthly_mean(j,1)-Power_future_2060s_RCM05_monthly_mean(j,1))/Power_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,34}=(Power_baseline_monthly_mean(j,1)-Power_future_2060s_RCM06_monthly_mean(j,1))/Power_baseline_monthly_mean(j,1)*100;
    Power_dif_2060s_RCM06_monthly_mean(j,1)=(Power_baseline_monthly_mean(j,1)-Power_future_2060s_RCM06_monthly_mean(j,1))/Power_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,35}=(Power_baseline_monthly_mean(j,1)-Power_future_2060s_RCM07_monthly_mean(j,1))/Power_baseline_monthly_mean(j,1)*100;
    Power_dif_2060s_RCM07_monthly_mean(j,1)=(Power_baseline_monthly_mean(j,1)-Power_future_2060s_RCM07_monthly_mean(j,1))/Power_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,36}=(Power_baseline_monthly_mean(j,1)-Power_future_2060s_RCM08_monthly_mean(j,1))/Power_baseline_monthly_mean(j,1)*100;
    Power_dif_2060s_RCM08_monthly_mean(j,1)=(Power_baseline_monthly_mean(j,1)-Power_future_2060s_RCM08_monthly_mean(j,1))/Power_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,37}=(Power_baseline_monthly_mean(j,1)-Power_future_2060s_RCM09_monthly_mean(j,1))/Power_baseline_monthly_mean(j,1)*100;
    Power_dif_2060s_RCM09_monthly_mean(j,1)=(Power_baseline_monthly_mean(j,1)-Power_future_2060s_RCM09_monthly_mean(j,1))/Power_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,38}=(Power_baseline_monthly_mean(j,1)-Power_future_2060s_RCM10_monthly_mean(j,1))/Power_baseline_monthly_mean(j,1)*100;
    Power_dif_2060s_RCM10_monthly_mean(j,1)=(Power_baseline_monthly_mean(j,1)-Power_future_2060s_RCM10_monthly_mean(j,1))/Power_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,39}=(Power_baseline_monthly_mean(j,1)-Power_future_2060s_RCM11_monthly_mean(j,1))/Power_baseline_monthly_mean(j,1)*100;
    Power_dif_2060s_RCM11_monthly_mean(j,1)=(Power_baseline_monthly_mean(j,1)-Power_future_2060s_RCM11_monthly_mean(j,1))/Power_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,40}=(Power_baseline_monthly_mean(j,1)-Power_future_2060s_RCM12_monthly_mean(j,1))/Power_baseline_monthly_mean(j,1)*100;
    Power_dif_2060s_RCM12_monthly_mean(j,1)=(Power_baseline_monthly_mean(j,1)-Power_future_2060s_RCM12_monthly_mean(j,1))/Power_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,41}=(Power_baseline_monthly_mean(j,1)-Power_future_2060s_RCM13_monthly_mean(j,1))/Power_baseline_monthly_mean(j,1)*100;
    Power_dif_2060s_RCM13_monthly_mean(j,1)=(Power_baseline_monthly_mean(j,1)-Power_future_2060s_RCM13_monthly_mean(j,1))/Power_baseline_monthly_mean(j,1)*100;
    Table_monthly{j,42}=(Power_baseline_monthly_mean(j,1)-Power_future_2060s_RCM15_monthly_mean(j,1))/Power_baseline_monthly_mean(j,1)*100;
    Power_dif_2060s_RCM15_monthly_mean(j,1)=(Power_baseline_monthly_mean(j,1)-Power_future_2060s_RCM15_monthly_mean(j,1))/Power_baseline_monthly_mean(j,1)*100;
 
    Table_monthly{j,43}=(Energy_baseline_monthly_sum(j,1)-Energy_future_2060s_RCM01_monthly_sum(j,1))/Energy_baseline_monthly_sum(j,1)*100;
    Energy_dif_2060s_RCM01_monthly_sum(j,1)=(Energy_baseline_monthly_sum(j,1)-Energy_future_2060s_RCM01_monthly_sum(j,1))/Energy_baseline_monthly_sum(j,1)*100;
    Table_monthly{j,44}=(Energy_baseline_monthly_sum(j,1)-Energy_future_2060s_RCM04_monthly_sum(j,1))/Energy_baseline_monthly_sum(j,1)*100;
    Energy_dif_2060s_RCM04_monthly_sum(j,1)=(Energy_baseline_monthly_sum(j,1)-Energy_future_2060s_RCM04_monthly_sum(j,1))/Energy_baseline_monthly_sum(j,1)*100;
    Table_monthly{j,45}=(Energy_baseline_monthly_sum(j,1)-Energy_future_2060s_RCM05_monthly_sum(j,1))/Energy_baseline_monthly_sum(j,1)*100;
    Energy_dif_2060s_RCM05_monthly_sum(j,1)=(Energy_baseline_monthly_sum(j,1)-Energy_future_2060s_RCM05_monthly_sum(j,1))/Energy_baseline_monthly_sum(j,1)*100;
    Table_monthly{j,46}=(Energy_baseline_monthly_sum(j,1)-Energy_future_2060s_RCM06_monthly_sum(j,1))/Energy_baseline_monthly_sum(j,1)*100;
    Energy_dif_2060s_RCM06_monthly_sum(j,1)=(Energy_baseline_monthly_sum(j,1)-Energy_future_2060s_RCM06_monthly_sum(j,1))/Energy_baseline_monthly_sum(j,1)*100;
    Table_monthly{j,47}=(Energy_baseline_monthly_sum(j,1)-Energy_future_2060s_RCM07_monthly_sum(j,1))/Energy_baseline_monthly_sum(j,1)*100;
    Energy_dif_2060s_RCM07_monthly_sum(j,1)=(Energy_baseline_monthly_sum(j,1)-Energy_future_2060s_RCM07_monthly_sum(j,1))/Energy_baseline_monthly_sum(j,1)*100;
    Table_monthly{j,48}=(Energy_baseline_monthly_sum(j,1)-Energy_future_2060s_RCM08_monthly_sum(j,1))/Energy_baseline_monthly_sum(j,1)*100;
    Energy_dif_2060s_RCM08_monthly_sum(j,1)=(Energy_baseline_monthly_sum(j,1)-Energy_future_2060s_RCM08_monthly_sum(j,1))/Energy_baseline_monthly_sum(j,1)*100;
    Table_monthly{j,49}=(Energy_baseline_monthly_sum(j,1)-Energy_future_2060s_RCM09_monthly_sum(j,1))/Energy_baseline_monthly_sum(j,1)*100;
    Energy_dif_2060s_RCM09_monthly_sum(j,1)=(Energy_baseline_monthly_sum(j,1)-Energy_future_2060s_RCM09_monthly_sum(j,1))/Energy_baseline_monthly_sum(j,1)*100;
    Table_monthly{j,50}=(Energy_baseline_monthly_sum(j,1)-Energy_future_2060s_RCM10_monthly_sum(j,1))/Energy_baseline_monthly_sum(j,1)*100;
    Energy_dif_2060s_RCM10_monthly_sum(j,1)=(Energy_baseline_monthly_sum(j,1)-Energy_future_2060s_RCM10_monthly_sum(j,1))/Energy_baseline_monthly_sum(j,1)*100;
    Table_monthly{j,51}=(Energy_baseline_monthly_sum(j,1)-Energy_future_2060s_RCM11_monthly_sum(j,1))/Energy_baseline_monthly_sum(j,1)*100;
    Energy_dif_2060s_RCM11_monthly_sum(j,1)=(Energy_baseline_monthly_sum(j,1)-Energy_future_2060s_RCM11_monthly_sum(j,1))/Energy_baseline_monthly_sum(j,1)*100;
    Table_monthly{j,52}=(Energy_baseline_monthly_sum(j,1)-Energy_future_2060s_RCM12_monthly_sum(j,1))/Energy_baseline_monthly_sum(j,1)*100;
    Energy_dif_2060s_RCM12_monthly_sum(j,1)=(Energy_baseline_monthly_sum(j,1)-Energy_future_2060s_RCM12_monthly_sum(j,1))/Energy_baseline_monthly_sum(j,1)*100;
    Table_monthly{j,53}=(Energy_baseline_monthly_sum(j,1)-Energy_future_2060s_RCM13_monthly_sum(j,1))/Energy_baseline_monthly_sum(j,1)*100;
    Energy_dif_2060s_RCM13_monthly_sum(j,1)=(Energy_baseline_monthly_sum(j,1)-Energy_future_2060s_RCM13_monthly_sum(j,1))/Energy_baseline_monthly_sum(j,1)*100;
    Table_monthly{j,54}=(Energy_baseline_monthly_sum(j,1)-Energy_future_2060s_RCM15_monthly_sum(j,1))/Energy_baseline_monthly_sum(j,1)*100;
    Energy_dif_2060s_RCM15_monthly_sum(j,1)=(Energy_baseline_monthly_sum(j,1)-Energy_future_2060s_RCM15_monthly_sum(j,1))/Energy_baseline_monthly_sum(j,1)*100;
 
    Table_monthly{j,55}=(Power_baseline_monthly_mean(j,1)-Power_future_2060s_allRCM_monthly_mean(j,1))/Power_baseline_monthly_mean(j,1)*100;
    Power_dif_2060s_monthly_mean(j,1)=(Power_baseline_monthly_mean(j,1)-Power_future_2060s_allRCM_monthly_mean(j,1))/Power_baseline_monthly_mean(j,1)*100;
 
    Table_monthly{j,56}=(Energy_baseline_monthly_sum(j,1)-Energy_future_2060s_allRCM_monthly_sum(j,1))/Energy_baseline_monthly_sum(j,1)*100; 
    Energy_dif_2060s_monthly_sum(j,1)=(Energy_baseline_monthly_sum(j,1)-Energy_future_2060s_allRCM_monthly_sum(j,1))/Energy_baseline_monthly_sum(j,1)*100;
 
end
 
Table_monthly_header={'Baseline','Baseline monthly autumn available power [kW]','Baseline monthly autumn energy output [kWh]','Future','RCM01 monthly autumn available power [kW]','RCM04 monthly autumn available power [kW]','RCM05 monthly autumn available power [kW]','RCM06 monthly autumn available power [kW]','RCM07 monthly autumn available power [kW]','RCM08 Table_monthly autumn available power [kW]','RCM09 monthly autumn available power [kW]','RCM10 monthly autumn available power [kW]','RCM11 monthly autumn available power [kW]','RCM12 monthly autumn available power [kW]','RCM13 monthly autumn available power [kW]','RCM15 monthly autumn available power [kW]','RCM01 monthly autumn energy output [kWh]','RCM04 monthly autumn energy output [kWh]','RCM05 monthly autumn energy output [kWh]','RCM06 monthly autumn energy output [kWh]','RCM07 monthly autumn energy output [kWh]','RCM08 monthly autumn energy output [kWh]','RCM09 monthly autumn energy output [kWh]','RCM10 monthly autumn energy output [kWh]','RCM11 monthly autumn energy output [kWh]','RCM12 monthly autumn energy output [kWh]','RCM13 monthly autumn energy output [kWh]','RCM15 monthly autumn energy output [kWh]','Future mean monthly autumn available power [kW]','Future sum monthly autumn energy output [kWh]','RCM01-Baseline Power [%]','RCM04-Baseline Power [%]','RCM05-Baseline Power [%]','RCM06-Baseline Power [%]','RCM07-Baseline Power [%]','RCM08-Baseline Power [%]','RCM09-Baseline Power [%]','RCM10-Baseline Power [%]' ,'RCM11-Baseline Power [%]','RCM12-Baseline Power [%]','RCM13-Baseline Power [%]','RCM15-Baseline Power [%]','RCM01-Baseline Energy output [%]','RCM04-Baseline Energy output [%]','RCM05-Baseline Energy output [%]','RCM06-Baseline Energy output [%]','RCM07-Baseline Energy output [%]','RCM08-Baseline Energy output [%]','RCM09-Baseline Energy output [%]','RCM10-Baseline Energy output [%]' ,'RCM11-Baseline Energy output [%]','RCM12-Baseline Energy output [%]','RCM13-Baseline Energy output [%]','RCM15-Baseline Energy output [%]','Future mean-Baseline Power [%]','Future sum-Baseline Energy output [%]'};
 
%Write the table into an excel file
 
if exist(strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Autumn\Intake_',Intake_ID,'_power_and_energy_2060s_monthly_vs_baseline.xls'), 'file')==2
   delete(strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Autumn\Intake_',Intake_ID,'_power_and_energy_2060s_monthly_vs_baseline.xls'));
end
 
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Autumn\Intake_',Intake_ID,'_power_and_energy_2060s_monthly_vs_baseline.xls'),Table_monthly,'Sheet1','A2');
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Autumn\Intake_',Intake_ID,'_power_and_energy_2060s_monthly_vs_baseline.xls'),Table_monthly_header,'Sheet1','A1');
 
%% Plot the differences in monthly autumn power and output
 
No_of_months=[1:length(Months_baseline)];
No_of_months=No_of_months.';
x_max=length(No_of_months);
 
ymin=-300;
ymax=+300;
 
X_line_zero=zeros(length(No_of_months),1);
 
%% Difference in monthly autumn power for RCM01
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Monthly_autumn_2060s_power_diff_RCM01_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s monthly autumn available power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM01');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Power_dif_2060s_RCM01_monthly_mean);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in monthly autumn power for RCM04
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Monthly_autumn_2060s_power_diff_RCM04_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s monthly autumn available power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM04');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Power_dif_2060s_RCM04_monthly_mean);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in monthly autumn power for RCM05
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Monthly_autumn_2060s_power_diff_RCM05_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s monthly autumn available power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM05');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Power_dif_2060s_RCM05_monthly_mean);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in monthly autumn power for RCM06
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Monthly_autumn_2060s_power_diff_RCM06_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s monthly autumn available power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM06');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Power_dif_2060s_RCM06_monthly_mean);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in monthly autumn power for RCM07
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Monthly_autumn_2060s_power_diff_RCM07_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s monthly autumn available power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM07');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Power_dif_2060s_RCM07_monthly_mean);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in monthly autumn power for RCM08
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Monthly_autumn_2060s_power_diff_RCM08_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s monthly autumn available power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM08');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Power_dif_2060s_RCM08_monthly_mean);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in monthly autumn power for RCM09
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Monthly_autumn_2060s_power_diff_RCM09_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s monthly autumn available power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM09');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Power_dif_2060s_RCM09_monthly_mean);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in monthly autumn power for RCM10
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Monthly_autumn_2060s_power_diff_RCM10_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s monthly autumn available power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM10');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Power_dif_2060s_RCM10_monthly_mean);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in monthly autumn power for RCM11
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Monthly_autumn_2060s_power_diff_RCM11_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s monthly autumn available power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM11');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Power_dif_2060s_RCM11_monthly_mean);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in monthly autumn power for RCM12
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Monthly_autumn_2060s_power_diff_RCM12_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s monthly autumn available power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM12');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Power_dif_2060s_RCM12_monthly_mean);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in monthly autumn power for RCM13
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Monthly_autumn_2060s_power_diff_RCM13_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s monthly autumn available power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM13');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Power_dif_2060s_RCM13_monthly_mean);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in monthly autumn power for RCM15
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Monthly_autumn_2060s_power_diff_RCM15_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s monthly autumn available power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM15');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Power_dif_2060s_RCM15_monthly_mean);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in mean monthly autumn power
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Monthly_autumn_2060s_power_diff_mean_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s mean monthly autumn available power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for all RCMs');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Power_dif_2060s_monthly_mean);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Plot the differences in monthly autumn energy sum output
 
No_of_months=[1:length(Months_baseline)];
No_of_months=No_of_months.';
x_max=length(No_of_months);
 
%% Difference in monthly autumn sum energy for RCM01
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Monthly_autumn_2060s_energy_diff_RCM01_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s monthly autumn sum energy at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM01');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Energy_dif_2060s_RCM01_monthly_sum);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in monthly autumn sum energy for RCM04
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Monthly_autumn_2060s_energy_diff_RCM04_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s monthly autumn sum energy at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM04');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Energy_dif_2060s_RCM04_monthly_sum);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in monthly autumn sum energy for RCM05
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Monthly_autumn_2060s_energy_diff_RCM05_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s monthly autumn sum energy at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM05');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Energy_dif_2060s_RCM05_monthly_sum);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in monthly autumn sum energy for RCM06
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Monthly_autumn_2060s_energy_diff_RCM06_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s monthly autumn sum energy at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM06');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Energy_dif_2060s_RCM06_monthly_sum);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in monthly autumn sum energy for RCM07
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Monthly_autumn_2060s_energy_diff_RCM07_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s monthly autumn sum energy at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM07');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Energy_dif_2060s_RCM07_monthly_sum);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in monthly autumn sum energy for RCM08
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Monthly_autumn_2060s_energy_diff_RCM08_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s monthly autumn sum energy at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM08');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Energy_dif_2060s_RCM08_monthly_sum);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in monthly autumn sum energy for RCM09
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Monthly_autumn_2060s_energy_diff_RCM09_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s monthly autumn sum energy at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM09');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Energy_dif_2060s_RCM09_monthly_sum);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in monthly autumn sum energy for RCM10
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Monthly_autumn_2060s_energy_diff_RCM10_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s monthly autumn sum energy at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM10');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Energy_dif_2060s_RCM10_monthly_sum);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in monthly autumn sum energy for RCM11
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Monthly_autumn_2060s_energy_diff_RCM11_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s monthly autumn sum energy at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM11');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Energy_dif_2060s_RCM11_monthly_sum);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in monthly autumn sum energy for RCM12
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Monthly_autumn_2060s_energy_diff_RCM12_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s monthly autumn sum energy at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM12');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Energy_dif_2060s_RCM12_monthly_sum);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in monthly autumn sum energy for RCM13
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Monthly_autumn_2060s_energy_diff_RCM13_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s monthly autumn sum energy at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM13');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Energy_dif_2060s_RCM13_monthly_sum);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in monthly autumn sum energy for RCM15
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Monthly_autumn_2060s_energy_diff_RCM15_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s monthly autumn sum energy at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM15');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Energy_dif_2060s_RCM15_monthly_sum);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in mean monthly autumn sum energy
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Monthly_autumn_2060s_energy_diff_mean_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s monthly autumn sum energy at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for all RCMs');
title(title_name_baseline);
xlabel('Months');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_months,Energy_dif_2060s_monthly_sum);
hold on
plot(No_of_months,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
    
%% Add the baseline and future annual autumn power and energy output to a table and calculate the difference
 
Table_annual=[];
 
for j=1:length(Years_baseline)
    Table_annual{j,1}=Months_baseline(j,:);
    Table_annual{j,2}=Power_baseline_annual_mean(j,1);
    Table_annual{j,3}=Energy_baseline_annual_sum(j,1);
    Table_annual{j,4}=Months_2060s(j,:);
 
    Table_annual{j,5}=Power_future_2060s_RCM01_annual_mean(j,1);
    Table_annual{j,6}=Power_future_2060s_RCM04_annual_mean(j,1);
    Table_annual{j,7}=Power_future_2060s_RCM05_annual_mean(j,1);
    Table_annual{j,8}=Power_future_2060s_RCM06_annual_mean(j,1);
    Table_annual{j,9}=Power_future_2060s_RCM07_annual_mean(j,1);
    Table_annual{j,10}=Power_future_2060s_RCM08_annual_mean(j,1);
    Table_annual{j,11}=Power_future_2060s_RCM09_annual_mean(j,1);
    Table_annual{j,12}=Power_future_2060s_RCM10_annual_mean(j,1);
    Table_annual{j,13}=Power_future_2060s_RCM11_annual_mean(j,1);
    Table_annual{j,14}=Power_future_2060s_RCM12_annual_mean(j,1);
    Table_annual{j,15}=Power_future_2060s_RCM13_annual_mean(j,1);
    Table_annual{j,16}=Power_future_2060s_RCM15_annual_mean(j,1);
 
    Table_annual{j,17}=Energy_future_2060s_RCM01_annual_sum(j,1);
    Table_annual{j,18}=Energy_future_2060s_RCM04_annual_sum(j,1);
    Table_annual{j,19}=Energy_future_2060s_RCM05_annual_sum(j,1);
    Table_annual{j,20}=Energy_future_2060s_RCM06_annual_sum(j,1);
    Table_annual{j,21}=Energy_future_2060s_RCM07_annual_sum(j,1);
    Table_annual{j,22}=Energy_future_2060s_RCM08_annual_sum(j,1);
    Table_annual{j,23}=Energy_future_2060s_RCM09_annual_sum(j,1);
    Table_annual{j,24}=Energy_future_2060s_RCM10_annual_sum(j,1);
    Table_annual{j,25}=Energy_future_2060s_RCM11_annual_sum(j,1);
    Table_annual{j,26}=Energy_future_2060s_RCM12_annual_sum(j,1);
    Table_annual{j,27}=Energy_future_2060s_RCM13_annual_sum(j,1);
    Table_annual{j,28}=Energy_future_2060s_RCM15_annual_sum(j,1);
 
    Table_annual{j,29}=Power_future_2060s_allRCM_annual_mean(j,1);
 
    Table_annual{j,30}=Energy_future_2060s_allRCM_annual_sum(j,1);
 
    Table_annual{j,31}=(Power_baseline_annual_mean(j,1)-Power_future_2060s_RCM01_annual_mean(j,1))/Power_baseline_annual_mean(j,1)*100;
    Power_dif_2060s_RCM01_annual_mean(j,1)=(Power_baseline(j,1)-Power_future_2060s_RCM01_annual_mean(j,1))/Power_baseline(j,1)*100;
    Table_annual{j,32}=(Power_baseline_annual_mean(j,1)-Power_future_2060s_RCM04_annual_mean(j,1))/Power_baseline_annual_mean(j,1)*100;
    Power_dif_2060s_RCM04_annual_mean(j,1)=(Power_baseline(j,1)-Power_future_2060s_RCM04_annual_mean(j,1))/Power_baseline(j,1)*100;
    Table_annual{j,33}=(Power_baseline_annual_mean(j,1)-Power_future_2060s_RCM05_annual_mean(j,1))/Power_baseline_annual_mean(j,1)*100;
    Power_dif_2060s_RCM05_annual_mean(j,1)=(Power_baseline_annual_mean(j,1)-Power_future_2060s_RCM05_annual_mean(j,1))/Power_baseline_annual_mean(j,1)*100;
    Table_annual{j,34}=(Power_baseline_annual_mean(j,1)-Power_future_2060s_RCM06_annual_mean(j,1))/Power_baseline_annual_mean(j,1)*100;
    Power_dif_2060s_RCM06_annual_mean(j,1)=(Power_baseline_annual_mean(j,1)-Power_future_2060s_RCM06_annual_mean(j,1))/Power_baseline_annual_mean(j,1)*100;
    Table_annual{j,35}=(Power_baseline_annual_mean(j,1)-Power_future_2060s_RCM07_annual_mean(j,1))/Power_baseline_annual_mean(j,1)*100;
    Power_dif_2060s_RCM07_annual_mean(j,1)=(Power_baseline_annual_mean(j,1)-Power_future_2060s_RCM07_annual_mean(j,1))/Power_baseline_annual_mean(j,1)*100;
    Table_annual{j,36}=(Power_baseline_annual_mean(j,1)-Power_future_2060s_RCM08_annual_mean(j,1))/Power_baseline_annual_mean(j,1)*100;
    Power_dif_2060s_RCM08_annual_mean(j,1)=(Power_baseline_annual_mean(j,1)-Power_future_2060s_RCM08_annual_mean(j,1))/Power_baseline_annual_mean(j,1)*100;
    Table_annual{j,37}=(Power_baseline_annual_mean(j,1)-Power_future_2060s_RCM09_annual_mean(j,1))/Power_baseline_annual_mean(j,1)*100;
    Power_dif_2060s_RCM09_annual_mean(j,1)=(Power_baseline_annual_mean(j,1)-Power_future_2060s_RCM09_annual_mean(j,1))/Power_baseline_annual_mean(j,1)*100;
    Table_annual{j,38}=(Power_baseline_annual_mean(j,1)-Power_future_2060s_RCM10_annual_mean(j,1))/Power_baseline_annual_mean(j,1)*100;
    Power_dif_2060s_RCM10_annual_mean(j,1)=(Power_baseline_annual_mean(j,1)-Power_future_2060s_RCM10_annual_mean(j,1))/Power_baseline_annual_mean(j,1)*100;
    Table_annual{j,39}=(Power_baseline_annual_mean(j,1)-Power_future_2060s_RCM11_annual_mean(j,1))/Power_baseline_annual_mean(j,1)*100;
    Power_dif_2060s_RCM11_annual_mean(j,1)=(Power_baseline_annual_mean(j,1)-Power_future_2060s_RCM11_annual_mean(j,1))/Power_baseline_annual_mean(j,1)*100;
    Table_annual{j,40}=(Power_baseline_annual_mean(j,1)-Power_future_2060s_RCM12_annual_mean(j,1))/Power_baseline_annual_mean(j,1)*100;
    Power_dif_2060s_RCM12_annual_mean(j,1)=(Power_baseline_annual_mean(j,1)-Power_future_2060s_RCM12_annual_mean(j,1))/Power_baseline_annual_mean(j,1)*100;
    Table_annual{j,41}=(Power_baseline_annual_mean(j,1)-Power_future_2060s_RCM13_annual_mean(j,1))/Power_baseline_annual_mean(j,1)*100;
    Power_dif_2060s_RCM13_annual_mean(j,1)=(Power_baseline_annual_mean(j,1)-Power_future_2060s_RCM13_annual_mean(j,1))/Power_baseline_annual_mean(j,1)*100;
    Table_annual{j,42}=(Power_baseline_annual_mean(j,1)-Power_future_2060s_RCM15_annual_mean(j,1))/Power_baseline_annual_mean(j,1)*100;
    Power_dif_2060s_RCM15_annual_mean(j,1)=(Power_baseline_annual_mean(j,1)-Power_future_2060s_RCM15_annual_mean(j,1))/Power_baseline_annual_mean(j,1)*100;
 
    Table_annual{j,43}=(Energy_baseline_annual_sum(j,1)-Energy_future_2060s_RCM01_annual_sum(j,1))/Energy_baseline_annual_sum(j,1)*100;
    Energy_dif_2060s_RCM01_annual_sum(j,1)=(Energy_baseline_annual_sum(j,1)-Energy_future_2060s_RCM01_annual_sum(j,1))/Energy_baseline_annual_sum(j,1)*100;
    Table_annual{j,44}=(Energy_baseline_annual_sum(j,1)-Energy_future_2060s_RCM04_annual_sum(j,1))/Energy_baseline_annual_sum(j,1)*100;
    Energy_dif_2060s_RCM04_annual_sum(j,1)=(Energy_baseline_annual_sum(j,1)-Energy_future_2060s_RCM04_annual_sum(j,1))/Energy_baseline_annual_sum(j,1)*100;
    Table_annual{j,45}=(Energy_baseline_annual_sum(j,1)-Energy_future_2060s_RCM05_annual_sum(j,1))/Energy_baseline_annual_sum(j,1)*100;
    Energy_dif_2060s_RCM05_annual_sum(j,1)=(Energy_baseline_annual_sum(j,1)-Energy_future_2060s_RCM05_annual_sum(j,1))/Energy_baseline_annual_sum(j,1)*100;
    Table_annual{j,46}=(Energy_baseline_annual_sum(j,1)-Energy_future_2060s_RCM06_annual_sum(j,1))/Energy_baseline_annual_sum(j,1)*100;
    Energy_dif_2060s_RCM06_annual_sum(j,1)=(Energy_baseline_annual_sum(j,1)-Energy_future_2060s_RCM06_annual_sum(j,1))/Energy_baseline_annual_sum(j,1)*100;
    Table_annual{j,47}=(Energy_baseline_annual_sum(j,1)-Energy_future_2060s_RCM07_annual_sum(j,1))/Energy_baseline_annual_sum(j,1)*100;
    Energy_dif_2060s_RCM07_annual_sum(j,1)=(Energy_baseline_annual_sum(j,1)-Energy_future_2060s_RCM07_annual_sum(j,1))/Energy_baseline_annual_sum(j,1)*100;
    Table_annual{j,48}=(Energy_baseline_annual_sum(j,1)-Energy_future_2060s_RCM08_annual_sum(j,1))/Energy_baseline_annual_sum(j,1)*100;
    Energy_dif_2060s_RCM08_annual_sum(j,1)=(Energy_baseline_annual_sum(j,1)-Energy_future_2060s_RCM08_annual_sum(j,1))/Energy_baseline_annual_sum(j,1)*100;
    Table_annual{j,49}=(Energy_baseline_annual_sum(j,1)-Energy_future_2060s_RCM09_annual_sum(j,1))/Energy_baseline_annual_sum(j,1)*100;
    Energy_dif_2060s_RCM09_annual_sum(j,1)=(Energy_baseline_annual_sum(j,1)-Energy_future_2060s_RCM09_annual_sum(j,1))/Energy_baseline_annual_sum(j,1)*100;
    Table_annual{j,50}=(Energy_baseline_annual_sum(j,1)-Energy_future_2060s_RCM10_annual_sum(j,1))/Energy_baseline_annual_sum(j,1)*100;
    Energy_dif_2060s_RCM10_annual_sum(j,1)=(Energy_baseline_annual_sum(j,1)-Energy_future_2060s_RCM10_annual_sum(j,1))/Energy_baseline_annual_sum(j,1)*100;
    Table_annual{j,51}=(Energy_baseline_annual_sum(j,1)-Energy_future_2060s_RCM11_annual_sum(j,1))/Energy_baseline_annual_sum(j,1)*100;
    Energy_dif_2060s_RCM11_annual_sum(j,1)=(Energy_baseline_annual_sum(j,1)-Energy_future_2060s_RCM11_annual_sum(j,1))/Energy_baseline_annual_sum(j,1)*100;
    Table_annual{j,52}=(Energy_baseline_annual_sum(j,1)-Energy_future_2060s_RCM12_annual_sum(j,1))/Energy_baseline_annual_sum(j,1)*100;
    Energy_dif_2060s_RCM12_annual_sum(j,1)=(Energy_baseline_annual_sum(j,1)-Energy_future_2060s_RCM12_annual_sum(j,1))/Energy_baseline_annual_sum(j,1)*100;
    Table_annual{j,53}=(Energy_baseline_annual_sum(j,1)-Energy_future_2060s_RCM13_annual_sum(j,1))/Energy_baseline_annual_sum(j,1)*100;
    Energy_dif_2060s_RCM13_annual_sum(j,1)=(Energy_baseline_annual_sum(j,1)-Energy_future_2060s_RCM13_annual_sum(j,1))/Energy_baseline_annual_sum(j,1)*100;
    Table_annual{j,54}=(Energy_baseline_annual_sum(j,1)-Energy_future_2060s_RCM15_annual_sum(j,1))/Energy_baseline_annual_sum(j,1)*100;
    Energy_dif_2060s_RCM15_annual_sum(j,1)=(Energy_baseline_annual_sum(j,1)-Energy_future_2060s_RCM15_annual_sum(j,1))/Energy_baseline_annual_sum(j,1)*100;
 
    Table_annual{j,55}=(Power_baseline_annual_mean(j,1)-Power_future_2060s_allRCM_annual_mean(j,1))/Power_baseline_annual_mean(j,1)*100;
    Power_dif_2060s_annual_mean(j,1)=(Power_baseline_annual_mean(j,1)-Power_future_2060s_allRCM_annual_mean(j,1))/Power_baseline_annual_mean(j,1)*100;
 
    Table_annual{j,56}=(Energy_baseline_annual_sum(j,1)-Energy_future_2060s_allRCM_annual_sum(j,1))/Energy_baseline_annual_sum(j,1)*100; 
    Energy_dif_2060s_annual_sum(j,1)=(Energy_baseline_annual_sum(j,1)-Energy_future_2060s_allRCM_annual_sum(j,1))/Energy_baseline_annual_sum(j,1)*100;
 
end
 
Table_annual_header={'Baseline','Baseline annual autumn available power [kW]','Baseline annual autumn energy output [kWh]','Future','RCM01 annual autumn available power [kW]','RCM04 annual autumn available power [kW]','RCM05 annual autumn available power [kW]','RCM06 annual autumn available power [kW]','RCM07 annual autumn available power [kW]','RCM08 annual autumn available power [kW]','RCM09 annual autumn available power [kW]','RCM10 annual autumn available power [kW]','RCM11 annual autumn available power [kW]','RCM12 annual autumn available power [kW]','RCM13 annual autumn available power [kW]','RCM15 annual autumn available power [kW]','RCM01 annual autumn energy output [kWh]','RCM04 annual autumn energy output [kWh]','RCM05 annual autumn energy output [kWh]','RCM06 annual autumn energy output [kWh]','RCM07 annual autumn energy output [kWh]','RCM08 annual autumn energy output [kWh]','RCM09 annual autumn energy output [kWh]','RCM10 annual autumn energy output [kWh]','RCM11 annual autumn energy output [kWh]','RCM12 annual autumn energy output [kWh]','RCM13 annual autumn energy output [kWh]','RCM15 annual autumn energy output [kWh]','Future mean annual autumn available power [kW]','Future sum annual autumn energy output [kWh]','RCM01-Baseline Power [%]','RCM04-Baseline Power [%]','RCM05-Baseline Power [%]','RCM06-Baseline Power [%]','RCM07-Baseline Power [%]','RCM08-Baseline Power [%]','RCM09-Baseline Power [%]','RCM10-Baseline Power [%]' ,'RCM11-Baseline Power [%]','RCM12-Baseline Power [%]','RCM13-Baseline Power [%]','RCM15-Baseline Power [%]','RCM01-Baseline Energy output [%]','RCM04-Baseline Energy output [%]','RCM05-Baseline Energy output [%]','RCM06-Baseline Energy output [%]','RCM07-Baseline Energy output [%]','RCM08-Baseline Energy output [%]','RCM09-Baseline Energy output [%]','RCM10-Baseline Energy output [%]' ,'RCM11-Baseline Energy output [%]','RCM12-Baseline Energy output [%]','RCM13-Baseline Energy output [%]','RCM15-Baseline Energy output [%]','Future mean-Baseline Power [%]','Future sum-Baseline Energy output [%]'};
 
%Write the table into an excel file
 
if exist(strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Autumn\Intake_',Intake_ID,'_power_and_energy_2060s_annual_vs_baseline.xls'), 'file')==2
   delete(strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Autumn\Intake_',Intake_ID,'_power_and_energy_2060s_annual_vs_baseline.xls'));
end
 
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Autumn\Intake_',Intake_ID,'_power_and_energy_2060s_annual_vs_baseline.xls'),Table_annual,'Sheet1','A2');
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Autumn\Intake_',Intake_ID,'_power_and_energy_2060s_annual_vs_baseline.xls'),Table_annual_header,'Sheet1','A1');
 
%% Plot the differences in annual power and output
 
No_of_years=[1:length(Years_baseline)];
No_of_years=No_of_years.';
x_max=length(No_of_years);
 
ymin=-100;
ymax=+100;
 
X_line_zero=zeros(length(No_of_years),1);
 
%% Difference in annual autumn power for RCM01
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Annual_autumn_power_2060s_diff_RCM01_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s annual autumn available power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM01');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Power_dif_2060s_RCM01_annual_mean);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in annual autumn power for RCM04
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Annual_autumn_power_2060s_diff_RCM04_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s annual autumn available power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM04');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Power_dif_2060s_RCM04_annual_mean);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in annual autumn power for RCM05
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Annual_autumn_power_2060s_diff_RCM05_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s annual autumn available power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM05');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Power_dif_2060s_RCM05_annual_mean);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in annual autumn power for RCM06
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Annual_autumn_power_2060s_diff_RCM06_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s annual autumn available power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM06');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Power_dif_2060s_RCM06_annual_mean);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in annual autumn power for RCM07
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Annual_autumn_power_2060s_diff_RCM07_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s annual autumn available power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM07');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Power_dif_2060s_RCM07_annual_mean);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in annual autumn power for RCM08
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Annual_autumn_power_2060s_diff_RCM08_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s annual autumn available power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM08');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Power_dif_2060s_RCM08_annual_mean);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in annual autumn power for RCM09
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Annual_autumn_power_2060s_diff_RCM09_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s annual autumn available power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM09');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Power_dif_2060s_RCM09_annual_mean);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in annual autumn power for RCM10
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Annual_autumn_power_2060s_diff_RCM10_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s annual autumn available power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM10');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Power_dif_2060s_RCM10_annual_mean);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in annual autumn power for RCM11
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Annual_autumn_power_2060s_diff_RCM11_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s annual autumn available power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM11');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Power_dif_2060s_RCM11_annual_mean);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in annual autumn power for RCM12
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Annual_autumn_power_2060s_diff_RCM12_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s annual autumn available power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM12');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Power_dif_2060s_RCM12_annual_mean);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in annual autumn power for RCM13
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Annual_autumn_power_2060s_diff_RCM13_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s annual autumn available power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM13');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Power_dif_2060s_RCM13_annual_mean);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in annual autumn power for RCM15
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Annual_autumn_power_2060s_diff_RCM15_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s annual autumn available power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM15');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Power_dif_2060s_RCM15_annual_mean);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in mean annual autumn power
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Annual_autumn_power_2060s_diff_mean_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s mean annual autumn available power at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for all RCMs');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Power_dif_2060s_annual_mean);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Plot the differences in annual energy sum output
 
No_of_years=[1:length(Years_baseline)];
No_of_years=No_of_years.';
x_max=length(No_of_years);
 
y_min=-100;
ymax=100;
 
%% Difference in annual autumn energy for RCM01
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Annual_autumn_energy_2060s_diff_RCM01_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s annual autumn sum energy at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM01');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Energy_dif_2060s_RCM01_annual_sum);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in annual autumn energy for RCM04
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Annual_autumn_energy_2060s_diff_RCM04_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s annual autumn sum energy at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM04');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Energy_dif_2060s_RCM04_annual_sum);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in annual autumn energy for RCM05
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Annual_autumn_energy_2060s_diff_RCM05_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s annual autumn sum energy at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM05');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Energy_dif_2060s_RCM05_annual_sum);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in annual autumn energy for RCM06
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Annual_autumn_energy_2060s_diff_RCM06_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s annual autumn sum energy at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM06');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Energy_dif_2060s_RCM06_annual_sum);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in annual autumn energy for RCM07
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Annual_autumn_energy_2060s_diff_RCM07_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s annual autumn sum energy at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM07');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Energy_dif_2060s_RCM07_annual_sum);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in annual autumn energy for RCM08
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Annual_autumn_energy_2060s_diff_RCM08_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s annual autumn sum energy at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM08');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Energy_dif_2060s_RCM08_annual_sum);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in annual autumn energy for RCM09
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Annual_autumn_energy_2060s_diff_RCM09_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s annual autumn sum energy at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM09');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Energy_dif_2060s_RCM09_annual_sum);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in annual autumn energy for RCM10
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Annual_autumn_energy_2060s_diff_RCM10_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s annual autumn sum energy at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM10');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Energy_dif_2060s_RCM10_annual_sum);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in annual autumn energy for RCM11
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Annual_autumn_energy_2060s_diff_RCM11_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s annual autumn sum energy at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM11');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Energy_dif_2060s_RCM11_annual_sum);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in annual autumn energy for RCM12
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Annual_autumn_energy_2060s_diff_RCM12_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s annual autumn sum energy at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM12');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Energy_dif_2060s_RCM12_annual_sum);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in annual autumn energy for RCM13
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Annual_autumn_energy_2060s_diff_RCM13_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s annual autumn sum energy at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM13');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Energy_dif_2060s_RCM13_annual_sum);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in annual autumn energy for RCM15
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Annual_autumn_energy_2060s_diff_RCM15_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s annual autumn sum energy at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for RCM15');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Energy_dif_2060s_RCM15_annual_sum);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Difference in mean annual autumn energy
clf %clears figure information
set(gca,'Box','on');       
save_name_baseline=strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Future_2060s\Autumn\Annual_autumn_energy_2060s_diff_mean_Intake_',Intake_ID,'.png');
title_name_baseline=strcat('Difference between future 2060s mean annual autumn sum energy at micro run of river scheme with Intake ID=',Intake_ID," ",'near station no.'," ",no," ",'for all RCMs');
title(title_name_baseline);
xlabel('Years');
ylabel('Difference [%]');
xlim([1 x_max]);
ylim([ymin ymax]);
hold on
plot(No_of_years,Energy_dif_2060s_annual_sum);
hold on
plot(No_of_years,X_line_zero,'Color','black');
if exist(save_name_baseline, 'file')==2
   delete(save_name_baseline);
end
saveas(gcf,save_name_baseline);
 
%% Calculate the available autumn power and energy output for the baseline and for the future
 
Power_baseline_all(i,1)=mean(Power_baseline_annual_mean);
 
Power_future_2060s_all(i,1)=mean(Power_future_2060s_mean_annual);
 
Energy_baseline_all(i,1)=sum(Energy_baseline_annual_sum);
 
Energy_future_2060s_all(i,1)=sum(Energy_future_2060s_sum_annual);
 
Table_final(1,1)=Micro_Intake_ID(i,1);
Table_final(1,2)=Power_baseline_all(i,1);
Table_final(1,3)=Power_future_2060s_all(i,1);
Table_final(1,4)=Energy_baseline_all(i,1);
Table_final(1,5)=Energy_future_2060s_all(i,1);
 
Table_final_header={'Intake ID','Baseline available mean autumn power [kW]','Future 2060s available mean autumn power [kW]','Baseline total autumn energy output [kWh]','Future 2060s total autumn energy output [kWh]'};
 
if exist(strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Autumn\Intake_',Intake_ID,'_final_2060s_annual_vs_baseline.xls'), 'file')==2
   delete(strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Autumn\Intake_',Intake_ID,'_final_2060s_annual_vs_baseline.xls'));
end
 
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Autumn\Intake_',Intake_ID,'_final_2060s_annual_vs_baseline.xls'),Table_final,'Sheet1','A2');
xlswrite(strcat('H:\01.PhD\004.Chapter4\00.Results\Micro_GR6J\Autumn\Intake_',Intake_ID,'_final_2060s_annual_vs_baseline.xls'),Table_final_header,'Sheet1','A1');
 
end