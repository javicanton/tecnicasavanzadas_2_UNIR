# Tema 3: Diseño de escenarios. Modelización en ciencias sociales
# Técnicas Avanzadas para el Análisis de Datos Cuantitativos II

# Este código implementa un modelo de crecimiento logístico para una población de bacterias
# El modelo logístico es especialmente útil para describir poblaciones que tienen un límite de crecimiento
# debido a restricciones ambientales (como nutrientes, espacio, etc.)

# Código para calcular la evolución de la población de bacterias en un cultivo

# Parámetros del modelo logístico:
# p0: Población inicial de bacterias (1000 bacterias)
# k: Tasa de crecimiento intrínseca (0.0001)
# M: Capacidad máxima del cultivo (100000 bacterias)
# La capacidad máxima representa el número máximo de bacterias que el medio puede sostener
p0 <- 1000 # Población inicial de bacterias
k <- 0.0001 # Tasa de crecimiento
M <- 100000 # Capacidad máxima del cultivo

# Función que implementa la ecuación logística:
# P(t) = M * p0 / (M * e^(-k*M*t) - p0 * e^(-k*M*t) + p0)
# Esta ecuación describe cómo la población crece inicialmente de forma exponencial
# y luego se ralentiza hasta alcanzar la capacidad máxima M
poblacion <- function(tiempo) {
    M * p0 / (M * exp(-k * M * tiempo) - p0 * exp(-k * M * tiempo) + p0)
}

# Simulación del crecimiento durante 24 horas
# Calculamos la población para cada hora y mostramos los resultados
for (i in 1:24) {
    print(poblacion(i))
}

# Datos para el análisis y visualización
# x: Vector de tiempo en horas (1 a 24)
# y: Datos simulados de población que siguen una curva logística
x <- 1:24 # Horas
y <- c(
    1000, 1500, 2200, 3200, 4500, 6500, 9000, 12500, 17000, 23000,
    31000, 41000, 54000, 70000, 85000, 95000, 98000, 99500, 99800,
    99900, 99950, 99980, 99990, 99995
)

# Creación del gráfico de dispersión
# Este gráfico nos permite visualizar la curva de crecimiento
# cex: tamaño de los puntos
# pch: tipo de símbolo para los puntos
plot(x, y,
    main = "Evolución de la población de bacterias",
    xlab = "Tiempo [horas]",
    ylab = "Número de bacterias",
    cex = 1,
    pch = 8
)

# Ajuste de un modelo lineal a los datos
# Aunque los datos siguen una curva logística, ajustamos una línea recta
# para ver cómo se desvía del comportamiento lineal
# Esto nos ayuda a entender la no-linealidad del crecimiento
linearModel <- lm(y ~ x)
print(linearModel)
summary(linearModel)

# El summary nos proporciona información importante sobre el ajuste:
# - Coeficientes: pendiente e intercepto de la línea
# - R-squared: qué tan bien la línea explica los datos
# - p-valores: significancia estadística de los coeficientes
# - Residuales: diferencias entre valores observados y predichos
