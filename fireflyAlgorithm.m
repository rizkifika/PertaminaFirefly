% Empty Firefly Structure

%read carCapacityconstrain
carAvail = dlmread('carCapacity.csv');
bestNow=zeros;
for i=1:1
    name = strcat('shift',num2str(i),'.csv');
    shift = dlmread(name);
    
    nameGas = strcat('gasoline',num2str(i),'.csv');
    gas = dlmread(nameGas);
    
    namePetrol = strcat('petrol',num2str(i),'.csv');
    petrol = dlmread(namePetrol);
    
    best=zeros();
    num = numel(shift);
    best.Stdev=inf;
    cityPerCar=zeros();
    %create dummy best
    
    %find minimum car constrain
    %for max car
    max=floor(num/2);
    %for min car
    min=ceil(num/5);
    %create initial fireflies
    for j=1:200
        %random path
        pathrand = randperm(num);
        %create jumlah mobil
        numCar = randi([min max]);
        %create NumSpbuPerCar
        numSpbuEachCar = zeros();
        dummy = zeros(4,1);
        n=1;
        while n<=numCar
           z = randi([2 5]);
           if(carAvail(z-1)-(dummy(z-1)+1)>0)
           numSpbuEachCar(n) = z; 
           n=n+1;
           dummy(z-1) = dummy(z-1)+1;
           end
        end
        %cek apakah terpenuhi atau tidak
        sum = 0;
        %sum adalah beban path-> beban path adalah total demand
        %solar+bensin
        for n=1:numCar
            sum = sum + numSpbuEachCar(n);
            
        end
        %bila lebih atau kurang
        sub=0;
        add=0;
        if (sum<num)
            add = num - sum;
            idx=1;
            
            while add>0
                if(numSpbuEachCar(idx)<5&&carAvail(numSpbuEachCar(idx))-(dummy(numSpbuEachCar(idx))+1)>=0)
                    dummy(numSpbuEachCar(idx)-1)=dummy(numSpbuEachCar(idx)-1)-1;
                    dummy(numSpbuEachCar(idx))=dummy(numSpbuEachCar(idx))+1;
                    numSpbuEachCar(idx)=numSpbuEachCar(idx)+1;
                    add = add-1
                    idx=idx+1;
                    if(idx>numCar)
                        idx=1;
                    end
                 else
                    idx=idx+1;
                    if(idx>numCar)
                        idx=1;
                    end
                end
            end
            
        elseif(sum > num)
            sub = sum - num;
            idx=1;
            possibility=1;
            while sub>0
                possibility=possibility+1;
                if(numSpbuEachCar(idx)>2&&numSpbuEachCar(idx)<=5&&carAvail(numSpbuEachCar(idx)-2)-(dummy(numSpbuEachCar(idx)-2)+1)>=0)
                    dummy(numSpbuEachCar(idx)-2)=dummy(numSpbuEachCar(idx)-2)+1;
                    dummy(numSpbuEachCar(idx)-1)=dummy(numSpbuEachCar(idx)-1)-1;
                    numSpbuEachCar(idx)=numSpbuEachCar(idx)-1;
                    sub=sub-1
                    idx=idx+1;
                    if(idx>numCar)
                        idx=1;
                    end
                elseif(possibility<150)
                    idx=idx+1;
                    if(idx>numCar)
                        idx=1;
                    end
                else
                    sub=-1;
                end
                
            end
        end
        if(sub~=-1&&add~=-1)
        firefly(j).numCar=numCar;
        firefly(j).numSpbuEachCar=numSpbuEachCar;
        firefly(j).capacity=numSpbuEachCar;
        firefly(j).pathRand=pathrand;
        firefly(j).Stdev=stdev(name,pathrand,numSpbuEachCar,numCar);
        firefly(j).dummy=dummy;
        else
        firefly(j).numCar=numCar;
        firefly(j).numSpbuEachCar=numSpbuEachCar;
        firefly(j).capacity=numSpbuEachCar;
        firefly(j).pathRand=pathrand;
        firefly(j).Stdev=inf;
        firefly(j).dummy=dummy;
        end
        %check the best
        if(firefly(j).Stdev < best.Stdev)
            best.numCar=firefly(j).numCar;
            best.numSpbuEachCar=firefly(j).numSpbuEachCar;
            best.capacity=firefly(j).capacity;
            best.pathRand=firefly(j).pathRand;
            best.Stdev=firefly(j).Stdev;
            best.dummy=firefly(j).dummy;
        end
    end
    
    maxIter=10;
    iter=1;
    while iter <=maxIter
        bestNow(iter)=best.Stdev;
            bestNow(iter)
        for x=1:200
            x
            bestNow(x)=best.Stdev;
            bestNow(x)
            for j=1:200
                if((firefly(x).Stdev~=inf&&firefly(j).Stdev)~=inf)
                if(firefly(x).Stdev<firefly(j).Stdev)
                    %move j to x
                    firefly(j).numCar=firefly(x).numCar;
                    firefly(j).numSpbuEachCar=firefly(x).numSpbuEachCar;
                    firefly(j).capacity=firefly(x).numSpbuEachCar;
                    firefly(j).Stdev=stdev(name,firefly(j).pathRand,firefly(x).numSpbuEachCar,firefly(x).numCar);
                end
                if(firefly(j).Stdev < best.Stdev)
                    best.numCar=firefly(j).numCar;
                    best.numSpbuEachCar=firefly(j).numSpbuEachCar;
                    best.capacity=firefly(j).capacity;
                    best.pathRand=firefly(j).pathRand;
                    best.Stdev=firefly(j).Stdev;
                end
                end
            end
        end
        iter=iter+1;
    end
    idx=1;
    for z=1:best.numCar;
        for x=1:best.numSpbuEachCar(z)
            cityPerCar(z,x)=shift(best.pathRand(idx));
            idx=idx+1;
        end
    end
    
    for z=1:4
        carAvail(z)=carAvail(z)-best.dummy(z);
    end
    for z=1:best.numCar
        best.capacity(z)=best.capacity(z)*8;
    end
            bestShift(i).numCar=best.numCar;
            bestShift(i).numSpbuEachCar=best.numSpbuEachCar;
            bestShift(i).capacity=best.capacity;
            bestShift(i).pathRand=cityPerCar;
            bestShift(i).Stdev=best.Stdev;
            bestShift(i).dummy=best.dummy;
            figure;
%plot(BestCost,'LineWidth',2);
semilogy(bestNow,'LineWidth',2);
xlabel('Iteration');
ylabel('Best Cost');
grid on;
    
end