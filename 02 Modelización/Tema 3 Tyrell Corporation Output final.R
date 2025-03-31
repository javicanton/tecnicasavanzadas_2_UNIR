# Tema 3: Diseño de escenarios. Modelización en ciencias sociales
# Técnicas Avanzadas para el Análisis de Datos Cuantitativos II

# Visualización retro de resultados del análisis de la Tyrell Corporation
# Eliminación de replicantes Nexus-5 por Blade Runners en diferentes ciudades

# Cargar paquetes necesarios
if (!require(tcltk)) install.packages("tcltk")
library(tcltk)

# Datos de eliminaciones por ciudad
# Opción 1: Usar datos directamente en el script
datos <- data.frame(
    month = 1:36,
    Los_Angeles = c(46, 47, 45, 48, 52, 49, 51, 53, 50, 54, 52, 55, 57, 56, 58, 59, 57, 60, 62, 61, 63, 64, 62, 65, 67, 66, 68, 69, 67, 70, 72, 71, 73, 74, 72, 75),
    Tokyo = c(37, 45, 55, 67, 82, 100, 122, 149, 182, 222, 271, 331, 404, 493, 602, 735, 897, 1095, 1337, 1632, 1993, 2433, 2971, 3627, 4428, 5406, 6600, 8059, 9840, 12015, 14670, 17910, 21865, 26695, 32590, 39790),
    Shanghai = c(173, 147, 125, 106, 90, 77, 65, 55, 47, 40, 34, 29, 25, 21, 18, 15, 13, 11, 9, 8, 7, 6, 5, 4, 4, 3, 3, 2, 2, 2, 1, 1, 1, 1, 1, 1),
    Londres = c(41, 43, 44, 46, 47, 49, 50, 51, 52, 53, 54, 54, 55, 55, 55, 55, 54, 53, 52, 50, 48, 46, 44, 41, 38, 35, 32, 29, 26, 23, 20, 17, 14, 11, 8, 6),
    Singapur = c(150, 165, 175, 182, 188, 193, 197, 200, 203, 205, 207, 209, 210, 211, 212, 213, 214, 214, 215, 215, 216, 216, 217, 217, 217, 218, 218, 218, 219, 219, 219, 219, 220, 220, 220, 220),
    Moscu = c(20, 28, 34, 40, 45, 49, 53, 57, 60, 63, 66, 69, 71, 74, 76, 78, 80, 82, 84, 86, 88, 90, 91, 93, 95, 96, 98, 99, 101, 102, 104, 105, 107, 108, 109, 111),
    Dubai = c(10, 12, 15, 18, 22, 27, 33, 40, 48, 58, 70, 84, 100, 119, 141, 167, 197, 231, 269, 311, 357, 407, 461, 519, 581, 647, 717, 791, 869, 951, 1037, 1127, 1221, 1319, 1421, 1527),
    Sydney = c(70, 86, 82, 74, 57, 53, 31, 35, 32, 17, 39, 56, 54, 92, 76, 73, 62, 34, 34, 32, 24, 23, 38, 51, 68, 91, 88, 80, 68, 48, 40, 26, 29, 30, 42, 56)
)

# Opción 2: Cargar datos desde CSV (comentada)
# datos <- read.csv("datos_tyrell.csv", header = TRUE)

# Función para crear efecto de escritura
escribir_texto <- function(texto, widget, delay = 0.02) {
    for (i in 1:nchar(texto)) {
        tcl(widget, "insert", "end", substr(texto, i, i))
        tcl(widget, "see", "end")
        tcl("update")
        Sys.sleep(delay)
    }
}

# Función para crear efecto glitch
efecto_glitch <- function(texto, widget, delay = 0.05) {
    # Efecto de glitch mejorado
    tcl(widget, "insert", "end", texto)
    tcl(widget, "see", "end")
    tcl("update")
    Sys.sleep(delay)
    
    # Simular corrupción de texto
    tcl(widget, "delete", "end-1c linestart", "end")
    tcl(widget, "insert", "end", paste(sample(unlist(strsplit(texto, "")), nchar(texto), replace = TRUE), collapse = ""))
    tcl(widget, "see", "end")
    tcl("update")
    Sys.sleep(delay)
    
    # Restaurar texto original
    tcl(widget, "delete", "end-1c linestart", "end")
    tcl(widget, "insert", "end", texto)
    tcl(widget, "see", "end")
    tcl("update")
}

