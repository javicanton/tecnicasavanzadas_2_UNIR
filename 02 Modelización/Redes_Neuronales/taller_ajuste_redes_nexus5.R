# Taller: Ajuste de Parámetros en Redes Neuronales (Caso Nexus-5)
# Técnicas Cuantitativas Avanzadas II — UNIR

# Establecer el directorio de trabajo actual
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Establecer el directorio de trabajo actual
if (interactive()) {
  tryCatch({
    setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
  }, error = function(e) {
    setwd("02 Modelización/Redes_Neuronales")
  })
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
x <- model.matrix(fallo ~ ., data = nexus)[, -1]
y <- class.ind(nexus$fallo)

# Parámetros iniciales del modelo: MODIFICAR
param_size <- 5
param_decay <- 0.01
param_maxit <- 300

# Entrenamiento del modelo inicial
set.seed(42)
modelo_inicial <- nnet(x, y,
  size = param_size,
  decay = param_decay,
  maxit = param_maxit,
  softmax = TRUE,
  trace = FALSE
)

# Evaluación del modelo inicial
pred_inicial <- predict(modelo_inicial, x)[, 2]
pred_clase_inicial <- ifelse(pred_inicial > 0.5, 1, 0)
real <- as.numeric(nexus$fallo) - 1

# Matriz de confusión del modelo inicial
print("Matriz de Confusión del Modelo Inicial:")
confusionMatrix(factor(pred_clase_inicial), factor(real))

# Curva ROC del modelo inicial
roc_obj_inicial <- roc(real, pred_inicial)
plot(roc_obj_inicial, main = "Curva ROC - Modelo Inicial")
print("AUC del Modelo Inicial:")
print(auc(roc_obj_inicial))

# Visualización del modelo inicial
nexus$prob_fallo <- pred_inicial
p_inicial <- ggplot(nexus, aes(x = energia_restante, y = prob_fallo, color = fallo)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "loess", se = FALSE) +
  labs(
    title = "Probabilidad estimada de fallo vs Energía restante (Modelo Inicial)",
    x = "Energía restante (normalizada)",
    y = "Probabilidad de fallo"
  ) +
  theme_minimal()
print(p_inicial)