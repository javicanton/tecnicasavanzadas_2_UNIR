# Tema 3: Diseño de escenarios. Modelización en ciencias sociales
# Técnicas Avanzadas para el Análisis de Datos Cuantitativos II

# =============================================================================
# TYRELL CORPORATION - ANÁLISIS DE ELIMINACIONES NEXUS-5
# =============================================================================
#
# AÑO 2049
#
# Como analista de datos senior en la Tyrell Corporation, la principal constructora 
# de replicantes genéticos, he sido encargado de analizar los patrones de eliminación 
# de replicantes Nexus-5 en las principales ciudades del mundo. Este análisis es 
# crucial para entender la efectividad de nuestros Blade Runners y el impacto de 
# nuestros últimos modelos de replicantes en la sociedad.
#
# Los datos recopilados durante los últimos 36 meses revelan patrones fascinantes 
# y, en algunos casos, alarmantes. Cada ciudad presenta su propia dinámica única, 
# reflejando no solo la eficacia de nuestros sistemas de control, sino también la 
# compleja interacción entre la tecnología replicante y la sociedad humana.
#
# Este análisis se centra en ocho ciudades principales, cada una con su propio 
# patrón de eliminaciones y desafíos únicos. Los modelos matemáticos nos permiten 
# no solo entender el presente, sino también predecir tendencias futuras y ajustar 
# nuestras estrategias de control de replicantes.
#
# =============================================================================

# Configurar el directorio de trabajo al directorio donde está el script
setwd(dirname(rstudioapi::getSourceEditorContext()$path))

# Datos de eliminaciones por ciudad
# Opción 1: Usar datos directamente en el script
datos <- data.frame(
    month = 1:36,
    Los_Angeles = c(46, 47, 45, 48, 52, 49, 51, 53, 50, 54, 52, 55, 57, 56, 58, 59, 57, 60, 62, 61, 63, 64, 62, 65, 67, 66, 68, 69, 67, 70, 72, 71, 73, 74, 72, 75),
    Tokyo = c(37, 45, 55, 67, 82, 100, 122, 149, 182, 222, 271, 331, 404, 493, 602, 735, 897, 1095, 1337, 1632, 1993, 2433, 2971, 3627, 4428, 5406, 6600, 8059, 9840, 12015, 14670, 17910, 21865, 26695, 32590, 39790),
    Shanghai = c(173, 147, 125, 106, 90, 77, 65, 55, 47, 40, 34, 29, 25, 21, 18, 15, 13, 11, 9, 8, 7, 6, 5, 4, 4, 3, 3, 2, 2, 2, 1, 1, 1, 1, 1, 1),
    Londres = c(41, 43, 44, 46, 47, 49, 50, 51, 52, 53, 54, 54, 55, 55, 55, 55, 54, 53, 52, 50, 48, 46, 44, 41, 38, 35, 32, 29, 26, 23, 20, 17, 14, 11, 8, 6),
    Singapur = c(150, 165, 175, 182, 188, 193, 197, 200, 203, 205, 207, 209, 210, 211, 212, 213, 214, 214, 215, 215, 216, 216, 217, 217, 217, 218, 218, 218, 219, 219, 219, 219, 220, 220, 220, 220),
    Moscu = c(20, 28, 34, 40, 45, 49, 53, 57, 60, 63, 66, 69, 71, 74, 76, 78, 80, 82, 84, 86, 88, 90, 91, 93, 95, 96, 98, 99, 101, 102, 104, 105, 107, 108, 109, 111),
    Dubai = c(10, 12, 15, 18, 22, 27, 33, 40, 48, 58, 70, 84, 100, 119, 141, 167, 197, 231, 269, 311, 357, 407, 461, 519, 581, 647, 717, 791, 869, 951, 1037, 1127, 1221, 1319, 1421, 1527),
    Sydney = c(70, 86, 82, 74, 57, 53, 31, 35, 32, 17, 39, 56, 54, 92, 76, 73, 62, 34, 34, 32, 24, 23, 38, 51, 68, 91, 88, 80, 68, 48, 40, 26, 29, 30, 42, 56)
)

# Opción 2: Cargar datos desde CSV (comentada)
datos <- read.csv("datos_tyrell.csv", sep = ";", header = TRUE)

