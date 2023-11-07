#### usgs timeseries test

library(forecast)
library(stlplus)
library(fpp)


getwd()

USGS = read.csv('USGS-412034119115601-USBLM-DESERT-DACE-SW-TEMP-15-txt.csv', stringsAsFactors = FALSE)
head(USGS)

USGS.ts = ts(USGS$Temperature_C, start = c(2020, 6), end = c(2021, 5), frequency = 200)
plot(USGS.ts, xlab = "Year", ylab="Temperature Celsius")


MA_m6 = ma(USGS.ts, order=6, centre = TRUE)
lines(MA_m6, col="blue", lwd = 2)

MA_m25 = ma(USGS.ts, order=25, centre = TRUE)
lines(MA_m25, col="green", lwd = 2)

MA_m13 = ma(USGS.ts, order=13, centre = TRUE)
lines(MA_m13, col="orange", lwd = 2)

MA_m35 = ma(USGS.ts, order=35, centre = TRUE)
lines(MA_m35, col="red", lwd = 2)

##### Decomp

##### Doesn't work --> Error in decompose(USGS.ts, type = "additive") : time series has no or less than 2 periods


Seasonal_residual_add = USGS.ts - MA_m6
plot(Seasonal_residual_add)


## usgs_decomp = decompose(USGS.ts, type = 'additive')       ### decomposed time series into longtime seasonal variation and random flux not accounted for by long-term trend
### breaks apart big graph into smaller graphs
## plot(fit_add)
