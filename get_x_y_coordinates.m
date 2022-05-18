for i=1:length(tracksFinal)
    tracks(i,1)=tracksFinal(i,1).tracksCoordAmpCG(1,1);
    tracks(i,2)=tracksFinal(i,1).tracksCoordAmpCG(1,2);
    tracks(i,3)=length(tracksFinal(i,1).tracksFeatIndxCG);
    tracks(i,4)=tracksFinal(i,1).seqOfEvents(1,1);
    tracks(i,5)=tracksFinal(i,1).seqOfEvents(2,1);
end