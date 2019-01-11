function schedules = initSchedule2(shift1,dist,weight)
    type2=1;
    type3=18;
    type4=84;
    type5=140;

    [a,b]=size(dist);
    schedule=zeros(153,1);
    z=1;
    flag=1;
    used = zeros(153,1);
            while z~=a
                if(type2>=18||type3>=84||type4>=140||type5>=154)
                    z=a;
                    flag=0;
                elseif(weight(z)==2)
                    if(shift1(type2)+dist(z)<=210)
                    schedule(type2)=dist(z);
                    used(type2)=z;
                    z=z+1;
                    type2=type2+1;
                    else
                        type2=type2+1;
                    end
                elseif(weight(z)==3)
                    if(shift1(type3)+dist(z)<=210)
                    schedule(type3)=dist(z);
                    used(type3)=z;
                    z=z+1;
                    type3=type3+1;
                    else
                        type3=type3+1;
                    end
                elseif(weight(z)==4)
                   if(shift1(type4)+dist(z)<=210)
                    schedule(type4)=dist(z);
                    used(type4)=z;
                    z=z+1;
                    type4=type4+1;
                    else
                        type4=type4+1;
                    end
                elseif(weight(z)==5)
                   if(shift1(type5)+dist(z)<=210)
                    schedule(type5)=dist(z);
                    used(type5)=z;
                    z=z+1;
                    type5=type5+1;
                    else
                        type5=type5+1;
                    end
                end
            end
      if(flag==0)
          for i=1:153
              schedule(i)=inf;
          end
      end
      
      schedules.schedule =schedule;
      schedules.used = used;
end