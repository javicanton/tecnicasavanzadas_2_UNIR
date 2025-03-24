# El Datasaurus y el Cuarteto de Anscombe

## Introducción

Este documento demuestra la importancia de la visualización de datos a través de dos ejemplos clásicos: el Cuarteto de Anscombe y el Datasaurus. Ambos casos muestran cómo conjuntos de datos con estadísticas descriptivas similares pueden tener patrones visuales completamente diferentes.

## El Cuarteto de Anscombe

El Cuarteto de Anscombe es un conjunto de cuatro conjuntos de datos que tienen estadísticas descriptivas casi idénticas pero visualmente muy diferentes. Fue creado por Francis Anscombe en 1973 para demostrar la importancia de visualizar los datos.

### Estadísticas del Cuarteto de Anscombe

```r
# Función auxiliar para calcular estadísticas
calcular_estadisticas <- function(x, y) {
    c(
        media_x = mean(x),
        media_y = mean(y),
        sd_x = sd(x),
        sd_y = sd(y),
        correlacion = cor(x, y)
    )
}

# Calcular estadísticas para cada conjunto
estadisticas <- data.frame(
    conjunto1 = calcular_estadisticas(anscombe$x1, anscombe$y1),
    conjunto2 = calcular_estadisticas(anscombe$x2, anscombe$y2),
    conjunto3 = calcular_estadisticas(anscombe$x3, anscombe$y3),
    conjunto4 = calcular_estadisticas(anscombe$x4, anscombe$y4)
)
```

### Visualización del Cuarteto de Anscombe

![Cuarteto de Anscombe](anscombe_plot.png)

## El Datasaurus

El Datasaurus es una extensión moderna del Cuarteto de Anscombe, creado por Justin Matejka y George Fitzmaurice en 2017. Consiste en 13 conjuntos de datos diferentes que tienen estadísticas descriptivas casi idénticas pero forman patrones visuales completamente diferentes.

### Estadísticas del Datasaurus

```r
# Calcular estadísticas para cada conjunto del Datasaurus
estadisticas_datasaurus <- datasaurus_dozen %>%
    group_by(dataset) %>%
    summarise(
        media_x = mean(x),
        media_y = mean(y),
        sd_x = sd(x),
        sd_y = sd(y),
        correlacion = cor(x, y)
    )
```

### Visualización del Datasaurus

![Todos los conjuntos del Datasaurus](datasaurus_plot.png)

## Lecciones Clave

1. **Las estadísticas descriptivas por sí solas pueden ser engañosas**: Cuatro conjuntos de datos pueden tener las mismas medias, desviaciones estándar y correlaciones, pero patrones visuales completamente diferentes.

2. **La visualización de datos es crucial**: Sin visualizar los datos, podríamos llegar a conclusiones incorrectas basadas únicamente en estadísticas descriptivas.

3. **No confiar ciegamente en los números**: Es importante complementar el análisis numérico con visualizaciones para entender realmente la naturaleza de los datos.

## Código Completo

El código completo para generar estas visualizaciones se encuentra en el archivo [Datasaurus.R](./Datasaurus.R).

## Referencias

- Anscombe, F. J. (1973). "Graphs in Statistical Analysis". American Statistician, 27(1), 17-21.
- Matejka, J., & Fitzmaurice, G. (2017). "Same Stats, Different Graphs: Generating Datasets with Varied Appearance and Identical Statistics through Simulated Annealing". CHI 2017 Conference Proceedings.
