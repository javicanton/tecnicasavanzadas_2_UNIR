# Script para explorar el Cuarteto de Anscombe y el Datasaurus
# Este ejemplo nos ayudará a entender mejor cómo analizar datos

# Instalar y cargar los paquetes necesarios
if (!require("datasauRus")) install.packages("datasauRus")
if (!require("ggplot2")) install.packages("ggplot2")
if (!require("dplyr")) install.packages("dplyr")
if (!require("tidyr")) install.packages("tidyr")

library(datasauRus)
library(ggplot2)
library(dplyr)
library(tidyr)

# Explorar el Cuarteto de Anscombe
# Cargar los datos
data("anscombe")

# Datos originales del Cuarteto de Anscombe
datos_anscombe <- data.frame(
    x1 = anscombe$x1, y1 = anscombe$y1, # nolint: indentation_linter.
    x2 = anscombe$x2, y2 = anscombe$y2,
    x3 = anscombe$x3, y3 = anscombe$y3,
    x4 = anscombe$x4, y4 = anscombe$y4
)
# Mostrar tabla
datos_anscombe

# Calcular estadísticas descriptivas para cada conjunto
# Función auxiliar para calcular estadísticas
calcular_estadisticas <- function(x, y) {
    c( # nolint: indentation_linter.
        media_x = mean(x), # nolint: indentation_linter.
        media_y = mean(y),
        sd_x = sd(x),
        sd_y = sd(y),
        correlacion = cor(x, y)
    ) # nolint: indentation_linter. # nolint: indentation_linter.
}

# Calcular estadísticas para cada conjunto
estadisticas <- data.frame(
    conjunto1 = calcular_estadisticas(anscombe$x1, anscombe$y1), # nolint: indentation_linter, line_length_linter. # nolint, line_length_linter: indentation_linter.
    conjunto2 = calcular_estadisticas(anscombe$x2, anscombe$y2),
    conjunto3 = calcular_estadisticas(anscombe$x3, anscombe$y3),
    conjunto4 = calcular_estadisticas(anscombe$x4, anscombe$y4)
)

# Estadísticas descriptivas del Cuarteto de Anscombe
estadisticas

# Observaciones sobre las estadísticas:
# 1. Todos los conjuntos tienen una media de X de 9.0000
# 2. Todos los conjuntos tienen una media de Y cercana a 7.5009
# 3. Las desviaciones estándar de X son aproximadamente 3.3166
# 4. Las desviaciones estándar de Y son aproximadamente 2.0316
# 5. Las correlaciones son todas cercanas a 0.8164

# Crear un gráfico mejorado del Cuarteto de Anscombe
anscombe_long <- data.frame(
    x = c(anscombe$x1, anscombe$x2, anscombe$x3, anscombe$x4), # nolint: indentation_linter, line_length_linter, indentation_linter.
    y = c(anscombe$y1, anscombe$y2, anscombe$y3, anscombe$y4),
    conjunto = rep(1:4, each = 11)
)

p1 <- ggplot(anscombe_long, aes(x = x, y = y)) +
    geom_point(color = "steelblue", size = 2) + # nolint: indentation_linter. # nolint: indentation_linter, line_length_linter, line_length_linter.
    facet_wrap(~conjunto, ncol = 2) +
    theme_minimal() +
    labs(
        title = "El Cuarteto de Anscombe", # nolint: indentation_linter.
        subtitle = "Cuatro conjuntos de datos con estadísticas similares"
    ) +
    theme(
        plot.title = element_text(size = 16, face = "bold"),
        plot.subtitle = element_text(size = 12, color = "gray")
    )

# Mostrar el gráfico
p1

# Guardar el gráfico
setwd(dirname(rstudioapi::getSourceEditorContext()$path))
ggsave("anscombe_plot.png", p1, width = 10, height = 8)

# Explorar el Datasaurus
# Cargar los datos del Datasaurus
data("datasaurus_dozen")

# Primeros 5 registros de cada conjunto del Datasaurus
datos_datasaurus <- datasaurus_dozen %>%
    group_by(dataset) %>%
    slice_head(n = 5) %>%
    select(dataset, x, y)

# Mostrar tabla
datos_datasaurus

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

# Mostrar estadísticas descriptivas del Datasaurus
estadisticas_datasaurus

# Observaciones sobre las estadísticas:
# 1. Todos los conjuntos tienen una media de X cercana a 54.26
# 2. Todos los conjuntos tienen una media de Y cercana a 47.83
# 3. Las desviaciones estándar de X son aproximadamente 16.76
# 4. Las desviaciones estándar de Y son aproximadamente 26.93
# 5. Las correlaciones son todas cercanas a -0.06

# Crear un gráfico mejorado del Datasaurus
p2 <- ggplot(datasaurus_dozen, aes(x = x, y = y)) +
    geom_point(color = "steelblue", alpha = 0.6, size = 0.8) +
    facet_wrap(~dataset, ncol = 4) +
    theme_minimal() +
    labs(
        title = "El Datasaurus",
        subtitle = "Conjuntos de datos con estadísticas similares"
    ) + # nolint
    theme(
        plot.title = element_text(size = 16, face = "bold"), # nolint: indentation_linter. # nolint: indentation_linter.
        plot.subtitle = element_text(size = 12, color = "gray"),
        strip.text = element_text(size = 8),
        axis.text = element_text(size = 6)
    ) # nolint: indentation_linter.

# Mostrar el gráfico
p2

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
