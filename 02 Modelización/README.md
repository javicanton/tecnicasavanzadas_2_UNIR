# Modelización - Técnicas Cuantitativas Avanzadas II

Este directorio contiene los talleres y ejemplos prácticos de modelización estadística y machine learning para la asignatura de Técnicas Avanzadas para el Análisis de Datos Cuantitativos.

## Estructura del Módulo

### 📈 Regresión Lineal
- [**Androides**](Regresion_Lineal/Androides/RegresionLineal_Androides.md) - Modelo de regresión lineal aplicado al análisis de comportamiento de androides
- [**Bacterias**](Regresion_Lineal/Bacterias/RegresionLineal_Bacterias.md) - Análisis de crecimiento bacteriano mediante regresión lineal

### 📊 Regresión No Lineal
- [**Tyrell Corp - Crecimiento Nexus-4 (Módulo A)**](Regresion_No_Lineal/Tyrell_Corp_1.Rmd) - Modelo logístico para análisis de crecimiento
- [**Tyrell Corp - Crecimiento Nexus-4 (Módulo B)**](Regresion_No_Lineal/Tyrell_Corp_2.Rmd) - Modelo de Gompertz para análisis de crecimiento
- [**Visualizaciones HTML**](Regresion_No_Lineal/html_output/) - Resultados interactivos en formato web

### 🎵 Análisis de Streaming
- [**Spotifal - Análisis de Abandono**](Analisis_Spotifal/Spotifal_Informe.md) - Análisis de patrones de abandono usando modelos lineales, logísticos y redes neuronales

### 🏢 Análisis Corporativo
- [**Tyrell Corporation - Análisis de Eliminaciones**](Analisis_Tyrell_Corp/TyrellCorporation.md) - Análisis estadístico de patrones de eliminación

### 🔗 Dependencias Múltiples (SEM)
- [**Análisis SEM del T-800**](Dependencias_multiples/T800/informe_T800_SEM.Rmd) - Análisis de Ecuaciones Estructurales aplicado a unidades T-800
- [**Análisis SEM Educativo**](Dependencias_multiples/educativo/informe_modelo_educativo_SEM.Rmd) - Estudio de relaciones entre apoyo docente, motivación y rendimiento

### 🧠 Redes Neuronales
- [**Análisis de Fallos en Nexus-5**](Redes_Neuronales/informe_nexus5_nn.Rmd) - Implementación de redes neuronales para predicción de fallos
- [**Taller de Ajuste de Redes Neuronales**](Redes_Neuronales/taller_ajuste_redes_nexus5.Rmd) - Taller práctico de optimización de hiperparámetros

## Técnicas Implementadas

### Modelización Estadística
- **Regresión Lineal Simple y Múltiple**
- **Regresión No Lineal** (Logística, Gompertz)
- **Análisis de Ecuaciones Estructurales (SEM)**
- **Modelos de Clasificación**

### Machine Learning
- **Redes Neuronales Artificiales**
- **Optimización de Hiperparámetros**
- **Validación Cruzada**
- **Métricas de Evaluación**

### Visualización y Análisis
- **Gráficos de Diagnóstico**
- **Matrices de Correlación**
- **Curvas ROC**
- **Visualizaciones SEM**

## Requisitos Técnicos

### Software Base
- R >= 4.0.0
- RStudio (recomendado)
- Git (opcional)

### Paquetes R Principales
```r
install.packages(c(
    "tidyverse",    # Manipulación y visualización de datos
    "caret",        # Entrenamiento de modelos
    "nnet",         # Redes neuronales
    "lavaan",       # Análisis SEM
    "semPlot",      # Visualización SEM
    "psych",        # Análisis psicométricos
    "ggplot2",      # Visualización avanzada
    "pROC",         # Curvas ROC
    "corrplot",     # Matrices de correlación
    "knitr",        # Generación de informes
    "rmarkdown"     # Documentos dinámicos
))
```

## Flujo de Trabajo Recomendado

1. **Revisar la documentación** de cada análisis en los archivos `.md`
2. **Examinar los scripts R** para entender la implementación
3. **Ejecutar los códigos** en orden secuencial
4. **Generar informes HTML** usando RMarkdown cuando esté disponible
5. **Analizar los resultados** y visualizaciones

## Estructura de Archivos

Cada subdirectorio contiene:
- **Documentación**: Archivos `.md` con explicaciones detalladas
- **Código R**: Scripts ejecutables (`.R`)
- **Informes**: Documentos RMarkdown (`.Rmd`)
- **Datos**: Archivos CSV con los datasets utilizados
- **Resultados**: Imágenes y gráficos generados
- **HTML**: Versiones web de los análisis (cuando aplique)

## Notas Importantes

- Cada subdirectorio contiene su propio README con instrucciones específicas
- Los datasets necesarios están incluidos en cada subdirectorio
- Los resultados pueden variar debido a la aleatoriedad en los modelos
- Se recomienda revisar los requisitos específicos de cada análisis
- Los archivos HTML proporcionan una mejor experiencia de visualización

## Contribuciones

Las contribuciones son bienvenidas. Por favor, seguir las guías de estilo establecidas y mantener la consistencia con la estructura existente.

## Licencia

Este proyecto está bajo la licencia MIT.