# Gráfico de dispersión para Los Angeles
plot(datos$month, datos$Los_Angeles,
     main = "Eliminaciones de Replicantes Nexus-5 en Los Angeles",
     xlab = "Mes",
     ylab = "Número de Eliminaciones",
     pch = 16,
     col = "blue")

# Ajuste del modelo lineal
modelo_LA <- lm(Los_Angeles ~ month, data = datos)
abline(modelo_LA, col = "red")

# Resumen del modelo lineal
summary(modelo_LA)

# Gráfico de dispersión para Tokyo
plot(datos$month, datos$Tokyo,
     main = "Eliminaciones de Replicantes Nexus-5 en Tokyo",
     xlab = "Mes",
     ylab = "Número de Eliminaciones",
     pch = 16,
     col = "green")

# Ajuste del modelo exponencial
modelo_Tokyo <- lm(log(Tokyo) ~ month, data = datos)
lines(datos$month, exp(predict(modelo_Tokyo)), col = "red")

# Resumen del modelo de Tokyo
summary(modelo_Tokyo)

# Gráfico de dispersión para Shanghai
plot(datos$month, datos$Shanghai,
     main = "Eliminaciones de Replicantes Nexus-5 en Shanghai",
     xlab = "Mes",
     ylab = "Número de Eliminaciones",
     pch = 16,
     col = "purple")

# Ajuste del modelo exponencial negativo
modelo_Shanghai <- lm(log(Shanghai) ~ month, data = datos)
lines(datos$month, exp(predict(modelo_Shanghai)), col = "red")

# Resumen del modelo de Shanghai
summary(modelo_Shanghai)

# Gráfico de dispersión para Londres
plot(datos$month, datos$Londres,
     main = "Eliminaciones de Replicantes Nexus-5 en Londres",
     xlab = "Mes",
     ylab = "Número de Eliminaciones",
     pch = 16,
     col = "orange")

# Ajuste del modelo polinomial
modelo_Londres <- lm(Londres ~ poly(month, 3), data = datos)
lines(datos$month, predict(modelo_Londres), col = "red")

# Resumen del modelo de Londres
summary(modelo_Londres)

# Gráfico de dispersión para Singapur
plot(datos$month, datos$Singapur,
     main = "Eliminaciones de Replicantes Nexus-5 en Singapur",
     xlab = "Mes",
     ylab = "Número de Eliminaciones",
     pch = 16,
     col = "darkblue")

# Ajuste del modelo logarítmico
modelo_Singapur <- lm(Singapur ~ log(month), data = datos)
lines(datos$month, predict(modelo_Singapur), col = "red")

# Resumen del modelo de Singapur
summary(modelo_Singapur)

# Gráfico de dispersión para Moscú
plot(datos$month, datos$Moscu,
     main = "Eliminaciones de Replicantes Nexus-5 en Moscú",
     xlab = "Mes",
     ylab = "Número de Eliminaciones",
     pch = 16,
     col = "red")

# Ajuste del modelo de potencia
modelo_Moscu <- lm(log(Moscu) ~ log(month), data = datos)
lines(datos$month, exp(predict(modelo_Moscu)), col = "blue")

# Resumen del modelo de Moscú
summary(modelo_Moscu)

# Gráfico de dispersión para Dubai
plot(datos$month, datos$Dubai,
     main = "Eliminaciones de Replicantes Nexus-5 en Dubai",
     xlab = "Mes",
     ylab = "Número de Eliminaciones",
     pch = 16,
     col = "gold")

# Ajuste del modelo sigmoidal
modelo_Dubai <- nls(Dubai ~ SSlogis(month, Asym, xmid, scal), data = datos)
lines(datos$month, predict(modelo_Dubai), col = "red")

# Resumen del modelo de Dubai
summary(modelo_Dubai)

# Gráfico de dispersión para Sydney
plot(datos$month, datos$Sydney,
     main = "Eliminaciones de Replicantes Nexus-5 en Sydney",
     xlab = "Mes",
     ylab = "Número de Eliminaciones",
     pch = 16,
     col = "cyan")

# Ajuste del modelo sinusoidal
modelo_Sydney <- lm(Sydney ~ sin(2*pi*month/12) + cos(2*pi*month/12), data = datos)
lines(datos$month, predict(modelo_Sydney), col = "red")

# Resumen del modelo de Sydney
summary(modelo_Sydney)

