sorteio = function(names_file, seed) {
  names = read.csv(names_file,
                   header=FALSE)
  
  set.seed(seed)
  
  shuffled_names = as.data.frame(sample(t(names)))
  
  return(shuffled_names)
}

print(sorteio("https://gitlab.com/StuntsPT/bp2023/raw/master/docs/classes/C01_assets/nomes.txt", 73892))
