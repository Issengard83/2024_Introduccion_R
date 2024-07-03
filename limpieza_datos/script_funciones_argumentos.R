
# Funciones simples -------------------------------------------------------
## Crear un vector
x <- c(1, 2, 4, 8, 16) # vector numérico

y <- c("función", "argumento", "objeto") # vector de caracteres

## Crear una lista
list(1, 2, 3, 4, "función", "argumento", "objeto")
  
## Operaciones aritméticas y estadísticas  
# Suma
sum(1, 2, 3, 4) # suma de cuatro valores numéricos

sum(x) # suma de un vector numérico

sum(iris$Sepal.Length) # suma de los valores de una columna numérica


# Media
mean(1, 2, 3, 4) # media de cuatro valores numéricos (incorrecto)

mean(x)

mean(iris$Sepal.Length)


# Mediana
median(1, 2, 3, 4) # mediana de cuatro valores numéricos (incorrecto)

median(x)

median(iris$Sepal.Length)


# Máximo
max(1, 2, 3, 4)

max(x)

max(iris$Sepal.Length)


# Mínimo
min(1, 2, 3, 4)

min(x)

min(iris$Sepal.Length)


# Cuartiles
quantile(x)

quantile(iris$Sepal.Length)


# Medidas de resumen
summary(x)

summary(iris$Sepal.Length)


# Raíz cuadrada
sqrt(1, 2, 3, 4) # raíz cuadrada de 4 valores numéricos (no funciona)

sqrt(2)

sqrt(x)

sqrt(iris$Sepal.Length)


# Exponencial
exp(1, 2, 3, 4) # exponencial de 4 valores numéricos (no funciona)

exp(2)

exp(x)

exp(iris$Sepal.Length)


# Logaritmo
log(1, 2, 3, 4) # logaritmo de 4 valores numéricos (no funciona)

log(2)

log(x)

log(iris$Sepal.Length)


# Redondeo
round(2)

round(x)

round(iris$Sepal.Length) 


# Redondeo hacia arriba
ceiling(x)

ceiling(iris$Sepal.Length)


# Redondeo hacia abajo
floor(x)

floor(iris$Sepal.Length)


## Operaciones con caracteres
# Convierte números a caracter
as.character(1234)

as.character(x)

as.character(iris$Sepal.Length)


# Convierte números a factor
as.factor(x)

as.factor(iris$Sepal.Length)

# Convierte caracteres a factor
as.factor(y)

as.factor(iris$Species)


# Cambia texto a minúsculas
tolower("Curso R Tidyverse INE")

tolower(y)

tolower(iris$Species)


# Cambia texto a mayúsculas
toupper("Curso R Tidyverse INE")

toupper(y)

toupper(iris$Species)


# Une valores
paste(1234, "Curso R Tidyverse INE")

paste(x, y)

paste(iris$Sepal.Length, iris$Species)


## Gráficos sencillos
# Gráficos de puntos
plot(x)

plot(iris$Sepal.Length)


# Histograma
hist(x)

hist(iris$Sepal.Length)


# Boxplot
boxplot(iris$Sepal.Length)


# Muestra contenido de un objeto
print(x)

print(iris$Sepal.Length)


## Carga de bases de datos
data(iris)

read.csv("base_pacientes.csv")

rio::import("base_pacientes.csv")

## Explorar NAs
skimr::skim(y)

skimr::skim(iris)


# Funciones con argumentos ------------------------------------------------
## Operaciones aritméticas o estadísticas excluyendo NAs
sum(iris$Sepal.Length, na.rm = T)

mean(iris$Sepal.Length, na.rm = T)

median(iris$Sepal.Length, na.rm = T)

max(iris$Sepal.Length, na.rm = T)

min(iris$Sepal.Length, na.rm = T)


## Redondeo especificando cifras
round(iris$Sepal.Length, 1)


# Condicional simple
ifelse(iris$Sepal.Length > 5, "si", "no")

dplyr::if_else(condition = iris$Sepal.Length > 5, true = "si", false = "no", missing = "empty")


### Para consultar los argumentos de una función y obtener un detalle de para que sirve cada cosa
### nos posicionamos sobre el nombre de la función y presionamos la tecla F1.
### Otra forma de acceder a la ayuda es escribiendo en la consola el signo ? seguido del nombre
### de la función.

