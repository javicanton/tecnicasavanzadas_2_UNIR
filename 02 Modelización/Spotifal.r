# ========================================
# 0. CONFIGURACIÓN DEL ENTORNO
# ========================================
# Instalamos rstudioapi si no está disponible
if (!require("rstudioapi")) install.packages("rstudioapi")

# Establecemos el directorio de trabajo al directorio del script
setwd(dirname(rstudioapi::getSourceEditorContext()$path))

# ========================================
# ========================================
# 0. INSTALACIÓN DE PAQUETES NECESARIOS
# ========================================
# Instalamos los paquetes necesarios si no están ya instalados
if (!require("tidyverse")) install.packages("tidyverse")
if (!require("readr")) install.packages("readr")
if (!require("skimr")) install.packages("skimr")
if (!require("janitor")) install.packages("janitor")
if (!require("ggplot2")) install.packages("ggplot2")
if (!require("ggthemes")) install.packages("ggthemes")
if (!require("forcats")) install.packages("forcats")
if (!require("ggeffects")) install.packages("ggeffects")
if (!require("nnet")) install.packages("nnet")
if (!require("yardstick")) install.packages("yardstick")
if (!require("pROC")) install.packages("pROC")

# ========================================
# 1. CARGA DE LIBRERÍAS
# ========================================
# Estas librerías nos permiten manipular datos, hacer análisis y visualizaciones

library(tidyverse) # Conjunto de paquetes útiles: dplyr, ggplot2, tidyr...
library(readr) # Para leer archivos CSV
library(skimr) # Para obtener resúmenes estadísticos detallados
library(janitor) # Para limpiar nombres de columnas y detectar errores
library(ggplot2) # Para hacer gráficos
library(ggthemes) # Temas bonitos para gráficos
library(forcats) # Para trabajar con variables categóricas
library(ggeffects) # Para graficar efectos marginales de modelos generalizados
library(nnet) # Para modelos de redes neuronales
library(yardstick) # Para métricas de clasificación
library(pROC) # Para calcular curvas ROC y AUC y evaluar modelos de clasificación

# ========================================
# 2. CARGA DEL DATASET
# ========================================
# Cargamos el dataset directamente desde la misma carpeta
df <- read_csv("Dataset_Spotifal.csv")

# Verificamos que se cargó correctamente
if (nrow(df) == 0) {
    stop("El archivo Dataset_Spotifal.csv no se pudo cargar o está vacío")
}

# ========================================
# 3. LIMPIEZA BÁSICA
# ========================================
# Comprobamos nombres de columnas y valores ausentes

df <- clean_names(df) # Pone los nombres de columnas en formato limpio (snake_case)
skim(df) # Da un resumen completo: tipos, valores únicos, NAs, etc.
any(is.na(df)) # Verificamos si hay valores ausentes

# ========================================
# 4. ANÁLISIS DESCRIPTIVO BÁSICO
# ========================================

# Visualizamos las primeras filas
head(df)

# Estadísticos básicos de las variables numéricas
summary(select(df, dias_ultimo_inicio, canciones_por_semana, listas_creadas, edad, abandona))

# Distribución de las variables categóricas
df %>%
    select(tipo_suscripcion, genero_favorito, sexo) %>%
    map(table)

# ========================================
# 5. VISUALIZACIÓN DE CORRELACIONES
# ========================================

# Instalamos corrplot si no está disponible
if (!require("corrplot")) install.packages("corrplot")
library(corrplot)

# Creamos matriz de correlaciones para variables numéricas
variables_numericas <- df %>%
    select(dias_ultimo_inicio, canciones_por_semana, listas_creadas, edad, abandona)
matriz_cor <- cor(variables_numericas)

# Visualización de la matriz de correlaciones
corrplot(matriz_cor,
    method = "color",
    type = "upper",
    order = "hclust",
    addCoef.col = "black",
    tl.col = "black",
    tl.srt = 45,
    diag = FALSE
)

