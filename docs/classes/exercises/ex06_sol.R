# Exercises 6 possible solutions

magic_beans = read.csv(url("https://gitlab.com/StuntsPT/bp2023/raw/master/docs/classes/exercises/Magic_beans.csv"), header=TRUE, row.names=1)

# Size category
size_category_counts = data.frame(table(magic_beans[, "Size.category"]))

barplot(height=size_category_counts[, "Freq"],
        width=c(3, 2, 1),
        names.arg=size_category_counts[, "Var1"],
        col="red",
        ylab="Magic beans",
        xlab="Size category",
        main="Magic bean counts per size category",
        axes=FALSE)
axis(2, at=round(seq(0, max(size_category_counts$Freq), length.out = 6),0), las=1)

# Colours
colour_counts = data.frame(table(magic_beans[,"Colour"]))

barplot(height=colour_counts[, "Freq"],
        width=1,
        las=1,
        names.arg=colour_counts[, "Var1"],
        col=as.vector(colour_counts[, "Var1"]),
        ylab="Magic beans",
        xlab="Colour category",
        main="Magic bean counts per colour",
        ylim=c(0, max(colour_counts[, "Freq"]) * 1.1))

# Hypothesis tests
# 2.1:
colour_expectations = c(1/6, 1/6, 1/6, 1/6, 1/6 ,1/6)
colour_observations = colour_counts[, "Freq"]
chisq.test(x=colour_observations, p=colour_expectations)

# H0: The observed colour distribution is not different from the expectation of 1:1:1:1:1:1.
# The Chi² test indicates that there are significant deviations from the expected distribution

# 2.2
p_vals = c()
for (i in 1:length(colour_expectations)) {
    partial_obs = c(colour_observations[i], sum(colour_observations[-i]))
    partial_exp = c(colour_expectations[i], sum(colour_expectations[-i]))

    partial_chisq = chisq.test(x=partial_obs, p=partial_exp)

    p_vals[i] = partial_chisq$p.value
    }

q_values = p.adjust(p_vals, method="fdr")
# According to the q-values, assuming alpha==0.05, only the green and blue beans are not significantly different from the expected proportion.

# 2.3
if (!require("XNomial")) {
    install.packages("XNomial")
    library("XNomial")
}


red_beans = table(magic_beans)["Red",]

xmulti(obs=red_beans, expr=c(1/3,1/3,1/3))
# The multinomial test indicates that the red beans' size categories are not significantly different from the expectation of 1:1:1

# 2.4
chisq.test(table(magic_beans), correct=TRUE)
# H0: The bean colour does not influence the distribution of the size categories
# The Chi² test does not reject H0, therefore independence between colour and size category proportions is assumed.

# 2.5
obs=c(89, 322, 16)
exp=c(5/21, 15/21, 1/21)

binom.test(x=obs[1], n=sum(obs), p=exp[1], alternative="greater")
# The proportion of tie fighters found aboard the Imperial Star Destroyer are not significantly larger from what is expected for a ground strike.
# The rebel base should deploy defenses to react to a ground assault.

## Netflix Originals

# 3.1
netflix = read.csv("https://gitlab.com/StuntsPT/bp2023/raw/master/docs/classes/exercises/NetflixOriginals.csv", row.names=1)

# 3.2

hist(netflix[,"IMDB.Score"])  # Need embellishment
hist(netflix[,"Runtime"])  # Need embellishment

# 3.3
plot(x=netflix[,"Runtime"], y=netflix[,"IMDB.Score"], pch="N", col="#E50914", lwd=3)  # Needs embellishment

# 3.4
shapiro.test(netflix[,"IMDB.Score"])
shapiro.test(netflix[,"Runtime"])

cor.test(x=netflix[,"Runtime"], y=netflix[,"IMDB.Score"], method ="spearman")
# H0: The distribution of "IMDB.Score" values is not significantly different from a normal distribution. (Rejected)
# H0: The distribution of "Runtime" values is not significantly different from a normal distribution. (Rejected)
# H0: As the values of "Runtime" increase, the values of "IMDB.Score" do not increase or decrease. (Not rejected)

# 3.5
model = lm(IMDB.Score ~ Runtime, data=netflix)
abline(model, lwd=4, col="black")


