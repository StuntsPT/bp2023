## Possible solutions for class 02 exercises (https://stuntspt.gitlab.io/bp2022/classes/exercises/ex02.html)

## 1. Data Structures

scratch_df = data.frame(c1=c(1,1,1,1), c2=c(2,2,2,2), c3=c(3,3,3,3))
rownames(scratch_df) = c("r1", "r2", "r3", "r4")

## 2. Diatoms data

diatoms_data = read.csv("../diatoms_data.csv", header=TRUE, row.names=2, sep=",")
#Use online data:
diatoms_data = read.csv("https://gitlab.com/StuntsPT/bp2022/raw/master/docs/classes/C05_assets/Dados_diatoms_heavymetals.csv", row.names=2)
diatoms_data["CC1", "Richness"]
diatoms_data[,"Diversity"]
diatoms_data["DC1",]
diatoms_data[diatoms_data[, "Stream"] == "SR", ]

## 3. Online data

# 3.1
pokedata = read.csv("https://gitlab.com/StuntsPT/bp2022/raw/master/docs/classes/exercises/poke_data.csv", header=TRUE, sep="\t", row.names=2)

# 3.2
View(pokedata)

# 3.3
min_hp = min(pokedata[,"hp"])
min_hp_pokemon = row.names(pokedata[pokedata[, "hp"] == min_hp, ])

max_hp = max(pokedata[,"hp"])
max_hp_pokemon = row.names(pokedata[pokedata[, "hp"] == max_hp, ])

# 3.4
table(pokedata$type1)

table(pokedata[pokedata$Generation == 1, "type1"])

# 3.5
water_type_pokemon = pokedata[pokedata[,"type1"] == "Water" | pokedata[,"type2"] == "Water", ]
max_sp_attack = max(water_type_pokemon[, "sp_attack"])
max_sp_attack_water_pokemon = row.names(water_type_pokemon[water_type_pokemon[, "sp_attack"] == max_sp_attack, ])
