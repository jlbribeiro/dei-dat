%% Ex. 5
%% Ex. 5.1
[img, map] = imread('files/lenna.jpg');
imshow(image);
title('lenna.jpg');

%% Ex. 5.2
DCT = dct2(img);
figure();
imshow(db(DCT), map);
colorbar;
title('Mesh da DCT da imagem lenna.jpg');

figure();
mesh(db(abs(DCT)));
colormap(jet);
colorbar;
title('DCT da imagem lenna.jpg');