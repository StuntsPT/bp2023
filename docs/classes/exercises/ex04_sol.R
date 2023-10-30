## Blood Pressure
# 1.

bp_f = read.csv("https://docs.google.com/spreadsheet/pub?key=0ArfEDsV3bBwCdHBzUVVSMDlTX1ZCUnNJQ3ZFdkFXVFE&output=csv", header=TRUE, sep=",", row.names=1)
bp_m = read.csv("https://docs.google.com/spreadsheet/pub?key=0ArfEDsV3bBwCdHNwRm9DN1FnT3hXWWZVSncxMkZyS2c&output=csv", header=TRUE, sep=",", row.names=1)

colnames(bp_f) = sub("^X", "", colnames(bp_f))  # This will get rid of the "X" in the name
colnames(bp_m) = sub("^X", "", colnames(bp_m))

bp_f_1985_2005 = bp_f[,6:26]  # Get only the years 1985-2005
pt_f_values = as.numeric(bp_f_1985_2005["Portugal", ])
max_f_y = max(pt_f_values)
min_f_y = min(pt_f_values)

png(filename="~/Bp_w_PT.png", height=900, width=900)  # The file path is set for *nix based operating systems

plot(pt_f_values, type="l", main="Blood pressure PT women 1985-2005", axes=FALSE, xlab="Years", ylab="Blood Pressure (mmHg)", ylim=c(floor(min_f_y), ceiling(max_f_y)))
axis(1, at=1:length(colnames(bp_f_1985_2005)), lab=colnames(bp_f_1985_2005))
axis(2, at=floor(min_f_y):ceiling((max_f_y)), las=1)

dev.off()

# 2.

pt_f_values = as.numeric(bp_f["Portugal", ])
pt_m_values = as.numeric(bp_m["Portugal", ])

max_y = max(c(pt_f_values, pt_m_values))
min_y = min(c(pt_f_values, pt_m_values))

png(filename="~/Bp_wm_PT.png", height=900, width=900) 

plot(pt_f_values, type="l", main="Blood pressure PT 1980-2008", axes=FALSE, xlab="Years", ylab="Blood Pressure (mmHg)", col="violet", ylim=c(floor(min_y), ceiling(max_y)), lwd=4)
lines(pt_m_values, type="l", col="cyan", lwd=4)
axis(1, at=1:length(colnames(bp_f)), lab=colnames(bp_f))
axis(2, at=floor(min_y):(ceiling(max_y)), las=1)

legend("topright", c("Women", "Men"),
       cex=0.8,
       col=c("violet", "cyan"), lwd=4)

dev.off()

# 3.

pt_f_values = as.numeric(bp_f["Portugal", ])
pt_m_values = as.numeric(bp_m["Portugal", ])
es_f_values = as.numeric(bp_f["Spain", ])
es_m_values = as.numeric(bp_m["Spain", ])

y_range = range(pt_f_values, pt_m_values, es_f_values, es_m_values)

png(filename="~/Bp_wm_PT_vs_ES.png", height=900, width=900)

plot(pt_f_values, type="l", main="Blood pressure PT 1980-2008", axes=FALSE, xlab="Years", ylab="Blood Pressure (mmHg)", col="forestgreen", ylim=c(floor(y_range[1] - 1),ceiling(y_range[2])), lwd=4)
lines(pt_m_values, type="l", col="forestgreen", lwd=4, lty=2)
lines(es_f_values, type="l", col="yellow", lwd=4, lty=1)
lines(es_m_values, type="l", col="yellow", lwd=4, lty=2)

axis(1, at=1:length(colnames(bp_f)), lab=colnames(bp_f))
axis(2, at=floor(y_range[1] - 1):ceiling(y_range[2]), las=1)

legend("topright", c("PT ♀", "PT ♂ ", "ES ♀", "ES ♂ "),
       cex=0.8,
       col=c("forestgreen", "forestgreen", "yellow", "yellow"),
       lwd=4, lty=c(1, 2, 1, 2))

