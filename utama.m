%read distance
dist = dlmread('distance.csv');

spbuNUM = 95;
pathSaved = zeros(countCar(spbuNUM),5);
%pembagian spbu;
spbuOrder = zeros();
spbuDemandPetrol = zeros();
spbuDemandGasoline = zeros();
spbuDemand = zeros();
idx=1;
for i = 1:95
    
    
    spbuOrder(i) = idx;
    spbuDemand(i) = idx;
    idx=idx+1;
    if(idx==4)
        idx=1;
    end
    
end

for i = 1:95
  %  spbuDemand(i) = randi([1,4]);
end


for i = 1:95
    spbuDemandPetrol(i) = randi([2,4]);
end

for i = 1:95
    if(spbuDemandPetrol(i)==1)
    spbuDemandGasoline(i) = randi([1,4]);
    elseif(spbuDemandPetrol(i)==4)
    spbuDemandGasoline(i)=1;
    elseif(spbuDemandPetrol(i)==3)
    spbuDemandGasoline(i)=randi([1,2]);
    elseif(spbuDemandPetrol(i)==2)
    spbuDemandGasoline(i)=randi([1,3]);
    end
end

shift1=zeros();
shift2=zeros();
shift3=zeros();
shift4=zeros();
petrol1=zeros();
petrol2=zeros();
petrol3=zeros();
petrol4=zeros();
gasoline1=zeros();
gasoline2=zeros();
gasoline3=zeros();
gasoline4=zeros();
x=1;
for i = 1:95
    if(spbuOrder(i)==1)
    shift1(x) = i;
    gasoline1(x) = spbuDemandGasoline(i);
    petrol1(x) = spbuDemandPetrol(i);
    x=x+1;
    end
end
x=1;
for i = 1:95
    if(spbuOrder(i)==2)
    shift2(x) = i;
    gasoline2(x) = spbuDemandGasoline(i);
    petrol2(x) = spbuDemandPetrol(i);
    x=x+1;
    end
end
x=1;
for i = 1:95
    if(spbuOrder(i)==3)
    shift3(x) = i;
    gasoline3(x) = spbuDemandGasoline(i);
    petrol3(x) = spbuDemandPetrol(i);
    x=x+1;
    end
end
x=1;
for i = 1:95
    if(spbuOrder(i)==4)
    shift4(x) = i;
    gasoline4(x) = spbuDemandGasoline(i);
    petrol4(x) = spbuDemandPetrol(i);
    x=x+1;
    end
end

car16 = zeros();
car24 = zeros();
car32 = zeros();
car40 = zeros();

for i = 1:17
    car16(i) =0;
end
for i = 1:66
    car24(i) =0;
end
for i = 1:56
    car32(i) =0;
end
for i = 1:14
    car40(i) =0;
end
carHours=zeros;
for i = 1:153
    carHours(i) =0;
end

dlmwrite('carHours.csv',carHours);
dlmwrite('spbuDemand.csv',spbuDemand);

dlmwrite('shift1.csv',shift1);
dlmwrite('shift2.csv',shift2);
dlmwrite('shift3.csv',shift3);
dlmwrite('shift4.csv',shift4);

dlmwrite('petrol1.csv',petrol1);
dlmwrite('petrol2.csv',petrol2);
dlmwrite('petrol3.csv',petrol3);
dlmwrite('petrol4.csv',petrol4);

dlmwrite('gasoline1.csv',gasoline1);
dlmwrite('gasoline2.csv',gasoline2);
dlmwrite('gasoline3.csv',gasoline3);
dlmwrite('gasoline4.csv',gasoline4);

dlmwrite('spbuOrder.csv',spbuOrder);

dlmwrite('16.csv',car16);
dlmwrite('24.csv',car24);
dlmwrite('32.csv',car32);
dlmwrite('40.csv',car40);