# Gráficos de dispersión para relaciones principales
# 1. Días último inicio vs Abandono
ggplot(df, aes(x = dias_ultimo_inicio, y = abandona)) +
    geom_jitter(height = 0.05, alpha = 0.5) +
    geom_smooth(method = "glm", method.args = list(family = "binomial")) +
    labs(
        title = "Relación entre días sin actividad y abandono",
        x = "Días desde último inicio",
        y = "Probabilidad de abandono"
    ) +
    theme_minimal()

# 2. Canciones por semana vs Abandono
ggplot(df, aes(x = canciones_por_semana, y = abandona)) +
    geom_jitter(height = 0.05, alpha = 0.5) +
    geom_smooth(method = "glm", method.args = list(family = "binomial")) +
    labs(
        title = "Relación entre uso semanal y abandono",
        x = "Canciones por semana",
        y = "Probabilidad de abandono"
    ) +
    theme_minimal()

# 3. Edad vs Abandono con línea de corte en 50 años
ggplot(df, aes(x = edad, y = abandona)) +
    geom_jitter(height = 0.05, alpha = 0.5) +
    geom_smooth(method = "glm", method.args = list(family = "binomial")) +
    geom_vline(xintercept = 50, linetype = "dashed", color = "red") +
    labs(
        title = "Relación entre edad y abandono",
        subtitle = "Línea vertical marca los 50 años",
        x = "Edad",
        y = "Probabilidad de abandono"
    ) +
    theme_minimal()

# 4. Visualización de tipo de suscripción vs abandono
ggplot(df, aes(x = tipo_suscripcion, fill = factor(abandona))) +
    geom_bar(position = "fill") +
    scale_fill_manual(
        values = c("steelblue", "tomato"),
        name = "Abandona",
        labels = c("No", "Sí")
    ) +
    labs(
        title = "Tasa de abandono por tipo de suscripción",
        x = "Tipo de suscripción",
        y = "Proporción"
    ) +
    theme_minimal()

# ========================================
# 6. MODELO LINEAL SIMPLE
# ========================================
# Objetivo: predecir la variable 'abandona' a partir de una sola variable predictora.
# Nota: aunque 'abandona' es binaria (0/1), empezamos con una regresión lineal para
# comprender mejor la relación básica con una sola variable.

# Modelo lineal: abandono en función de 'dias_ultimo_inicio'
modelo_lineal_simple <- lm(abandona ~ dias_ultimo_inicio, data = df)

# Resumen del modelo
summary(modelo_lineal_simple)

# Visualización del ajuste del modelo lineal
ggplot(df, aes(x = dias_ultimo_inicio, y = abandona)) +
    geom_jitter(height = 0.05, width = 0.3, alpha = 0.3, color = "darkblue") +
    geom_smooth(method = "lm", se = TRUE, color = "red") +
    labs(
        title = "Modelo lineal simple: abandono ~ días sin iniciar sesión",
        x = "Días desde el último inicio de sesión",
        y = "Probabilidad estimada de abandono"
    ) +
    theme_minimal()

# ========================================
# 7. MODELO LOGÍSTICO SIMPLE
# ========================================
# La variable 'abandona' es binaria (0 = no, 1 = sí), por lo que ahora usamos
# una regresión logística, que es el modelo más apropiado para este tipo de respuesta.

# Ajustamos un modelo logístico usando 'dias_ultimo_inicio' como predictor
modelo_logistico_simple <- glm(abandona ~ dias_ultimo_inicio, data = df, family = "binomial")

# Resumen del modelo
summary(modelo_logistico_simple)

# Visualización del ajuste del modelo logístico
ggplot(df, aes(x = dias_ultimo_inicio, y = abandona)) +
    geom_jitter(height = 0.05, width = 0.3, alpha = 0.3, color = "darkblue") +
    stat_smooth(method = "glm", method.args = list(family = "binomial"), se = TRUE, color = "darkred") +
    labs(
        title = "Modelo logístico simple: abandono ~ días sin iniciar sesión",
        x = "Días desde el último inicio de sesión",
        y = "Probabilidad estimada de abandono"
    ) +
    theme_minimal()

