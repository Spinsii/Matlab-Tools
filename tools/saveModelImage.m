function saveModelImage(model_path, image_path, subsystem)
%saveModelImage prints simulink models as vectorgraphic

% varargin
if ~exist("image_path")
    image_path = model_path;
end

% varargin
if ~exist("subsystem")
    subsystem = "";
end

% open model
isopen = bdIsLoaded(model_path);        % if model is open dont close it
open_system(model_path, 'loadonly');

% print model
% model_handle = get_param(model_path + subsystem , 'Handle');
% saveas(model_handle, image_path, 'pdf');
print("-s" + model_path + subsystem, "-vector", "-dpdf", image_path);

% close model
if ~isopen
    close_system(model_path);
end

end