## Exercise 1
# a)
costal_phytoplankton = read.csv("https://gitlab.com/StuntsPT/bp2021/raw/master/docs/exam_data/phyto_costal.csv", header=T, sep=";", row.names=1)
offshore_phytoplankton = read.csv("https://gitlab.com/StuntsPT/bp2021/raw/master/docs/exam_data/phyto_offshore.csv", header=T, sep=";", row.names=1)

plankton_plotter = function(datafile, title, save_file) {
  y_limits = range(datafile)
  png(filename=save_file, width=1200, height=800)
  plot(as.numeric(datafile[1,]),
       ylim=y_limits,
       type="l",
       lwd=3,
       col=1,
       axes=F,
       xlab="Year",
       ylab="Phytoplankton annual mean biovolume (MgL/L)",
       main=title)
  
  axis(1, at=1:length(colnames(datafile)), labels=colnames(datafile))
  axis(2, at=seq(y_limits[1], y_limits[2], length.out=6))
  
  for (i in 2:length(row.names(datafile))) {
    lines(as.numeric(datafile[i,]), lwd=3, col=i)
  }
  
  legend("topright", legend=row.names(datafile), lty=1, lwd=3, col=1:length(row.names(datafile)))
  dev.off()
}

plankton_plotter(t(costal_phytoplankton), "Costal phytoplankton [] across years", "~/lineplot_plankton_costal.png")
plankton_plotter(t(offshore_phytoplankton), "Offshore phytoplankton [] across years", "~/lineplot_plankton_offshore.png")

# These plots show how the [] of each plankton category evolves across the studied range.
# In both locations "DinoAUMX", "Diatomophyceae, and "Litosomatea" are generally higher than other taxa.
# They also fluctuate more across the measured range than other taxa, and display a somewhat descending trend.
# "Prasinophyceae", "DinoHT", "Cryptophyceae", and "Nostocophyceae" have a relatively lower [],
# and a generally stable trend across the studied range.

avg_costal = apply(costal_phytoplankton, 1, mean)
avg_offshore = apply(offshore_phytoplankton, 1, mean)

plot(x=as.numeric(row.names(costal_phytoplankton)), y=avg_costal, type="l")
lines(x=as.numeric(row.names(offshore_phytoplankton)), y=avg_offshore)

# b) (prova A)
shapiro.test(as.numeric(costal_phytoplankton["2009",]))
shapiro.test(as.numeric(costal_phytoplankton["2008",]))
t.test(x=as.numeric(costal_phytoplankton["2009",]), y=as.numeric(costal_phytoplankton["2008",]), paired=T)

# b) (prova B)
shapiro.test(as.numeric(offshore_phytoplankton["2009",]))
shapiro.test(as.numeric(offshore_phytoplankton["2008",]))
wilcox.test(x=as.numeric(offshore_phytoplankton["2009",]), y=as.numeric(offshore_phytoplankton["2008",]), paired=T)

# The upwelling event did not affect the plankton [].


# c), d) and e)
small_costal_phytoplankton = costal_phytoplankton[as.character(1994:2011),]



generic_correlation = function(x_data, y_data, x_label, y_label, title, file_name, alpha) {
  if (shapiro.test(x_data)$p.value < alpha |
      shapiro.test(y_data)$p.value < alpha) {
    cor_method = "spearman"
  } else {
    cor_method = "pearson"
  }
  significance = cor.test(x=x_data, y=y_data, method=cor_method)$p.value
  model = lm(y_data ~ x_data)
  strength = cor.test(x=x_data, y=y_data, method=cor_method)$estimate
  
  png(filename=file_name, width=600, height=500)
  plot(x=x_data, y=y_data,
       ylim=range(y_data)*c(0.8,1.20),
       xlim=range(x_data)*c(0.8,1.10),
       xlab=x_label,
       ylab=y_label,
       main=title,
       pch="o",
       col="3")
  abline(model, lwd=3, col="navy")
  dev.off()
  
  return(c(significance, strength, cor_method))
}

litocorr = generic_correlation(x_data=small_costal_phytoplankton$Litostomatea,
                               y_data=offshore_phytoplankton$Litostomatea,
                               x_label="Costal Litostomatea []",
                               y_label="Offshor Litostomatea []",
                               title="Costal Litostomatea [] Vs. Offshore Litostomatea []",
                               file_name="~/Correlation_Lito.png",
                               alpha=0.05)
print(litocorr)
# There is no significant (p > 0.05) correlation between costal and offshore Litostomatea [].
# Since R is low (0.03), it means that it is not possible to accurately
# infer costal Litostomatea [] from offshore Litostomatea [] and vice versa.

