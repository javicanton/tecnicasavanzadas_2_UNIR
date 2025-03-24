# Script para explorar el Cuarteto de Anscombe y el Datasaurus
# Este ejemplo nos ayudará a entender mejor cómo analizar datos

# Instalar y cargar los paquetes necesarios
if (!require("datasauRus")) install.packages("datasauRus")
if (!require("ggplot2")) install.packages("ggplot2")
if (!require("dplyr")) install.packages("dplyr")

library(datasauRus)
library(ggplot2)
library(dplyr)

# Explorar el Cuarteto de Anscombe
# Cargar los datos
data("anscombe")

# Mostrar los datos originales del Cuarteto de Anscombe
cat("\nDatos originales del Cuarteto de Anscombe:\n")
datos_anscombe <- data.frame(
    x1 = anscombe$x1, y1 = anscombe$y1,
    x2 = anscombe$x2, y2 = anscombe$y2,
    x3 = anscombe$x3, y3 = anscombe$y3,
    x4 = anscombe$x4, y4 = anscombe$y4
)
print(datos_anscombe, row.names = FALSE)

# Calcular estadísticas descriptivas para cada conjunto
# Función auxiliar para calcular estadísticas
calcular_estadisticas <- function(x, y) {
    c(
        media_x = mean(x),
        media_y = mean(y),
        sd_x = sd(x),
        sd_y = sd(y),
        correlacion = cor(x, y)
    )
}

# Calcular estadísticas para cada conjunto
estadisticas <- data.frame(
    conjunto1 = calcular_estadisticas(anscombe$x1, anscombe$y1),
    conjunto2 = calcular_estadisticas(anscombe$x2, anscombe$y2),
    conjunto3 = calcular_estadisticas(anscombe$x3, anscombe$y3),
    conjunto4 = calcular_estadisticas(anscombe$x4, anscombe$y4)
)

# Mostrar estadísticas
cat("\nEstadísticas descriptivas del Cuarteto de Anscombe:\n")
print(estadisticas)

cat("\nObservaciones sobre las estadísticas:\n")
cat("1. Todos los conjuntos tienen una media de X de 9.0000\n")
cat("2. Todos los conjuntos tienen una media de Y cercana a 7.5009\n")
cat("3. Las desviaciones estándar de X son aproximadamente 3.3166\n")
cat("4. Las desviaciones estándar de Y son aproximadamente 2.0316\n")
cat("5. Las correlaciones son todas cercanas a 0.8164\n")

# Crear un gráfico mejorado del Cuarteto de Anscombe
anscombe_long <- data.frame(
    x = c(anscombe$x1, anscombe$x2, anscombe$x3, anscombe$x4),
    y = c(anscombe$y1, anscombe$y2, anscombe$y3, anscombe$y4),
    conjunto = rep(1:4, each = 11)
)

p1 <- ggplot(anscombe_long, aes(x = x, y = y)) +
    geom_point(color = "steelblue", size = 2) +
    facet_wrap(~conjunto, ncol = 2) +
    theme_minimal() +
    labs(
        title = "El Cuarteto de Anscombe",
        subtitle = "Cuatro conjuntos de datos con estadísticas similares"
    ) +
    theme(
        plot.title = element_text(size = 16, face = "bold"),
        plot.subtitle = element_text(size = 12, color = "gray")
    )

# Guardar el gráfico
setwd(dirname(rstudioapi::getSourceEditorContext()$path))
ggsave("anscombe_plot.png", p1, width = 10, height = 8)

# Explorar el Datasaurus
# Cargar los datos del Datasaurus
data("datasaurus_dozen")

# Mostrar los datos originales del Datasaurus (primeros 5 registros de cada conjunto)
cat("\nPrimeros 5 registros de cada conjunto del Datasaurus:\n")
datos_datasaurus <- datasaurus_dozen %>%
    group_by(dataset) %>%
    slice_head(n = 5) %>%
    pivot_wider(names_from = dataset, values_from = c(x, y))
print(datos_datasaurus, row.names = FALSE)

# Calcular estadísticas para cada conjunto del Datasaurus
estadisticas_datasaurus <- datasaurus_dozen %>%
    group_by(dataset) %>%
    summarise(
        media_x = mean(x),
        media_y = mean(y),
        sd_x = sd(x),
        sd_y = sd(y),
        correlacion = cor(x, y)
    )

# Convertir a data.frame y redondear los valores
estadisticas_datasaurus <- as.data.frame(estadisticas_datasaurus)
estadisticas_datasaurus[, -1] <- round(estadisticas_datasaurus[, -1], 4)

# Mostrar estadísticas
cat("\nEstadísticas descriptivas del Datasaurus:\n")
print(estadisticas_datasaurus, row.names = FALSE)

cat("\nObservaciones sobre las estadísticas:\n")
cat("1. Todos los conjuntos tienen una media de X cercana a 54.26\n")
cat("2. Todos los conjuntos tienen una media de Y cercana a 47.83\n")
cat("3. Las desviaciones estándar de X son aproximadamente 16.76\n")
cat("4. Las desviaciones estándar de Y son aproximadamente 26.93\n")
cat("5. Las correlaciones son todas cercanas a -0.06\n")

# Crear un gráfico mejorado del Datasaurus
p2 <- ggplot(datasaurus_dozen, aes(x = x, y = y)) +
    geom_point(color = "steelblue", alpha = 0.6, size = 0.8) +
    facet_wrap(~dataset, ncol = 4) +
    theme_minimal() +
    labs(
        title = "El Datasaurus",
        subtitle = "Conjuntos de datos con estadísticas similares"
    ) +
    theme(
        plot.title = element_text(size = 16, face = "bold"),
        plot.subtitle = element_text(size = 12, color = "gray"),
        strip.text = element_text(size = 8),
        axis.text = element_text(size = 6)
    )

# Guardar el gráfico
ggsave("datasaurus_plot.png", p2, width = 16, height = 12)

# Crear un gráfico interactivo con plotly (opcional)
if (!require("plotly")) install.packages("plotly")
library(plotly)

# Gráfico interactivo del dinosaurio
dino_data <- subset(datasaurus_dozen, dataset == "dino")
plot_ly(dino_data, x = ~x, y = ~y, type = "scatter", mode = "markers") %>%
    layout(
        title = "El Datasaurus",
        xaxis = list(title = "X"),
        yaxis = list(title = "Y")
    )
