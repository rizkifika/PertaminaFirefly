function selectPath = solution(carAvail,weight)
possible=0;
flag=zeros();
for i=1:numel(weight)
    flag(i)=0;
end
while possible==0


pathEachCar=zeros();
visible =0;
num=1;
urut = zeros();
%create dummy checker
dummy=zeros(4,1);
minimum=min(weight);
        if(minimum<=2)
            minimum=2;
        end
while visible==0
    carSize=randi([minimum 5]);
    
    if(carAvail(carSize-1)-dummy(carSize-1)>1)
        avail=carSize;
        idx=1;
        for i=1:14
            if(weight(i)<=avail&&flag(i)==0)
                avail=avail-weight(i);
                flag(i)=1;
                pathEachCar(num,idx)=weight(i);
                idx=idx+1;
            end
        end
        dummy(carSize-1)=dummy(carSize-1)+1;
        num=num+1;
        %detect minimum req
        minimum = 100;
        for i=1:14
            if(minimum > weight(i)&&flag(i)==0)
                minimum = weight(i);
            end
        end
        if(minimum<=2)
            minimum=2;
        end
    end
    if(sum(flag)==14)
        visible=1;
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
if(term>1)
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