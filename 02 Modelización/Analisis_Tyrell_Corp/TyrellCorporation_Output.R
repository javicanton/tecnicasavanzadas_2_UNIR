# Tema 3: Diseño de escenarios. Modelización en ciencias sociales
# Técnicas Avanzadas para el Análisis de Datos Cuantitativos II

# Visualización retro de resultados del análisis de la Tyrell Corporation
# Eliminación de replicantes Nexus-5 por Blade Runners en diferentes ciudades

# Cargar paquetes necesarios
if (!require(tcltk)) install.packages("tcltk")
library(tcltk)

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
