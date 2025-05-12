# Modelo básico para Análisis de Eficiencia T-800
# Autor: Skynet
# Fecha: 28/8/1997
# Propósito: Análisis básico de eficiencia operativa de unidades T-800

# NOTA: Este script está diseñado para ejecutarse desde RStudio.
#       Si lo ejecutas desde otro entorno, la detección automática de la carpeta puede no funcionar.

# Fijar directorio de trabajo a la carpeta donde está este script
if (rstudioapi::isAvailable()) {
  setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
} else {
  # Si no estamos en RStudio, usar la ruta actual
  cat("Ejecutando fuera de RStudio. Asegúrate de que el archivo T800 data.csv está en el directorio actual.\n")
}

# Verificar e instalar librerías necesarias
paquetes_requeridos <- c("lavaan", "semPlot", "psych", "rstudioapi")
paquetes_faltantes <- paquetes_requeridos[!(paquetes_requeridos %in% installed.packages()[,"Package"])]

if(length(paquetes_faltantes) > 0) {
  cat("Instalando paquetes faltantes:", paste(paquetes_faltantes, collapse = ", "), "\n")
  install.packages(paquetes_faltantes, repos = "https://cloud.r-project.org")
}

# Cargar librerías necesarias
library(lavaan)    # Para análisis SEM
library(semPlot)   # Para visualización del modelo
library(psych)     # Para análisis psicométricos
library(rstudioapi) # Para manejo de rutas

# Configuración de opciones
options(scipen = 999)  # Evita notación científica en números

# Cargar datos de rendimiento de unidades T-800
archivo_datos <- "T800 data.csv"
if (!file.exists(archivo_datos)) {
  stop("Error: No se encuentra el archivo ", archivo_datos, 
       "\nAsegúrate de que el archivo está en el directorio: ", getwd())
}

datos <- read.csv(archivo_datos)

# DIAGNÓSTICO COMPLETO
cat("\n==============================\n")
cat("INFORME DE ANÁLISIS SEM T-800\n")
cat("==============================\n")

cat("\n1. Carga y resumen de datos\n")
cat("- Número de filas:", nrow(datos), "\n")
cat("- Variables disponibles:", paste(names(datos), collapse = ", "), "\n")
cat("- Resumen de combat_exp:\n")
print(summary(datos$combat_exp))
cat("- Resumen de self_diagnosis_hours:\n")
print(summary(datos$self_diagnosis_hours))
cat("- Correlación entre combat_exp y self_diagnosis_hours:\n")
print(cor(datos$combat_exp, datos$self_diagnosis_hours, use = "complete.obs"))

cat("\n2. Especificación y ajuste del modelo\n")
cat("Modelo de medida:
  Eficiencia =~ 1*combat_exp + self_diagnosis_hours\n")
cat("- Se fija el primer indicador (combat_exp) a 1 para identificar la escala de la variable latente.\n")
cat("- Se fija la varianza de la variable latente a 1.\n")

modelo <- "
  Eficiencia =~ 1*combat_exp + self_diagnosis_hours
  Eficiencia ~~ 1*Eficiencia
  combat_exp ~~ combat_exp
  self_diagnosis_hours ~~ self_diagnosis_hours
"

fit <- lavaan(modelo, 
             data = datos,
             auto.var = FALSE,
             auto.fix.first = FALSE)

cat("\n3. Resultados del modelo\n")
cat("- Parámetros estandarizados:\n")
print(parameterEstimates(fit, standardized = TRUE)[,c("lhs","op","rhs","est","se","z","pvalue","std.all")])

cat("\n- Medidas de ajuste global del modelo:\n")
print(fitMeasures(fit, c("chisq","df","pvalue","cfi","tli","rmsea","srmr")))

cat("\nInterpretación básica:\n")
cat("- Los coeficientes de carga indican la relación entre la variable latente 'Eficiencia' y los indicadores observados.\n")
cat("- Un valor negativo o bajo puede indicar poca relación o incluso relación inversa.\n")
cat("- Las medidas de ajuste (CFI, TLI, RMSEA, SRMR) ayudan a evaluar si el modelo representa bien los datos.\n")
cat("- Si CFI/TLI > 0.90 y RMSEA/SRMR < 0.08, el ajuste es aceptable.\n")

cat("\n4. Visualización del modelo\n")
semPaths(fit,
         what = "std",
         layout = "tree",
         edge.label.cex = 0.8,
         sizeMan = 8,
         sizeLat = 10,
         residuals = TRUE,
         intercepts = FALSE,
         color = list(lat = "red", man = "blue"))

cat("\nAnálisis completado.\n") 