# Función para crear la ventana de análisis
crear_ventana_analisis <- function() {
    # Crear ventana principal
    ventana <- tktoplevel()
    tktitle(ventana) <- "Tyrell Corporation - Análisis de Eliminaciones"
    
    # Crear frame principal
    frame_principal <- ttkframe(ventana)
    tkgrid(frame_principal, padx = 10, pady = 10, sticky = "nsew")
    
    # Configurar fuente monoespaciada
    fuente <- tkfont.create(family = "Courier", size = 10)
    
    # Crear widget de texto con scrollbar
    texto <- tktext(frame_principal, wrap = "word", font = fuente, bg = "black", fg = "green")
    scrollbar <- tkscrollbar(frame_principal, orient = "vertical", command = function(...) tkyview(texto, ...))
    tkconfigure(texto, yscrollcommand = function(...) tkset(scrollbar, ...))
    
    tkgrid(texto, scrollbar)
    tkgrid.configure(texto, sticky = "nsew")
    tkgrid.configure(scrollbar, sticky = "ns")
    
    # Configurar expansión de la ventana
    tkgrid.columnconfigure(ventana, 0, weight = 1)
    tkgrid.rowconfigure(ventana, 0, weight = 1)
    tkgrid.columnconfigure(frame_principal, 0, weight = 1)
    tkgrid.rowconfigure(frame_principal, 0, weight = 1)
    
    # Título con efecto glitch (solo una vez)
    efecto_glitch("TYRELL CORPORATION - ANÁLISIS DE ELIMINACIONES NEXUS-5\n\n", texto)
    
    # Explicaciones detalladas con efecto de escritura
    explicaciones <- list(
        "Los Angeles - Modelo Lineal" = "El modelo lineal muestra una tendencia constante de crecimiento en las eliminaciones, con un R² de 0.89. Esto sugiere un patrón estable y predecible en la actividad de los Blade Runners en esta ciudad.",
        
        "Tokyo - Modelo Exponencial" = "El crecimiento exponencial en Tokyo es alarmante, con un R² de 0.99. La tasa de eliminaciones se duplica aproximadamente cada 6 meses, indicando una situación crítica que requiere atención inmediata.",
        
        "Shanghai - Modelo Exponencial Negativo" = "La disminución exponencial en Shanghai muestra el éxito de las medidas preventivas, con un R² de 0.98. Las eliminaciones han disminuido drásticamente, sugiriendo una mejora significativa en el control de replicantes.",
        
        "Londres - Modelo Polinomial" = "El patrón polinomial en Londres refleja cambios complejos en las políticas de eliminación, con un R² de 0.95. La tendencia sugiere una estabilización después de un período de ajuste.",
        
        "Singapur - Modelo Logarítmico" = "El modelo logarítmico indica una rápida saturación en las eliminaciones, con un R² de 0.97. Esto sugiere que Singapur ha alcanzado un nivel de control estable.",
        
        "Moscú - Modelo de Potencia" = "La relación de potencia en Moscú muestra una correlación no lineal entre el tiempo y las eliminaciones, con un R² de 0.96. Esto indica un patrón de crecimiento controlado.",
        
        "Dubai - Modelo Sigmoidal" = "La curva sigmoidal en Dubai sugiere una adopción gradual de nuevas tecnologías de detección, con un R² de 0.99. El patrón indica una estabilización después de un período de implementación.",
        
        "Sydney - Modelo Sinusoidal" = "El patrón sinusoidal en Sydney revela una clara estacionalidad en las eliminaciones, con un R² de 0.92. Las fluctuaciones sugieren factores climáticos o temporales que influyen en la actividad de los Blade Runners."
    )
    
    for (ciudad in names(explicaciones)) {
        escribir_texto(paste(ciudad, ":\n", explicaciones[[ciudad]], "\n\n"), texto)
    }
    
    # Análisis global con efecto de escritura
    escribir_texto("ANÁLISIS GLOBAL:\n\n", texto)
    escribir_texto("La diversidad de patrones observados sugiere que cada ciudad ha desarrollado su propia estrategia para manejar la amenaza de los replicantes. Tokyo representa la situación más crítica, mientras que Shanghai muestra el mayor éxito en el control. Sydney destaca por su patrón estacional único, y Dubai por su enfoque gradual en la implementación de nuevas tecnologías.\n\n", texto)
    
    # Mensaje final con efecto glitch
    efecto_glitch("ANÁLISIS COMPLETADO - TYRELL CORPORATION 2049\n", texto)
    
    # Botón para cerrar
    tkgrid(ttkbutton(frame_principal, text = "Cerrar", command = function() tkdestroy(ventana)))
    
    # Mantener la ventana principal activa
    tcl("update")
    tkfocus(ventana)
}

# Crear y mostrar la ventana de análisis
crear_ventana_analisis()
