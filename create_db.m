function [db] = create_db(folder)
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
        clear fname img img_5;
        fname = fullfile(folder, files{i});
        img = imsquare(imread(fname));
        img = rgb2lab(img);
        img_5 = imresize(img, [5 5]);
        db{i} = img;
        mean_5(:,i) = mean_lab(img_5);
    end
    
    save('palette.mat', 'db', 'mean_5');
    
    disp(['Saved to palette.mat']);
end