dev.off()

# 4.

male_subset = bp_m[c("China", "Canada", "Finland", "Greece"), c("1980","1990","2000")]  # Use lines and columns indexing
female_subset = bp_f[c("China", "Canada", "Finland", "Greece"), c("1980","1990","2000")]

country_colours = c("darkred", "red", "white", "cyan")  # Set colours outside

png(filename="~/Bp_barplots.png", height=900, width=1300)

par(mfrow=c(1,2), xpd=T, mar=par()$mar+c(0,0,0,4))

barplot(as.matrix(male_subset), main="♂ blood pressure levels",
        col=country_colours, beside=TRUE, xlab="Years",
        ylab="Blood pressure  (mmHg)", las=1,
        ylim=c(0, max(male_subset) + max(male_subset, female_subset) * 0.1))

legend(15.5, 120, c("China", "Canada", "Finland", "Greece"),
       cex=1,
       fill=country_colours)

barplot(as.matrix(female_subset), main="♀ blood pressure levels",
        col=country_colours, beside=TRUE, xlab="Years",
        ylab="Blood pressure  (mmHg)", las=1,
        ylim=c(0, max(male_subset, female_subset) * 1.1))

dev.off()

## Pokedata Pt. 2
# 1.
pokedata = read.csv("https://gitlab.com/StuntsPT/bp2023/raw/master/docs/classes/exercises/poke_data.csv", header=TRUE, sep=",")

max_hp = as.numeric(max(pokedata$hp))

png(filename="~/HP_hist.png", height=1000, width=1000)

hist(pokedata$hp, xlab="HP", main="Histogram of Pokemon HP", col="red", axes=FALSE, ylim=c(0,400), las=1)
axis(1, at=seq(0, max_hp + 5, by=20))
axis(2, at=seq(0, 400, 50))

dev.off()

max_sp_def = max(pokedata$sp_defense)

png(filename="~/Sp.def_hist.png", height=1000, width=1000)

hist(pokedata$sp_defense, xlab="Special Defense",
     main="Histogram of Pokemon Sp. Defense",
     col="gold", axes=FALSE,
     xlim=c(0, max_sp_def + 50),
     ylim=c(0,300),
     las=1)
axis(1, at=seq(0, max_sp_def + 50, by=20))
axis(2, at=seq(0, 300, by=50))

dev.off()

max_speed = max(pokedata$speed)

png(filename="~/Speed_hist.png", height=1000, width=1000)

hist(pokedata$speed, xlab="Speed",
     main="Histogram of Pokemon Speed",
     col="orange",
     xlim=c(0, max_speed + 50),
     ylim=c(0,300),
     las=1)

dev.off()

# 2.

png(filename="~/HP_vs_Defense.png", height=1000, width=1200)

plot(x=pokedata$sp_defense, y=pokedata$defense, pch="x", col="blue", xlab="Sp. Defense",
     ylab="Defense", main="Pokemon Special Defense Vs. Defense",
     las=1)

dev.off()

png(filename="~/HP_vs_Sp_Defense.png", height=1000, width=1200)

plot(x=pokedata$sp_attack, y=pokedata$attack, pch="x", col="darkgreen", xlab="Sp. Attack",
     ylab="Attack", main="Pokemon Special Attack Vs. Attack",
     las=1)

dev.off()

# 3.

fire_sp_attack = pokedata[pokedata[,"type1"] == "Fire" | pokedata[,"type2"] == "Fire", "sp_attack"]
water_sp_attack = pokedata[pokedata[,"type1"] == "Water" | pokedata[,"type2"] == "Water", "sp_attack"]
electric_sp_attack = pokedata[pokedata[,"type1"] == "Electric" | pokedata[,"type2"] == "Electric", "sp_attack"]
ice_sp_attack = pokedata[pokedata[,"type1"] == "Ice" | pokedata[,"type2"] == "Ice", "sp_attack"]
grass_sp_attack = pokedata[pokedata[,"type1"] == "Grass" | pokedata[,"type2"] == "Grass", "sp_attack"]

