# Modelo de Crecimiento Logístico de Bacterias

## Descripción
Este código implementa un modelo de crecimiento logístico para simular la evolución de una población de bacterias en un cultivo. El modelo logístico es especialmente útil para describir poblaciones que tienen un límite de crecimiento debido a restricciones ambientales (como nutrientes, espacio, etc.).

## Parámetros del Modelo
El modelo utiliza tres parámetros principales:
- `p0 = 1000`: Población inicial de bacterias
- `k = 0.0001`: Tasa de crecimiento intrínseca
- `M = 100000`: Capacidad máxima del cultivo (número máximo de bacterias que el medio puede sostener)

## Implementación en R

### Configuración Inicial
```R
p0 <- 1000  # Población inicial de bacterias
k <- 0.0001 # Tasa de crecimiento
M <- 100000 # Capacidad máxima del cultivo
```

### Función de Crecimiento Logístico
La ecuación logística que describe el crecimiento de la población es:

P(t) = M * p0 / (M * e^(-k*M*t) - p0 * e^(-k*M*t) + p0)

Implementación en R:
```R
poblacion <- function(tiempo) {
    M * p0 / (M * exp(-k * M * tiempo) - p0 * exp(-k * M * tiempo) + p0)
}
```

### Simulación del Crecimiento
```R
# Simulación para 24 horas
for (i in 1:24) {
    print(poblacion(i))
}

# Datos para visualización
x <- 1:24  # Horas
y <- c(1000, 1500, 2200, 3200, 4500, 6500, 9000, 12500, 17000, 23000,
       31000, 41000, 54000, 70000, 85000, 95000, 98000, 99500, 99800,
       99900, 99950, 99980, 99990, 99995)
```

### Visualización
```R
plot(x, y,
    main = "Evolución de la población de bacterias",
    xlab = "Tiempo [horas]",
    ylab = "Número de bacterias",
    cex = 1,
    pch = 8
)
```

### Análisis de Regresión Lineal
Aunque sabemos que el crecimiento es logístico, ajustamos un modelo lineal para demostrar por qué un modelo lineal no es apropiado para estos datos.

```R
linearModel <- lm(y ~ x)
summary(linearModel)
```

## Interpretación del Modelo Lineal

### 1. Residuales
- Rango: -41899 a 24843
- La mediana cercana a 0 sugiere cierta simetría en los errores
- El amplio rango de residuales indica un ajuste deficiente del modelo lineal

### 2. Coeficientes
- Intercepto ≈ -15178
  - Representa la población inicial estimada
  - El valor negativo no tiene sentido biológico
- Pendiente ≈ 5273
  - Representa el incremento promedio de bacterias por hora
  - Estadísticamente significativo (p < 0.001)
- Los errores estándar altos indican incertidumbre en las estimaciones

### 3. Bondad del Ajuste
- R² = 0.7824
  - El modelo explica el 78.24% de la variabilidad
  - A pesar de ser alto, no es óptimo para datos logísticos
  - R² ajustado similar al R² indica que no hay sobreajuste

### 4. Prueba F
- F-statistic = 79.16 (p < 0.001)
- Confirma una relación significativa entre tiempo y población
- No valida que esta relación sea lineal

## Conclusión
El modelo lineal no es apropiado para estos datos, como se esperaba. Se recomienda usar un modelo logístico que capture adecuadamente la saturación del crecimiento poblacional. El crecimiento logístico es más realista ya que:
1. Comienza con crecimiento exponencial
2. Se ralentiza a medida que se acerca a la capacidad máxima
3. Se estabiliza en un valor límite (capacidad de carga) 