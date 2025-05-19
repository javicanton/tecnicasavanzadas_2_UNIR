# Establecer el directorio de trabajo actual
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# -------------------------------------------------------------
# Modelo de Red Neuronal para detección de fallos en Nexus-5
# Tyrell Corporation — División Analítica Experimental
# -------------------------------------------------------------
# Este script está diseñado como ejemplo práctico para entender
# cómo funcionan las redes neuronales en R usando el paquete nnet.
# Podrás experimentar con diferentes estructuras de red y evaluar
# el rendimiento del modelo con métricas estándar.
#
# El output de este script incluye:
# - Estadísticas descriptivas de las variables
# - Proceso de entrenamiento de la red neuronal
# - Métricas de evaluación (matriz de confusión, AUC, curva ROC)
# - Visualización de la probabilidad de fallo según energía restante

# Verificar e instalar paquetes necesarios
paquetes <- c("nnet", "dplyr", "ggplot2", "caret", "pROC", "e1071")
for (pkg in paquetes) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg)
    library(pkg, character.only = TRUE)
  }
}

# -----------------------------------------
# 1. Cargar y explorar los datos
# -----------------------------------------
df <- read.csv("nexus5_datos_1000.csv")
str(df) # Estructura de los datos: muestra tipos y rangos de variables
summary(df) # Estadísticas descriptivas: medias, medianas, mínimos y máximos
#
# Interpretación:
# - Las variables numéricas (energía, contacto, antigüedad, experiencia) están en diferentes escalas.
# - 'sexo', 'rebeldia' y 'fallo' son variables categóricas (fallo es binaria: 0/1).
# - El dataset está balanceado: fallo tiene media ~0.51 (mitad de los casos son fallos).

# -----------------------------------------
# 2. Normalizar y preparar los datos
# -----------------------------------------
# Las redes neuronales funcionan mejor con variables numéricas normalizadas (0 a 1)
normalizar <- function(x) (x - min(x)) / (max(x) - min(x))

df_norm <- df %>%
  mutate(
    across(
      c(energia_restante, contacto_blade_runner, antiguedad, experiencia_acumulada),
      normalizar
    )
  ) %>%
  mutate(
    sexo = as.factor(sexo),
    rebeldia = as.factor(rebeldia),
    fallo = as.factor(fallo)
  )
#
# Interpretación:
# - Se normalizan las variables numéricas para mejorar el aprendizaje de la red.
# - Las variables categóricas se convierten a factor para su posterior codificación.

# Convertimos variables categóricas en dummies (codificación one-hot)
df_model <- model.matrix(fallo ~ ., data = df_norm)[, -1]
df_fallo <- df_norm$fallo
#
# Interpretación:
# - La función model.matrix crea variables dummy para las categóricas.
# - Se elimina la primera columna para evitar multicolinealidad.

# -----------------------------------------
# 3. Entrenamiento del modelo
# -----------------------------------------
# Puedes modificar los siguientes parámetros para experimentar:
tamanio_capa_oculta <- 5 # Número de neuronas en la capa oculta
max_iteraciones <- 300 # Número máximo de iteraciones
decaimiento <- 0.01 # Parámetro de regularización

set.seed(42)
modelo_nn <- nnet(
  x = df_model,
  y = class.ind(df_fallo), # clase binaria codificada
  size = tamanio_capa_oculta,
  maxit = max_iteraciones,
  decay = decaimiento,
  softmax = TRUE # clasificación multiclase (aquí binaria)
)
#
# Output del entrenamiento:
# - El modelo converge tras unas 190 iteraciones.
# - El valor final de la función de error disminuye notablemente respecto al inicial, lo que indica aprendizaje.

# -----------------------------------------
# 4. Predicción y evaluación
# -----------------------------------------
# Predicción
pred_prob <- predict(modelo_nn, df_model)[, 2] # Probabilidad estimada de fallo (clase 1)
pred_clase <- ifelse(pred_prob > 0.5, 1, 0) # Clasificación binaria según umbral 0.5

# Matriz de confusión
conf_matrix <- confusionMatrix(factor(pred_clase), factor(df$fallo))
print(conf_matrix)
#
# Interpretación de la matriz de confusión:
# - Accuracy: 0.669 (el modelo acierta el 66.9% de los casos)
# - Sensibilidad (detecta fallos reales): 0.56
# - Especificidad (detecta no-fallos): 0.77
# - El modelo es mejor prediciendo la clase 0 (no fallo) que la clase 1 (fallo)
# - El AUC (ver abajo) nos da una visión global del poder discriminativo