# ========================================
# 8. MODELO LOGÍSTICO MÚLTIPLE
# ========================================
# Ahora incluimos varias variables explicativas para mejorar la predicción de 'abandona'.

# Creamos un modelo logístico con múltiples variables:
modelo_logistico_multiple <- glm(
    abandona ~ dias_ultimo_inicio + canciones_por_semana +
        listas_creadas + edad + tipo_suscripcion,
    data = df, family = "binomial"
)

# Resumen del modelo
summary(modelo_logistico_multiple)

# Visualización de efectos marginales: probabilidad predicha según días de inactividad y tipo de suscripción
pred <- ggpredict(
    modelo_logistico_multiple,
    terms = c("dias_ultimo_inicio", "tipo_suscripcion")
)

ggplot(pred, aes(x = x, y = predicted, color = group)) +
    geom_line(size = 1.2) +
    labs(
        title = "Probabilidad de abandono según días sin iniciar sesión y tipo de suscripción",
        x = "Días desde el último inicio de sesión",
        y = "Probabilidad predicha",
        color = "Tipo de suscripción"
    ) +
    theme_minimal()

# ========================================
# 9. MODELO LOGÍSTICO CON INTERACCIONES
# ========================================
# Añadimos una interacción entre 'dias_ultimo_inicio' y 'tipo_suscripcion'.
# Esto permite comprobar si el efecto del tiempo de inactividad depende del tipo de cuenta.

modelo_interaccion <- glm(
    abandona ~ dias_ultimo_inicio * tipo_suscripcion +
        canciones_por_semana + listas_creadas + edad,
    data = df, family = "binomial"
)

# Resumen del modelo con interacción
summary(modelo_interaccion)

# Visualización del efecto de la interacción
pred_inter <- ggpredict(
    modelo_interaccion,
    terms = c("dias_ultimo_inicio", "tipo_suscripcion")
)

ggplot(pred_inter, aes(x = x, y = predicted, color = group)) +
    geom_line(size = 1.2) +
    labs(
        title = "Interacción: efecto de días sin iniciar sesión según tipo de suscripción",
        x = "Días desde el último inicio",
        y = "Probabilidad predicha de abandono",
        color = "Tipo de suscripción"
    ) +
    theme_minimal()

# ========================================
# 10. MODELO DE RED NEURONAL
# ========================================
# Vamos a entrenar una red neuronal simple para predecir la variable 'abandona'.
# Usaremos el paquete 'nnet', que permite redes sencillas de una capa oculta.

# Instalamos el paquete si no está disponible
if (!require("nnet")) install.packages("nnet")
library(nnet)

# Preparamos los datos: convertimos variables categóricas a numéricas
df_nn <- df %>%
    mutate(
        tipo_suscripcion = as.numeric(factor(tipo_suscripcion)),
        genero_favorito = as.numeric(factor(genero_favorito)),
        sexo = as.numeric(factor(sexo))
    )

# Normalizamos las variables numéricas para facilitar el entrenamiento
df_nn_scaled <- df_nn %>%
    mutate(across(
        c(dias_ultimo_inicio, canciones_por_semana, listas_creadas, edad),
        ~ scale(.)[, 1]
    ))

# Entrenamos una red neuronal con una capa oculta de 5 nodos
set.seed(123) # para reproducibilidad
modelo_red_neuronal <- nnet(
    abandona ~ dias_ultimo_inicio + canciones_por_semana + listas_creadas + edad +
        tipo_suscripcion + genero_favorito + sexo,
    data = df_nn_scaled,
    size = 5, # número de neuronas en la capa oculta
    maxit = 500, # número máximo de iteraciones
    decay = 0.01, # regularización
    linout = FALSE # salida logística, ideal para clasificación binaria
)

# Resumen de la red
print(modelo_red_neuronal)

# Predicción sobre los mismos datos
df_nn_scaled$pred_nn <- predict(modelo_red_neuronal, type = "raw")

