function Create_NoC
% Function to create a customizable NoC Model
% Author: Denis Pereira de Lima
% V1.0 09/2021
%--------------------------------------------

% Specify the name of the model to create
fname = 'Teste';

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
spacing=100;

% Config Grid Size
lin=5;
col=5;

% Add a block and place
k=1;
for j=1:col
    pos1_Y=init_X+(block_size+spacing)*j;
    pos2_Y=init_Y+(block_size+spacing)*j;
    for i=1:lin
        pos1_X=init_X+(block_size+spacing)*i;
        pos2_X=init_Y+(block_size+spacing)*i;
        add_block('simple_router/Router00', [gcs,strcat('/Router',int2str(k))],...
            'Position', [ pos1_X pos1_Y pos2_X pos2_Y],...
            'ME',int2str(k),...
            'C','1',...
            'D','1',...
            'F','1',...
            'S','1e-6');
        k=k+1;
    end
end


%Wiring E->W    E<-W
for j=1:lin:lin*col
    for i=j:j+(lin-2)
        add_line('Teste',strcat('Router',int2str(i),'/RConn3'),strcat('Router',int2str(i+1),'/LConn2'), 'autorouting', 'on')
        add_line('Teste',strcat('Router',int2str(i+1),'/RConn2'),strcat('Router',int2str(i),'/LConn3'), 'autorouting', 'on')
    end
end


% Wiring N->S    S<-N
for j=1:lin
    for i=j:lin:(col-1)*lin
        add_line('Teste',strcat('Router',int2str(i),'/RConn4'),strcat('Router',int2str(i+lin),'/RConn1')', 'autorouting', 'on')
        add_line('Teste',strcat('Router',int2str(i+lin),'/LConn1'),strcat('Router',int2str(i),'/LConn4'), 'autorouting', 'on')
    end
end


% % Set a couple of model parameters to eliminate warning messages
% set_param(gcs,...
%     'Solver','FixedStepDiscrete',...
%     'FixedStep','0.1');

% Save the model
save_system(fname);