dinocorr = generic_correlation(x_data=small_costal_phytoplankton$DinoAUMX,
                               y_data=offshore_phytoplankton$DinoAUMX,
                               x_label="Costal DinoAUMX []",
                               y_label="Offshor DinoAUMX []",
                               title="Costal DinoAUMX [] Vs. Offshore DinoAUMX []",
                               file_name="~/Correlation_Dino.png",
                               alpha=0.05)
print(dinocorr)
# There is no significant (p > 0.05) correlation between costal and offshore DinoAUMX [].
# Since R is low (0.21), it means that it is not possible to accurately
# infer costal DinoAUMX [] from offshore DinoAUMX [] and vice versa.

dinHcorr = generic_correlation(x_data=small_costal_phytoplankton$DinoHT,
                               y_data=offshore_phytoplankton$DinoHT,
                               x_label="Costal DinoHT []",
                               y_label="Offshor DinoHT []",
                               title="Costal DinoHT [] Vs. Offshore DinoHT []",
                               file_name="~/Correlation_DinoHT.png",
                               alpha=0.05)
print(dinHcorr)
# There is a significant (p > 0.05) correlation between costal and offshore DinoHT [].
# Since rho is somewhat low (0.52), it means that it is not possible to accurately
# infer costal DinoHT [] from offshore DinoHT [] and vice versa.


## Exercise 2

patients = read.csv("https://gitlab.com/StuntsPT/bp2021/raw/master/docs/exam_data/mystery_disease.tsv", header=TRUE, sep="\t")

# a)
print(table(patients$Symptom))

# b)
barplot(table(patients$Symptom),
        beside=TRUE,
        col=c("cyan","forestgreen", "darkred", "gold"),
        ylim=c(0, max(table(patients$Symptom)*1.20)),
        xlab="Symptoms",
        ylab="Frequency",
        main="Frequency of disease symptoms")

# c)

obs = table(patients$Symptom)
obs=c(1135, 558, 600, 216)  # Poor alternative
exp = c(4/9, 2/9, 2/9, 1/9)

chisq.test(x=obs, p=exp)

p_vals = c()

for (i in 1:length(obs)) {
  partial_obs = c(obs[i], sum(obs[-i]))
  partial_exp = c(exp[i], sum(exp[-i]))
  part_chisq = chisq.test(x=partial_obs, p=partial_exp)
  
  p_vals[i] = part_chisq$p.value
}

print(p_vals)
p.adjust(p_vals, method="fdr")

# d)
# H0: The observed proportions of symptoms are not significantly different from the expected proportions
# REJECTED!

# H0: The observed proportion of Abdominal bloat is not significantly different from the expected
# Not rejected

# H0: The observed proportion of back pimples is not significantly different from the expected
# Not rejected

# H0: The observed proportion of baldness is not significantly different from the expected
# Not rejected

# H0: The observed proportion of black nails bloat is not significantly different from the expected
# REJECTED!



## Exercise 3

chamaleon = read.csv("/home/francisco/Syncthing/general/Classes/FCUL/2021-2022/Bioinformática_Prática/bp2021/docs/exam_data/Ccham.csv", header=TRUE, sep=",")

# a)
print(table(chamaleon$Region))

# b)
print(length(colnames(chamaleon)[-c(1,2,3)]))

# c)
just_morph_data = chamaleon[,4:length(chamaleon)]

install.packages("BiocManager")
BiocManager::install("pcaMethods")
library(pcaMethods)

color_categories = chamaleon$Capture

morph_pca <- pca(just_morph_data, scale="vector", center=TRUE, nPcs=2, method="nipals")

png(filename="~/PCA_Cchamaleon_nocols.png")
slplot(morph_pca,
       scoresLoadings=c(T,F),
       main="PCA from T. chamaleon morphological data")
dev.off()

# The PCA does not reveal any sort of individual clustering. Adding a discriminant might change that.


# d)
png(filename="~/PCA_Cchamaleon.png")
slplot(morph_pca,
       scol=color_categories,
       scoresLoadings=c(T,F),
       main="PCA from T. chamaleon morphological data")
legend("topright",
       legend=c("Night", "Day"),
       col=unique(color_categories),
       pch=1)
dev.off()

# The measured characteristics do not seem to be able to discern whether an individual was sampled at night or during the day.

# e)
png(filename="~/PCA_loadings_chamaleon.png")
slplot(morph_pca,
       scol=color_categories,
       scoresLoadings=c(F,T))
dev.off()

# Head_length and Snout.Vent_length

# f)
indy = table(chamaleon[,c(2,3)])

fisher.test(indy)
