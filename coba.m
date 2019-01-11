carAvail = dlmread('carCapacity.csv');
for r=1:1
possible=0;

weight = zeros();

flag = zeros();

for i=1:14
    weight(i)=randi([2 3]);
    flag(i)=0;
end

while possible==0
for i=1:14
    
    flag(i)=0;
    end

pathEachCar=zeros();
visible =0;
idx=0;
num=1;
pathCreated = randperm(14);
%create dummy checker
dummy=zeros(4,1);
minimum=min(weight);
        if(minimum<=2)
            minimum=2;
        end
        i=1;
while visible==0
    i=1+1;
    carSize=randi([minimum 5]);
    
    if(carAvail(carSize-1)-dummy(carSize-1)>1)
        avail=carSize;
        idx=1;
        for i=1:14
            if(weight(pathCreated(i))<=avail&&flag(i)==0)
                avail=avail-weight(pathCreated(i));
                flag(i)=1;
                pathEachCar(num,idx)=weight(pathCreated(i));
                idx=idx+1;
            end
        end
        dummy(carSize-1)=dummy(carSize-1)+1;
        num=num+1;
        %detect minimum req
        minimum = 100;
        for i=1:14
            if(minimum > weight(pathCreated(i))&&flag(pathCreated(i))==0)
                minimum = weight(pathCreated(i));
            end
        end
        if(minimum<=2)
            minimum=2;
        end
    end
    if(sum(flag)==14)
        visible=1;
    end
    if(i==500)
        visible=100;
    end
end
%check final car
[x, y]=size(pathEachCar);

carUsed=zeros(x,1);

for i=1:x
    for j=1:y
        if(pathEachCar(i,j)~=0)
            carUsed(i)=carUsed(i)+pathEachCar(i,j);
        end
    end
end
term = min(carUsed);
visible
term

while term<=1
    
end

if(term>1&&visible==1)
finalDummy=zeros(4,1);
for i=1:x
    finalDummy(carUsed(i)-1,1)=finalDummy(carUsed(i)-1,1)+1;
end

for i=1:4
    carAvail(i,1)=carAvail(i,1)-finalDummy(i,1);
end
    possible=1;
else
    possible=0;
end
end
end