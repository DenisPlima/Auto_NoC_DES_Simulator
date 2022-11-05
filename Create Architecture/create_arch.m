function create_arch(lin,col)
% Function to create a customizable NoC Model
% Author: Denis Pereira de Lima
% V1.0 09/2021 (Automatic Flexible Block)
% V1.1 07/2022 (Automatic Flexible Connection)
% V1.2 10/2022 (Synthetic or Chromossome)
%--------------------------------------------

%% Specify the name of the model to create
fname = 'Architecture';

% Check if the file already exists and delete it if it does
if exist(fname,'file') == 4
    % If it does then check whether it's open
    if bdIsLoaded(fname)
        % If it is then close it (without saving!)
        close_system(fname,0)
    end
    % delete the file
    delete([fname,'.mdl']);
end

% Create the system
new_system(fname);
% Config Sizes and spaces between blocks
%Define Block Size
block_size=150;
%Define Initial Position
init_X=150;
init_Y=init_X+block_size;
%Define Spaces Between Blocks
spacing=130;

%% Add a block and place
k=1;
load Traffic_Pattern.mat

for j=1:col
    
    % Determine Positions
    pos1_Y=init_X+(block_size+spacing)*j;
    pos2_Y=init_Y+(block_size+spacing)*j;
    
    
    for i=1:lin
        %% Number of Tasks in each processor
        sz_traffic=length(traffic{k});
        
        % Number of Tasks in each processor
        if(sz_traffic>=2)
            SWT=1;
            S='1';
        elseif(sz_traffic==0)
            SWT=3;
            S='1';
        else
            SWT=2;
            S='1';
        end
        
        % Determine Positions
        pos1_X=init_X+(block_size+spacing)*i;
        pos2_X=init_Y+(block_size+spacing)*i;
        
        %% ROUTERS
        add_block('simple_router/Router00', [gcs,strcat('/Router',int2str(k))],...
            'Position', [ pos1_X pos1_Y pos2_X pos2_Y],...
            'ME',int2str(k),...
            'C','1',...
            'D','1',...
            'F','1',...
            'S','1e-6');
        %% PE's
        
        switch SWT
            case 1 % Processor with Tasks >=2
                
                add_block('traffic_generator_sink_cluster/Processor', [gcs,strcat('/PE',int2str(k))],...
                    'Position', [ pos1_X+15 pos1_Y+(block_size+20) pos2_X-15 pos2_Y+70],...
                    'ME',int2str(k),...
                    'Inst',strcat("'","Inst",int2str(k),"'"),...
                    'Router',strcat("'","Mean",int2str(k),"'"),...
                    'Loss',strcat("'","Loss",int2str(k),"'"),...
                    'N',strcat("'","N",int2str(k),"'"),...
                    'V',strcat("[",strjoin(string(traffic{k})),"]"),...
                    'P',strcat('ones(1,',int2str(sz_traffic),')./',int2str(sz_traffic)),...
                    'SELECT',S);
                
            case 2 % Processor with Tasks = 1
                add_block('traffic_generator_sink_single/Processor', [gcs,strcat('/PE',int2str(k))],...
                    'Position', [ pos1_X+15 pos1_Y+(block_size+20) pos2_X-15 pos2_Y+70],...
                    'ME',int2str(k),...
                    'Inst',strcat("'","Inst",int2str(k),"'"),...
                    'Router',strcat("'","Mean",int2str(k),"'"),...
                    'Loss',strcat("'","Loss",int2str(k),"'"),...
                    'N',strcat("'","N",int2str(k),"'"),...
                    'DST1',strcat("[",strjoin(string(traffic{k})),"]"),...
                    'SELECT',S);
            case 3 % Processor with Tasks = 1
                add_block('traffic_generator_sink_Nop/Processor', [gcs,strcat('/PE',int2str(k))],...
                    'Position', [ pos1_X+15 pos1_Y+(block_size+20) pos2_X-15 pos2_Y+70],...
                    'ME',int2str(k),...
                    'Inst',strcat("'","Inst",int2str(k),"'"),...
                    'Router',strcat("'","Mean",int2str(k),"'"),...
                    'Loss',strcat("'","Loss",int2str(k),"'"),...
                    'N',strcat("'","N",int2str(k),"'"),...
                    'SELECT',S);
            otherwise
                disp("Error: Line 74")
        end
        
        
        k=k+1;
    end
end


%% Wiring E->W    E<-W
for j=1:lin:lin*col
    for i=j:j+(lin-2)
        add_line('Architecture',strcat('Router',int2str(i),'/RConn3'),strcat('Router',int2str(i+1),'/LConn2'), 'autorouting', 'on')
        add_line('Architecture',strcat('Router',int2str(i+1),'/RConn2'),strcat('Router',int2str(i),'/LConn3'), 'autorouting', 'on')
    end
end


%% Wiring N->S    S<-N
for j=1:lin
    for i=j:lin:(col-1)*lin
        add_line('Architecture',strcat('Router',int2str(i),'/RConn4'),strcat('Router',int2str(i+lin),'/RConn1')', 'autorouting', 'on')
        add_line('Architecture',strcat('Router',int2str(i+lin),'/LConn1'),strcat('Router',int2str(i),'/LConn4'), 'autorouting', 'on')
    end
end

%% Wiring Router <-> PE
for i=1:lin*col
    add_line('Architecture',strcat('PE',int2str(i),'/LConn1'),strcat('Router',int2str(i),'/RConn5')', 'autorouting', 'on')
    add_line('Architecture',strcat('PE',int2str(i),'/RConn1'),strcat('Router',int2str(i),'/LConn5'), 'autorouting', 'on')
end

%% Set a couple of model parameters to eliminate warning messages
% set_param(gcs,...
%     'Solver','FixedStepDiscrete',...
%     'FixedStep','0.1');

%% Save the model
save_system(fname);