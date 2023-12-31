### Class #8

#### Bioinformática Prática 2023

![Logo FCUL](C01_assets/logo-FCUL.png)


©Francisco Pina Martins 2017-2023

---

## Automation & Reproducibility

Automation <!-- .element: class="fragment" data-fragment-index="1" -->

---

### Main questions

* What is it?
* When is it useful? <!-- .element: class="fragment" data-fragment-index="1" -->
* How does it 'work'? <!-- .element: class="fragment" data-fragment-index="2" -->

---

### What is automation?

* Performing tasks without human intervention

![Automate all the things](C08_assets/automate.jpg) <!-- .element: class="fragment" data-fragment-index="1" -->

---

### When is automation useful?

* For repetitive tasks
* For complex tasks <!-- .element: class="fragment" data-fragment-index="1" -->
* For long tasks <!-- .element: class="fragment" data-fragment-index="2" -->
* For repetitive, long, complex, tasks <!-- .element: class="fragment" data-fragment-index="3" -->

|||

### Consequences of automation

* Reduces random error
	* At the cost of increased systematic error <!-- .element: class="fragment" data-fragment-index="1" -->
* Reduces intervention times <!-- .element: class="fragment" data-fragment-index="2" -->
	* At the cost of a longer development process <!-- .element: class="fragment" data-fragment-index="3" -->
* Helps focus on main goals <!-- .element: class="fragment" data-fragment-index="4" -->
	* At the cost of reduced flexibility <!-- .element: class="fragment" data-fragment-index="5" -->

---

### How does automation work?

* A task is considered "automated" when it does not require human intervention
* For this, several things are important: <!-- .element: class="fragment" data-fragment-index="1" -->
	* Repeating a task with slightly different parameters <!-- .element: class="fragment" data-fragment-index="2" -->
		* "for loop" <!-- .element: class="fragment" data-fragment-index="3" -->
	* Making decisions based on defined criteria <!-- .element: class="fragment" data-fragment-index="4" -->
		* "if - else" clauses <!-- .element: class="fragment" data-fragment-index="5" -->
* Flexibility must be built-in <!-- .element: class="fragment" data-fragment-index="6" -->

|||

### Speaking of which...

If - else clause in "pseudocode"

```
if (condition to assess) {
    do something
} else {
    do some other thing
}
```

|||

### Speaking of which...

If - else clause in R

```R
x = 3

if (x < 4) {
    x = x * x
} else {
    x = x + x
}
x
```

|||

### Speaking of which...

We can do better, though

```R
x = 3

if (x < 4) {
    x = x * x
} else if (x == 4) {
    x = 4
} else {
    x = x + x
}
x
```

---

### There has to be a better way!

---

### How about a function?

```R
magic_4 = function(x) {
    if (x < 4) {
        x = x * x
    } else if (x == 4) {
        x = 4
    } else {
        x = x + x
    }
    return(x)
}

magic_4(3)
magic_4(4)
magic_4(5)
```

|||

### Are we sure this is looking good?

```R
for (i in c(3:5)){
    print(magic_4(i))
}
```

---

## AUTOMATION!

---

## Reproducibility

---

### Main questions

* What is it?
* When is it useful? <!-- .element: class="fragment" data-fragment-index="1" -->
* How to improve a work's reproducibility? <!-- .element: class="fragment" data-fragment-index="2" -->

---

### What is reproducibility?

* Re-doing something and obtaining the same result
* Central to science in general <!-- .element: class="fragment" data-fragment-index="1" -->
* Especially relevant in computational analyses <!-- .element: class="fragment" data-fragment-index="2" -->
	* Easy to re-run (including by other people) <!-- .element: class="fragment" data-fragment-index="3" -->
	* Cheap to re-run (unlike wet-lab experiments) <!-- .element: class="fragment" data-fragment-index="4" -->

---

### When is reproducibility useful?

* Making sure a procedure is (technically) correct
* Sharing analyses with other researchers <!-- .element: class="fragment" data-fragment-index="1" -->
* Validating studies <!-- .element: class="fragment" data-fragment-index="2" -->

