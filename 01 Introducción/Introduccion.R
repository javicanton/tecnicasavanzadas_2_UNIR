# Introducción a R: Paso a Paso

# 1. Comentarios en R
# Todo lo que se escriba después de '#' es un comentario y no se ejecutará.

# 2. Imprimir en pantalla
print("¡Hola, mundo!")  # Muestra texto en la consola

# 3. Variables y tipos de datos
x <- 10         # Asignación de un número entero
pi_val <- 3.14  # Números decimales (doble precisión)
texto <- "R es genial"  # Cadenas de texto
logico <- TRUE   # Valores lógicos (TRUE o FALSE)

# Mostrar el valor de una variable
print(x)
print(texto)

# 4. Operaciones matemáticas básicas
a <- 5
b <- 2
suma <- a + b
resta <- a - b
multiplicacion <- a * b
division <- a / b
potencia <- a^b
raiz_cuadrada <- sqrt(a)

# Mostrar resultados
print(suma)
print(raiz_cuadrada)

# 5. Vectores en R (listas de datos del mismo tipo)
numeros <- c(1, 2, 3, 4, 5)
print(numeros)

# Operaciones con vectores
numeros_dobles <- numeros * 2  # Multiplica cada elemento por 2
print(numeros_dobles)

# Seleccionar elementos de un vector
print(numeros[1])  # Primer elemento
print(numeros[2:4])  # Del segundo al cuarto

# 6. Factores (variables categóricas)
colores <- factor(c("rojo", "azul", "verde", "rojo", "azul"))
print(colores)

# 7. DataFrames (tablas de datos)
datos <- data.frame(
  Nombre = c("Ana", "Carlos", "Beatriz"),
  Edad = c(23, 35, 29),
  Ciudad = c("Madrid", "Barcelona", "Sevilla")
)
print(datos)

# Acceder a una columna
datos$Edad

# Seleccionar una fila específica
datos[2, ]  # Segunda fila

# Seleccionar una celda específica
datos[2, "Ciudad"]

# 8. Condicionales y bucles
if (x > 5) {
  print("x es mayor que 5")
} else {
  print("x es menor o igual a 5")
}

# Bucle for
for (i in 1:5) {
  print(paste("Iteración número", i))
}

# Bucle while
contador <- 1
while (contador <= 3) {
  print(paste("Valor de contador:", contador))
  contador <- contador + 1
}

# 9. Funciones en R
doble <- function(numero) {
  return(numero * 2)
}

resultado <- doble(4)
print(resultado)

# Función con múltiples argumentos
suma_numeros <- function(a, b) {
  return(a + b)
}
print(suma_numeros(10, 20))

# 10. Gráficos básicos con R
x <- c(1, 2, 3, 4, 5)
y <- c(2, 4, 6, 8, 10)
plot(x, y, type = "b", col = "blue", main = "Gráfico en R")

# 11. Librerías en R
# Algunas funciones avanzadas requieren paquetes externos
install.packages("ggplot2")  # Instalar un paquete (solo una vez)
library(ggplot2)  # Cargar la librería

# Crear un gráfico con ggplot2
df <- data.frame(x = c(1, 2, 3, 4, 5), y = c(3, 5, 7, 9, 11))
ggplot(df, aes(x = x, y = y)) +
  geom_point(color = "red") +
  geom_line() +
  ggtitle("Gráfico con ggplot2")

# 12. Lectura y escritura de archivos
# Guardar un DataFrame en un archivo CSV
write.csv(datos, "datos.csv", row.names = FALSE)

# Leer un archivo CSV
datos_leidos <- read.csv("datos.csv")
print(datos_leidos)
