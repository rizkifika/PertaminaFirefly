function copy = copyMatrix(distance, shift)
    n=numel(shift);
    copy=zeros(n,n);
    
    for i=1:n
        for j=1:n
            copy(i,j)=distance(shift(i),shift(j));
        end
    end
    
end