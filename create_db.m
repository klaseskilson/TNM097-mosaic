function [palette] = create_db(folder)
%db = CREATE_DB(folder) Create an image database from the images in the folder `folder`
%   If no folder is provided, `images` is assumed. The files are saved to
%   `palette.mat` and returned as `db`.
    if nargin == 0
        folder = 'images';
    end
    
    addpath('helpers');
    clear db mean_5;
    disp(['Creating database from folder ' folder]);
    
    % load files from folder and loop through them
    files = [dir(fullfile(folder,'*.jpg')); dir(fullfile(folder,'*.png'))];
    files = {files.name}';
    for i = 1:numel(files)
        clear fname img;
        fname = fullfile(folder, files{i});
        img = imsquare(imread(fname));
        img = rgb2lab(img);
        palette{i} = img;
    end
    
    save('palette.mat', 'palette');
    
    disp(['Saved to palette.mat']);
end
