%% build a list of file names with absolute path
fPath = uigetdir('*.tif', 'Select directory containing Tiff files');
if fPath==0, error('no folder selected'), end
fNames = dir( fullfile(fPath,'*.tif') );
name = {fNames.name};
fNames = strcat(fPath, filesep, {fNames.name});
root = strfind(fPath, '\');
rootdir = fPath(1:root(end)-1); %absolute root path
videosMat=rootdir + "\videosMat"; %.mat files path
videosList=rootdir + "\videosList"; %list files path
output=rootdir + "\output"; % output path
listOut=rootdir + "\listOut"; % list output path, only required to build list
mkdir(videosMat); % create directory
mkdir(videosList); % create directory
mkdir(output); % create directory
mkdir(listOut); % create directory
%% creat mat file for every tiff
for i=1:length(fNames)
    img=imread(fNames{i});
    imSize=size(img);
    filename=name{1,i};
    filename=erase(filename,'.tif');
    ref=load(rootdir + "\refMat\ref.mat");
    movie=ref.MD; %duplicate .mat file
    %change image size
    movie.imSize_=imSize;
    %change movieDataPath_
    videosMat=char(videosMat);
    movie.movieDataPath_=videosMat;
    %change movieDataFileName_
    matFilename=filename + ".mat";
    matFilename=char(matFilename);
    movie.movieDataFileName_=matFilename;
    %change output directory
    %matOutput=movie.outputDirectory_ + "\" + i;
    matOutput=output + "\" + i;
    matOutput=char(matOutput);
    movie.outputDirectory_=matOutput;
    %change channel path and name
    movie.channels_.channelPath_=fNames{1,i};
    %save
    matToSave=videosMat + "\" + matFilename;
    %mkdir(matOutput);
    save(matToSave, 'movie');
end
%% build list
List=load(rootdir + "\refList\movieList"); %load ref movie list
refList=List.ML; %duplicate movie list
refList.movieListFileName_='videosList.mat'; %change movie list name
refList.movieListPath_=(char(videosList)); %change movie list path
matNames = dir( fullfile(videosMat,'*.mat') ); %get names of .mat files
matNames = strcat(videosMat, filesep, {matNames.name});
refList.movieDataFile_=matNames; %list .mat files
refList.outputDirectory_=(char(videosList)); %specify list output path, largely useless but necessary
videosList=refList.movieListPath_ + "\" + "videosList.mat"; %create path and filename for movie list
%ML=refList;
save(videosList, 'refList');