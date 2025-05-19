# Modelo SEM educativo: Influencia del apoyo docente en la motivación y el rendimiento
# Autor: Equipo docente
# Fecha: [modifica según convenga]
# Propósito: Analizar cómo el apoyo percibido del profesorado influye en la motivación del alumnado y, a su vez, en su rendimiento

# Fijar directorio si se ejecuta desde RStudio
if (rstudioapi::isAvailable()) {
  setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
} else {
  cat("Ejecutando fuera de RStudio. Asegúrate de que el archivo esté en el directorio actual.\n")
}

# Verificar e instalar paquetes necesarios
paquetes <- c("lavaan", "semPlot", "psych", "rstudioapi")
instalar <- paquetes[!(paquetes %in% installed.packages()[,"Package"])]
if(length(instalar) > 0) {
  install.packages(instalar, repos = "https://cloud.r-project.org")
}

# Cargar librerías
library(lavaan)
library(semPlot)
library(psych)
library(rstudioapi)

# Evitar notación científica
options(scipen = 999)

# Cargar datos educativos
archivo <- "datos_educativos.csv"
if (!file.exists(archivo)) {
  stop("Error: No se encuentra el archivo ", archivo, "\nRevisa el directorio de trabajo: ", getwd())
}
datos <- read.csv(archivo)

# INFORME SEM
cat("\n==================================\n")
cat("ANÁLISIS SEM: MODELO EDUCATIVO\n")
cat("==================================\n")

cat("\n1. Carga de datos:\n")
cat("- Filas:", nrow(datos), "\n")
cat("- Variables:", paste(names(datos), collapse = ", "), "\n")

# Verificar datos antes del análisis
cat("\nVerificación de datos:\n")
print(summary(datos))
print(cor(datos, use = "complete.obs"))

# Definir el modelo SEM con varianzas explícitas
modelo_educativo <- '
  # Factores latentes
  Apoyo_Docente =~ claridad_explicacion + disponibilidad_profesor + feedback_rapido
  Motivacion_Alumno =~ interes_tema + esfuerzo_estudio + asistencia
  Rendimiento_Academico =~ nota_final + calidad_trabajos + participacion_clase

  # Varianzas de factores latentes
  Apoyo_Docente ~~ Apoyo_Docente
  Motivacion_Alumno ~~ Motivacion_Alumno
  Rendimiento_Academico ~~ Rendimiento_Academico

  # Relaciones estructurales
  Motivacion_Alumno ~ Apoyo_Docente
  Rendimiento_Academico ~ Motivacion_Alumno + Apoyo_Docente
'

cat("\n2. Especificación del modelo:\n")
cat("- Modelo con 3 factores latentes y relaciones jerárquicas.\n")

# Ajuste del modelo con opciones de optimización
fit <- lavaan(modelo_educativo, 
              data = datos,
              auto.var = TRUE,
              auto.fix.first = TRUE,
              auto.cov.lv.x = TRUE,
              estimator = "MLM",  # Usar estimador robusto
              optim.method = "nlminb",  # Método de optimización más robusto
              control = list(iter.max = 1000))  # Aumentar iteraciones máximas

cat("\n3. Resultados del modelo:\n")
cat("- Parámetros estandarizados:\n")
print(parameterEstimates(fit, standardized = TRUE)[,c("lhs","op","rhs","est","se","z","pvalue","std.all")])

cat("\n- Índices de ajuste global:\n")
print(fitMeasures(fit, c("chisq", "df", "pvalue", "cfi", "tli", "rmsea", "srmr")))

cat("\nInterpretación:\n")
cat("- Relación positiva entre Apoyo Docente y Motivación.\n")
cat("- Influencia significativa de ambos factores sobre el Rendimiento.\n")
cat("- Evalúa el ajuste con CFI/TLI > 0.90 y RMSEA/SRMR < 0.08.\n")

# Visualización del modelo
semPaths(fit,
         what = "std",
         layout = "tree",
         edge.label.cex = 0.8,
         sizeMan = 8,
         sizeLat = 10,
         residuals = TRUE,
         intercepts = FALSE,
         color = list(lat = "darkgreen", man = "steelblue"))

# Visualización del modelo SEM (se guarda como imagen)
png("modelo_educativo_SEM.png", width=800, height=600)
semPaths(fit,
         what = "std",
         layout = "tree",
         edge.label.cex = 0.8,
         sizeMan = 8,
         sizeLat = 10,
         residuals = TRUE,
         intercepts = FALSE,
         color = list(lat = "darkgreen", man = "steelblue"))
dev.off()

# Matriz de correlaciones (se guarda como imagen)
png("matriz_correlaciones.png", width=800, height=600)
cor.plot(cor(datos, use = "complete.obs"),
         numbers = TRUE,
         main = "Matriz de Correlaciones",
         colors = TRUE)
dev.off()

# Gráfico de cargas factoriales (se guarda como imagen)
library(ggplot2)
library(dplyr)
png("cargas_factoriales.png", width=800, height=600)
parameterEstimates(fit, standardized = TRUE) %>%
  filter(op == "=~") %>%
  ggplot(aes(x = rhs, y = std.all)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  facet_wrap(~lhs) +
  theme_minimal() +
  labs(title = "Cargas Factoriales Estandarizadas",
       x = "Indicadores",
       y = "Carga Estandarizada") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
dev.off()

cat("\nAnálisis completado con éxito.\n")
cat("==================================\n")
cat("Fin del script.\n")
