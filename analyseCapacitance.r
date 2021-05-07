## Routines for analysis of capacitance data

## Finds indices where capacitance starts
capfindStepOnset=function(fitA, thresh=0.05) {
    return (
        which(
            diff(fitA$value)>=thresh
        )
    )
}

## Finds indices of local maxima in vector of values v
capfindLocalMax=function(v) {
    return (
        which(
            diff(
                sign(
                    diff(v)
                )
            )==-2) + 1
    )
}

## Finds peak of local maximum: Start with index of ONSET
capfindStepPeak=function(fitA,i0) {
    locmax=capfindLocalMax(fitA$value)
    return (
        locmax[
            min(
                which(locmax>i0)
            )
        ]
    )
}

## Finds indices of local minima in vector of values v
capfindLocalMin=function(v) {
    return (
        which(
            diff(
                sign(
                    diff(v)
                )
            )==2) + 1
    )
}

## Finds peak of local maximum: Start with index of ONSET
capfindStepLow=function(fitA,i0) {
    locmin=capfindLocalMin(fitA$value)
    return (
        locmin[
            min(
                which(locmin>i0)
            )
        ]
    )
}

## Finds first local maxima after each step onset
capfindPeaks=function(fitA, onsets=capfindStepOnset(fitA)) {
    sapply (X=onsets, FUN=function(i0) {
        capfindStepPeak(fitA,i0)
    })
}

## Finds first local maxima after each step onset
capfindLows=function(fitA, max=capfindPeaks(fitA)) {
    sapply (X=max, FUN=function(i0) {
        capfindStepLow(fitA,i0)
    })
}

## Calculates statistics of all events detected.
## Known bugs: Fails when no events are detected
capReport=function(fitA, threshold=0.05) {
    report=data.frame(onsetInd=capfindStepOnset(fitA,thresh=threshold))
    report$onsets=fitA$rightEnd[report$onsetInd]
    report$onsetVal=fitA[report$onsetInd,]$value
    report$peakInd=capfindPeaks(fitA,onsets=report$onsetInd)
    report$peakLoc=(fitA$rightEnd[report$peakInd]+fitA$leftEnd[report$peakInd])/2
    report$peakValue=fitA$value[report$peakInd]
    report$terminationInd=capfindLows(fitA,max=report$peakInd)
    report$termination=fitA$leftEnd[report$terminationInd]
    report$terminationVal=fitA$value[report$terminationInd]
    return (report)
}

## Creates a new vector by interleaving the vectors c1 and c2
zipVectors=function(c1,c2) {
    as.vector(mapply(c, c1,c2))
}

## Generates a vector for selecting from a data frame
segmentSelector=function(v, segVec) {
    segments=cut(v, segVec, labels=FALSE)
    segments[is.na(segments)]=0
    return (segments)
}

## Select segments from a data set df using the vector segments that
## provides the segmentation - non-selected data points are replaced
## by NA
selectSegments=function(df, segments) {
    dfSelect=df
    dfSelect[segments%%2==0,]=NA
    return(dfSelect)
}

## Plots raw data df and marks events dfEvents in different colour
capplotEvents=function(df, dfEvents, eventsCol="blue", ...) {
    plot(df, pch=".", ...)
    points(dfEvents,col=eventsCol, pch=".")
}
