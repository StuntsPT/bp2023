# Bonus exercises solutions

# 1.1
cholesterol_plots = function(full_data, title, save_location) {
    mean_chol = apply(full_data, 2, mean)
    median_chol = apply(full_data, 2, median)
    cholrange = range(mean_chol, median_chol)

    years = names(full_data) = sub("^X", "", names(full_data))
    # Alternatively have an extra argument named "years" with a vector of years

    png(filename=save_location, width=700, height=700)
    plot(x=years,
         y=mean_chol,
         type="l",
         col="red",
         lwd=2,
         main=title,
         ylab="Cholesterol concentration (mmol/L)",
         xlab="Years",
         ylim=cholrange,
         axes=FALSE)
    lines(x=years,
          y=median_chol,
          type="l",
          col="blue",
          lwd=2)
    axis(1, at=years, labels=years)
    axis(2, las=1,
         at=round(seq(cholrange[1] * 0.999, cholrange[2] * 1.001, length.out=5), 2))
    legend("topright",
           inset=.05,
           c("Mean", "Median"),
           lwd=2, col=c("red", "blue"))
    dev.off()
}

# Data downloading
male_chol = read.csv("http://docs.google.com/spreadsheet/pub?key=0ArfEDsV3bBwCdDU5SnRoQ0xlZWhwRUZ6RFNQV042enc&output=csv", header=TRUE, row.names=1)
female_chol = read.csv("http://docs.google.com/spreadsheet/pub?key=0ArfEDsV3bBwCdGJHcHZkSUdBcU56aS1OT3lLeU4tRHc&output=csv", header=TRUE, row.names=1)

# Male cholesterol plot
cholesterol_plots(full_data=male_chol,
                  title="Mean Cholesterol concentration in male patient's blood, from 1980 to 2008",
                  save_location="~/male_plot.png")

# Female cholesterol plot
cholesterol_plots(full_data=female_chol,
                  title="Mean Cholesterol concentration in female patient's blood, from 1980 to 2008",
                  save_location="~/female_plot.png")

# 1.2
malaria_cases = read.csv("http://docs.google.com/spreadsheet/pub?key=pp59adS3CHWczfPHQMiqxCg&output=csv", header=TRUE, row.names=1)
malaria_deaths = read.csv("http://docs.google.com/spreadsheet/pub?key=pp59adS3CHWfZGL9qouvTbQ&output=csv", header=TRUE, row.names=1)

shapiro.test(malaria_deaths$X2003)
shapiro.test(malaria_deaths$X2005)
# Both samples' distributions are significantly different from a normal distribution.
# A non-parametric test should be used.

wilcox.test(x=malaria_deaths$X2003, y=malaria_deaths$X2005, paired=TRUE)
# There are no significant differences between the number of malaria deaths in 2003 and 2005.

# 1.3
exp=c(22,25,3,19,31,7,55,28)
obs=c(7,15,1,6,10,2,18,9)

binom.test(x=obs[2], n=sum(obs), p=exp[2]/sum(exp), alternative="greater")

# H0: The number of "Mimbulus mimbletoina" specimens in the greenhouse is not not significantly greater than what is expected based on the records.
# Since H0 is rejected, that means that the number of "Mimbulus mimbletoina" in the greenhouse is significantly greater than what should be expected
# and therefore it may be indicated as a possible cause for the incident.
# Neville, we are all looking at you and your plants...

# 2.1
malaria_corr = function(deaths, cases, save_path) {
    death_norm_test = shapiro.test(deaths)$p.value
    cases_norm_test = shapiro.test(cases)$p.value

    if (death_norm_test < 0.05 | cases_norm_test < 0.05) {
        test_res = cor.test(x=cases, y=deaths, method="spearman")
    } else {
        test_res = cor.test(x=cases, y=deaths, method="pearson")
    }
    png(filename=save_path)
    plot(x=cases,
         y=deaths,
         col="green",
         ylab="Number of malaria caused deaths",
         xlab="Number of malaria cases",
         main="Worldwide malaria cases Vs. worldwide malaria caused deaths")
    abline(lm(deaths ~ cases), col="blue", lwd=3)
    dev.off()
    return(c(test_res$p.value, test_res$estimate))
}

malaria_cases = subset(malaria_cases, row.names(malaria_cases) %in% row.names(malaria_deaths))
print(malaria_corr(deaths=as.matrix(malaria_deaths),
                   cases=as.matrix(malaria_cases),
                   save_path="~/malaria_corrplot.png"))

# There is a correlation between the worldwide number of malaria cases & deaths
# However, Spearman's "rho" is very low, which means the number of reported 
# malaria cases is not a good predictor for the number of deaths.

# 2.2
# H0: When the number of malaria cases increases, the number of malaria deaths
# does not significantly increase or decrease

