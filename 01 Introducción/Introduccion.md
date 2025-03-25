# Introducción a R: Guía Básica

## Descripción

Este script proporciona una introducción paso a paso al lenguaje de programación R, cubriendo los conceptos fundamentales y operaciones básicas.

## 1. Comentarios y Comunicación Básica

En R, los comentarios se escriben después del símbolo `#` y no se ejecutan al correr el código:

```R
# Este es un comentario en R
# Los comentarios son útiles para documentar y explicar el código

# Para mostrar texto en la consola, usamos print()
print("¡Hola, mundo!")
```

## 2. Variables y Tipos de Datos

R maneja diferentes tipos de datos básicos:

```R
# Asignación de variables usando <-
x <- 10         # Número entero
pi_val <- 3.14  # Número decimal (doble precisión)
texto <- "R es genial"  # Cadena de texto
logico <- TRUE   # Valor lógico

# Mostrar valores
print(x)
print(texto)
```

## 3. Operaciones Matemáticas Básicas

R puede realizar operaciones matemáticas básicas:

```R
# Definir variables para operaciones
a <- 5
b <- 2

# Operaciones básicas
suma <- a + b
resta <- a - b
multiplicacion <- a * b
division <- a / b
potencia <- a^b
raiz_cuadrada <- sqrt(a)

# Mostrar resultados
print(suma)
print(raiz_cuadrada)
```

## 4. Vectores

Los vectores son estructuras de datos fundamentales en R:

```R
# Crear un vector
numeros <- c(1, 2, 3, 4, 5)
print(numeros)

# Operaciones con vectores
numeros_dobles <- numeros * 2  # Multiplica cada elemento por 2
print(numeros_dobles)

# Seleccionar elementos
print(numeros[1])     # Primer elemento
print(numeros[2:4])   # Del segundo al cuarto
```

## 5. Factores

Los factores son útiles para variables categóricas:

```R
# Crear un factor
colores <- factor(c("rojo", "azul", "verde", "rojo", "azul"))
print(colores)

# Ver niveles del factor
levels(colores)
```

## 6. DataFrames

Los DataFrames son estructuras de datos tabulares:

```R
# Crear un DataFrame
datos <- data.frame(
  Nombre = c("Ana", "Carlos", "Beatriz"),
  Edad = c(23, 35, 29),
  Ciudad = c("Madrid", "Barcelona", "Sevilla")
)
print(datos)

# Acceder a columnas
datos$Edad

# Seleccionar filas
datos[2, ]  # Segunda fila

# Seleccionar celdas específicas
datos[2, "Ciudad"]
```

## 7. Control de Flujo

R proporciona estructuras de control básicas que nos permiten tomar decisiones y repetir operaciones. Estas estructuras son fundamentales para la programación:

### Condicionales (if/else)

Los condicionales nos permiten ejecutar código solo cuando se cumple una condición específica:

```R
# Ejemplo básico de if/else
edad <- 18
if (edad >= 18) {
  print("Eres mayor de edad")
} else {
  print("Eres menor de edad")
}

# Ejemplo con múltiples condiciones
nota <- 85
if (nota >= 90) {
  print("Excelente")
} else if (nota >= 80) {
  print("Bueno")
} else if (nota >= 70) {
  print("Aprobado")
} else {
  print("Suspenso")
}

# Ejemplo práctico: Clasificar flores iris por tamaño
flor <- iris[1, ]  # Tomamos la primera flor
if (flor$Sepal.Length > 6) {
  print("Flor grande")
} else if (flor$Sepal.Length > 5) {
  print("Flor mediana")
} else {
  print("Flor pequeña")
}
```

### Bucles for

Los bucles for nos permiten repetir una operación un número específico de veces o sobre una secuencia de elementos:

```R
# Ejemplo básico: Imprimir números del 1 al 5
for (i in 1:5) {
  print(paste("Número:", i))
}

# Ejemplo práctico: Calcular potencias de 2
for (i in 1:5) {
  print(paste("2 elevado a", i, "es:", 2^i))
}

# Ejemplo con vectores: Calcular el cuadrado de cada número
numeros <- c(1, 2, 3, 4, 5)
for (num in numeros) {
  print(paste("El cuadrado de", num, "es:", num^2))
}

# Ejemplo práctico: Calcular estadísticas para cada columna numérica de iris
for (col in names(iris)[1:4]) {  # Las primeras 4 columnas son numéricas
  media <- mean(iris[[col]])
  print(paste("La media de", col, "es:", media))
}
```

### Bucles while

Los bucles while se ejecutan mientras una condición sea verdadera:

