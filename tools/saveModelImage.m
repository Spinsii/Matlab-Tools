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
open_system(model_path, 'loadonly');

% print model
print("-s" + model_path + subsystem, "-vector", "-dpdf", image_path);

% close model
close_system(model_path);

end