png(filename="~/Sp.Attack_by_type.png", height=1000, width=1200)

boxplot(fire_sp_attack, water_sp_attack, electric_sp_attack, ice_sp_attack, grass_sp_attack,
        ylab="Sp. Attack", xlab="Pokemon type",
        col=c("red", "lightblue", "gold", "white", "forestgreen"),
        main="Pokemon Sp. Attack by type", axes=FALSE, notch=TRUE,
        ylim=c(0,max(fire_sp_attack, water_sp_attack, electric_sp_attack, ice_sp_attack, grass_sp_attack)))
axis(1, at=1:5, labels=c("Fire", "Water", "Electric", "Ice", "Grass"))
axis(2,
     at=seq(0, max(fire_sp_attack, water_sp_attack, electric_sp_attack, ice_sp_attack, grass_sp_attack), by=20),
     las=1)
box()

dev.off()

# 4.

png(filename="~/Sp.Attack_by_type.png", height=2000, width=2400)

par(mfrow=c(2,2))

fire_sp_attack = pokedata[pokedata[,"type1"] == "Fire" | pokedata[,"type2"] == "Fire", "sp_attack"]
water_sp_attack = pokedata[pokedata[,"type1"] == "Water" | pokedata[,"type2"] == "Water", "sp_attack"]
electric_sp_attack = pokedata[pokedata[,"type1"] == "Electric" | pokedata[,"type2"] == "Electric", "sp_attack"]
ice_sp_attack = pokedata[pokedata[,"type1"] == "Ice" | pokedata[,"type2"] == "Ice", "sp_attack"]
grass_sp_attack = pokedata[pokedata[,"type1"] == "Grass" | pokedata[,"type2"] == "Grass", "sp_attack"]

boxplot(fire_sp_attack, water_sp_attack, electric_sp_attack, ice_sp_attack, grass_sp_attack,
        ylab="Sp. Attack", xlab="Pokemon type",
        col=c("red", "lightblue", "gold", "white", "forestgreen"),
        main="Pokemon Sp. Attack by type", axes=FALSE, notch=TRUE)
axis(1, at=1:5, labels=c("Fire", "Water", "Electric", "Ice", "Grass"))
axis(2, at=seq(0, max(fire_sp_attack, water_sp_attack, electric_sp_attack, ice_sp_attack, grass_sp_attack), by=20))
box()

fire_sp_def = pokedata[pokedata[,"type1"] == "Fire" | pokedata[,"type2"] == "Fire", "sp_defense"]
water_sp_def = pokedata[pokedata[,"type1"] == "Water" | pokedata[,"type2"] == "Water", "sp_defense"]
electric_sp_def = pokedata[pokedata[,"type1"] == "Electric" | pokedata[,"type2"] == "Electric", "sp_defense"]
ice_sp_def = pokedata[pokedata[,"type1"] == "Ice" | pokedata[,"type2"] == "Ice", "sp_defense"]
grass_sp_def = pokedata[pokedata[,"type1"] == "Grass" | pokedata[,"type2"] == "Grass", "sp_defense"]

boxplot(fire_sp_def, water_sp_def, electric_sp_def, ice_sp_def, grass_sp_def,
        ylab="Sp. Defense", xlab="Pokemon type",
        col=c("red", "lightblue", "gold", "white", "forestgreen"),
        main="Pokemon Sp. Defense by type", axes=FALSE, notch=TRUE)
axis(1, at=1:5, labels=c("Fire", "Water", "Electric", "Ice", "Grass"))
axis(2, at=seq(0, max(fire_sp_def, water_sp_def, electric_sp_def, ice_sp_def, grass_sp_def), by=20))
box()

