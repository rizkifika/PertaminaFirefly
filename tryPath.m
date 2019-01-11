    i=2;
    
    carAvail = dlmread('carCapacity.csv');
    
    name = strcat('shift',num2str(i),'.csv');
    shift = dlmread(name);
    
    nameGas = strcat('gasoline',num2str(i),'.csv');
    gas = dlmread(nameGas);
    
    namePetrol = strcat('petrol',num2str(i),'.csv');
    petrol = dlmread(namePetrol);
    
    num = numel(shift);
    iter=0;
    
    visible=0;
    while visible==0
    pathRand = randperm(num);
    
    iter=iter+1
    
    pathEachCar = zeros();
    idx=1;
    numCity=0;
    weight=0;
    for z=1:num
        z;
        add = petrol(pathRand(z))+gas(pathRand(z));
        
        if(weight==0&&add>5)
            break;
        elseif(weight+add<5)
            numCity=numCity+1;
            weight=weight+add;
        elseif(weight+add>=5)
            weight=add;
            pathEachCar(idx)=numCity;
            idx=idx+1;
            numCity = 1;
        end
        weight;
        numCity;
    end
    
    end