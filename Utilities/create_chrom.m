function [crm] = create_chrom(tasks,N_proc)
% Generation of one individual...
% [crm] = chrom(tasks,numProc)...
% nTasks: number of tasks...
% numProc: number of processors
% tasks: tasks vector...
% crm: random chromosome
crm = {{0}};
[~,nTasks] = size(tasks);
for i = 1:nTasks
    crm{i} = tasks(i);
    crm{i}(2) = randi(N_proc);  
end
    crm = cell2mat(crm);
end
