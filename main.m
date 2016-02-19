%% Create the database
create_db();

%% Create mosaic image
tic
input_image = imread('images/morena.jpg');
result = mosaic(input_image);
subplot(1, 2, 1), imshow(input_image)
subplot(1, 2, 2), imshow(result)
toc

%%
tile_width = 20;
img = imread('images/clintan.png');
[stacked_image, dimensions] = stack_image(img, tile_width);
result = unstack_image(stacked_image, dimensions);
imshow(uint8(result))