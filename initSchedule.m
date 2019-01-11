function schedules = initSchedule(dist,weight)
    type2=1;
    type3=18;
    type4=84;
    type5=140;

    [a,b]=size(dist);
    flag = zeros(153,1);
    schedule=zeros(153,1);            
            for z=1:a
                if(weight(z)==2)
                    schedule(type2)=dist(z);
                    flag(type2)=z;
                    type2=type2+1;
                elseif(weight(z)==3)
                    schedule(type3)=dist(z);
                    flag(type3)=z;
                    type3=type3+1;
                elseif(weight(z)==4)
                    schedule(type4)=dist(z);
                    flag(type4)=z;
                    type4=type4+1;
                elseif(weight(z)==5)
                    schedule(type5)=dist(z);
                    flag(type5)=z;
                    type5=type5+1;
                end
            end
            
     schedules.schedule=schedule;
     schedules.used=flag;
end