---

### How to improve the reproducibility value of a work?

* Keep track of program versions
	* Control the environment <!-- .element: class="fragment" data-fragment-index="1" -->
* Use a Version Control System (VCS) <!-- .element: class="fragment" data-fragment-index="2" -->
	* Version control code, parameters and results <!-- .element: class="fragment" data-fragment-index="3" -->
* Use automated code! <!-- .element: class="fragment" data-fragment-index="4" -->
* Make the data/code available  <!-- .element: class="fragment" data-fragment-index="5" -->

[Now is a good chance to show github](https://github.com/StuntsPT/BP2023) <!-- .element: class="fragment" data-fragment-index="6" -->

[Now is a good chance to show gitlab](https://gitlab.com/StuntsPT/bp2023) <!-- .element: class="fragment" data-fragment-index="6" -->

---

## Some practical examples

---

### Say "no" to "hard coding" things

```R
obsvd = c(5, 32)
exptd = c(1/11, 9/11)
```

Vs.

```R
obsvd = table(war_data[,"attacker_outcome"])
exptd = c(1/11, 9/11)
```

---

### Do not rely on "autoprints"

```R
shapiro.test(some_distribution)
```

Vs.

```R
print(shapiro.test(some_distribution))
```

---

### Filter your outputs

```R
print(shapiro.test(some_distribution))
```

Vs.

```R
print(shapiro.test(some_distribution)$p.value)
```

---

### Write readable code

Especially at this early stage!

```R
plot(hclust(dist(plantTraits)))
```

Vs.

```R
dist_matrix = dist(plantTraits)
cluster = hclust(dist_matrix)

plot(cluster)
```

|||

"Debugging is twice as hard as writing the code in the first place. Therefore, if you write the code as cleverly as possible, you are, by definition, not smart enough to debug it."

[Brian W. Kernighan](https://en.wikipedia.org/wiki/Brian_Kernighan)

---

### Save your plots

```R
dist_matrix = dist(plantTraits)
cluster = hclust(dist_matrix)

plot(cluster)

```

Vs.

```R
dist_matrix = dist(plantTraits)
cluster = hclust(dist_matrix)

png(filename="/path/to/file/directory/name.png")
plot(cluster)
dev.off()
```

---

## Practical example

---

### Automating a common task

```R
generic_test = function(sampleA, sampleB, alpha, pair=FALSE) {
  # Tests if there are significant differences between two samples.
  # Chooses the correct test based on each sample's normality.
  # Takes the two samples (vectors), an alpha value (numeric)
  # and an optional "paired" (bool) arguments as input.
  # Returns an answer.
  # Can be further simplified by changing only the test function
  # in the conditional.
  
  sampleA_norm = shapiro.test(sampleA)$p.value
  sampleB_norm = shapiro.test(sampleB)$p.value
  
  if (sampleA_norm <= alpha | sampleB_norm <= alpha){
    p_val = wilcox.test(x=sampleA,
                        y=sampleB,
                        paired=pair)$p.value
  } else {
    p_val = t.test(x=sampleA,
                   y=sampleB,
                   paired=pair)$p.value
  }
  
  if (p_val <= alpha) {
    answer = "Reject H0."
  } else {
    answer = "Do not reject H0."
  }
  return(answer)
}


soif_data = read.csv("https://raw.githubusercontent.com/chrisalbon/war_of_the_five_kings_dataset/master/5kings_battles_v1.csv",
                     header=TRUE,
                     row.names=1)

my_answer <- generic_test(soif_data[,"attacker_size"], soif_data[,"defender_size"], 0.05)
print("H0: there are no significant differences between attacker army size and defending army size.")
print(my_answer)

```

---

### Before we are done

```R
sorteio = function(names_file, seed) {
    names = read.csv(names_file,
                     header=FALSE)

    set.seed(seed)

    shuffled_names = as.data.frame(sample(t(names)))

    return(shuffled_names)
}

print(sorteio("https://gitlab.com/StuntsPT/bp2023/raw/master/docs/classes/C01_assets/nomes.txt", 73892))
```
