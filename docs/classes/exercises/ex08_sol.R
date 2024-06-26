## Exercises 9 solutions

# 1.1
double_trouble = function(x) {
    return(x * 2)
}

print(double_trouble(9))
print(double_trouble(6.5))

# 1.2
significance = function(p_value, alpha) {
    if (p_value < alpha) {
        msg = "H0 should be rejected."
    } else {
        msg = "H0 should not be rejected."
    }
    return(msg)
}

print(significance(0.01, 0.05))
print(significance(0.07, 0.05))


# 2.1
male_data = read.csv("https://gitlab.com/StuntsPT/bp2023/-/raw/master/docs/classes/exercises/TC_male.csv", header=TRUE, row.names=1)
female_data = read.csv(url("https://gitlab.com/StuntsPT/bp2023/-/raw/master/docs/classes/exercises/TC_female.csv"), header=TRUE, row.names=1)

cholesterol_tests = function(male_chol, female_chol) {
    res = t.test(x=male_chol, y=female_chol)

    return(res$p.value)
}

p_values = c()
for (i in c("X1980", "X1990", "X2000", "X2008")){
    p_val = cholesterol_tests(male_data[, i], female_data[, i])
    p_values = c(p_values, p_val)
}

print(p.adjust(p_values, method="fdr"))

# Alternative using indexing: Kudos to Margarida Curto!
alt_p_vals = c()
for (i in c( "X1980" , "X1990" , "X2000" , "X2008" )) {
  answer = cholesterol_tests(male_data[, i], female_data[, i])
  alt_p_vals[i] = answer
}

print(p.adjust(alt_p_vals, method="fdr"))

# 2.2
years = c("X1983", "X1992", "X1998", "X2003", "X2005")
p_values = c()
for (i in years) {
    p_val = cholesterol_tests(male_data[, i], female_data[, i])
    p_values = c(p_values, p_val)
}
adj_pvals = p.adjust(p_values, method="fdr")
print(adj_pvals)


# 2.3
# Yes!

# 3.1
diatoms_data = read.csv(url("https://raw.githubusercontent.com/StuntsPT/BP2017/master/classes/C1_assets/Dados_diatoms_heavymetals.csv"), header=TRUE)

diatoms_regression = function (x, y, file_name, xlab, ylab) {
    if (shapiro.test(x)$p.value < 0.05 | shapiro.test(y)$p.value < 0.05 ) {
        corr_method = "spearman"
    } else { corr_method = "pearson"

    }
    cor_results = cor.test(x=x, y=y, method=corr_method)
    regress = lm(y ~ x)
    png(filename=file_name)
    plot(x=x,
         y=y,
         col="brown",
         ylab=ylab,
         xlab=xlab,
         main="Diatoms data scatterplot with regression line")
    abline(regress, col="blue", lwd=3)
    dev.off()

    return(c(cor_results$p.value, cor_results$estimate))
}

print(diatoms_regression(diatoms_data$Zn, diatoms_data$Diversity, "~/corrplot1.png", ylab="Species diversity", xlab="Zn concentration"))

# 3.2
print(diatoms_regression(diatoms_data$Zn, diatoms_data$Richness, "~/corrplot2.png", ylab="Species richness", xlab="Zn concentration"))
