# Análisis de Datos con R: Ejemplo Práctico

## Descripción

Este script proporciona un ejemplo completo de análisis de datos utilizando el dataset 'iris', que es un conjunto de datos clásico incluido en R. El script demuestra diversas técnicas de análisis exploratorio de datos, visualización y modelado estadístico.

## 1. Carga y Exploración Inicial

Primero, cargamos el dataset 'iris' y realizamos una exploración inicial:

```R
# Carga del dataset
data(iris)

# Mostrar las primeras filas
head(iris)

# Ver la estructura del dataset
str(iris)

# Resumen estadístico de las variables
summary(iris)

# Nombres de las columnas
colnames(iris)

# Dimensiones del dataset (filas y columnas)
dim(iris)
```

El dataset 'iris' contiene:

- 150 observaciones
- 5 variables:
  - Sepal.Length
  - Sepal.Width
  - Petal.Length
  - Petal.Width
  - Species

## 2. Análisis Descriptivo

Realizamos cálculos de estadísticas básicas:

```R
# Media, mediana y desviación estándar de una variable numérica
mean(iris$Sepal.Length)
median(iris$Sepal.Length)
sd(iris$Sepal.Length)

# Contar valores por categoría
table(iris$Species)
```

## 3. Manipulación de Datos

Aprenderemos a filtrar y seleccionar datos:

```R
# Seleccionar solo las filas donde la especie es "setosa"
setosa <- subset(iris, Species == "setosa")
head(setosa)

# Seleccionar solo columnas numéricas
iris_numeric <- iris[, 1:4]
head(iris_numeric)
```

## 4. Visualización de Datos

Creamos diferentes tipos de gráficos para visualizar los datos:

```R
# Histograma de la longitud del sépalo
hist(iris$Sepal.Length, main = "Histograma de Sepal Length", 
     col = "blue", xlab = "Sepal Length")

# Diagrama de dispersión entre dos variables
plot(iris$Sepal.Length, iris$Sepal.Width, col = iris$Species,
     main = "Relación entre Sepal Length y Sepal Width", 
     xlab = "Sepal Length", ylab = "Sepal Width")
```

### Gráficos Avanzados con ggplot2

```R
# Cargar la librería ggplot2
library(ggplot2)

# Gráfico de dispersión coloreado por especie
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_point() +
  ggtitle("Relación entre Sepal Length y Sepal Width por especie")

# Boxplot de la longitud del sépalo por especie
ggplot(iris, aes(x = Species, y = Sepal.Length, fill = Species)) +
  geom_boxplot() +
  ggtitle("Distribución de Sepal Length por especie")
```

## 5. Análisis Estadístico Avanzado

Realizamos análisis más complejos:

```R
# Correlación entre variables
cor(iris_numeric)

# Modelos de regresión
modelo <- lm(Sepal.Length ~ Sepal.Width, data = iris)
summary(modelo)

# Agregar la recta de regresión al gráfico de dispersión
ggplot(iris, aes(x = Sepal.Width, y = Sepal.Length)) +
  geom_point() +
  geom_smooth(method = "lm", col = "red") +
  ggtitle("Regresión lineal entre Sepal Width y Sepal Length")
```

### Análisis Clúster: Agrupamiento K-Means

```R
# Análisis Clúster: Agrupamiento K-Means
set.seed(123)  # Para reproducibilidad
kmeans_result <- kmeans(iris_numeric, centers = 3)

# Añadir los clusters al dataset
iris$Cluster <- as.factor(kmeans_result$cluster)

# Visualizar clusters
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Cluster)) +
  geom_point() +
  ggtitle("Agrupamiento K-Means en el dataset iris")
```

## 6. Visualización Interactiva

Finalmente, creamos gráficos interactivos:

```R
# Cargar la librería plotly
library(plotly)

# Convertir un gráfico de ggplot2 a interactivo
grafico_interactivo <- ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_point() +
  ggtitle("Gráfico interactivo con Plotly")

# Mostrar el gráfico interactivo
ggplotly(grafico_interactivo)
```

## Requisitos

Para ejecutar este script necesitarás:

- R instalado
- Paquetes necesarios:
  - ggplot2
  - plotly

## Notas Adicionales

- El script es educativo y puede modificarse para diferentes análisis
- Los resultados pueden variar según la versión de R y los paquetes
- Se recomienda ejecutar cada sección por separado para mejor comprensión
- Las visualizaciones interactivas requieren un entorno que soporte HTML
