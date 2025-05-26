# Taller: Ajuste de Parámetros en Redes Neuronales (Caso Nexus-5)
# Técnicas Cuantitativas Avanzadas II — UNIR

# Establecer el directorio de trabajo actual
if (interactive()) {
  tryCatch(
    {
      setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
    },
    error = function(e) {
      setwd("02 Modelización/Redes_Neuronales")
    }
  )
} else {
  setwd("02 Modelización/Redes_Neuronales")
}

# Cargar paquetes necesarios
required_packages <- c("nnet", "dplyr", "ggplot2", "caret", "pROC", "e1071")
for (pkg in required_packages) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg, repos = "https://cloud.r-project.org")
    library(pkg, character.only = TRUE)
  }
}

# Cargar y preparar datos
if (!file.exists("nexus5_datos_1000.csv")) {
  stop("El archivo nexus5_datos_1000.csv no existe en el directorio actual")
}

nexus <- read.csv("nexus5_datos_1000.csv", stringsAsFactors = FALSE)

# Verificar que no hay NA antes de la normalización
if (any(is.na(nexus))) {
  stop("Hay valores NA en el dataset que deben ser manejados primero")
}

# Normalización de variables numéricas
nexus <- nexus |>
  mutate(across(
    c(energia_restante, contacto_blade_runner, antiguedad, experiencia_acumulada),
    ~ (. - min(., na.rm = TRUE)) / (max(., na.rm = TRUE) - min(., na.rm = TRUE))
  )) |>
  mutate(
    sexo = as.factor(sexo),
    rebeldia = as.factor(rebeldia),
    fallo = as.factor(fallo)
  )

# Verificar que la transformación fue exitosa
if (any(is.na(nexus))) {
  stop("La normalización produjo valores NA")
}

# Preparar matrices para el modelo
x <- model.matrix(fallo ~ ., data = nexus)[, -1L]
y <- class.ind(nexus$fallo)

# Definir grid de parámetros para búsqueda
param_grid <- expand.grid(
  size = c(3L, 5L, 7L, 10L),
  decay = c(0.001, 0.01, 0.1),
  maxit = c(200L, 300L, 400L)
)

# Función para evaluar modelo
evaluar_modelo <- function(size, decay, maxit) {
  set.seed(42L)
  modelo <- nnet(x, y,
    size = size,
    decay = decay,
    maxit = maxit,
    softmax = TRUE,
    trace = FALSE
  )

  pred <- predict(modelo, x)[, 2L]
  pred_clase <- ifelse(pred > 0.5, 1L, 0L)
  real <- as.numeric(nexus$fallo) - 1L

  # Calcular métricas
  cm <- confusionMatrix(factor(pred_clase), factor(real))
  roc_obj <- roc(real, pred)

  return(list(
    accuracy = cm$overall["Accuracy"],
    sensitivity = cm$byClass["Sensitivity"],
    specificity = cm$byClass["Specificity"],
    auc = auc(roc_obj)
  ))
}

# Realizar búsqueda de parámetros
resultados <- list()
for (i in seq_len(nrow(param_grid))) {
  cat(sprintf("Evaluando combinación %d/%d\n", i, nrow(param_grid)))
  resultados[[i]] <- evaluar_modelo(
    param_grid$size[i],
    param_grid$decay[i],
    param_grid$maxit[i]
  )
}

# Convertir resultados a data frame
resultados_df <- do.call(rbind, lapply(resultados, as.data.frame))
resultados_completos <- cbind(param_grid, resultados_df)

# Encontrar mejor modelo según AUC
mejor_modelo <- resultados_completos[which.max(resultados_completos$auc), ]
print("Mejor combinación de parámetros:")
print(mejor_modelo)

# Visualizar resultados
ggplot(resultados_completos, aes(x = size, y = auc, color = factor(decay))) +
  geom_point() +
  geom_line(aes(group = decay)) +
  facet_wrap(~maxit) +
  labs(
    title = "AUC por combinación de parámetros",
    x = "Número de neuronas",
    y = "AUC",
    color = "Decay"
  ) +
  theme_minimal()

# Entrenar modelo final con mejores parámetros
set.seed(42L)
modelo_final <- nnet(x, y,
  size = mejor_modelo$size,
  decay = mejor_modelo$decay,
  maxit = mejor_modelo$maxit,
  softmax = TRUE,
  trace = FALSE
)

# Evaluación del modelo final
pred_final <- predict(modelo_final, x)[, 2L]
pred_clase_final <- ifelse(pred_final > 0.5, 1L, 0L)
real <- as.numeric(nexus$fallo) - 1L

# Matriz de confusión del modelo final
print("Matriz de Confusión del Modelo Final:")
confusionMatrix(factor(pred_clase_final), factor(real))

# Curva ROC del modelo final
roc_obj_final <- roc(real, pred_final)
plot(roc_obj_final, main = "Curva ROC - Modelo Final")
print("AUC del Modelo Final:")
print(auc(roc_obj_final))

# Visualización del modelo final
nexus$prob_fallo <- pred_final
p_final <- ggplot(nexus, aes(x = energia_restante, y = prob_fallo, color = fallo)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "loess", se = FALSE) +
  labs(
    title = "Probabilidad estimada de fallo vs Energía restante (Modelo Final)",
    x = "Energía restante (normalizada)",
    y = "Probabilidad de fallo"
  ) +
  theme_minimal()
print(p_final)
