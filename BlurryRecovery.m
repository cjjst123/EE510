% This code is about deconvolution from a convolution core [0 1/8 0;1/8 1/2 1/8;0 1/8 0]
img = load('blurryimage.mat');          %Load Image from structure
img = img.blurryimage;                     
[row,col] = size(img);                  %Read image size

A = sparse(row*col,row*col);            %Creat target equivalent matrix of convolution core with respect to column-first indexing
b = reshape(img,row*col,1);

dx = [0 0 1 -1];                        %Direction matrix for search around adjacent units
dy = [-1 1 0 0];
for i = 1:row*col                       %Traverse the reshaped mat with respect to address indexing
    [l,r]=ind2sub([row,col],i);         %Recalculate the 2d index
    A(i,i)=1/2;                         %Fill A(i,i) with 1/2, and search adjacent units
    for t = 1:4
        x = l+dx(t);
        y = r+dy(t);
        if x>=1 && x<=row && y>=1 && y<=col         %Boundary verification
            A(i,sub2ind([row,col],x,y)) = 1/8; 
        end
    end
end
subplot(1,2,1)
imshow(img);
title('Blurrymat')
recover = A\b;
recover = reshape(recover,[row,col]);
subplot(1,2,2)
imshow(recover);
title('Originalmat')