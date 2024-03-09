########  brundage snowpit data

library(ggplot2)

head(Snowpit_data_brundage)
head(snowpit_data_temp)

pit_brundage = Snowpit_data_brundage
pit_temp = snowpit_data_temp


d = 0.8
k  = 0.00213
Tb = 21.6
A = 367.17
Ta = -4.6

surface = ((k*A))*((Tb-Ta)/d)
surface ##    25.61286

surface = ((0.00213 W/cm*K * 367.17 cm^2))*((21.6 C - (-4.6 C))/0.8 cm)
subniv = ((0.00213 W/cm*K * 367.17 cm^2))*((21.6 C - 0.7 C)/0.8 cm)


subnv = ((k*A))*((Tb-0.7)/d)
subnv ##      20.43163

## metabolic equation
##    Qa = (k * A) * ((Tb-Ta)/d)
##    k = thermal conductivity, A = surface area, Tb = core temp. Ta = air temp, d = insulation thickness


#### table

table()

