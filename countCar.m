function num = countCar(SPBUNum)
   
bagi = SPBUNum/5;
rest = mod(SPBUNum,5);

if(rest~=0)
    num = (SPBUNum-rest)/5 + 1;
else
    num = bagi;
end
   
end