# Visualización: comparativa de predicción según tipo de suscripción
ggplot(df_nn_scaled, aes(x = dias_ultimo_inicio, y = pred_nn, color = factor(tipo_suscripcion))) +
    geom_point(alpha = 0.5) +
    labs(
        title = "Red neuronal: predicción de abandono",
        x = "Días desde último inicio de sesión",
        y = "Probabilidad estimada",
        color = "Tipo de suscripción"
    ) +
    theme_minimal()

# ========================================
# 11. EVALUACIÓN DEL RENDIMIENTO
# ========================================
# Vamos a comparar los modelos utilizando métricas como la precisión, sensibilidad y AUC.

# Cargamos los paquetes necesarios
library(yardstick) # para métricas de clasificación
library(pROC) # para calcular curvas ROC y AUC

# Creamos una nueva tabla con predicciones de todos los modelos
df_evaluacion <- df_nn_scaled %>%
    mutate(
        pred_lineal = predict(modelo_lineal_simple, newdata = df, type = "response"),
        pred_log_simple = predict(modelo_logistico_simple, type = "response"),
        pred_log_multiple = predict(modelo_logistico_multiple, type = "response"),
        pred_interaccion = predict(modelo_interaccion, type = "response")
    ) %>%
    mutate(
        abandonado = factor(abandona, levels = c(0, 1), labels = c("no", "sí"))
    )

# Creamos una función para calcular métricas básicas
evaluar_modelo <- function(predicciones, verdad) {
    tibble(
        verdad = verdad,
        pred_prob = predicciones,
        pred_clase = factor(ifelse(predicciones > 0.5, "sí", "no"), levels = c("no", "sí"))
    ) %>%
        metrics(truth = verdad, estimate = pred_clase)
}

# Evaluamos los modelos
eval_lineal <- evaluar_modelo(df_evaluacion$pred_lineal, df_evaluacion$abandonado)
eval_log_simple <- evaluar_modelo(df_evaluacion$pred_log_simple, df_evaluacion$abandonado)
eval_log_multiple <- evaluar_modelo(df_evaluacion$pred_log_multiple, df_evaluacion$abandonado)
eval_interaccion <- evaluar_modelo(df_evaluacion$pred_interaccion, df_evaluacion$abandonado)
eval_nn <- evaluar_modelo(df_evaluacion$pred_nn, df_evaluacion$abandonado)

# Unimos los resultados en una tabla
evaluacion_total <- bind_rows(
    mutate(eval_lineal, modelo = "Lineal simple"),
    mutate(eval_log_simple, modelo = "Logístico simple"),
    mutate(eval_log_multiple, modelo = "Logístico múltiple"),
    mutate(eval_interaccion, modelo = "Logístico con interacción"),
    mutate(eval_nn, modelo = "Red neuronal")
)

# Mostramos la tabla final de evaluación
print(evaluacion_total)

# Comparación visual de curvas ROC
roc_lineal <- roc(df_evaluacion$abandonado, df_evaluacion$pred_lineal)
roc_log_simple <- roc(df_evaluacion$abandonado, df_evaluacion$pred_log_simple)
roc_log_multiple <- roc(df_evaluacion$abandonado, df_evaluacion$pred_log_multiple)
roc_interaccion <- roc(df_evaluacion$abandonado, df_evaluacion$pred_interaccion)
roc_nn <- roc(df_evaluacion$abandonado, df_evaluacion$pred_nn)

# Comparación visual de curvas ROC
plot(roc_log_simple, col = "blue", lwd = 2, main = "Curvas ROC de los modelos")
lines(roc_log_multiple, col = "green", lwd = 2)
lines(roc_interaccion, col = "purple", lwd = 2)
lines(roc_nn, col = "orange", lwd = 2)
lines(roc_lineal, col = "gray", lwd = 2, lty = 2)
legend("bottomright",
    legend = c("Logístico simple", "Logístico múltiple", "Interacción", "Red neuronal", "Lineal simple"),
    col = c("blue", "green", "purple", "orange", "gray"),
    lwd = 2, lty = c(1, 1, 1, 1, 2)
)
