function create_synth_chrom(N_Proc)
% Function to create a customizable NoC Model
% Author: Denis Pereira de Lima
% V1.0 09/2021 (Automatic Flexible Block)
% V1.1 07/2022 (Automatic Flexible Connection)
% V1.2 10/2022 (Synthetic or Chromossome)
%--------------------------------------------
%% Create Cromossome
[crm] = create_chrom([1:N_Proc],N_Proc);

%% Create Source and Target (Nodes Traffic)
s=randi(N_Proc,1,N_Proc*2); 
t=randi(N_Proc,1,N_Proc*2); 

%% Convert S_Proc and T_Proc
[~,~,s_proc,t_proc] = conversion(crm,N_Proc,s,t);

sz_s_proc=N_Proc; 

%% Create Traffic Vector
traffic(1,1:sz_s_proc) = {[]};

%% Create Traffic Pattern
for i=1:length(s_proc)
    if s_proc(i)~=t_proc(i)
        traffic{s_proc(i)}=[traffic{s_proc(i)} t_proc(i)];
    end
end

%% Remove duplicated Number and Sort

for i=1:length(traffic)
    if ~isempty(traffic{i})
        aux=traffic{i};
        traffic{i}=unique(aux);
    end
end
%% Define T
T=1;
%%
save('Traffic_Pattern.mat','traffic','T')