# Curva ROC y AUC
roc_obj <- roc(df$fallo, pred_prob)
plot(roc_obj, main = "Curva ROC — Nexus 5")
cat("AUC:", auc(roc_obj), "\n")
#
# Interpretación:
# - El AUC es 0.74, lo que indica un modelo con capacidad discriminativa aceptable (0.5 sería azar, 1.0 perfecto)
# - La curva ROC muestra el compromiso entre sensibilidad y especificidad

# -----------------------------------------
# 5. Visualización
# -----------------------------------------
df_vis <- df_norm %>%
  mutate(prob_fallo = pred_prob)

# Visualización: Probabilidad de fallo según energía restante
ggplot(df_vis, aes(x = energia_restante, y = prob_fallo, color = fallo)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "loess", se = FALSE) +
  labs(
    title = "Probabilidad estimada de fallo según energía restante",
    x = "Energía restante (normalizada)",
    y = "Probabilidad de fallo"
  ) +
  theme_minimal()
#
# Interpretación del gráfico:
# - Se observa que a menor energía restante, la probabilidad de fallo tiende a ser mayor.
# - La tendencia es más clara para la clase 1 (fallo), aunque hay solapamiento entre clases.
# - El modelo capta una relación negativa entre energía y probabilidad de fallo.

# Visualización: Probabilidad de fallo según antigüedad
ggplot(df_vis, aes(x = antiguedad, y = prob_fallo, color = fallo)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "loess", se = FALSE) +
  labs(
    title = "Probabilidad estimada de fallo según antigüedad",
    x = "Antigüedad (normalizada)",
    y = "Probabilidad de fallo"
  ) +
  theme_minimal()
#
# Interpretación:
# - Permite observar si la antigüedad del Nexus-5 influye en la probabilidad de fallo.
# - Analiza si hay tendencia creciente o decreciente según la antigüedad.

# Visualización: Probabilidad de fallo según contacto_blade_runner
ggplot(df_vis, aes(x = contacto_blade_runner, y = prob_fallo, color = fallo)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "loess", se = FALSE) +
  labs(
    title = "Probabilidad estimada de fallo según contacto con Blade Runner",
    x = "Contacto con Blade Runner (normalizado)",
    y = "Probabilidad de fallo"
  ) +
  theme_minimal()
#
# Interpretación:
# - Permite analizar si el contacto con Blade Runner afecta la probabilidad de fallo.
# - Observa si hay relación positiva, negativa o nula.

# Visualización: Probabilidad de fallo según experiencia acumulada
ggplot(df_vis, aes(x = experiencia_acumulada, y = prob_fallo, color = fallo)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "loess", se = FALSE) +
  labs(
    title = "Probabilidad estimada de fallo según experiencia acumulada",
    x = "Experiencia acumulada (normalizada)",
    y = "Probabilidad de fallo"
  ) +
  theme_minimal()
#
# Interpretación:
# - Analiza si la experiencia acumulada del Nexus-5 está asociada a mayor o menor probabilidad de fallo.

# Visualización: Probabilidad de fallo según rebeldía
ggplot(df_vis, aes(x = as.numeric(rebeldia), y = prob_fallo, color = fallo)) +
  geom_jitter(alpha = 0.5, width = 0.1) +
  geom_smooth(method = "loess", se = FALSE) +
  scale_x_continuous(breaks = c(0, 1), labels = c("No rebelde", "Rebelde")) +
  labs(
    title = "Probabilidad estimada de fallo según rebeldía",
    x = "Rebeldía",
    y = "Probabilidad de fallo"
  ) +
  theme_minimal()
#
# Interpretación:
# - Permite comparar la probabilidad de fallo entre Nexus-5 rebeldes y no rebeldes.
# - Observa si la rebeldía incrementa la probabilidad de fallo según el modelo.

# -----------------------------------------
# 6. Próximos pasos sugeridos
# -----------------------------------------
# - Experimenta con el tamaño de la capa oculta (size)
# - Ajusta el decay y número de iteraciones
# - Separa en entrenamiento/test para validación cruzada
# - Usa otros modelos con caret para comparar
#
# Nota: El script actual entrena y evalúa sobre el mismo conjunto de datos. Para una evaluación más realista, separar en train/test o usar validación cruzada.

# -----------------------------------------
# 7. Mejoras y comparación de modelos
# -----------------------------------------
# En esta sección se implementan estrategias para mejorar la accuracy y comparar modelos.
# No se borra nada del proceso anterior, esto es una extensión.

# 7.1 Separación en conjunto de entrenamiento y test (70/30)
library(caret)
set.seed(123)
trainIndex <- createDataPartition(df_fallo, p = 0.7, list = FALSE)
df_train <- df_model[trainIndex, ]
df_test <- df_model[-trainIndex, ]
fallo_train <- df_fallo[trainIndex]
fallo_test <- df_fallo[-trainIndex]

