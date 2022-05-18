%% build a list of output parent folder names with absolute path
fPath = uigetdir('C:\LocalData\abouelez', 'Select directory containing result files');
if fPath==0, error('no folder selected'), end
folderList=dir(fPath); %create a list of folders containing output files
folderList(ismember( {folderList.name}, {'.', '..'})) = [];  %remove . and ..
for i=1:height(folderList)
folderNames(i,:)=str2double(folderList(i,1).name); %get names of folders
end
folderNames=sort(folderNames);
for i=1:height(folderNames)
    tracks=load(char(fPath) + "\" + i + "\TrackingPackage\tracks\Channel_1_tracking_result.mat"); %load tracking output file
    tracks=tracks.tracksFinal;
    for j=1:height(tracks)
        lifetimes(j,i)=length(tracks(j,1).tracksFeatIndxCG); %list the lifetime of each track
    end
end
lifetimes=lifetimes.*(lifetimes>20); %remove events shorter than 20 seconds, converts them to zeros
lifetimes=sort(lifetimes, 'descend'); %sort events in descending order