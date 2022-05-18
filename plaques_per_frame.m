%% build a list of output parent folder names with absolute path
fPath = uigetdir('C:\LocalData\abouelez', 'Select directory containing result files');
if fPath==0, error('no folder selected'), end
folderList=dir(fPath); %create a list of folders containing output files
folderList(ismember( {folderList.name}, {'.', '..'})) = [];  %remove . and ..
for i=1:height(folderList)
folderNames(i,:)=str2double(folderList(i,1).name); %get names of folders
end
folderNames=sort(folderNames);
for k=1:height(folderNames)
    tracks=load(char(fPath) + "\" + k + "\TrackingPackage\tracks\Channel_1_tracking_result.mat"); %load tracking output file
    tracksFinal=tracks.tracksFinal;
for i=1:length(tracksFinal)
    events(i,1)=length(tracksFinal(i,1).tracksFeatIndxCG(1,:)); %lifetime
    events(i,2)=tracksFinal(i,1).seqOfEvents(1,1); %first frame
    events(i,3)=tracksFinal(i,1).seqOfEvents(2,1); %last frame
end
isplaque=any(events(:,1)>120,2); %filter out events shorter than 120s
plaques=events(isplaque,:); %list plaques
ispit=any(events(:,1)<120 & events(:,1)>20,2); %filter out events shorter than 20s and longer than 120s
pits=events(ispit,:); %list pits
for j=1:300
numEvents(j,1)=sum((plaques(:,2)<=j) & (plaques(:,3)>=j)); %each row represents a frame, column1 tells how many FCLs in that frame
numEvents(j,2)=sum((pits(:,2)<=j) & (pits(:,3)>=j)); %each row represents a frame, column2 tells how many pits in that frame
numEvents(j,3)=numEvents(j,1)/(numEvents(j,1)+numEvents(j,2)); %proportion of FCLs out of total in each frame
end
table=array2table(numEvents, 'VariableNames', {'FCLs','CCPs','Proportion of FCLs'}); %create a table with headings
%writetable(table,char(fPath) + "FCLcounts-" + k + ".csv"); %save table
FCLproportions(k,1)=mean(numEvents(125:175,3)); %create a list of the average proportion for each video
end