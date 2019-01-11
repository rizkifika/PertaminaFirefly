function path = getPath(shift)

num = numel(shift);
path = randperm(num);
data1 = zeros();
demandSpbu=dlmread('spbuDemand.csv');
dist = dlmread('distance.csv');
distDepo = dlmread('distFromDepo.csv');

for i=1:num
    data1(1,i)=demandSpbu(shift(i));
    data1(2,i)=shift(i);
end

randomize=randperm(num);

data=zeros();

for i=1:num
    data(1,i)=data1(1,randomize(i));
    data(2,i)=data1(2,randomize(i));
end

initialDist = distDepo(data(2,1));

tempuh = initialDist;

pathEachCar=zeros();
distEachCar=zeros();
weightEachCar=zeros();
weight=data(1,1);
weightEachCar(1,1)=weight;
distEachCar(1,1)=distDepo(data(2,1));
idx=1;
idy=1;
pathEachCar(idx,idy)=data(2,1);
idy=2;
jarak=zeros();

for i=2:num
    
    add = data(1,i);
    addJarak = dist(data(2,i-1),data(2,i));
    jarak(i-1)=addJarak;
 
    if(weight+add<=5 && tempuh+addJarak<=190)
        
        pathEachCar(idx,idy)=data(2,i);
        distEachCar(idx,idy)=addJarak;
        weightEachCar(idx,idy)=add;
        weight=weight+add;
        tempuh=tempuh+addJarak;
        idy=idy+1;
        
    else
        distEachCar(idx,idy)=distDepo(data(2,i-1));
        idy=1;
        idx=idx+1;
        pathEachCar(idx,idy)=data(2,i);
        weightEachCar(idx,idy)=add;
        distEachCar(idx,idy)=distDepo(data(2,i));
        tempuh = distDepo(data(2,i));
        weight = add;
        idy=2;

    end
    if(i==num)
        distEachCar(idx,idy)=distDepo(data(2,i));
    end
end

[a,b]=size(pathEachCar);

carSize=zeros(a,1);
for i=1:a
    for y=1:b
        carSize(i)=carSize(i)+weightEachCar(i,y);
    end
end

[a,b]=size(distEachCar);
totalDist=zeros(a,1);
for i=1:a
    for y=1:b
        totalDist(i)=totalDist(i)+distEachCar(i,y);
    end
end

path.pathEachCar = pathEachCar;
path.distEachCar = distEachCar;
path.Jarak = jarak;
path.weightEachCar = weightEachCar;
path.data = data;
path.carSize = carSize;
path.totDist = totalDist;

end