distFromDepo = zeros;
min = 15;
range = 25;
for i=1:95
    distFromDepo(i)= min + range*rand();
end


dlmwrite('distFromDepo.csv',distFromDepo);