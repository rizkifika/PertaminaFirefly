function num = carCapacity(path,idx)
[a b] = size(path);
multi =0;
for i=1:b
    if(path(idx,i)~=0)
        multi = multi+1;
    end
end
 num = multi*8;
end