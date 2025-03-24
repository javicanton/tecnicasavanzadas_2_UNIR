# Script para demostrar el Datasaurus y el Cuarteto de Anscombe
# Este ejemplo muestra por qué es importante visualizar los datos

# Instalar y cargar los paquetes necesarios
if (!require("datasauRus")) install.packages("datasauRus")
if (!require("ggplot2")) install.packages("ggplot2")
if (!require("dplyr")) install.packages("dplyr")
if (!require("gganimate")) install.packages("gganimate")
if (!require("gifski")) install.packages("gifski")

library(datasauRus)
library(ggplot2)
library(dplyr)
library(gganimate)
library(gifski)

# Mostrar el Cuarteto de Anscombe
# Cargar los datos
data("anscombe")

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

print("Estadísticas del Cuarteto de Anscombe:")
print(estadisticas)

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
        subtitle = "Cuatro conjuntos de datos con estadísticas similares pero visualmente diferentes"
    ) +
    theme(
        plot.title = element_text(size = 16, face = "bold"),
        plot.subtitle = element_text(size = 12, color = "gray")
    )

# Guardar el gráfico
ggsave("anscombe_plot.png", p1, width = 10, height = 8)

# Ahora mostramos el Datasaurus
# Cargar los datos del Datasaurus
data("datasaurus_dozen")

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

print("Estadísticas del Datasaurus:")
print(estadisticas_datasaurus)

# Crear un gráfico mejorado del Datasaurus
p2 <- ggplot(datasaurus_dozen, aes(x = x, y = y)) +
    geom_point(color = "steelblue", alpha = 0.6) +
    facet_wrap(~dataset, ncol = 3) +
    theme_minimal() +
    labs(
        title = "El Datasaurus",
        subtitle = "Conjuntos de datos con estadísticas similares pero patrones visuales únicos" # nolint: line_length_linter.
    ) +
    theme(
        plot.title = element_text(size = 16, face = "bold"),
        plot.subtitle = element_text(size = 12, color = "gray")
    )

# Guardar el gráfico
ggsave("datasaurus_plot.png", p2, width = 12, height = 8)

# Crear una animación del Datasaurus
# Añadir un frame temporal para la animación
datasaurus_dozen$frame <- as.numeric(factor(datasaurus_dozen$dataset))

# Crear el gráfico animado
p3 <- ggplot(datasaurus_dozen, aes(x = x, y = y)) +
    geom_point(color = "steelblue", alpha = 0.6) +
    theme_minimal() +
    labs(
        title = "El Datasaurus: {closest_state}",
        subtitle = "Conjuntos de datos con estadísticas similares pero patrones visuales únicos"
    ) +
    theme(
        plot.title = element_text(size = 16, face = "bold"),
        plot.subtitle = element_text(size = 12, color = "gray")
    ) +
    transition_states(dataset, transition_length = 2, state_length = 3) +
    ease_aes("cubic-in-out")

# Guardar la animación
anim_save("datasaurus_animation.gif", p3,
    width = 800, height = 600,
    fps = 2, duration = 26
)

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

# Mensaje final
cat("\nEste ejemplo demuestra que:\n")
cat("1. Las estadísticas descriptivas por sí solas pueden ser engañosas\n")
cat("2. La visualización de datos es crucial para entender realmente los datos\n")
cat("3. No debemos confiar ciegamente en los números sin ver qué hay detrás\n")

cat("\nSe han generado los siguientes archivos:\n")
cat("- anscombe_plot.png: Visualización del Cuarteto de Anscombe\n")
cat("- datasaurus_plot.png: Visualización de todos los conjuntos del Datasaurus\n")
cat("- datasaurus_animation.gif: Animación de los conjuntos del Datasaurus\n")
