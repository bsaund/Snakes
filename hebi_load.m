%HEBI_LOAD loads the HEBI library
%
%   This function loads the necessary binaries into the MATLAB path. This
%   only needs to be executed once and can only be undone by restarting
%   MATLAB.
%
%   Example
%      % Setup and view network
%      hebi_load();
%      HebiApi.initialize();
%      pause(1); % give the lookup some time to find modules
%      display(HebiApi); % shows current status
%      HebiApi.clearGroups(); % clear existing groups
%
%   Example
%      % Get further help
%      hebi_load();
%      HebiApi.help()

% Load the library only if the required clases are not yet in the classpath
if ~exist('us.hebi.sdk.matlab.HebiApi','class')
    % Note: change the filepath to match your downloaded sdk version
    % The sdk needs to be located in the same folder as this script
    javaaddpath(fullfile(fileparts(mfilename('fullpath')), 'hebi-sdk0.1-rev1018.jar'));
end

% Import namespace into the current context. This works because it's not 
% a function, but a script that gets executed in the same context.
import us.hebi.sdk.matlab.*;
HebiApi = HebiApi;
