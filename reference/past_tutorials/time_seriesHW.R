######## Time Decomp Homework
##### Madison Harris


getwd()
tucson = read.csv('data/tucson_prism_monthly.csv')
head(tucson)
### all columns except Date are numnbers, Date is character

tucson.ts = ts(tucson$tmin_C, start = c(1895, 01), end = c(2018, 07), frequency = 2)
#### turns into value ordered by date, only showing tmin, lowered freq from original example
plot(tucson.ts, xlab = "Year", ylab = "Minimum Temp C")


#### copy-paste from tutorial
### ts = timeseries command
### frequency: how often a year data was measured

class(tucson.ts)
tucson.ts
start(tucson.ts)
end(tucson.ts)

#### can get basic info (start/end) from the dataframe


# You cannot slice and dice a ts object without losing the date info, unless you
# use a special tool
str(tucson.ts)
data.2000 = window(tucson.ts, start=c(1999,1),end=c(2000,12))
data.2000

# Extracting a trend

# a moving average is a classic way of extracting the 'cross year'  
# pattern in the data

# We lose data on the front and back because as the name implies it is 
# averaging over a window of values. Order is the size of the window. 

MA_m11 = ma(tucson.ts, order=11, centre = TRUE)

plot(tucson.ts)
lines(MA_m11, col="blue", lwd = 3)

MA_m49 = ma(tucson.ts, order=49, centre = TRUE)

###     order value changes to get a MORE average trend line

plot(tucson.ts)
lines(MA_m49, col="blue", lwd = 3)

#MA_m12 = ma(tucson.ts, order=12, centre = FALSE)
#MA_2x12 = ma(MA_m12, order=2,centre=FALSE)
#plot(tucson.ts)
#lines(MA_m12, col="green", lwd = 3)

# Classic Decomposition uses a Moving Average to obtain a trend, then detrend the observed data.

# Two basic ways to remove a seasonal signal - additive or multiplicative. 

# Additive: Observed = Trend + Seasonal + Irregular (fluctuations in the time series stable with trend)
# Multiplicative: Observed = Trend*Seasonal*Irregular (fluctuations in the time series increase with trend)
# In our data, not much of a trend, no clear relationship between trend and seasonality

Seasonal_residual_add = tucson.ts - MA_m49
plot(Seasonal_residual_add)

Seasonal_residual_multi = tucson.ts/MA_m49
plot(Seasonal_residual_multi)

fit_add = decompose(NDVI.ts, type = 'additive')       ### decomposed time series into longtime seasonal variation and random flux not accounted for by long-term trend
### breaks apart big graph into smaller graphs
plot(fit_add)
str(fit_add)    ### just lists out whats in the data window. list of 6 listed out

#What is the moving average window, hard to tell based on function documentation and output

fit_mult = decompose(NDVI.ts, type = 'multiplicative')
plot(fit_mult)
str(fit_mult)

# It's hard to see the seasonal pattern, so let's zoom in.
# by subsetting the seasonal fits:
plot(fit_add$seasonal[11:23],type="o") # started at 11 b/c it is the first January

# Would we get the same answer just by calculating monthly means?
# Use tapply() and cycle():
monthly_means <- tapply(NDVI.ts, cycle(NDVI.ts), FUN=mean)
plot(monthly_means,type="o")