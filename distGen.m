 distance = zeros(95,95);
 for i=1:95
     for j=i:95
         if(i==j)
         distance(i,j)=0;
         distance(j,i)=0;
         else
         distance(i,j)=rand()*50+65*rand()+38+50*rand();
         distance(j,i)=distance(i,j);
         end
     end
 end
 
dlmwrite('distance.csv',distance);