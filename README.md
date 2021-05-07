# capacitance

`analyseCapacitance.r` contains routines for analysing capacitance
data. It depends on the library `R` library
[stepR](https://cran.r-project.org/web/packages/stepR/index.html). This
library implements the multiscale regression estimators `SMUCE`
(K. Frick, A. Munk and H. Sieling, 2014)
<[doi:10.1111/rssb.12047](https://doi.org/10.1111%2Frssb.12047)> and
`HSMUCE` (F. Pein, H. Sieling and A. Munk, 2017)
<[doi:10.1111/rssb.12202](https://doi.org/10.1111%2Frssb.12202)>.

- `capfindStepOnset(fitA, thresh=0.05)`: finds the onset of an event
  by checking if a threshold `thresh` has been exceeded in a step
  function represented in the `stepR::stepfit` object `fitA`. Returns
  an index.

- `capfindStepPeak(fitA, i0)`: Finds the index of the next local
  maximum in the step function represented in the `stepR::stepfit`
  object `fitA` starting from index `i0`. Returns an index.

- `capfindStepLow(fitA, i0)`: Finds the index of the next local
  minimum in the step function represented in the `stepR::stepfit`
  object `fitA` starting from index `i0`. Returns an index.

- `capfindPeaks=function(fitA, onsets=capfindStepOnset(fitA))`: Finds
  first local maxima after each detected onset in the step function
  represented in the `stepR::stepfit` object `fitA`. Returns a vector
  of indices.

- `capfindLows=function(fitA, onsets=capfindStepOnset(fitA))`: Finds
  first local minima after each detected peak in the step function
  represented in the `stepR::stepfit` object `fitA`. These are
  interpreted as points where an event terminates. Returns a vector of
  indices.

- `capReport(fitA, threshold=0.05)`: Returns a data frame containing
  indices of onset, peak and termination of each event detected in the
  step function represented in the `stepR::stepfit` object
  `fitA`. Also determines the values attained by the step function at these
  indices. 
