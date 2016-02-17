function [output_args] = create_db(folder)
%CREATE_DB(folder) Create an image database from the images in the folder `folder`
%   If no folder is provided, `images` is assumed.
    if nargin == 0
        folder = 'images/db1';
    end
    
    % load files from dirname
    files = dir(fullfile(folder, '*.jpg'));
    files = {files.name}';
    for i = 1:numel(files)
        clear img fname;
        fname = fullfile(dirname, files{i});
        img = imread(fname);
        
        % magic goes here!
    end
end
