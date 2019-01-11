% Empty Firefly Structure

%read carCapacityconstrain
    carAvail = dlmread('carCapacity.csv');
    bestNow=zeros;
    %read shift
    name1 = strcat('shift1.csv');
    shift1 = dlmread(name1);
    name2 = strcat('shift2.csv');
    shift2 = dlmread(name2);
    name3 = strcat('shift3.csv');
    shift3 = dlmread(name3);
    name4 = strcat('shift4.csv');
    shift4 = dlmread(name4);
    %read order
    order = strcat('spbuOrder.csv');
    spbuOrder = dlmread(order);
    newPath = spbuOrder;
    %read initial Distance
    init = strcat('distFromDepo.csv');
    initDist = dlmread(init);
    %initiate best
    best=zeros();
    
    
    initial1=struct;
    initial2=struct;
    initial3=struct;
    %car Schedule
    carSchedule=struct;
    
    bestAll.stdevi=inf;
    bestpath=zeros;
    
localBest=zeros();
    
for s=1:100
    
    
    
    
    best.stdevi=inf;
    %initiate first generation
for i =1:150
            
            answer = getPath(shift1);
            initial1(i).pathEachCar=answer.pathEachCar;
            initial1(i).distEachCar=answer.distEachCar;
            initial1(i).weightEachCar=answer.weightEachCar;
            initial1(i).carSize=answer.carSize;
            initial1(i).totDist=answer.totDist;
            
            answer = getPath(shift2);
            initial2(i).pathEachCar=answer.pathEachCar;
            initial2(i).distEachCar=answer.distEachCar;
            initial2(i).weightEachCar=answer.weightEachCar;
            initial2(i).carSize=answer.carSize;
            initial2(i).totDist=answer.totDist;
            
            answer = getPath(shift3);
            initial3(i).pathEachCar=answer.pathEachCar;
            initial3(i).distEachCar=answer.distEachCar;
            initial3(i).weightEachCar=answer.weightEachCar;
            initial3(i).carSize=answer.carSize;
            initial3(i).totDist=answer.totDist;
            
            schedule = zeros(153,3);
            
            type2=1;
            type3=18;
            type4=84;
            type5=140;
            
            [a,b]=size(initial1(i).totDist);
            
            sch1s = initSchedule(initial1(i).totDist,initial1(i).carSize);
            sch1=sch1s.schedule;
            used1=sch1s.used;
            beban=zeros(153,1);
            for r=1:153
                beban(r)=sch1(r);
            end
            sch2s = initSchedule2(beban,initial2(i).totDist,initial2(i).carSize);
            sch2 = sch2s.schedule;
            used2 = sch2s.used;
            beban=zeros(153,1);
            for r=1:153
                beban(r)=sch1(r)+sch2(r);
            end
            sch3s = initSchedule2(beban,initial3(i).totDist,initial3(i).carSize);
            sch3 = sch3s.schedule;
            used3 = sch3s.used;
            beban=zeros(153,1);
            for r=1:153
                beban(r)=sch1(r)+sch2(r)+sch3(r);
            end
            
            cleanLoad = zeros();
            idx=1;
            for r=1:153
                if(beban(r)>0)
                cleanLoad(idx)=beban(r);
                idx=idx+1;
                end
            end
            stdevi = distStdev(cleanLoad);
            
            carSchedule(i).cleanLoad=cleanLoad;
            carSchedule(i).beban=beban;
            carSchedule(i).sch1=sch1;
            carSchedule(i).sch2=sch2;
            carSchedule(i).sch3=sch3;
            carSchedule(i).stdevi=stdevi;
            carSchedule(i).shift1=initial1(i);
            carSchedule(i).shift2=initial2(i);
            carSchedule(i).shift3=initial3(i);
            carSchedule(i).used1=used1;
            carSchedule(i).used2=used2;
            carSchedule(i).used3=used3;
            
            if(carSchedule(i).stdevi<best.stdevi)
            best.cleanLoad=carSchedule(i).cleanLoad;
            best.beban=carSchedule(i).beban;
            best.sch1=carSchedule(i).sch1;
            best.sch2=carSchedule(i).sch2;
            best.sch3=carSchedule(i).sch3;
            best.stdevi=carSchedule(i).stdevi;
            best.shift1=carSchedule(i).shift1;
            best.shift2=carSchedule(i).shift2;
            best.shift3=carSchedule(i).shift3;
            best.used1=used1;
            best.used2=used2;
            best.used3=used3;
            end
            