# Convertimos los niveles de la variable objetivo a nombres válidos para caret
fallo_train_caret <- factor(ifelse(fallo_train == 1, "fallo_1", "fallo_0"))
fallo_test_caret <- factor(ifelse(fallo_test == 1, "fallo_1", "fallo_0"))

# 7.2 Entrenamiento de la red neuronal con los datos de entrenamiento
modelo_nn_train <- nnet(
  x = df_train,
  y = class.ind(fallo_train),
  size = tamanio_capa_oculta,
  maxit = max_iteraciones,
  decay = decaimiento,
  softmax = TRUE
)
#
# Output del entrenamiento:
# - El modelo converge tras 160 iteraciones
# - El valor de la función de error baja de 500 a 413, indicando aprendizaje efectivo
# - La convergencia es estable, sin oscilaciones significativas

# 7.3 Evaluación en el conjunto de test
pred_prob_test <- predict(modelo_nn_train, df_test)[, 2]
pred_clase_test <- ifelse(pred_prob_test > 0.5, 1, 0)
conf_matrix_test <- confusionMatrix(factor(pred_clase_test), factor(fallo_test))
print(conf_matrix_test)
roc_obj_test <- roc(fallo_test, pred_prob_test)
cat("AUC test:", auc(roc_obj_test), "\n")
#
# Resultados en test:
# - Accuracy: 0.612 (61.2% de aciertos)
# - AUC: 0.622 (capacidad discriminativa moderada)
# - Sensibilidad: 0.545 (54.5% de aciertos en clase 0)
# - Especificidad: 0.675 (67.5% de aciertos en clase 1)
# - Balanced Accuracy: 0.610
# Interpretación:
# - El rendimiento es modesto pero mejor que el azar (p-valor < 0.001)
# - El modelo es ligeramente mejor prediciendo la clase 1 (no fallo)
# - La diferencia entre sensibilidad y especificidad indica cierto desbalance

# 7.4 Búsqueda de hiperparámetros con caret (validación cruzada)
grid <- expand.grid(
  size = c(3, 5, 7, 10),
  decay = c(0.001, 0.01, 0.1)
)
control <- trainControl(method = "cv", number = 5, classProbs = TRUE)
set.seed(123)
modelo_caret <- train(
  x = df_train,
  y = fallo_train_caret,
  method = "nnet",
  tuneGrid = grid,
  trControl = control,
  maxit = 300,
  trace = FALSE
)
print(modelo_caret)
#
# Resultados de la validación cruzada:
# - Mejor combinación: size=3, decay=0.1 (accuracy=0.640)
# - La red más pequeña con regularización moderada funciona mejor
# - El resto de combinaciones tienen accuracy entre 0.61-0.63

# Evaluación del mejor modelo en test
y_pred_caret <- predict(modelo_caret, df_test)
conf_matrix_caret <- confusionMatrix(y_pred_caret, fallo_test_caret)
print(conf_matrix_caret)
#
# Resultados del modelo optimizado en test:
# - Accuracy: 0.612 (igual que el modelo básico)
# - Sensibilidad: 0.566
# - Especificidad: 0.656
# - Balanced Accuracy: 0.611
# Interpretación:
# - La optimización no mejoró el rendimiento en test
# - Sugiere que el problema puede estar en las características o en el tamaño del dataset

# 7.5 Comparación con otros modelos
# Árbol de decisión
set.seed(123)
modelo_arbol <- train(
  x = df_train,
  y = fallo_train_caret,
  method = "rpart",
  trControl = control
)
y_pred_arbol <- predict(modelo_arbol, df_test)
conf_matrix_arbol <- confusionMatrix(y_pred_arbol, fallo_test_caret)
print(conf_matrix_arbol)
#
# Resultados del árbol de decisión:
# - Accuracy: 0.582 (58.2%)
# - Sensibilidad: 0.297 (muy baja)
# - Especificidad: 0.851 (muy alta)
# - Balanced Accuracy: 0.574
# Interpretación:
# - El árbol tiene un rendimiento inferior a las redes neuronales
# - Muestra un fuerte desbalance entre sensibilidad y especificidad
# - Tiende a clasificar todo como clase 1 (no fallo)

