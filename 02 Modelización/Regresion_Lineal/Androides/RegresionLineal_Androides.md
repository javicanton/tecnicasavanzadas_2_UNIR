# Modelo de Crecimiento Logístico de Androides

## Descripción

Este código implementa un modelo de crecimiento logístico para simular la evolución de una población de androides. El modelo logístico es particularmente útil para modelar el crecimiento de poblaciones que tienen un límite máximo, como podría ser el caso de una línea de producción de androides con capacidad limitada.

## Parámetros del Modelo

El modelo utiliza tres parámetros principales:

- `p0 = 10`: Población inicial de androides
- `k = 0.001`: Tasa de crecimiento de la producción
- `M = 60`: Capacidad máxima de producción (número máximo de androides que se pueden mantener/producir)

## Implementación en R

### Configuración Inicial

```R
p0 <- 10    # Población inicial de androides
k <- 0.001  # Tasa de crecimiento
M <- 60     # Capacidad máxima de producción
```

### Función de Crecimiento Logístico

La ecuación logística que describe el crecimiento de la población es:

P(t) = M *p0 / (M* e^(-k*M*t) - p0 * e^(-k*M*t) + p0)

Implementación en R:

```R
poblacion <- function(tiempo) {
    M * p0 / (M * exp(-k * M * tiempo) - p0 * exp(-k * M * tiempo) + p0)
}
```

### Simulación del Crecimiento

```R
# Simulación para 30 meses
for(i in 1:30) {
    print(poblacion(i*12))
}

# Datos para visualización
x <- c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30)
x <- 12 * x/30  # Conversión a escala mensual

# Datos observados de la población de androides
y <- c(17.5,27.5,38.0,46.9,52.8,56.3,58.1,59.1,59.6,59.7,59.9,59.9,59.9,59.9,59.9,
       59.9,59.9,59.9,59.9,59.9,59.9,59.9,59.9,60,60,60,60,60,60,60)
```

### Visualización

```R
# Crear el gráfico
plot(x, y,
    main = "Evolución de la población de androides",
    xlab = "Tiempo de medición [meses]",
    ylab = "Número de androides [valor absoluto]",
    cex = 1,
    pch = 8
)
```

### Análisis de Regresión Lineal

Para demostrar por qué un modelo lineal no es apropiado para estos datos, ajustamos una regresión lineal:

```R
linearModel <- lm(y ~ x)
print(linearModel)
summary(linearModel)
```

## Interpretación del Modelo

### 1. Comportamiento del Crecimiento

- **Fase Inicial**: Crecimiento rápido desde 10 hasta aproximadamente 40 androides
- **Fase Media**: Desaceleración gradual entre 40 y 55 androides
- **Fase Final**: Estabilización cerca de la capacidad máxima (60 androides)

### 2. Características del Modelo Logístico

- El crecimiento no es constante (como asumiría un modelo lineal)
- La tasa de crecimiento es máxima al principio
- La población se estabiliza al acercarse a M = 60
- Los datos muestran una clara curva en forma de S (sigmoide)

### 3. Limitaciones del Modelo Lineal

- No captura la saturación del crecimiento
- Subestima el crecimiento inicial
- Sobreestima el crecimiento final
- Predice valores poco realistas fuera del rango de observación

## Conclusión

El modelo logístico es más apropiado que un modelo lineal para este caso porque:

1. Refleja las limitaciones físicas de la producción de androides
2. Captura la desaceleración natural del crecimiento
3. Tiene un límite superior realista
4. Modela correctamente las tres fases del crecimiento:
   - Crecimiento exponencial inicial
   - Desaceleración intermedia
   - Estabilización final

## Aplicaciones Prácticas

Este modelo puede utilizarse para:

- Planificar la capacidad de producción
- Predecir tiempos de saturación
- Optimizar recursos de fabricación
- Establecer metas realistas de producción
