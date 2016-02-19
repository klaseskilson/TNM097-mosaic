%% Create the database
create_db();

%% Create mosaic image
input_image = imread('images/morena.jpg');
result = mosaic(input_image);