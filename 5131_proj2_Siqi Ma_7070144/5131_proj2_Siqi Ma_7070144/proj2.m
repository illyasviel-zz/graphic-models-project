load('playOnfield.mat')
[a,b]=size(playOnfield8);
as=playOnfield8;
right=0;
down=0;
distance=0;
j=1;
pr = zeros(300,1); %the probability of going right
pd = zeros(300,1); %the probability of going down
for i=2:158711
    if ((as(i+1,1) == 0 && as(i+1,2) == 0) || (as(i,1) == 255 && as(i,2) == 255))
        %one person reach the destination or failed in the walking
        %distance = right + down;
        pr(j,1)=right/distance;
        pd(j,1)=down/distance;
        a1(j,1) = right;
        a2(j,1) = down;
        j = j+1; 
        right = 0;
        down = 0;
    else if as(i,1) > as(i-1,1) && as(i,2) == as(i-1,2)
            %go to the right, plus right and distance
        right=right+1;
        distance=distance+1;
        else if as(i,1) > as(i-1,1) &&as(i,2) > as(i-1,2)
                %go to the right down side, plus right, and distance
            right=right+1;
            %down=down+1;
            distance=distance+1;
            else if as(i,1) == as(i-1,1) && as(i,2)>as(i-1,2)
                    %go to the dowm, plus down and distance
                down=down+1;
                distance=distance+1;
                else
                    right = right;
                    down = down;
                    distance = distance;
            end
        end
        end
    end
end
prob_matrix=[pr,pd]

%way_of_all_people=[pr,pd];% the percentage of everyperson go down and go right
c = 0
scatter(a1,a2,'*') %plot the distribution of the steps towards right and
%down.
hold on
xlabel('right step');
ylabel('down step');
figure
scatter(pr*100,pd*100,'*');
xlabel('probability of going right(%)');
ylabel('probability of going down (%)');
obj = gmdistribution.fit(prob_matrix,4)
%MP = obj.PComponents
%CM = obj.mu
%CC = obj.Sigma
%E = Expectation(prob_matrix,3,MP,CM,CC)