fire_speed = pokedata[pokedata[,"type1"] == "Fire" | pokedata[,"type2"] == "Fire", "speed"]
water_speed = pokedata[pokedata[,"type1"] == "Water" | pokedata[,"type2"] == "Water", "speed"]
electric_speed = pokedata[pokedata[,"type1"] == "Electric" | pokedata[,"type2"] == "Electric", "speed"]
ice_speed = pokedata[pokedata[,"type1"] == "Ice" | pokedata[,"type2"] == "Ice", "speed"]
grass_speed = pokedata[pokedata[,"type1"] == "Grass" | pokedata[,"type2"] == "Grass", "speed"]

boxplot(fire_speed, water_speed, electric_speed, ice_speed, grass_speed,
        ylab="Speed", xlab="Pokemon type",
        col=c("red", "lightblue", "gold", "white", "forestgreen"),
        main="Pokemon Speed by type", axes=FALSE, notch=TRUE)
axis(1, at=1:5, labels=c("Fire", "Water", "Electric", "Ice", "Grass"))
axis(2, at=seq(0, max(fire_speed, water_speed, electric_speed, ice_speed, grass_speed), by=20))
box()

fire_hp = pokedata[pokedata[,"type1"] == "Fire" | pokedata[,"type2"] == "Fire", "hp"]
water_hp = pokedata[pokedata[,"type1"] == "Water" | pokedata[,"type2"] == "Water", "hp"]
electric_hp = pokedata[pokedata[,"type1"] == "Electric" | pokedata[,"type2"] == "Electric", "hp"]
ice_hp = pokedata[pokedata[,"type1"] == "Ice" | pokedata[,"type2"] == "Ice", "hp"]
grass_hp = pokedata[pokedata[,"type1"] == "Grass" | pokedata[,"type2"] == "Grass", "hp"]

boxplot(fire_hp, water_hp, electric_hp, ice_hp, grass_hp,
        ylab="HP", xlab="Pokemon type",
        col=c("red", "lightblue", "gold", "white", "forestgreen"),
        main="Pokemon HP by type", axes=FALSE, notch=TRUE)
axis(1, at=1:5, labels=c("Fire", "Water", "Electric", "Ice", "Grass"))
axis(2, at=seq(0, max(fire_hp, water_hp, electric_hp, ice_hp, grass_hp), by=20))
box()

dev.off()

# Alternative solution by Joana Rocha (2022-2023)
# Automated, so come back here **after** learning about functions and for loops
pokemons = read.csv("https://gitlab.com/StuntsPT/bp2023/raw/master/docs/classes/exercises/poke_data.csv", header=TRUE, sep=",")

types = function(data, ycols1, ycols2, type) {
  
  cols = data[,ycols1] == type | data[,ycols2] == type
  
  return(cols) 
  
}

type=c("Fire", "Water","Electric", "Ice", "Grass")
my_dataframes = c()

for (i in type ) {
  
  my_dataframes = cbind(my_dataframes, types(pokemons, "type1", "type2", i))
  
}


poketype = function(data, xcols, main, colours) {
  
  cols = data[,xcols]
  
  plot = boxplot(cols[my_dataframes[,1]],cols[my_dataframes[,2]],cols[my_dataframes[,3]],cols[my_dataframes[,4]],cols[my_dataframes[,5]],
                 col=colours,
                 main=main,
                 xlab=xcols,
                 ylim=c(0,max(data[,xcols])),
                 axes=F, notch=TRUE)
  axis(1, at=1:5, labels=type)
  axis(2,at=seq(0, max(cols), by=20),las=1)
  box()
  
  return(plot) 
  
}

stat= c("sp_attack", "sp_defense", "speed", "hp")
colours= c("red4", "steelblue2", "yellow", "lightskyblue1", "palegreen")
type=c("Fire", "Water","Electric", "Ice", "Grass")

for (i in stat) {
  
  poketype(pokemons, i, "Different types", colours)
  
}