### Class #2

#### Bioinformática Prática 2023

![FCUL Logo](C01_assets/logo-FCUL.png)

©Francisco Pina Martins 2017-2023

---

![GUN R Logo](C02_assets/R_logo.png)

[GNU R](https://www.r-project.org/)

---

### Meet R

![R Console](C02_assets/R-console.gif)

---

### RStudio - an R IDE

![RStudio_image](C02_assets/rstudio.png)

* Text editor (Top left) <!-- .element: class="fragment" data-fragment-index="1" -->
* Console (Bottom left) <!-- .element: class="fragment" data-fragment-index="2" -->
* Workspace objects (Top right) <!-- .element: class="fragment" data-fragment-index="3" -->
* Multi-purpose (Bottom right) <!-- .element: class="fragment" data-fragment-index="4" -->

---

### How do I use this thing?

Calculator

```R
4 + 4
[1] 8

(2 + 5) * 6 / (6 - 2)
[1] 10.5
```

|||


### How do I use this thing?

Text processor

```R
print("Good Morning World!")
[1] "Good Morning World!"

```

![Good Morinig World!](C02_assets/BS_good_morning.gif)

|||

### How do I use this thing?

```R
2 < 3  # Logical operators

2 > 3

2 <= 3

2 >= 3

2 == 2

2 == 2 | 2 >= 3  # OR

2 == 2 & 2 < 3  # AND
```

---

### R programming 101

#### Variables

```R
txt <- "Good Morning World!"  # "Classic" syntax
txt = "Good Morning World!"  # Alternative
print(txt)
```

---

### "Basic" data types

* Numeric (1.5) - AKA "Float" <!-- .element: class="fragment" data-fragment-index="1" -->
* Integer (1) - these have to be coerced <!-- .element: class="fragment" data-fragment-index="2" -->
* Complex (1+2i) - for imaginary numbers <!-- .element: class="fragment" data-fragment-index="3" -->
* Logical (TRUE) - or FALSE <!-- .element: class="fragment" data-fragment-index="4" -->
* Character ("ABC") - AKA "String" <!-- .element: class="fragment" data-fragment-index="5" -->

|||

### "Basic" data types

```R
number = 1.5
class(number)
```

* Try this with other variable types <!-- .element: class="fragment" data-fragment-index="1" -->

---

### "Advanced" data types

#### Vector

* &shy;<!-- .element: class="fragment" -->A **sequence** of data elements **of the same basic type**
* &shy;<!-- .element: class="fragment" -->Members in a vector are called "components"
* &shy;<!-- .element: class="fragment" -->Defined using `c()`:

<div class="fragment">

```R
c(1,2,1)

c("AA", "Aa", "aa")

c(TRUE, FALSE, TRUE)
```

</div>

|||

#### Vector

* &shy;<!-- .element: class="fragment" -->Support many different operations:

<div class="fragment">

```R
odd = c(1, 3, 5, 7)
odd * 5  # Multiplication
even = c(2, 4, 6, 8) 
odd + even  # Arithmetics with vectors
small = c(1, 2)
odd + small  # Recycling rule!
odd[2]  # Indexing
```

</div>

---

### Advanced data types

#### Factor

* &shy;<!-- .element: class="fragment" -->Used for storing **categorical variables**.

![Pokéball](C02_assets/pokeball.png)

<div class="fragment">

```R
captured_pokemon = c("normal", "normal", "electric", "fire", "fire", "fire", "water", "grass")
captured_pokemon_types = levels(as.factor(captured_pokemon))
```

</div>

---

### Advanced data types

#### Matrix

* &shy;<!-- .element: class="fragment" -->Collection of **data elements**
    * &shy;<!-- .element: class="fragment" -->Arranged in a **two-dimensional rectangular layout**
* &shy;<!-- .element: class="fragment" -->Defined using a `function`.

<div class="fragment">


```R
my_matrix = matrix(c(1, 2, 3, 4, 5, 6),  # data elements
                   nrow=2,  # number of rows
                   ncol=3)  # number of columns
print(my_matrix)

my_matrix[1,2]  # Bidimensional indexing!
my_matrix[1,]  # Get a single row
my_matrix[,1]  # Get a single column
```

</div>

---

### Advanced data types

#### List

* &shy;<!-- .element: class="fragment" -->A *generic* vector containing other objects

<div class="fragment">

```R
n = c(2, 3, 5) 
s = c("aa", "bb", "cc", "dd", "ee") 
b = c(TRUE, FALSE, TRUE, FALSE, FALSE) 
x = list(n, s, b, 3)  # x contains copies of n, s, b 
```

</div>

---

### Advanced data types

#### Data Frame

* &shy;<!-- .element: class="fragment" -->A set of vectors of equal length
* &shy;<!-- .element: class="fragment" -->Used for storing data tables

<div class="fragment">

```R
n = c(2, 3, 5) 
s = c("aa", "bb", "cc") 
b = c(TRUE, FALSE, TRUE) 
dframe = data.frame(n, s, b)  # dframe is a data frame 
```

</div>

|||

### Advanced data types

#### Data Frame

```R
mtcars  # Built in data! 
head(mtcars)  # Try this instead...
View(mtcars)  # Or this
mtcars[1, 2]  # Indexing
mtcars["Mazda RX4", "cyl"]  # Named indexing!

# All these get the same data (sort of)
mtcars[[9]]  # Get column 9
mtcars[, 9]  # Also get column 9
mtcars[["am"]]  # Get column "am"
mtcars$am  # Alternative - notice the lack of quotes
mtcars[, "am"]  # Another alternative - arguably the most common
mtcars["am"]  # Calling it like this will get the names too

# Same thing, but for rows
mtcars[1, ]  # Get row 1
mtcars["Mazda RX4", ]

# Logical indexing!!!111!!one
mtcars[, "mpg"] <= 15

# Rows and columns can be combined:
mtcars["Maxda RX4", mpg]  # The Japenese car's fuel consumption
mtcars[mtcars[, "cyl"] == 6, ]  # Can you guess what this does?
```

---

### Functions

* &shy;<!-- .element: class="fragment" -->Invoked by their **name**
    * &shy;<!-- .element: class="fragment" -->Followed by parenthesis `()`
        * &shy;<!-- .element: class="fragment" -->Containing zero or more arguments

<div class="fragment">

```R
c(1, 2, 3)  # `c` actually stands for "combine"

sum(1, 2)  # A sum function

head(mtcars)  # Show the first few lines of...

seq(10, 30)  # Create a sequence (start, end, [step])
seq(10, 30, 2)  # See "step" in action
```

</div>

* &shy;<!-- .element: class="fragment" -->We can also define our own functions. More on that later

|||

### Functions

```R
# See also

mean()
sd()
max()
min()
summary()
table()

```

---

### Data coercion (AKA *Typecasting*)

* There are functions than can be used to transform variables:

```R
as.data.frame(MATRIX)

as.numeric(INTEGER)

as.character(NUMERIC)

# Many more!
```

---

### Getting help

* "When in doubt, ask."
  * &shy;<!-- .element: class="fragment"-->Ask R for help with the command `?function`
  * &shy;<!-- .element: class="fragment"-->If you need help on a **topic**, use the `??` notation ("fuzzy search")


<div class="fragment">

```R
?head

??multivariate
```

</div>

---

### Installing external packages

* &shy;<!-- .element: class="fragment"-->One of R's greatest strengths is how many 3rd party packages are developed for it
  * &shy;<!-- .element: class="fragment"-->Installing these external packages is as easy as typing `install.packages(pkg_name)`
  * &shy;<!-- .element: class="fragment"-->We then have to load the packages we need in order to use them


<div class="fragment">

```R
install.packages("psych")

library("psych")
```

</div>

---

### Missing data

Missing data is coded in R as `NA`, which stands for "**N**ot **A**vailable"

<div class="fragment">

```R
incomplete_vector = c(1, 2, NA, 4)
is.na(incomplete_vector)

mean(incomplete_vector)

mean(incomplete_vector, na.rm=TRUE)
```

</div>

---

### Loading data from external sources

* &shy;<!-- .element: class="fragment"-->You don't have to type data into R manually
  * &shy;<!-- .element: class="fragment"-->You can load data directly from files
  * &shy;<!-- .element: class="fragment"-->Use `read.csv()` or `read.table()`

<div class="fragment">

```R
data = read.csv("/path/to/file.csv")

data = read.table("/path/to/file.txt", header=FALSE, sep="\t")

data = read.table("https://some.site.with.data.com/datafile.txt", header=TRUE, sep=";", dec=",")
```

</div>

---

# Break time!

