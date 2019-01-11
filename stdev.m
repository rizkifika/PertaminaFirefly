

function z=stdev(shiftName,pathRand,numSpbuEachCar,numCar)

master = dlmread('distance.csv');

shift = dlmread(shiftName);
dist = copyMatrix(master,shift);

spbuNUM = numel(shift);
pathSaved = zeros(numCar,5);

flag = pathRand;
idx=1;
%spbu yang dikunjungi mobil
for i=1:numCar
    for j=1:numSpbuEachCar(i)
        pathSaved(i,j)=flag(idx);
        idx=idx+1;
    end
end
%jarak tiap spbu

cardist = zeros(numCar,1);

for i=1:numCar
    for j=1:4
        if(pathSaved(i,j)~=0&&pathSaved(i,j+1)~=0)
        cardist(i)=cardist(i)+dist(pathSaved(i,j),pathSaved(i,j+1));
        end
    end
end

%-------------------------------------
    x = cardist;
    rata = mean(x);
    stdev1=0;
    [a,~] = size(x);
    for i=1:a
        stdev1 = stdev1 + (abs(rata-x(i))*abs(rata-x(i)));
    end
    z=stdev1/a;

end