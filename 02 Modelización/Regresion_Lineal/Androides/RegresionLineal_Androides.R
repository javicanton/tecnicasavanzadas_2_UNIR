# Tema 3: Diseño de escenarios. Modelización en ciencias sociales
# Técnicas Avanzadas para el Análisis de Datos Cuantitativos II

# Este código implementa un modelo de crecimiento logístico para una población de androides
# El modelo logístico es útil para describir poblaciones que tienen un límite de crecimiento
# debido a restricciones como recursos, espacio o capacidad de producción

# Parámetros del modelo logístico:
# p0: Población inicial de androides (10 unidades)
# k: Tasa de crecimiento intrínseca (0.001)
# M: Capacidad máxima de producción (60 androides)
p0 = 10
k = 0.001
M = 60

# Función que implementa la ecuación logística:
# P(t) = M * p0 / (M * e^(-k*M*t) - p0 * e^(-k*M*t) + p0)
# Esta ecuación describe cómo la población crece inicialmente de forma exponencial
# y luego se ralentiza hasta alcanzar la capacidad máxima M
poblacion <- function(tiempo){M*p0/(M*exp(-k*M*tiempo) -p0*exp(-k*M*tiempo)+p0)}

# Simulación del crecimiento durante 30 meses
# Calculamos la población para cada mes multiplicando i por 12 para convertir a meses
for(i in 1:30) {
    print(poblacion(i*12))
}

# Creación de vectores para el análisis
# x: Vector de tiempo en meses (1 a 30)
# Convertimos x a escala mensual multiplicando por 12/30
x <- c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30)
x = 12*x/30

# y: Datos simulados de población que siguen una curva logística
# Estos valores muestran el crecimiento típico: rápido al inicio y luego se estabiliza cerca de M=60
y <- c(17.5,27.5,38.0,46.9,52.8,56.3,58.1,59.1,59.6,59.7,59.9,59.9,59.9,59.9,59.9,59.9,59.9,59.9,59.9,59.9,59.9,59.9,59.9,60,60,60,60,60,60,60)

# Creación del gráfico de dispersión
# Este gráfico nos permite visualizar la curva de crecimiento logístico
# cex: tamaño de los puntos
# pch: tipo de símbolo para los puntos (8 = asterisco)
plot(main = "Evolución de la población de androides",
     x, xlab = "Tiempo de medición [meses]",
     y, ylab = "Número de androides [valor absoluto]",
     cex = 1, pch = 8)

# Ajuste de un modelo lineal a los datos
# Aunque los datos siguen una curva logística, ajustamos una línea recta
# para ver cómo se desvía del comportamiento lineal
linearModel <- lm(y ~ x)
print(linearModel)
# El summary nos proporciona información sobre el ajuste:
# - Coeficientes: pendiente e intercepto de la línea
# - R-squared: cómo de bien la línea explica los datos
# - p-valores: significancia estadística
summary(linearModel)
