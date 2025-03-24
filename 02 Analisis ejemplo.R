# Análisis y visualización de datos en R con conjuntos de datos precargados

# 1. Cargar un dataset precargado en R
# Vamos a usar el dataset 'iris', que contiene información sobre flores

# Cargar el dataset
data(iris)

# Mostrar las primeras filas
head(iris)

# 2. Exploración básica del dataset
# Ver la estructura del dataset
str(iris)

# Resumen estadístico de las variables
summary(iris)

# Nombres de las columnas
colnames(iris)

# Dimensiones del dataset (filas y columnas)
dim(iris)

# 3. Análisis descriptivo
# Media, mediana y desviación estándar de una variable numérica
mean(iris$Sepal.Length)
median(iris$Sepal.Length)
sd(iris$Sepal.Length)

# Contar valores por categoría
table(iris$Species)

# 4. Filtrado de datos
# Seleccionar solo las filas donde la especie es "setosa"
setosa <- subset(iris, Species == "setosa")
head(setosa)

# Seleccionar solo columnas numéricas
iris_numeric <- iris[, 1:4]
head(iris_numeric)

# 5. Visualización de datos
# Histograma de la longitud del sépalo
hist(iris$Sepal.Length, main = "Histograma de Sepal Length", col = "blue", xlab = "Sepal Length")

# Diagrama de dispersión entre dos variables
plot(iris$Sepal.Length, iris$Sepal.Width, col = iris$Species, 
     main = "Relación entre Sepal Length y Sepal Width", xlab = "Sepal Length", ylab = "Sepal Width")

# 6. Gráficos avanzados con ggplot2
library(ggplot2)

# Gráfico de dispersión coloreado por especie
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_point() +
  ggtitle("Relación entre Sepal Length y Sepal Width por especie")

# Boxplot de la longitud del sépalo por especie
ggplot(iris, aes(x = Species, y = Sepal.Length, fill = Species)) +
  geom_boxplot() +
  ggtitle("Distribución de Sepal Length por especie")

# 7. Correlación entre variables
cor(iris_numeric)

# 8. Modelos de regresión
modelo <- lm(Sepal.Length ~ Sepal.Width, data = iris)
summary(modelo)

# Agregar la recta de regresión al gráfico de dispersión
ggplot(iris, aes(x = Sepal.Width, y = Sepal.Length)) +
  geom_point() +
  geom_smooth(method = "lm", col = "red") +
  ggtitle("Regresión lineal entre Sepal Width y Sepal Length")

# 9. Análisis Clúster: Agrupamiento K-Means
set.seed(123)  # Para reproducibilidad
kmeans_result <- kmeans(iris_numeric, centers = 3)

# Añadir los clusters al dataset
iris$Cluster <- as.factor(kmeans_result$cluster)

# Visualizar clusters
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Cluster)) +
  geom_point() +
  ggtitle("Agrupamiento K-Means en el dataset iris")

# 10. Gráficos interactivos con plotly
library(plotly)

# Convertir un gráfico de ggplot2 a interactivo
grafico_interactivo <- ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_point() +
  ggtitle("Gráfico interactivo con Plotly")

# Mostrar el gráfico interactivo
ggplotly(grafico_interactivo)
