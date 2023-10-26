### Class #1

#### Bioinformática Prática 2023

<img src="C01_assets/logo-FCUL.png" style="background:none; border:none; box-shadow:none;">

©Francisco Pina Martins 2017-2023

---

## Programa

**1ª semana**

* 30-10-2023 – Apresentação; organização e tratamento de dados
* 31-11-2023 – Introdução ao R
* 01-11-2023 – **FERIADO**
* 02-11-2023 – Gráficos em R
* 03-11-2023 – Testes de hipóteses I

|||

## Programa

**2ª semana**

* 06-11-2023 – Testes de hipóteses II
* 07-11-2023 – Análise exploratória
* 08-11-2023 – **Journal Club** (14-16h) - Seminário
* 09-11-2023 – Automatização e reprodutibilidade
* 10-11-2023 – Exercícios

|||

## Programa

**3ª semana**

* 14-11-2023 – **Apresentações**
* 15-11-2023 – **Apresentações**
* 16-11-2023 – Revisões (14-16h) - Seminário
* 17-11-2023 – Exercícios
* 18-11-2023 – **Exame TP**

---

## Avaliação

* Exame prático - exame individual realizado em computador, semelhante aos exercícios das aulas teórico-práticas - 50% <!-- .element: class="fragment" data-fragment-index="1" -->
* Seminário apresentado pelos alunos - 25%  <!-- .element: class="fragment" data-fragment-index="2" -->
* Discussão de artigos científicos - 10%  <!-- .element: class="fragment" data-fragment-index="3" -->
* Participação geral nas aulas - 15%. <!-- .element: class="fragment" data-fragment-index="4" -->
* Melhorias:<!-- .element: class="fragment" data-fragment-index="5" -->
  * Avaliação de cada componente é 'guardada'<!-- .element: class="fragment" data-fragment-index="6" -->
  * Melhoria de exame pode ser feita ou no ano seguinte ou na época de recurso<!-- .element: class="fragment" data-fragment-index="7" -->
  * Restantes componentes, só no ano seguinte<!-- .element: class="fragment" data-fragment-index="8" -->

|||

## Exame TP

* Baseado nos exercícios feitos ao longo da UC <!-- .element: class="fragment" data-fragment-index="1" -->
* Com consulta <!-- .element: class="fragment" data-fragment-index="2" -->
* 100% digital <!-- .element: class="fragment" data-fragment-index="3" -->

|||

## Seminários

* Apresentação individual de 10 minutos <!-- .element: class="fragment" data-fragment-index="1" -->
  * Discussão de 5 minutos <!-- .element: class="fragment" data-fragment-index="1" -->
* Enviem um artigo científico à vossa escolha por email <!-- .element: class="fragment" data-fragment-index="2" -->
  * Apresentação deve ser focada nos conteúdos relacionados com o programa da UC <!-- .element: class="fragment" data-fragment-index="2" -->

|||

## Journal club

* Discussão de um artigo científico <!-- .element: class="fragment" data-fragment-index="1" -->

|||

## Participação Geral

* Participação nas aulas <!-- .element: class="fragment" data-fragment-index="1" -->
* Perguntas durante os seminários <!-- .element: class="fragment" data-fragment-index="2" -->

---

## Ordem das apresentações

* Ficheiro com os nomes dos alunos <!-- .element: class="fragment" data-fragment-index="1" -->
* "Random seed" <!-- .element: class="fragment" data-fragment-index="2" -->
* Script <!-- .element: class="fragment" data-fragment-index="3" -->

|||

## Ordem das apresentações

```R
sorteio = function(names_file, seed) {
    names = read.csv(names_file,
                     header=FALSE)

    set.seed(seed)

    shuffled_names = as.data.frame(sample(t(names)))

    return(shuffled_names)
}

print(sorteio("https://gitlab.com/StuntsPT/bp2023/raw/master/docs/classes/C01_assets/nomes.txt", 12345))
```
