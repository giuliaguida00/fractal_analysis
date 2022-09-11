function[boundary,cc]=boundary(bw)
bw=im2bw(bw);
bw=bwareaopen(bw,5000);
bw = imclearborder(bw);
bw = imfill(bw,'holes');
cc=bwconncomp(bw,8);

[B,~] = bwboundaries(bw);
boundary =0;
for k = 1:length(B)
    boundary = B{k};
end

end