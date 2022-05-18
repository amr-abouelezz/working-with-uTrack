# working-with-uTrack
For running uTrack on multiple videos and extracting data from the analysis

I use uTrack to track and analyse endocytic events from live-cell videos. These are some poorly-written scripts to make my life easier.

For batch processing, the original code needs to be slightly modified to get rid of some protections.

The analysis is based on 5-minute movies at 1 frame/second. A pit is defined as an event between 20 and 120 seconds long.
