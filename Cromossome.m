%% Clear
clear all
close all
clc

%% Create Cromossome
[crm] = create_chrom([1 2 3 4 5 6 7 8],8);

%% Create Source and Target (Nodes Traffic)
s=randi(8,1,10);
t=randi(8,1,10);

%% Convert S_Proc and T_Proc
[new_crm,ft_crm,s_proc,t_proc] = conversion(crm,8,s,t);

sz_s_proc=8; %---------------------------

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

%%
save traffic