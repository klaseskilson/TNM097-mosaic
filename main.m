%% Create the database
create_db();

%% Create mosaic image
input_image = imread('images/morena.jpg');
result = mosaic(input_image);

%%
tile_width = 20;
img = imread('images/morena.jpg');
[stacked_image, dimensions] = stack_image(img, tile_width);
result = unstack_image(stacked_image, dimensions);
imshow(uint8(result))