# Random Forest
set.seed(123)
modelo_rf <- train(
  x = df_train,
  y = fallo_train_caret,
  method = "rf",
  trControl = control
)
y_pred_rf <- predict(modelo_rf, df_test)
conf_matrix_rf <- confusionMatrix(y_pred_rf, fallo_test_caret)
print(conf_matrix_rf)
#
# Resultados del Random Forest:
# - Accuracy: 0.619 (61.9%)
# - Sensibilidad: 0.579
# - Especificidad: 0.656
# - Balanced Accuracy: 0.618
# Interpretación:
# - Es el modelo con mejor rendimiento general
# - Mejor balance entre sensibilidad y especificidad
# - Ligeramente mejor que las redes neuronales en este caso

# -----------------------------------------
# Conclusiones:
# - El Random Forest es el mejor modelo (accuracy 61.9%)
# - Las redes neuronales tienen un rendimiento similar (accuracy 61.2%)
# - El árbol de decisión es el peor modelo (accuracy 58.2%)
# - Todos los modelos tienen un rendimiento modesto, sugiriendo que:
#   * Podrían necesitarse más características
#   * El problema podría ser inherentemente difícil
#   * El tamaño del dataset podría ser insuficiente

# -----------------------------------------
# 8. Visualizaciones comparativas
# -----------------------------------------
# 8.1 Comparación de métricas entre modelos
metricas <- data.frame(
  Modelo = c("Red Neuronal", "Red Neuronal (caret)", "Árbol", "Random Forest"),
  Accuracy = c(0.612, 0.612, 0.582, 0.619),
  Sensibilidad = c(0.545, 0.566, 0.297, 0.579),
  Especificidad = c(0.675, 0.656, 0.851, 0.656)
)

# Convertir a formato largo para ggplot
metricas_largo <- tidyr::pivot_longer(
  metricas,
  cols = c(Accuracy, Sensibilidad, Especificidad),
  names_to = "Metrica",
  values_to = "Valor"
)

# Gráfico de barras comparativo
ggplot(metricas_largo, aes(x = Modelo, y = Valor, fill = Metrica)) +
  geom_bar(stat = "identity", position = "dodge") +
  scale_fill_brewer(palette = "Set2") +
  labs(
    title = "Comparación de métricas entre modelos",
    x = "Modelo",
    y = "Valor",
    fill = "Métrica"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# 8.2 Curvas ROC superpuestas
# Calcular probabilidades para cada modelo
prob_nn <- predict(modelo_nn_train, df_test)[, 2]
prob_caret <- predict(modelo_caret, df_test, type = "prob")[, 2]
prob_arbol <- predict(modelo_arbol, df_test, type = "prob")[, 2]
prob_rf <- predict(modelo_rf, df_test, type = "prob")[, 2]

# Crear curvas ROC
roc_nn <- roc(fallo_test, prob_nn)
roc_caret <- roc(fallo_test, as.numeric(prob_caret))
roc_arbol <- roc(fallo_test, as.numeric(prob_arbol))
roc_rf <- roc(fallo_test, as.numeric(prob_rf))

# Gráfico de curvas ROC
plot(roc_nn, main = "Curvas ROC - Comparación de modelos", col = "red")
lines(roc_caret, col = "blue")
lines(roc_arbol, col = "green")
lines(roc_rf, col = "purple")
legend("bottomright",
  legend = c(
    paste("Red Neuronal (AUC =", round(auc(roc_nn), 3), ")"),
    paste("Red Neuronal caret (AUC =", round(auc(roc_caret), 3), ")"),
    paste("Árbol (AUC =", round(auc(roc_arbol), 3), ")"),
    paste("Random Forest (AUC =", round(auc(roc_rf), 3), ")")
  ),
  col = c("red", "blue", "green", "purple"),
  lwd = 2
)

# 8.3 Importancia de variables (Random Forest)
# Extraer importancia de variables
importancia <- varImp(modelo_rf)
# Convertir a dataframe para ggplot
importancia_df <- data.frame(
  Variable = rownames(importancia$importance),
  Importancia = importancia$importance$Overall
)
# Ordenar por importancia
importancia_df <- importancia_df[order(importancia_df$Importancia, decreasing = TRUE), ]

# Gráfico de importancia de variables
ggplot(importancia_df, aes(x = reorder(Variable, Importancia), y = Importancia)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  coord_flip() +
  labs(
    title = "Importancia de variables (Random Forest)",
    x = "Variable",
    y = "Importancia"
  ) +
  theme_minimal()

# -----------------------------------------
# Interpretación de las visualizaciones:
# - El gráfico de barras muestra claramente que el Random Forest tiene el mejor
#   balance entre sensibilidad y especificidad
# - Las curvas ROC permiten comparar el poder discriminativo de cada modelo
# - El gráfico de importancia de variables ayuda a entender qué características
#   son más relevantes para predecir los fallos