```R
# Ejemplo básico: Contador hasta 3
contador <- 1
while (contador <= 3) {
  print(paste("Contador:", contador))
  contador <- contador + 1
}

# Ejemplo práctico: Encontrar el primer número que supere 100 al multiplicar por 2
numero <- 1
while (numero * 2 <= 100) {
  numero <- numero * 2
  print(paste("Número actual:", numero))
}

# Ejemplo con control de error: Búsqueda de un valor en un vector
numeros <- c(1, 2, 3, 4, 5)
valor_buscar <- 3
encontrado <- FALSE
i <- 1

while (!encontrado && i <= length(numeros)) {
  if (numeros[i] == valor_buscar) {
    encontrado <- TRUE
    print(paste("Valor encontrado en la posición:", i))
  }
  i <- i + 1
}
```

## 8. Funciones

Las funciones son bloques de código reutilizables que nos permiten encapsular operaciones comunes. Son fundamentales para:

- Evitar repetir código
- Hacer el código más mantenible
- Crear operaciones personalizadas
- Facilitar la reutilización de código

### Funciones Básicas

```R
# Función simple: Calcular el doble de un número
doble <- function(numero) {
  return(numero * 2)
}

# Función con múltiples argumentos: Calcular el área de un rectángulo
area_rectangulo <- function(base, altura) {
  return(base * altura)
}

# Función con valores por defecto: Calcular el volumen de un cubo
volumen_cubo <- function(lado = 1) {
  return(lado^3)
}

# Ejemplos de uso
print(doble(4))                    # Resultado: 8
print(area_rectangulo(5, 3))       # Resultado: 15
print(volumen_cubo())              # Resultado: 1 (usando valor por defecto)
print(volumen_cubo(2))             # Resultado: 8
```

### Funciones Avanzadas

```R
# Función que calcula estadísticas básicas
estadisticas_basicas <- function(datos) {
  media <- mean(datos)
  mediana <- median(datos)
  desv_est <- sd(datos)
  
  return(list(
    media = media,
    mediana = mediana,
    desviacion_estandar = desv_est
  ))
}

# Función que clasifica flores iris por tamaño
clasificar_flor <- function(sepal_length) {
  if (sepal_length > 6) {
    return("Grande")
  } else if (sepal_length > 5) {
    return("Mediana")
  } else {
    return("Pequeña")
  }
}

# Ejemplos de uso
# Calcular estadísticas de la longitud del sépalo
stats <- estadisticas_basicas(iris$Sepal.Length)
print(stats)

# Clasificar las primeras 5 flores
for (i in 1:5) {
  print(paste("Flor", i, "es:", 
              clasificar_flor(iris$Sepal.Length[i])))
}
```

### Funciones con Validación de Datos

```R
# Función que calcula el factorial de un número
factorial <- function(n) {
  # Validar que n sea un número entero positivo
  if (!is.numeric(n) || n < 0 || n != floor(n)) {
    stop("El número debe ser un entero positivo")
  }
  
  # Calcular factorial
  if (n == 0 || n == 1) {
    return(1)
  } else {
    return(n * factorial(n - 1))
  }
}

# Ejemplos de uso
print(factorial(5))    # Resultado: 120
print(factorial(0))    # Resultado: 1
# print(factorial(-1)) # Esto generará un error
```

## 9. Gráficos Básicos

R tiene capacidades gráficas básicas:

```R
# Crear datos para graficar
x <- c(1, 2, 3, 4, 5)
y <- c(2, 4, 6, 8, 10)

# Gráfico básico
plot(x, y, type = "b", col = "blue", 
     main = "Gráfico en R",
     xlab = "Eje X", ylab = "Eje Y")
```

## 10. Librerías y Paquetes

R tiene un extenso sistema de paquetes:

```R
# Instalar un paquete (solo una vez)
install.packages("ggplot2")

# Cargar una librería
library(ggplot2)

# Crear un gráfico con ggplot2
df <- data.frame(x = c(1, 2, 3, 4, 5), 
                 y = c(3, 5, 7, 9, 11))
ggplot(df, aes(x = x, y = y)) +
  geom_point(color = "red") +
  geom_line() +
  ggtitle("Gráfico con ggplot2")
```

## 11. Manejo de Archivos

R puede leer y escribir archivos:

```R
# Guardar un DataFrame en CSV
write.csv(datos, "datos.csv", row.names = FALSE)

# Leer un archivo CSV
datos_leidos <- read.csv("datos.csv")
print(datos_leidos)
```

## Requisitos

Para ejecutar este script necesitarás:

- R instalado en el sistema
- Conexión a internet (para instalar paquetes)

## Notas Adicionales

- Los comentarios en el código proporcionan explicaciones detalladas
- Se recomienda ejecutar cada sección por separado para mejor comprensión
- Los ejemplos son interactivos y pueden modificarse para experimentar
