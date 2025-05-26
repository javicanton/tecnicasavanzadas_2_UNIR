# Taller: Ajuste de Parámetros en Redes Neuronales (Caso Nexus-5)
# Técnicas Cuantitativas Avanzadas II — UNIR
# Evaluación de modelos

# Función para evaluar modelos
evaluar_modelo <- function(size, decay, maxit) {
  set.seed(42)
  modelo <- nnet(x, y,
    size = size,
    decay = decay,
    maxit = maxit,
    softmax = TRUE,
    trace = FALSE
  )

  pred <- predict(modelo, x)[, 2]
  pred_clase <- ifelse(pred > 0.5, 1, 0)
  real <- as.numeric(nexus$fallo) - 1

  # Calcular métricas
  cm <- confusionMatrix(factor(pred_clase), factor(real))
  roc_obj <- roc(real, pred)

  # Devolver resultados como vector
  c(
    size = size,
    decay = decay,
    maxit = maxit,
    accuracy = as.numeric(cm$overall["Accuracy"]),
    sensitivity = as.numeric(cm$byClass["Sensitivity"]),
    specificity = as.numeric(cm$byClass["Specificity"]),
    auc = as.numeric(auc(roc_obj))
  )
}

# Definir combinaciones a probar
combinaciones <- expand.grid(
  size = c(2, 5, 10, 20),
  decay = c(0.001, 0.01, 0.1),
  maxit = c(100, 300, 500, 1000)
)

# Evaluar todas las combinaciones
resultados <- t(sapply(1:nrow(combinaciones), function(i) {
  with(combinaciones[i, ], evaluar_modelo(size, decay, maxit))
}))

# Convertir a data frame
resultados_df <- as.data.frame(resultados)

# Ordenar por AUC (de mayor a menor)
resultados_df <- resultados_df[order(resultados_df$auc, decreasing = TRUE), ]

# Mostrar resultados
print(knitr::kable(resultados_df,
  digits = 3,
  caption = "Comparativa de Modelos"
))

# Visualizar resultados
# Gráfico de AUC
p1 <- ggplot(resultados_df, aes(x = size, y = auc, color = factor(decay))) +
  geom_point(size = 3) +
  geom_line(aes(group = decay)) +
  facet_wrap(~maxit) +
  labs(
    title = "AUC por combinación de hiperparámetros",
    x = "Tamaño de capa oculta",
    y = "AUC",
    color = "Decay"
  ) +
  theme_minimal()

# Gráfico de Precisión
p2 <- ggplot(resultados_df, aes(x = size, y = accuracy, color = factor(decay))) +
  geom_point(size = 3) +
  geom_line(aes(group = decay)) +
  facet_wrap(~maxit) +
  labs(
    title = "Precisión por combinación de hiperparámetros",
    x = "Tamaño de capa oculta",
    y = "Precisión",
    color = "Decay"
  ) +
  theme_minimal()

# Mostrar gráficos
print(p1)
print(p2)

# Función para entrenar y evaluar un modelo específico
entrenar_evaluar_modelo <- function(size, decay, maxit) {
  set.seed(42)
  modelo <- nnet(x, y,
    size = size,
    decay = decay,
    maxit = maxit,
    softmax = TRUE,
    trace = FALSE
  )

  pred <- predict(modelo, x)[, 2]
  pred_clase <- ifelse(pred > 0.5, 1, 0)
  real <- as.numeric(nexus$fallo) - 1

  # Matriz de confusión
  cm <- confusionMatrix(factor(pred_clase), factor(real))
  print("Matriz de Confusión:")
  print(cm$table)

  # Métricas
  print("\nMétricas:")
  print(cm$overall)
  print(cm$byClass)

  # Curva ROC
  roc_obj <- roc(real, pred)
  print("\nAUC:")
  print(auc(roc_obj))

  # Gráfico de probabilidades
  nexus$prob_fallo <- pred
  p3 <- ggplot(nexus, aes(x = energia_restante, y = prob_fallo, color = fallo)) +
    geom_point(alpha = 0.5) +
    geom_smooth(method = "loess", se = FALSE) +
    labs(
      title = "Probabilidad estimada de fallo vs Energía restante",
      x = "Energía restante (normalizada)",
      y = "Probabilidad de fallo"
    ) +
    theme_minimal()

  print(p3)

  return(modelo)
}

# Ejemplo de uso con los mejores parámetros encontrados
print("\nEvaluación del mejor modelo encontrado:")
mejor_modelo <- entrenar_evaluar_modelo(
  size = resultados_df$size[1],
  decay = resultados_df$decay[1],
  maxit = resultados_df$maxit[1]
)