end
%start butterfly
for x=1:150
    for y=1:151
        if(carSchedule(i).stdevi<best.stdevi)
               select = randi([1 5]);
                %fungsi mutasi absorsi
            if(select==1)
            carSchedule(i).sch1=best.sch1;
            carSchedule(i).shift1=best.initial1(i);
            carSchedule(i).used1=best.used1;
            elseif(select==2)
            carSchedule(i).sch2=best.sch2;
            carSchedule(i).shift2=best.initial2(i);
            carSchedule(i).used2=best.used2;

            elseif(select==3)
            carSchedule(i).sch3=best.sch3;
            carSchedule(i).shift3=best.initial3(i);
            carSchedule(i).used3=best.used3;
            elseif(select==4)
            carSchedule(i).sch3=best.sch3;
            carSchedule(i).shift3=best.initial3(i);
            carSchedule(i).used3=best.used3;
            carSchedule(i).sch2=best.sch2;
            carSchedule(i).shift2=best.initial2(i);
            carSchedule(i).used2=best.used2;
            elseif(select==5)
            carSchedule(i).sch2=best.sch2;
            carSchedule(i).shift2=best.initial2(i);
            carSchedule(i).used2=best.used2;
            carSchedule(i).sch1=best.sch1;
            carSchedule(i).shift1=best.initial1(i);
            carSchedule(i).used1=best.used1;
            end
            for r=1:153
                beban(r)=carSchedule(i).sch1(r)+carSchedule(i).sch2(r)+carSchedule(i).sch3(r);
            end
            cleanLoad = zeros();
            idx=1;
                for r=1:153
                    if(beban(r)>0)
                     cleanLoad(idx)=beban(r);
                     idx=idx+1;
                    end
                end
            carSchedule(i).beban=beban;
            carSchedule(i).cleanLoad=cleanLoad;
            carSchedule(i).stdevi=distStdev(cleanLoad);
            elseif(carSchedule(i).stdevi<best.stdevi)
            best.cleanLoad=carSchedule(i).cleanLoad;
            best.beban=carSchedule(i).beban;
            best.sch1=carSchedule(i).sch1;
            best.sch2=carSchedule(i).sch2;
            best.sch3=carSchedule(i).sch3;
            best.stdevi=carSchedule(i).stdevi;
            best.shift1=carSchedule(i).shift1;
            best.shift2=carSchedule(i).shift2;
            best.shift3=carSchedule(i).shift3;
            best.used1=used1;
            best.used2=used2;
            best.used3=used3;
        end
    end
end

            if(bestAll.stdevi>best.stdevi)
            bestAll.cleanLoad=best.cleanLoad;
            bestAll.beban=best.beban;
            bestAll.sch1=best.sch1;
            bestAll.sch2=best.sch2;
            bestAll.sch3=best.sch3;
            bestAll.stdevi=best.stdevi;
            bestAll.shift1=best.shift1;
            bestAll.shift2=best.shift2;
            bestAll.shift3=best.shift3;
            bestAll.used1=best.used1;
            bestAll.used2=best.used2;
            bestAll.used3=best.used3;
            bestpath=newPath;
            end

localBest(s)=bestAll.stdevi;

newPath = randperm(95);
shift1=zeros();
shift2=zeros();
shift3=zeros();
shift4=zeros();
shift1(1:24)=newPath(1:24);
shift2(1:24)=newPath(25:48);
shift3(1:24)=newPath(49:72);
shift4(1:23)=newPath(73:95);
end

semilogy(localBest,'LineWidth',2);
xlabel('Iteration');
ylabel('Best Cost');
grid on;