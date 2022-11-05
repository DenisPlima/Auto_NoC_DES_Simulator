function [new_crm,ft_crm,s_proc,t_proc] = conversion(crm,N_proc,s,t)
%function [new_crm,ft_crm,s_proc,t_proc] = conversion(crm,N_proc,s,t)
% crm: random chromosome...
% N_proc: number of processors...
% s: task where the arc is initialized...
% t: task where the arc ends...
% s_proc: start on processor...
% t_proc: target on processor...
% new_crm: calculation Chromosome...
%ft_crm: cromosome for Fault Tolerance...


[~,lCrm] = size(crm);
procs = crm(2:2:lCrm);
tasks = crm(1:2:lCrm);

%Pre Allocate new_crm
new_crm=zeros(1,N_proc);

%Allocated Processor
Alloc_proc=unique(procs);

%Cromossome used to calculate F1 F2 F3
new_crm(Alloc_proc)=Alloc_proc;

%Cromossome used to calculate F4 (Fault Tolerance)
ft_crm=double((new_crm>=1));

%Collect size of s
[~,sz_s] = size(s);

%Pre Allocate s and t
s_proc=[];
t_proc=[];


for i=1:sz_s
    %Collect s(init_task) and t(target_task)
    aux_tasks_1=s(i);
    aux_tasks_2=t(i);
    %Collect postion of task in processor
    pos_proc1=find(tasks==aux_tasks_1);
    pos_proc2=find(tasks==aux_tasks_2);
    
    % If Processor(init_task) ~= Processor(target_task)    
    if procs(pos_proc1)~=procs(pos_proc2)
        %Create S and T of Processors
        s_proc=[s_proc procs(pos_proc1)];
        t_proc=[t_proc procs(pos_proc2)];
    end
end
%S Processadores
s_proc;
%T Processadores
t_proc;
%Cromossomo para calculos
new_crm;
%Cromossomo para Fault Tolerance
ft_crm;