# 2.3
# Done above

# 2.4
malaria_trendplot = function(full_data, title, save_location, ylab) {
    total_malaria = apply(as.matrix(full_data), 2, sum, na.rm=TRUE)

    years = names(full_data) = sub("^X", "", names(full_data))
    # Alternatively have an extra argument named "years" with a vector of years
    lims = range(total_malaria)

    png(filename=save_location)
    plot(x=years,
         y=total_malaria,
         type="l",
         col="red",
         lwd=2,
         main=title,
         ylab=ylab,
         xlab="Years",
         axes=FALSE,
         ylim=c(lims[1] * 0.95, lims[2] * 1.05))
    axis(1)
    axis(2, at=seq(lims[1] * 0.95, lims[2] * 1.05, length.out = 4))
    dev.off()
}

malaria_cases = read.csv("http://docs.google.com/spreadsheet/pub?key=pp59adS3CHWczfPHQMiqxCg&output=csv", header=TRUE, row.names=1)
malaria_deaths = read.csv("http://docs.google.com/spreadsheet/pub?key=pp59adS3CHWfZGL9qouvTbQ&output=csv", header=TRUE, row.names=1)

malaria_trendplot(full_data=malaria_cases, title="Worldwide malaria cases over time", save_location="~/malaria_cases_trendplot.png", ylab="Number of malaria cases")
malaria_trendplot(full_data=malaria_deaths, title="Worldwide malaria deaths over time", save_location="~/malaria_deaths_trendplot.png", ylab="Number of malaria deaths")

# 3.1
install.packages("BiocManager")
BiocManager::install("pcaMethods")
library(pcaMethods)

community_data = read.csv("https://gitlab.com/StuntsPT/bp2023/-/raw/master/docs/classes/exercises/april-dvp.csv", header=TRUE, sep=",")
plant_traits_data = community_data[,7:length(community_data)]
discriminant = community_data[,6]

plant_pca <- pca(plant_traits_data, scale="vector", center=TRUE, nPcs=2, method="nipals")

scores_pc1 = plant_pca@scores[, "PC1"]
scores_pc2 = plant_pca@scores[, "PC2"]

plot(scores_pc1, scores_pc2,
     col=factor(discriminant),
     ann=FALSE)

title(main="PCA scores plot from Alberta grassland plant data")
title(xlab=sprintf("PC1 %0.1f%% variation explained", round(plant_pca@R2[1] * 100, 2)))
title(ylab=sprintf("PC2 %0.1f%% variation explained", round(plant_pca@R2[2] * 100, 2)))

legend("bottomright", legend=unique(discriminant), col=unique(factor(discriminant)), pch=1)

# 3.2
# The segregation by "base grass" suggests a split between Rye and TF individuals.

# 3.3
loadings_pc1 = plant_pca@loadings[, "PC1"]
loadings_pc2 = plant_pca@loadings[, "PC2"]
plot(loadings_pc1, loadings_pc2, pch="", ann=F)
arrows(0, 0, loadings_pc1, loadings_pc2)

text(loadings_pc1, loadings_pc2,
     rownames(plant_pca@loadings), cex=0.9)
title(xlab=sprintf("PC1 %0.1f%% variation explained", round(plant_pca@R2[1] * 100, 2)))
title(ylab=sprintf("PC2 %0.1f%% variation explained", round(plant_pca@R2[2] * 100, 2)))
title(main="PCA loadings plot from Alberta grassland plant data")

# According to the "Loadings" plot, "TF.per" is the most strongly associated variable do PC1 (CWM.X13C is a close second).
# "Plan.per" is the most strongly associated variable to PC2 (followed by Broadleaved.dock.per.tot).

# 3.4
plant_pca@R2

# 4.1

single_sample_test = function(sample, value, norm_alpha, test_alpha) {
    norm_test = shapiro.test(sample)$p.value

    if (norm_test < norm_alpha) {
        test_res = wilcox.test(x=sample, mu=value)$p.value
    } else {
        test_res = t.test(x=sample, mu=value)$p.value
    }
    if (test_res < test_alpha) {
        msg = "Reject H0: There are significant differences between the sample and the value."
    } else {
        msg = "Do not reject H0: There are no significant differences between the sample and the value."
    }
    return(msg)
}

## Wilcoxon test
# No differences
print(single_sample_test(sample=mtcars$hp, value=150, norm_alpha=0.05, test_alpha=0.01))

# Differences
print(single_sample_test(sample=mtcars$hp, value=100, norm_alpha=0.05, test_alpha=0.01))

## t-test
# No differences
print(single_sample_test(sample=mtcars$mpg, value=20, norm_alpha=0.01, test_alpha=0.05))

# Differences
print(single_sample_test(sample=mtcars$mpg, value=10, norm_alpha=0.01, test_alpha=0.05))

